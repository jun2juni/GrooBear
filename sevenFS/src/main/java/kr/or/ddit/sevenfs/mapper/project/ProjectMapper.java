package kr.or.ddit.sevenfs.mapper.project;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.sevenfs.utils.ArticlePage;
import kr.or.ddit.sevenfs.vo.AttachFileVO;
import kr.or.ddit.sevenfs.vo.project.ProjectEmpVO;
import kr.or.ddit.sevenfs.vo.project.ProjectVO;


@Mapper
public interface ProjectMapper {

	public List<ProjectVO> projectList(Map<String, Object> map);
	public int getTotal(Map<String, Object> map);
	public int projectInsert(ProjectVO projectVO);
	public int insertProjectEmpBatch(List<ProjectEmpVO> projectEmps);
	public ProjectVO projectDetail(int prjctNo);

}
