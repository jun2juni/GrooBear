package kr.or.ddit.sevenfs.mapper.project;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.sevenfs.vo.project.TaskAnsertVO;

@Mapper
public interface TaskAnsertMapper {

	public void saveTaskAnswer(TaskAnsertVO vo);
	
	public List<TaskAnsertVO> selectTaskAnswer(Map<String, Object> params);
	
	public void updateTaskAnswer(int taskAnswerSn, String answerCn);
	
	public void deleteTaskAnswer(int taskAnswerSn);
	
	public int deleteTaskAnswersByProject(@Param("prjctNo") long prjctNo);


}
