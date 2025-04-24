package kr.or.ddit.sevenfs.service.project;

import java.util.List;
import java.util.Map;

import kr.or.ddit.sevenfs.vo.project.TaskAnsertVO;

public interface TaskAnsertService {
	
   public void saveTaskAnswer(TaskAnsertVO vo);
   
   public List<TaskAnsertVO> selectTaskAnswer(Map<String, Object> params);
   
   public void updateTaskAnswer(int taskAnswerSn, String answerCn);
   
   public void deleteTaskAnswer(int taskAnswerSn);
}

