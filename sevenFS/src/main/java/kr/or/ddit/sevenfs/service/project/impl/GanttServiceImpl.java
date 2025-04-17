package kr.or.ddit.sevenfs.service.project.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.or.ddit.sevenfs.mapper.project.GanttMapper;
import kr.or.ddit.sevenfs.service.project.GanttService;
import kr.or.ddit.sevenfs.vo.project.LinkVO;
import kr.or.ddit.sevenfs.vo.project.TaskVO;

@Service
public class GanttServiceImpl implements GanttService {

    @Autowired
    private GanttMapper ganttMapper;
    
    @Override
    public List<TaskVO> getTasksByProject(int prjctNo) {
        return ganttMapper.selectAllTasksByProject(prjctNo);
    }

    @Override
    public TaskVO getTaskById(long taskId) {
        return ganttMapper.selectTaskById(taskId);
    }

    @Override
    public TaskVO createTask(TaskVO task) {
        ganttMapper.insertTask(task);
        return ganttMapper.selectTaskById(task.getTaskId());
    }

    @Override
    public TaskVO updateTask(TaskVO task) {
        ganttMapper.updateTask(task);
        return ganttMapper.selectTaskById(task.getTaskId());
    }

    @Override
    public void deleteTask(long taskId) {
        ganttMapper.deleteTask(taskId);
    }

    @Override
    public List<LinkVO> getAllLinks() {
        return ganttMapper.selectAllLinks();
    }

    @Override
    public LinkVO createLink(LinkVO link) {
        ganttMapper.insertLink(link);
        return ganttMapper.selectLinkById(link.getLinkId());
    }

    @Override
    public LinkVO updateLink(LinkVO link) {
        ganttMapper.updateLink(link);
        return ganttMapper.selectLinkById(link.getLinkId());
    }

    @Override
    public void deleteLink(long linkId) {
        ganttMapper.deleteLink(linkId);
    }
}