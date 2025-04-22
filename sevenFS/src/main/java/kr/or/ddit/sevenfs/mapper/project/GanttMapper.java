package kr.or.ddit.sevenfs.mapper.project;

import kr.or.ddit.sevenfs.vo.project.GanttTaskVO;
import kr.or.ddit.sevenfs.vo.project.LinkVO;
import kr.or.ddit.sevenfs.vo.project.ProjectTaskEntity;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface GanttMapper {

    List<ProjectTaskEntity> selectTaskEntitiesByProjectNo(int prjctNo);

    List<GanttTaskVO> selectProjectTasksByProjectNo(int prjctNo); // (선택적)

    List<LinkVO> selectAllLinks();

    int insertTask(GanttTaskVO task);

    int updateTask(GanttTaskVO task);

    int deleteTask(long taskId);

    int insertLink(LinkVO link);

    int updateLink(LinkVO link);

    int deleteLink(long linkId);
}
