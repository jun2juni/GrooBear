package kr.or.ddit.sevenfs.mapper.project;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.sevenfs.vo.project.LinkVO;
import kr.or.ddit.sevenfs.vo.project.TaskVO;

@Mapper
public interface GanttMapper {

    // 업무
    List<TaskVO> selectAllTasksByProject(int prjctNo);
    TaskVO selectTaskById(long taskId);
    int insertTask(TaskVO task);
    int updateTask(TaskVO task);
    int deleteTask(long taskId);

    //  링크
    List<LinkVO> selectAllLinks();
    LinkVO selectLinkById(long linkId);
    int insertLink(LinkVO link);
    int updateLink(LinkVO link);
    int deleteLink(long linkId);
}
