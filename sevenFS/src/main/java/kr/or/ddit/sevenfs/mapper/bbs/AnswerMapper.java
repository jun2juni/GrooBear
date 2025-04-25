package kr.or.ddit.sevenfs.mapper.bbs;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.sevenfs.vo.bbs.AnswerVO;

@Mapper
public interface AnswerMapper {

	public void insertAnswer(AnswerVO vo);

	public List<AnswerVO> selectAnswer(Map<String, Object> params);

	public void updateAnswer(int answerNo, String answerCn);

	public void deleteAnswer(int answerNo);

	public AnswerVO findById(Integer parentAnswerNo);

}
