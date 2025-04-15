package kr.or.ddit.sevenfs.mapper.project;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.sevenfs.vo.project.ProjectTaskVO;
import kr.or.ddit.sevenfs.vo.project.ProjectVO;

@Mapper
public interface DashboardMapper {
	
	public List<Map<String, Object>> countProjectByStatus();

	public List<Map<String, Object>> countTaskByStatus();

	public List<Map<String, Object>> countTaskByGrade();

	public List<ProjectVO> selectMyProjects(int emplNo);

	public List<Map<String, Object>> countTaskMainStatus();

	public List<Map<String, Object>> countTaskByProgressGroup();

	public List<ProjectTaskVO> selectUrgentTasks();

	public List<Map<String, Object>> countTaskByPriort();
	
	public List<Map<String, Object>> selectCommonCodes();

}
