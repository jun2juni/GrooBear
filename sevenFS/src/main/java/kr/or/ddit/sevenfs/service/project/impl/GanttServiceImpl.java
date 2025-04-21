package kr.or.ddit.sevenfs.service.project.impl;

import kr.or.ddit.sevenfs.mapper.project.GanttMapper;
import kr.or.ddit.sevenfs.service.project.GanttService;
import kr.or.ddit.sevenfs.vo.project.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
public class GanttServiceImpl implements GanttService {

    @Autowired
    private GanttMapper ganttMapper;

    @Override
    public List<GanttTaskVO> getProjectTasksByProjectNo(int prjctNo) {
        List<ProjectTaskEntity> entities = ganttMapper.selectTaskEntitiesByProjectNo(prjctNo);
        return entities.stream().map(ProjectTaskEntity::toGanttVO).collect(Collectors.toList());
    }
    
    @Override
    public List<ProjectTaskEntity> getTaskEntitiesByProject(int prjctNo) {
        return ganttMapper.selectTaskEntitiesByProjectNo(prjctNo); //
    }


    @Override
    public GanttTaskVO createTask(GanttTaskVO task) {
        ganttMapper.insertTask(task);
        return task;
    }

    @Override
    public GanttTaskVO updateTask(GanttTaskVO task) {
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
}
