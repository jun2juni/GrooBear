package kr.or.ddit.sevenfs.mapper.project;

import java.util.List;

import kr.or.ddit.sevenfs.vo.project.GanttTaskVO;
import kr.or.ddit.sevenfs.vo.project.LinkVO;
import kr.or.ddit.sevenfs.vo.project.ProjectTaskEntity;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface GanttMapper {
    List<ProjectTaskEntity> selectTaskEntitiesByProjectNo(int prjctNo);
    int insertTask(GanttTaskVO task);
    int updateTask(GanttTaskVO task);
    int deleteTask(long taskId);
    List<LinkVO> selectAllLinks();
    int insertLink(LinkVO link);
    int updateLink(LinkVO link);
    int deleteLink(long linkId);

}
