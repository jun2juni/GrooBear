package kr.or.ddit.sevenfs.service.project;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.sevenfs.vo.project.ProjectTaskVO;
import kr.or.ddit.sevenfs.vo.project.ProjectVO;

public interface ProjectTaskService {

	public void insertProjectTask(ProjectTaskVO taskVO);
	
	public void insertProjectTaskBatch(List<ProjectTaskVO> taskList);

    public  List<ProjectTaskVO> getParentTasks(int prjctNo);

	public ProjectTaskVO getTaskById(Long taskNo);

	public int updateTask(ProjectTaskVO taskVO);

	public ProjectTaskVO selectTaskById(Long taskNo);
    
	public boolean deleteTask(Long taskNo);

	// TASK_NO 반환하는 메서드
	public Long insertProjectTaskAndGetId(ProjectTaskVO taskVO);

	// 상위 업무 관계 업데이트 메서드
	public boolean updateTaskParent(Long taskNo, Long parentTaskNo);
	
	public void updateTaskParentRelations(List<ProjectTaskVO> tasks);
    
	public Long insertProjectTaskWithFiles(ProjectTaskVO taskVO, MultipartFile[] uploadFiles);

	public boolean hasChildTasks(Long parentTaskNo);
	
	public int updateTaskStatus(long taskId, String status);

    // 업무 일정(Gantt에서 이동/수정) 업데이트
    public void updateSchedule(ProjectTaskVO task);

	public boolean hasTaskAssigned(int prjctNo, String empNo);
}
