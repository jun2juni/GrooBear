package kr.or.ddit.sevenfs.service.project.impl;

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
public class ProjectServiceImpl implements ProjectService{

	@Autowired
	ProjectMapper projectMapper;
	
	@Autowired
	ProjectTaskMapper projectTaskMapper;
	
	@Override
	public List<ProjectVO> projectList(Map<String, Object> map) {
		
		return projectMapper.projectList(map);
	}

	public int getTotal(Map<String, Object> map) {
		return projectMapper.getTotal(map);
	}

	@Override
	public int insertProject(ProjectVO projectVO) {
		return projectMapper.insertProject(projectVO);
	}

	@Override
	public int insertProjectEmpBatch(List<ProjectEmpVO> projectEmpList) {
		// TODO Auto-generated method stub
		return projectMapper.insertProjectEmpBatch(projectEmpList);
	}

	@Override
	public ProjectVO projectDetail(int prjctNo) {
		// TODO Auto-generated method stub
		return projectMapper.projectDetail(prjctNo);
	}

	@Override
	public int createProject(ProjectVO projectVO, List<ProjectTaskVO> taskList) {
	    int insertedCount = 0;

	    insertedCount += projectMapper.insertProject(projectVO);
	    log.info("▶ 프로젝트 생성: {}", projectVO);

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

	    return insertedCount;
	}




	
	


}
