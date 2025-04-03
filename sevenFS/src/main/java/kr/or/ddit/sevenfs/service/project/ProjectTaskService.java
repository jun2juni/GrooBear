package kr.or.ddit.sevenfs.service.project;

import java.util.List;
import java.util.Map;

import kr.or.ddit.sevenfs.vo.project.ProjectTaskVO;
import kr.or.ddit.sevenfs.vo.project.ProjectVO;

public interface ProjectTaskService {

	public ProjectVO selectProjectDetail(Long prjctNo);

	public int insertProjectTask(ProjectTaskVO taskVO);

   
    
    /**
     * 프로젝트의 상위 업무 목록 조회
     * @param prjctNo 프로젝트 번호
     * @return 상위 업무 목록
     */
    public  List<ProjectTaskVO> getParentTasks(int prjctNo);
    
    /**
     * 특정 업무의 하위 업무 목록 조회
     * @param taskNo 업무 번호
     * @return 하위 업무 목록
     */
    public List<ProjectTaskVO> getChildTasks(int taskNo);

	public Map<String, Integer> insertParentTasks(List<ProjectTaskVO> parentTasks, int prjctNo);

	
    public int insertChildTasks(Map<String, List<ProjectTaskVO>> childTasksMap, 
            Map<String, Integer> taskIdMap, int prjctNo);
    
}
