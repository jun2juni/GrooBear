package kr.or.ddit.sevenfs.mapper.atrz;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.sevenfs.vo.atrz.AtrzLineVO;
import kr.or.ddit.sevenfs.vo.atrz.AtrzVO;
import kr.or.ddit.sevenfs.vo.atrz.BankAccountVO;
import kr.or.ddit.sevenfs.vo.atrz.DraftVO;
import kr.or.ddit.sevenfs.vo.atrz.HolidayVO;
import kr.or.ddit.sevenfs.vo.atrz.SalaryVO;
import kr.or.ddit.sevenfs.vo.atrz.SpendingVO;

@Mapper
public interface AtrzMapper {
	//결재 대기중인 문서리스트
	public List<AtrzVO> atrzApprovalList(String emplNo);
	//기안 올린 문서리스트
	public List<AtrzVO> atrzSubmitList(String emplNo);
	//기안완료된 문서리스트
	public List<AtrzVO> atrzCompletedList(String emplNo);
	
	//목록 출력
	public List<AtrzVO> homeList(String emplNo);
	
	//기안문서 detail
	public DraftVO draftDetail(String draftNo);
	
	//전자결재 상세를 보기위한
	public List<AtrzLineVO> atrzLineList(String atrzDocNo);
	
	
	//전자결재 테이블 등록
	public int insertAtrz(AtrzVO atrzVO);
	
	//전자결재선 테이블 등록
	public int insertAtrzLine(AtrzLineVO atrzLineVO);
	
	//연차신청서 테이블 등록
	public int insertHoliday(HolidayVO documHolidayVO);
	//연차신청서 상세
	public AtrzVO holidayDetail(String atrzDocNo);
	
	//지출결의서 테이블 등록
	public int insertSpending(SpendingVO spendingVO);
	//급여명세서 등록
	public int insertSalary(SalaryVO salaryVO);
	//급여계좌변경신청서 테이블 등록
	public int insertBankAccount(BankAccountVO bankAccountVO);
	
	//기안서 등록
	public int insertDraft(DraftVO draftVO);
	
	//전자결재 상세보기 
	public AtrzVO selectAtrzDetail(String atrzDocNo);
	public List<AtrzLineVO> selectAtrzLineList(String atrzDocNo);
	//2) 결재선지정 후에 제목, 내용, 등록일자, 상태 update
	public int insertUpdateAtrz(AtrzVO atrzVO);
	
	
	
	

	
	
}
