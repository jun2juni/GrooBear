package kr.or.ddit.sevenfs.mapper.project;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.sevenfs.vo.project.ProjectTaskVO;
import kr.or.ddit.sevenfs.vo.project.ProjectVO;

@Mapper
public interface ProjectTaskMapper {

	public int insertProjectTask(ProjectTaskVO taskVO);

	public List<ProjectTaskVO> getParentTasks(int prjctNo); 
	
	public void insertProjectTaskBatch(List<ProjectTaskVO> taskList);


}
