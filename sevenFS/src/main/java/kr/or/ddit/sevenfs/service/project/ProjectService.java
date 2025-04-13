package kr.or.ddit.sevenfs.service.project;

import java.util.List;
import java.util.Map;

import kr.or.ddit.sevenfs.utils.ArticlePage;
import kr.or.ddit.sevenfs.vo.AttachFileVO;
import kr.or.ddit.sevenfs.vo.project.ProjectEmpVO;
import kr.or.ddit.sevenfs.vo.project.ProjectTaskVO;
import kr.or.ddit.sevenfs.vo.project.ProjectVO;

public interface ProjectService {

	public List<ProjectVO> projectList(Map<String, Object> map);
	public int getTotal(Map<String, Object> map);
	public int insertProject(ProjectVO projectVO);
	public int insertProjectEmpBatch(List<ProjectEmpVO> projectEmpList);
	public ProjectVO projectDetail(int prjctNo);
	public int createProject(ProjectVO projectVO, List<ProjectTaskVO> taskList);
	public void deleteProject(int prjctNo);



	
}
