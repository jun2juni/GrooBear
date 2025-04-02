package kr.or.ddit.sevenfs.service.impl.atrz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.sevenfs.mapper.atrz.AtrzMapper;
import kr.or.ddit.sevenfs.service.atrz.AtrzService;
import kr.or.ddit.sevenfs.vo.atrz.AtrzVO;
import kr.or.ddit.sevenfs.vo.atrz.DraftVO;
@Service
public class AtrzServiceImpl implements AtrzService {
	
	@Autowired
	AtrzMapper atrzMapper;
	
	//목록 출력
	public List<AtrzVO> list() {
		return this.atrzMapper.list();
	}
	//문서양식 post
	@Override
	public int draftInsert(DraftVO draftVO) {
		
		
		return this.atrzMapper.draftInsert(draftVO);
	}
	@Override
	public DraftVO draftDetail(String draftNo) {
		return this.atrzMapper.draftDetail(draftNo);
	}
	@Override
	public AtrzVO atrzDetail(String atrzDocNo) {
		return this.atrzMapper.atrzDetail(atrzDocNo);
	}
	
}
