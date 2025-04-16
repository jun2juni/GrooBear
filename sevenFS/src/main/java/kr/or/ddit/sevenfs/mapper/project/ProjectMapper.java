package kr.or.ddit.sevenfs.mapper.project;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.sevenfs.utils.ArticlePage;
import kr.or.ddit.sevenfs.vo.AttachFileVO;
import kr.or.ddit.sevenfs.vo.project.ProjectEmpVO;
import kr.or.ddit.sevenfs.vo.project.ProjectTaskVO;
import kr.or.ddit.sevenfs.vo.project.ProjectVO;


@Mapper
public interface ProjectMapper {

	public List<ProjectVO> projectList(Map<String, Object> map);
	public int getTotal(Map<String, Object> map);

	/* public int insertProjectEmpBatch(List<ProjectEmpVO> projectEmps); */
	public ProjectVO projectDetail(long prjctNo);
	public int insertProject(ProjectVO projectVO);
	public int insertProjectEmpBatch(@Param("list") List<ProjectEmpVO> projectEmpVOList);
	public void deleteProject(int prjctNo);
	public void deleteProjectEmpsByProjectNo(int prjctNo);
	public void updateProject(ProjectVO projectVO);
	public void deleteProjectEmpsByProject(int prjctNo);
	public List<Map<String, Object>> getProjectCategoryList();
	public List<Map<String, Object>> getProjectStatusList();
	public List<Map<String, Object>> getProjectGradeList();

}
