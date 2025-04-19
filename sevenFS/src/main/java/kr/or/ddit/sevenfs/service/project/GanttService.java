package kr.or.ddit.sevenfs.service.project;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.ddit.sevenfs.vo.project.LinkVO;
import kr.or.ddit.sevenfs.vo.project.TaskVO;

public interface GanttService {
    List<TaskVO> getTasksByProject(int prjctNo);
    TaskVO createTask(TaskVO task);
    TaskVO updateTask(TaskVO task);
    void deleteTask(long taskId);

    List<LinkVO> getAllLinks();
    LinkVO createLink(LinkVO link);
    LinkVO updateLink(LinkVO link);
    void deleteLink(long linkId);
    
    List<TaskVO> getProjectTasksByProjectNo(int prjctNo);
    TaskVO getTaskById(long taskId);

}
