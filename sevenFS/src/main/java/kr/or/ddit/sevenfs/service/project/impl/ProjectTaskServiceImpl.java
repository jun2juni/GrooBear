package kr.or.ddit.sevenfs.service.project.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.sevenfs.mapper.project.ProjectTaskMapper;
import kr.or.ddit.sevenfs.service.project.ProjectTaskService;
import kr.or.ddit.sevenfs.vo.project.ProjectTaskVO;
import kr.or.ddit.sevenfs.vo.project.ProjectVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ProjectTaskServiceImpl implements ProjectTaskService {

	@Autowired
	ProjectTaskMapper projectTaskMapper;

	@Override
	public ProjectVO selectProjectDetail(Long prjctNo) {
		// TODO Auto-generated method stub
		return projectTaskMapper.selectProjectDetail();
	}

	@Override
	@Transactional
	public int insertProjectTask(ProjectTaskVO taskVO) {
		log.info("업무 등록 서비스 시작");
		return projectTaskMapper.insertProjectTask(taskVO);
	}


	@Override
	public List<ProjectTaskVO> getParentTasks(int prjctNo) {
		return projectTaskMapper.getParentTasks(prjctNo);
	}

	@Override
	public List<ProjectTaskVO> getChildTasks(int taskNo) {
		return projectTaskMapper.getChildTasks(taskNo);
	}

	@Override
	public Map<String, Integer> insertParentTasks(List<ProjectTaskVO> parentTasks, int prjctNo) {
        log.info("상위 업무 일괄 등록 시작: 개수={}", parentTasks.size());
        
        Map<String, Integer> taskIdMap = new HashMap<>();
        
        for (int i = 0; i < parentTasks.size(); i++) {
            ProjectTaskVO taskVO = parentTasks.get(i);
            taskVO.setPrjctNo(prjctNo);
            
            // 업무 등록
            projectTaskMapper.insertProjectTask(taskVO);
            
            // 클라이언트 ID와 DB ID 매핑
            taskIdMap.put("task-" + i, taskVO.getTaskNo());
        }
        
        log.info("상위 업무 일괄 등록 완료: {}", taskIdMap);
        return taskIdMap;
    }

	@Override
	 public int insertChildTasks(Map<String, List<ProjectTaskVO>> childTasksMap, 
             Map<String, Integer> taskIdMap, int prjctNo) {
		log.info("하위 업무 일괄 등록 시작: 상위업무 개수={}", childTasksMap.size());
		
		int totalInserted = 0;
		
		for (Map.Entry<String, List<ProjectTaskVO>> entry : childTasksMap.entrySet()) {
		String parentClientId = entry.getKey();
		List<ProjectTaskVO> childTasks = entry.getValue();
		
		// 상위 업무 ID 찾기
		Integer parentTaskId = taskIdMap.get(parentClientId);
		if (parentTaskId == null) {
		log.warn("상위 업무 ID를 찾을 수 없음: {}", parentClientId);
		continue;
		}
		
		// 하위 업무 등록
		for (ProjectTaskVO childTask : childTasks) {
		childTask.setPrjctNo(prjctNo);
		childTask.setUpperTaskNo(parentTaskId);
		
		projectTaskMapper.insertProjectTask(childTask);
		totalInserted++;
		}
		}
		
		log.info("하위 업무 일괄 등록 완료: 총 {}개 등록", totalInserted);
		return totalInserted;
	}
}
