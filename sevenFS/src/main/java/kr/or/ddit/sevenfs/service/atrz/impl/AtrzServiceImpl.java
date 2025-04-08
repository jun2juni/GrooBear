package kr.or.ddit.sevenfs.service.atrz.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.sevenfs.mapper.atrz.AtrzMapper;
import kr.or.ddit.sevenfs.service.atrz.AtrzService;
import kr.or.ddit.sevenfs.vo.atrz.AtrzLineVO;
import kr.or.ddit.sevenfs.vo.atrz.AtrzVO;
import kr.or.ddit.sevenfs.vo.atrz.HolidayVO;
import kr.or.ddit.sevenfs.vo.atrz.SpendingVO;
import kr.or.ddit.sevenfs.vo.atrz.DraftVO;
@Service
public class AtrzServiceImpl implements AtrzService {
	
	@Autowired
	AtrzMapper atrzMapper;
	
	//결재 대기중인 문서리스트
	@Override
	public List<AtrzVO> atrzApprovalList(String emplNo) {
		return this.atrzMapper.atrzApprovalList(emplNo);
	}
	//기안중인 문서리스트
	@Override
	public List<AtrzVO> atrzSubmitList(String emplNo) {
		return this.atrzMapper.atrzSubmitList(emplNo);
	}
	//기안완료된 문서리스트
	@Override
	public List<AtrzVO> atrzCompletedList(String emplNo) {
		return this.atrzMapper.atrzCompletedList(emplNo);
	}
	
	//목록 출력
	public List<AtrzVO> homeList(String emplNo) {
		return this.atrzMapper.homeList(emplNo);
	}
	
	//문서양식 post
	@Override
	public int draftInsert(DraftVO draftVO) {
		return this.atrzMapper.draftInsert(draftVO);
	}
	
	//기안서 상세
	@Override
	public DraftVO draftDetail(String draftNo) {
		return this.atrzMapper.draftDetail(draftNo);
	}
	
	//전자결재와 기안문서 조인을 위한것
	@Override
	public AtrzVO atrzDetail(String atrzDocNo) {
		return this.atrzMapper.atrzDetail(atrzDocNo);
	}
	
	//전자결재테이블 등록
	@Override
	public int insertAtrz(AtrzVO atrzVO) {
		return this.atrzMapper.insertAtrz(atrzVO);
	}
	//전자결재선 등록
	@Override
	public int insertAtrzLine(AtrzLineVO atrzLineVO) {
		return this.atrzMapper.insertAtrzLine(atrzLineVO);
	}
	//연차신청서 등록
	@Override
	public int insertHoliday(HolidayVO documHolidayVO) {
		return this.atrzMapper.insertHoliday(documHolidayVO);
	}
	
	//연차신청서 상세보기
	@Override
	public HolidayVO holidayDetail(int holiActplnNo) {
		return this.atrzMapper.holidayDetail(holiActplnNo);
	}
	
	//지출결의서등록
	@Override
	public int insertSpending(SpendingVO spendingVO) {
		return this.atrzMapper.insertSpending(spendingVO);
	}
	
	
	
	
}
