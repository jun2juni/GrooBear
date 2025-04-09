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

	    // 1. 프로젝트 등록
	    insertedCount += projectMapper.insertProject(projectVO);
	    log.info("▶▶ 프로젝트 생성: {}", projectVO);

	    // 2. 참여자 등록
	    if (projectVO.getProjectEmpVOList() != null && !projectVO.getProjectEmpVOList().isEmpty()) {
	        for (ProjectEmpVO empVO : projectVO.getProjectEmpVOList()) {
	            empVO.setPrjctNo(projectVO.getPrjctNo());
	            empVO.setEvlManEmpno(empVO.getPrtcpntEmpno()); // 기본으로 자기 자신을 평가
	            empVO.setEvlCn("");
	            empVO.setEvlGrad("1");
	            empVO.setSecsnYn(null);
	            empVO.setPrjctAuthor("0000");
	        }
	        insertedCount += projectMapper.insertProjectEmpBatch(projectVO.getProjectEmpVOList());
	    }
	    log.info("▶▶ 참여자 목록: {}", projectVO.getProjectEmpVOList());

	    // 3. 업무 등록
	    for (ProjectTaskVO task : taskList) {
	        task.setPrjctNo(projectVO.getPrjctNo());
	        task.setTaskSttus("00");
	        task.setProgrsrt(0);
	        insertedCount += projectTaskMapper.insertProjectTask(task);
	    }
	    log.info("▶▶ 업무 목록: {}", taskList);

	    return insertedCount;
	}



	
	


}
