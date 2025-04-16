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
	public ProjectVO projectDetail(long prjctNo);
	public int createProject(ProjectVO projectVO, List<ProjectTaskVO> taskList);
	public boolean deleteProject(Long prjctNo); 
	public void updateProject(ProjectVO projectVO);
	public List<Map<String, Object>> getProjectCategoryList();
	public List<Map<String, Object>> getProjectStatusList();
	public List<Map<String, Object>> getProjectGradeList();
	public int selectMaxProjectNo();

}
