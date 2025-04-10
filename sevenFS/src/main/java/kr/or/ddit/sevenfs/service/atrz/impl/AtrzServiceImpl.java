package kr.or.ddit.sevenfs.service.atrz.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.sevenfs.mapper.atrz.AtrzMapper;
import kr.or.ddit.sevenfs.service.atrz.AtrzService;
import kr.or.ddit.sevenfs.utils.ArticlePage;
import kr.or.ddit.sevenfs.vo.AttachFileVO;
import kr.or.ddit.sevenfs.vo.atrz.AtrzLineVO;
import kr.or.ddit.sevenfs.vo.atrz.AtrzVO;
import kr.or.ddit.sevenfs.vo.atrz.BankAccountVO;
import kr.or.ddit.sevenfs.vo.atrz.HolidayVO;
import kr.or.ddit.sevenfs.vo.atrz.SalaryVO;
import kr.or.ddit.sevenfs.vo.atrz.SpendingVO;
import lombok.extern.slf4j.Slf4j;
import kr.or.ddit.sevenfs.vo.atrz.DraftVO;

@Slf4j
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
	
	//기안서 상세
	@Override
	public DraftVO draftDetail(String draftNo) {
		return this.atrzMapper.draftDetail(draftNo);
	}
	
	
	//전자결재테이블 등록
	@Override
	public int insertAtrz(AtrzVO atrzVO) {
		int result = this.atrzMapper.insertAtrz(atrzVO);
		//atrzVO에는 전자결재 문서 번호가 생성되어있음
		
		//2) 결재선들 등록
		List<AtrzLineVO> atrzLineVOList = atrzVO.getAtrzLineVOList();
		log.info("insertAtrzLine->atrzLineVOList(문서번호 생성 후) : " + atrzLineVOList);
		
		for (AtrzLineVO atrzLineVO : atrzLineVOList) {
			atrzLineVO.setAtrzDocNo(atrzVO.getAtrzDocNo());
			
			result += this.atrzMapper.insertAtrzLine(atrzLineVO);
		}
		
		return result;
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
	
	
	//지출결의서 등록
	@Override
	public int insertSpending(SpendingVO spendingVO) {
		return this.atrzMapper.insertSpending(spendingVO);
	}
	//급여명세서 등록
	@Override
	public int insertSalary(SalaryVO salaryVO) {
		return this.atrzMapper.insertSalary(salaryVO);
	}
	//급여계좌변경신청서 등록
	@Override
	public int insertBankAccount(BankAccountVO bankAccountVO) {
		return this.atrzMapper.insertBankAccount(bankAccountVO);
	}
	
	//기안서 등록 
	@Override
	public int insertDraft(DraftVO draftVO) {
		return this.atrzMapper.insertDraft(draftVO);
	}
	//전자결재 상세보기
	@Override
	public AtrzVO getAtrzDetail(String atrzDocNo) {
		AtrzVO atrzVO = atrzMapper.selectAtrzDetail(atrzDocNo);
        if (atrzVO != null) {
            atrzVO.setAtrzLineVOList(atrzMapper.selectAtrzLineList(atrzDocNo));
        }
        return atrzVO;
	}
	
	//2) 결재선지정 후에 제목, 내용, 등록일자, 상태 update
	@Override
	public int insertUpdateAtrz(AtrzVO atrzVO) {
		return this.atrzMapper.insertUpdateAtrz(atrzVO);
	}
	
	
	
}
