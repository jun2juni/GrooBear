package kr.or.ddit.sevenfs.service.atrz.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.sevenfs.mapper.atrz.AtrzMapper;
import kr.or.ddit.sevenfs.service.atrz.AtrzService;
import kr.or.ddit.sevenfs.vo.atrz.AtrzLineVO;
import kr.or.ddit.sevenfs.vo.atrz.AtrzVO;
import kr.or.ddit.sevenfs.vo.atrz.DocumHolidayVO;
import kr.or.ddit.sevenfs.vo.atrz.DraftVO;
@Service
public class AtrzServiceImpl implements AtrzService {
	
	@Autowired
	AtrzMapper atrzMapper;
	
	//사원정보가져오기
	@Override
	public List<AtrzVO> atrzEmploInfo() {
		return this.atrzMapper.atrzEmploInfo();
	}
	
	//목록 출력
	public List<AtrzVO> list() {
		return this.atrzMapper.list();
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
	
	//이건뭐지??
	@Override
	public AtrzVO atrzDetail(String atrzDocNo) {
		return this.atrzMapper.atrzDetail(atrzDocNo);
	}
	//결재대기문서 갯수
	@Override
	public int beDocCnt(String emplNo) {
		return this.atrzMapper.beDocCnt(emplNo);
	}
	//전자 결재대기
	@Override
	public List<AtrzVO> selectHomeBeDoc(String emplNo) {
		return this.atrzMapper.selectHomeBeDoc(emplNo);
	}
	//기안진행문서
	@Override
	public List<AtrzVO> selectHomeReqDoc(String emplNo) {
		return this.atrzMapper.selectHomeReqDoc(emplNo);
	}
	//결재수신문서갯수
	@Override
	public int recDocCnt(String emplNo) {
		return this.atrzMapper.recDocCnt(emplNo);
	}
	
	// 결재 수신 문서
	@Override
	public List<AtrzVO> selectReceiptDoc(int currentPage, int pageSize, AtrzVO atrzVO) {
		return this.atrzMapper.selectReceiptDoc(currentPage,pageSize,atrzVO);
	}
	@Override
	public int receiptTotalCnt(AtrzVO atrzVO) {
		return this.atrzMapper.receiptTotalCnt(atrzVO);
	}
	// 결재 대기 문서
	@Override
	public List<AtrzVO> selectBeforeDoc(int currentPage, int pageSize, AtrzVO atrzVO) {
		return this.atrzMapper.selectBeforeDoc(currentPage,pageSize,atrzVO);
	}
	@Override
	public int beforeTotalCnt(AtrzVO atrzVO) {
		return this.atrzMapper.beforeTotalCnt(atrzVO);
	}
	//문서양식-연차신청서인경우
	@Override
	public int insertHoDoc() {
		return this.atrzMapper.insertHoDoc();
	}
	
	//전자결재테이블 인서트
	@Override
	public int insertAtrz(AtrzVO atrzVO) {
		return this.atrzMapper.insertAtrz(atrzVO);
	}
	//전자결재선 인서트
	@Override
	public int insertAtrzLine(AtrzLineVO atrzLineVO) {
		return this.atrzMapper.insertAtrzLine(atrzLineVO);
	}
	//연차신청서 인서트
	@Override
	public int insertHoliday(DocumHolidayVO documHolidayVO) {
		return this.atrzMapper.insertHoliday(documHolidayVO);
	}
	
	
//	
//	//사원의 직급가져오기
//	
//	public String atrzEmplPosi() {
//		
//	}
	
	
}
