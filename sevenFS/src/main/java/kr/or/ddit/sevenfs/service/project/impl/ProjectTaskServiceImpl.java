package kr.or.ddit.sevenfs.service.project.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.sevenfs.mapper.AttachFileMapper;
import kr.or.ddit.sevenfs.mapper.project.ProjectTaskMapper;
import kr.or.ddit.sevenfs.service.AttachFileService;
import kr.or.ddit.sevenfs.service.project.ProjectTaskService;
import kr.or.ddit.sevenfs.vo.AttachFileVO;
import kr.or.ddit.sevenfs.vo.project.ProjectTaskVO;
import kr.or.ddit.sevenfs.vo.project.ProjectVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ProjectTaskServiceImpl implements ProjectTaskService {

	@Autowired
	ProjectTaskMapper projectTaskMapper;
	
	@Autowired
	AttachFileMapper attachFileMapper;
	
	@Autowired
	AttachFileService attachFileService;


    @Override
    public void insertProjectTask(ProjectTaskVO taskVO) {
    	
    	if (taskVO.getTaskBeginDt() != null && taskVO.getTaskEndDt() != null) {
    	    long diffInMillies = taskVO.getTaskEndDt().getTime() - taskVO.getTaskBeginDt().getTime();
    	    int daycnt = (int) (diffInMillies / (1000 * 60 * 60 * 24)) + 1;
    	    taskVO.setTaskDaycnt(daycnt);
    	}
    	
        if (taskVO.getTaskSttus() == null || taskVO.getTaskSttus().isBlank()) {
            taskVO.setTaskSttus("00"); 
        }
    	
        if (taskVO.getProgrsrt() == 0) {
            taskVO.setProgrsrt(0);
        }
        
        projectTaskMapper.insertProjectTask(taskVO);
    }


    @Override
    public List<ProjectTaskVO> getParentTasks(int prjctNo) {
        return projectTaskMapper.getParentTasks(prjctNo);
    }

    @Override
    public void insertProjectTaskBatch(List<ProjectTaskVO> taskList) {
        for (ProjectTaskVO taskVO : taskList) {
            projectTaskMapper.insertProjectTask(taskVO);
        }
    }


    @Override
    public ProjectTaskVO getTaskById(Long taskNo) {
    	
        return projectTaskMapper.selectTaskById(taskNo);
    }

    @Override
    public int updateTask(ProjectTaskVO taskVO) {
        // 1. taskDaycnt 계산 추가
        if (taskVO.getTaskBeginDt() != null && taskVO.getTaskEndDt() != null) {
            long diff = taskVO.getTaskEndDt().getTime() - taskVO.getTaskBeginDt().getTime();
            taskVO.setTaskDaycnt((int)(diff / (1000 * 60 * 60 * 24)) + 1);
        }

        // 2. 첨부파일 처리
        if (taskVO != null && taskVO.getAtchFileNo() > 0) {
            List<AttachFileVO> attachFiles = attachFileMapper.getFileAttachList(taskVO.getAtchFileNo());
            taskVO.setAttachFileList(attachFiles);
        }

        // 3. 업데이트 실행
        return projectTaskMapper.updateTask(taskVO);
    }




    @Override
    public ProjectTaskVO selectTaskById(Long taskNo) {
        ProjectTaskVO task = projectTaskMapper.selectTaskById(taskNo);

        // 첨부 파일 조회
        if (task != null && task.getAtchFileNo() > 0) {
            List<AttachFileVO> attachFiles = attachFileMapper.getFileAttachList(task.getAtchFileNo());
            task.setAttachFileList(attachFiles);
        }

        return task;
    }

    @Override
    public Long insertProjectTaskAndGetId(ProjectTaskVO taskVO) {
        if (taskVO.getTaskBeginDt() != null && taskVO.getTaskEndDt() != null) {
            long diffInMillies = taskVO.getTaskEndDt().getTime() - taskVO.getTaskBeginDt().getTime();
            int daycnt = (int) (diffInMillies / (1000 * 60 * 60 * 24)) + 1;
            taskVO.setTaskDaycnt(daycnt);
        }
        
        // 업무 기본 설정
        taskVO.setTaskSttus("00");
        taskVO.setProgrsrt(0);
        
        projectTaskMapper.insertProjectTask(taskVO);
        return (long) taskVO.getTaskNo(); // MyBatis에서 생성된 키 반환
    }

    @Override
    public boolean updateTaskParent(Long taskNo, Long parentTaskNo) {
        Map<String, Object> params = new HashMap<>();
        params.put("taskNo", taskNo);
        params.put("parentTaskNo", parentTaskNo);
        
        try {
            projectTaskMapper.updateTaskParent(params);
            return true;
        } catch (Exception e) {
            log.error("업무 상위 관계 업데이트 실패: {}", e.getMessage(), e);
            return false;
        }
    }

    @Transactional
    public void updateTaskParentRelations(List<ProjectTaskVO> tasks) {
        for (ProjectTaskVO task : tasks) {
            if (task.getTempParentIndex() != null && !task.getTempParentIndex().isEmpty()) {
                int parentIndex = Integer.parseInt(task.getTempParentIndex());
                if (parentIndex >= 0 && parentIndex < tasks.size()) {
                    ProjectTaskVO parentTask = tasks.get(parentIndex);
                    
                    Map<String, Object> params = new HashMap<>();
                    params.put("taskNo", task.getTaskNo());
                    params.put("parentTaskNo", parentTask.getTaskNo());
                    
                    projectTaskMapper.updateTaskParent(params);
                }
            }
        }
    }
    
    @Override
    @Transactional
    public Long insertProjectTaskWithFiles(ProjectTaskVO taskVO, MultipartFile[] uploadFiles) {
        // 1. 업무 기본 설정
        taskVO.setTaskSttus("00");
        taskVO.setProgrsrt(0);

        if (taskVO.getTaskBeginDt() != null && taskVO.getTaskEndDt() != null) {
            long diff = taskVO.getTaskEndDt().getTime() - taskVO.getTaskBeginDt().getTime();
            taskVO.setTaskDaycnt((int) (diff / (1000 * 60 * 60 * 24)) + 1);
        }

        // 2. 파일 저장
        log.debug("파일 업로드 시작 - 파일 개수: {}", uploadFiles != null ? uploadFiles.length : 0);
        
        if (uploadFiles != null && uploadFiles.length > 0) {
            boolean hasValidFile = false;
            
            // 유효한 파일만 필터링
            List<MultipartFile> validFiles = new ArrayList<>();
            
            for (MultipartFile file : uploadFiles) {
                if (file != null && !file.isEmpty() && file.getSize() > 0 && file.getOriginalFilename() != null && !file.getOriginalFilename().trim().isEmpty()) {
                    log.info(">> 유효한 파일: {}, 크기: {}", file.getOriginalFilename(), file.getSize());
                    hasValidFile = true;
                    validFiles.add(file);
                } else {
                    log.warn(">> 무시된 파일: {}, 크기: {}", 
                        (file != null ? file.getOriginalFilename() : "null"), 
                        (file != null ? file.getSize() : -1));
                }
            }
            
            // 유효한 파일이 있을 경우에만 처리
            if (hasValidFile) {
                MultipartFile[] validFileArray = validFiles.toArray(new MultipartFile[0]);
                log.debug(">> 유효한 파일 {} 개를 처리합니다.", validFileArray.length);
                
                // atchFileNo가 없으면 생성
                if (taskVO.getAtchFileNo() == 0) {
                    long atchFileNo = attachFileService.getAttachFileNo();
                    taskVO.setAtchFileNo(atchFileNo);
                }
                
                AttachFileVO fileVO = new AttachFileVO();
                fileVO.setAtchFileNo(taskVO.getAtchFileNo());
                
                try {
                    int result = attachFileService.updateFileList("project/task", validFileArray, fileVO);
                    log.debug(">> 파일 저장 결과: {}", result);
                } catch (Exception e) {
                    log.error("파일 저장 중 오류 발생", e);
                }
            } else {
                // 유효한 파일이 없으면 atchFileNo를 null로 설정
                taskVO.setAtchFileNo(0);
            }
        }

        // 3. 업무 저장
        log.debug(">>> 업무 저장 직전 taskVO: {}", taskVO);
        projectTaskMapper.insertProjectTask(taskVO);
        log.debug(">>> 업무 저장 완료 taskNo: {}", taskVO.getTaskNo());

        return (long) taskVO.getTaskNo();
    }


 
	@Override
	public boolean deleteTask(Long taskNo) {
	    return projectTaskMapper.deleteTask(taskNo) > 0;
	}
	
	@Override
	public boolean hasChildTasks(Long parentTaskNo) {
	    return projectTaskMapper.countChildTasks(parentTaskNo) > 0;
	}

    @Override
    public int updateTaskStatus(long taskId, String status) {
        return projectTaskMapper.updateTaskStatus(taskId, status);
    }
    
    @Override
    public void updateSchedule(ProjectTaskVO task) {
        log.debug("업무 일정 업데이트 - taskNo: {}, 시작일: {}, 종료일: {}, 진행률: {}%",
                  task.getTaskNo(), task.getTaskBeginDt(), task.getTaskEndDt(), task.getProgrsrt());

        int affected = projectTaskMapper.updateTaskSchedule(task);

        if (affected != 1) {
            throw new RuntimeException("업무 일정 업데이트 실패: taskNo=" + task.getTaskNo());
        }
    }


    @Override
    public boolean hasTaskAssigned(int prjctNo, String empNo) {
        return projectTaskMapper.countTasksByAssignee(prjctNo, empNo) > 0;
    }

    

}
