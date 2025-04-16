package kr.or.ddit.sevenfs.service.project.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.sevenfs.mapper.project.GanttMapper;
import kr.or.ddit.sevenfs.service.project.GanttService;
import kr.or.ddit.sevenfs.vo.project.LinkVO;
import kr.or.ddit.sevenfs.vo.project.TaskVO;

import java.util.*;

@Service
public class GanttServiceImpl implements GanttService {

    @Autowired
    private GanttMapper ganttMapper;

    @Override
    public List<TaskVO> getTasksByProject(int prjctNo) {
        List<TaskVO> tasks = ganttMapper.selectAllTasksByProject(prjctNo);
        for (TaskVO task : tasks) {
            validateAndSetDefaults(task);
            calculateDuration(task);
        }
        return tasks;
    }

    @Override
    public TaskVO getTaskById(long taskId) {
        TaskVO task = ganttMapper.selectTaskById(taskId);
        if (task != null) {
            validateAndSetDefaults(task);
            calculateDuration(task);
        }
        return task;
    }

    @Override
    public TaskVO createTask(TaskVO task) {
        validateAndSetDefaults(task);
        if (task.getEndDate().before(task.getStartDate())) {
            Calendar cal = Calendar.getInstance();
            cal.setTime(task.getStartDate());
            cal.add(Calendar.DATE, 1);
            task.setEndDate(cal.getTime());
        }
        ganttMapper.insertTask(task);
        return task;
    }

    @Override
    public TaskVO updateTask(TaskVO task) {
        TaskVO existing = ganttMapper.selectTaskById(task.getTaskId());
        if (existing == null) return task;

        if (task.getTaskText() == null) task.setTaskText(existing.getTaskText());
        if (task.getStartDate() == null) task.setStartDate(existing.getStartDate());
        if (task.getEndDate() == null) task.setEndDate(existing.getEndDate());
        if (task.getProgress() == null) task.setProgress(existing.getProgress());
        if (task.getPriority() == null) task.setPriority(existing.getPriority());
        if (task.getStatus() == null) task.setStatus(existing.getStatus());
        if (task.getOwner() == null) task.setOwner(existing.getOwner());

        if (task.getEndDate().before(task.getStartDate())) {
            Calendar cal = Calendar.getInstance();
            cal.setTime(task.getStartDate());
            cal.add(Calendar.DATE, 1);
            task.setEndDate(cal.getTime());
        }

        ganttMapper.updateTask(task);
        return getTaskById(task.getTaskId());
    }

    @Override
    public void deleteTask(long taskId) {
        ganttMapper.deleteTask(taskId);
    }

    @Override
    public List<LinkVO> getAllLinks() {
        return Optional.ofNullable(ganttMapper.selectAllLinks()).orElse(Collections.emptyList());
    }

    @Override
    public LinkVO createLink(LinkVO link) {
        ganttMapper.insertLink(link);
        return link;
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

    // 유틸
    private void validateAndSetDefaults(TaskVO task) {
        if (task.getStartDate() == null) task.setStartDate(new Date());
        if (task.getEndDate() == null) {
            Calendar cal = Calendar.getInstance();
            cal.setTime(task.getStartDate());
            cal.add(Calendar.DATE, 1);
            task.setEndDate(cal.getTime());
        }
        if (task.getProgress() == null) task.setProgress(0.0);
        if (task.getStatus() == null) task.setStatus(0);
        if (task.getPriority() == null) task.setPriority(1);
        if (task.getParentId() != null && task.getParentId().equals(task.getTaskId())) {
            task.setParentId(0L); // 자기가 자기를 참조하는 건 막자
        }
    }

    private void calculateDuration(TaskVO task) {
        long millis = task.getEndDate().getTime() - task.getStartDate().getTime();
        task.setDuration((int)(millis / (1000 * 60 * 60 * 24)) + 1);
    }
}
