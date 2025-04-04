package kr.or.ddit.sevenfs.service.project.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.sevenfs.mapper.project.ProjectMapper;
import kr.or.ddit.sevenfs.service.project.ProjectService;
import kr.or.ddit.sevenfs.utils.ArticlePage;
import kr.or.ddit.sevenfs.vo.AttachFileVO;
import kr.or.ddit.sevenfs.vo.project.ProjectEmpVO;
import kr.or.ddit.sevenfs.vo.project.ProjectVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ProjectServiceImpl implements ProjectService{

	@Autowired
	ProjectMapper projectMapper;
	
	@Override
	public List<ProjectVO> projectList(Map<String, Object> map) {
		
		return projectMapper.projectList(map);
	}

	public int getTotal(Map<String, Object> map) {
		return projectMapper.getTotal(map);
	}

	@Override
	public int projectInsert(ProjectVO projectVO) {
		return projectMapper.projectInsert(projectVO);
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
	
	


}
