package kr.or.ddit.sevenfs.service.project;

import java.util.List;
import java.util.Map;

import kr.or.ddit.sevenfs.vo.project.ProjectTaskVO;
import kr.or.ddit.sevenfs.vo.project.ProjectVO;

public interface DashboardService {
    public List<Map<String, Object>> countProjectByStatus();
    public List<Map<String, Object>> countTaskMainStatus();
    public List<Map<String, Object>> countTaskByGrade();
    public List<Map<String, Object>> countTaskByProgressGroup();
    public List<ProjectTaskVO> selectUrgentTasks();
    public List<ProjectVO> selectMyProjects(int emplNo);
	public List<Map<String, Object>> countTaskByPriort();
	public Map<String, Map<String, String>> getCommonCodes();
    public List<ProjectTaskVO> selectUrgentTasksAll();

}
