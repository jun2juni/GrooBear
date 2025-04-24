package kr.or.ddit.sevenfs.service.project.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.sevenfs.mapper.project.TaskAnsertMapper;
import kr.or.ddit.sevenfs.service.project.TaskAnsertService;
import kr.or.ddit.sevenfs.vo.project.TaskAnsertVO;


@Service
public class TaskAnsertServiceImpl implements TaskAnsertService {

	@Autowired
	TaskAnsertMapper taskAnswerMapper;
	
	@Override
	public void saveTaskAnswer(TaskAnsertVO vo) {
		// TODO Auto-generated method stub
		taskAnswerMapper.saveTaskAnswer(vo);
	}

	@Override
	public List<TaskAnsertVO> selectTaskAnswer(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return taskAnswerMapper.selectTaskAnswer(params);
	}

	@Override
	public void updateTaskAnswer(int taskAnswerSn, String answerCn) {
		// TODO Auto-generated method stub
		taskAnswerMapper.updateTaskAnswer(taskAnswerSn, answerCn);
	}

	@Override
	public void deleteTaskAnswer(int taskAnswerSn) {
		// TODO Auto-generated method stub
		taskAnswerMapper.deleteTaskAnswer(taskAnswerSn);
	}

	
}
