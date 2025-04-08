package kr.or.ddit.sevenfs.service.bbs.Impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.sevenfs.mapper.bbs.AnswerMapper;
import kr.or.ddit.sevenfs.service.bbs.AnswerService;
import kr.or.ddit.sevenfs.vo.bbs.AnswerVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class AnswerServiceImpl implements AnswerService {
	
	@Autowired
	AnswerMapper answerMapper;
	
	@Override
	public void saveAnswer(AnswerVO vo) {
		// TODO Auto-generated method stub
		answerMapper.insertAnswer(vo);
	}

	@Override
	public List<AnswerVO> selectAnswer(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return answerMapper.selectAnswer(params);
	}

}
