package kr.or.ddit.sevenfs.service.project.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.sevenfs.mapper.project.GanttMapper;
import kr.or.ddit.sevenfs.service.project.GanttService;
import kr.or.ddit.sevenfs.vo.project.LinkVO;
import kr.or.ddit.sevenfs.vo.project.ProjectTaskVO;
import kr.or.ddit.sevenfs.vo.project.TaskVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class GanttServiceImpl implements GanttService {

    @Autowired
    private GanttMapper ganttMapper;

    @Override
    public List<TaskVO> getTasksByProject(int prjctNo) {
        return ganttMapper.selectAllTasksByProject(prjctNo);
    }

    @Override
    public TaskVO createTask(TaskVO task) {
        ganttMapper.insertTask(task);
        return task;
    }

    @Override
    public TaskVO updateTask(TaskVO task) {
        ganttMapper.updateTask(task);
        return task;
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
        return link;
    }

    @Override
    public LinkVO updateLink(LinkVO link) {
        ganttMapper.updateLink(link);
        return link;
    }

    @Override
    public void deleteLink(long linkId) {
        ganttMapper.deleteLink(linkId);
    }

	@Override
	public TaskVO getTaskById(long taskId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<TaskVO> getProjectTasksByProjectNo(int prjctNo) {
		// TODO Auto-generated method stub
		return null;
	}
} 
