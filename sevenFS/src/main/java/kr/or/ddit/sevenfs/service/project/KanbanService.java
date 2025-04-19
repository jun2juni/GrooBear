package kr.or.ddit.sevenfs.service.project;

import kr.or.ddit.sevenfs.vo.project.ProjectTaskVO;
import kr.or.ddit.sevenfs.vo.project.ProjectVO;
import kr.or.ddit.sevenfs.vo.project.TaskVO;

import java.util.List;

import org.springframework.stereotype.Service;


public interface KanbanService {

    List<ProjectTaskVO> getTasksByProject(Long prjctNo);

    boolean updateTaskStatus(Long taskNo, String newStatus);

    ProjectTaskVO getTaskById(Long taskNo);

    List<TaskVO> getCardsByProject(Long prjctNo);
    
    TaskVO getTaskCardById(Long taskNo);


}
