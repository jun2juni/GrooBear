package kr.or.ddit.sevenfs.service.project.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.sevenfs.mapper.project.ProjectMapper;
import kr.or.ddit.sevenfs.mapper.project.ProjectTaskMapper;
import kr.or.ddit.sevenfs.service.project.ProjectService;
import kr.or.ddit.sevenfs.utils.ArticlePage;
import kr.or.ddit.sevenfs.vo.AttachFileVO;
import kr.or.ddit.sevenfs.vo.project.ProjectEmpVO;
import kr.or.ddit.sevenfs.vo.project.ProjectTaskVO;
import kr.or.ddit.sevenfs.vo.project.ProjectVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ProjectServiceImpl implements ProjectService {

    @Autowired
    private ProjectMapper projectMapper;

    @Autowired
    private ProjectTaskMapper projectTaskMapper;

    @Override
    public List<ProjectVO> projectList(Map<String, Object> map) {
        return projectMapper.projectList(map);
    }

    @Override
    public int getTotal(Map<String, Object> map) {
        return projectMapper.getTotal(map);
    }

    @Override
    public int insertProject(ProjectVO projectVO) {
        return projectMapper.insertProject(projectVO);
    }

    @Override
    public int insertProjectEmpBatch(List<ProjectEmpVO> projectEmpList) {
        return projectMapper.insertProjectEmpBatch(projectEmpList);
    }

    @Override
    public ProjectVO projectDetail(long prjctNo) {
        ProjectVO projectVO = projectMapper.projectDetail(prjctNo);

        // 1. 참여자 역할 분리
        if (projectVO.getProjectEmpVOList() != null) {
            List<ProjectEmpVO> responsibleList = new ArrayList<>();
            List<ProjectEmpVO> participantList = new ArrayList<>();
            List<ProjectEmpVO> observerList = new ArrayList<>();

            for (ProjectEmpVO emp : projectVO.getProjectEmpVOList()) {
                switch (emp.getPrtcpntRole()) {
                    case "00" -> responsibleList.add(emp);
                    case "01" -> participantList.add(emp);
                    case "02" -> observerList.add(emp);
                }
            }

            projectVO.setResponsibleList(responsibleList);
            projectVO.setParticipantList(participantList);
            projectVO.setObserverList(observerList);
        }

        // 2. 계층 정렬 먼저 수행
        if (projectVO.getProjectTaskVOList() != null) {
            List<ProjectTaskVO> sortedTasks = sortTasksHierarchy(projectVO.getProjectTaskVOList());
            projectVO.setTaskList(sortedTasks);

            // 3. 정렬된 리스트 기준으로 역할 부여
            if (projectVO.getProjectEmpVOList() != null) {
                for (ProjectTaskVO task : sortedTasks) {
                    for (ProjectEmpVO emp : projectVO.getProjectEmpVOList()) {
                        if (emp.getPrtcpntEmpno().equals(task.getChargerEmpno())) {
                            task.setRole(emp.getPrtcpntRole()); // "00", "01", "02"
                            break;
                        }
                    }
                }
            }
        }

        return projectVO;
    }



    @Override
    public int createProject(ProjectVO projectVO, List<ProjectTaskVO> taskList) {
        int insertedCount = 0;

        // 1. 프로젝트 생성
        insertedCount += projectMapper.insertProject(projectVO);
        log.info("▶ 프로젝트 생성: {}", projectVO);

        // 2. 참여자 등록
        if (projectVO.getProjectEmpVOList() != null) {
            for (ProjectEmpVO emp : projectVO.getProjectEmpVOList()) {
                emp.setPrjctNo(projectVO.getPrjctNo());
                emp.setPrjctAuthor("0000");
                emp.setEvlManEmpno(emp.getPrtcpntEmpno());
                emp.setEvlCn("평가 내용이 없습니다.");
                emp.setEvlGrad("1");
            }
            insertedCount += projectMapper.insertProjectEmpBatch(projectVO.getProjectEmpVOList());
        }

        // 3. 업무 등록
        if (taskList != null) {
            for (ProjectTaskVO task : taskList) {
                task.setPrjctNo(projectVO.getPrjctNo());
                task.setTaskSttus("00");
                task.setProgrsrt(0);

                if (task.getTaskBeginDt() != null && task.getTaskEndDt() != null) {
                    long diffMillis = task.getTaskEndDt().getTime() - task.getTaskBeginDt().getTime();
                    task.setTaskDaycnt((int) (diffMillis / (1000 * 60 * 60 * 24)) + 1);
                } else {
                    task.setTaskDaycnt(0);
                }

                insertedCount += projectTaskMapper.insertProjectTask(task);
            }
        }

        return insertedCount;
    }
    
    private List<ProjectTaskVO> sortTasksHierarchy(List<ProjectTaskVO> tasks) {
        if (tasks == null || tasks.isEmpty()) {
            return new ArrayList<>();
        }
        
        Map<Long, List<ProjectTaskVO>> childMap = new HashMap<>();
        List<ProjectTaskVO> topLevel = new ArrayList<>();
        
        // 로그 추가
        log.debug("업무 계층 정렬 시작 - 총 업무 수: {}", tasks.size());
        
        for (ProjectTaskVO task : tasks) {
            log.debug("업무 분석: {}, upperTaskNo: {}", task.getTaskNm(), task.getUpperTaskNo());
            
            Long upperTaskNo = task.getUpperTaskNo();
            if (upperTaskNo == null) {
                topLevel.add(task);
                log.debug("최상위 업무로 분류: {}", task.getTaskNm());
            } else {
                childMap.computeIfAbsent(upperTaskNo, k -> new ArrayList<>()).add(task);
                log.debug("하위 업무로 분류: {} (상위: {})", task.getTaskNm(), upperTaskNo);
            }
        }
        
        List<ProjectTaskVO> result = new ArrayList<>();
        for (ProjectTaskVO parent : topLevel) {
            parent.setDepth(0);
            result.add(parent);
            log.debug("최상위 업무 추가: {}", parent.getTaskNm());
            
            addChildrenRecursively(parent, childMap, result, 1);
        }
        
        log.debug("계층 정렬 결과 - 총 업무 수: {}", result.size());
        return result;
    }

    private void addChildrenRecursively(ProjectTaskVO parent, Map<Long, List<ProjectTaskVO>> childMap,
                                       List<ProjectTaskVO> result, int depth) {
        List<ProjectTaskVO> children = childMap.get(parent.getTaskNo());
        if (children != null) {
            for (ProjectTaskVO child : children) {
                child.setDepth(depth);
                child.setParentTaskNm(parent.getTaskNm());
                result.add(child);
                log.debug("하위 업무 추가: {} (상위: {}, 깊이: {})", child.getTaskNm(), parent.getTaskNm(), depth);
                
                addChildrenRecursively(child, childMap, result, depth + 1);
            }
        }
    }

    @Override
    public boolean deleteProject(Long prjctNo) {
        try {
            projectTaskMapper.deleteProjectTasksByProject(prjctNo);
            projectMapper.deleteProjectEmpsByProject(prjctNo);
            int result = projectMapper.deleteProject(prjctNo); // 성공 여부 체크
            return result > 0;
        } catch (Exception e) {
            log.error("프로젝트 삭제 중 오류", e);
            return false;
        }
    }


	@Override
	public void updateProject(ProjectVO projectVO) {
	    // 1. 프로젝트 정보 업데이트
	    projectMapper.updateProject(projectVO);

	    // 2. 새 참여자 목록에서만 insert 처리
	    List<ProjectEmpVO> newEmpList = projectVO.getProjectEmpVOList();
	    if (newEmpList != null && !newEmpList.isEmpty()) {
	        projectMapper.insertProjectEmpBatch(newEmpList); // 중복제거 미리 됐다고 가정
	    }


	}


	@Override
	public List<Map<String, Object>> getProjectCategoryList() {
	    return projectMapper.getProjectCategoryList();
	}

	@Override
	public List<Map<String, Object>> getProjectStatusList() {
	    return projectMapper.getProjectStatusList();
	}

	@Override
	public List<Map<String, Object>> getProjectGradeList() {
	    return projectMapper.getProjectGradeList();
	}

	@Override
	public int selectMaxProjectNo() {
	    return projectMapper.selectMaxProjectNo();
	}

}

