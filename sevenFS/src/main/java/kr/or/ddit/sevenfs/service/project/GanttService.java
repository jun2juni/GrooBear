package kr.or.ddit.sevenfs.service.project;

import kr.or.ddit.sevenfs.vo.project.GanttTaskVO;
import kr.or.ddit.sevenfs.vo.project.LinkVO;
import kr.or.ddit.sevenfs.vo.project.ProjectTaskEntity;

import java.util.List;

public interface GanttService {

    List<GanttTaskVO> getProjectTasksByProjectNo(int prjctNo);

    List<ProjectTaskEntity> getTaskEntitiesByProject(int prjctNo);

    GanttTaskVO createTask(GanttTaskVO task);

    GanttTaskVO updateTask(GanttTaskVO task);

    void deleteTask(long taskId);

    List<LinkVO> getAllLinks();

    LinkVO createLink(LinkVO link);

    LinkVO updateLink(LinkVO link);

    void deleteLink(long linkId);
}
