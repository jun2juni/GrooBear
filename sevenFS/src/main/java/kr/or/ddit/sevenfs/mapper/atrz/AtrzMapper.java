package kr.or.ddit.sevenfs.mapper.atrz;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.sevenfs.vo.AttachFileVO;
import kr.or.ddit.sevenfs.vo.atrz.AtrzLineVO;
import kr.or.ddit.sevenfs.vo.atrz.AtrzVO;
import kr.or.ddit.sevenfs.vo.atrz.BankAccountVO;
import kr.or.ddit.sevenfs.vo.atrz.DraftVO;
import kr.or.ddit.sevenfs.vo.atrz.HolidayVO;
import kr.or.ddit.sevenfs.vo.atrz.SalaryVO;
import kr.or.ddit.sevenfs.vo.atrz.SpendingVO;
import kr.or.ddit.sevenfs.vo.organization.DclzTypeVO;
import kr.or.ddit.sevenfs.vo.organization.VacationVO;

@Mapper
public interface AtrzMapper {
	
	//home결재 대기문서
	public List<AtrzVO> homeAtrzApprovalList(String emplNo);
	
	
	//기안진행문서 최신순 5개
	public List<AtrzVO> atrzMinSubmitList(String emplNo);
	//기안완료문서 최신순 5개
	public List<AtrzVO> atrzMinCompltedList(String emplNo);
	
	//결재대기문서
	public List<AtrzVO> atrzApprovalList(Map<String, Object> map);
	//기안진행문서
	public List<AtrzVO> atrzSubmitList(String emplNo);
	//결재완료문서
	public List<AtrzVO> atrzCompletedList(String emplNo);
	
	//참조대기문서
	public List<AtrzVO> atrzReferList(String emplNo);
	//결재예정문서
	public List<AtrzVO> atrzExpectedList(String emplNo);
	
	//기안문서함
	public List<AtrzVO> atrzAllSubmitList(String emplNo);
	//임시저장함
	public List<AtrzVO> atrzStorageList(String emplNo);
	//결재문서함
	public List<AtrzVO> atrzAllApprovalList(String emplNo);

	//반려문서함
	public List<AtrzVO> atrzCompanionList(String emplNo);
	
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
	
	//연차신청서 상세보기
	public HolidayVO holidayDetail(String atrzDocNo);
	//전자결재 문서 상세보기 수정(업데이트)
	public int atrzDetailAppUpdate(AtrzVO atrzVO);
	
	//현재결재선 업데이트 (승인시)
	public void atrzDetailAppUpdate(AtrzLineVO currentLine);
	//전자결재 문서 상태 업데이트 (최종결재자인경우)
	public int atrzStatusFinalUpdate(AtrzVO atrzVO);
	//H_20250411_00003 문서의 결재선 총 스탭수
	public int getMaxStep(AtrzVO atrzVO);
	//나의 전자결재선 상황(1행)
	public AtrzLineVO getAtrzLineInfo(AtrzVO atrzVO);
	
	//현재결재선 업데이트 (반려시)
	public int atrzDetilCompUpdate(AtrzVO atrzVO);
	//전자결재 문서 상태 업데이트 (반려시)
//	public int atrzStatusCompFinalUpdate(AtrzVO atrzVO);
	
	public AtrzVO getAtrzDetail(String atrzDocNo);

	//기안취소시(전자결재 테이블)
	public int atrzCancelUpdate(AtrzVO atrzVO);
	//기안취소시(전자결재선 테이블)
	public int atrzLineCancelUpdate(AtrzVO atrzVO);
	
	//연차신청서 임시저장 인서트
	public void atrzDocStorage(AtrzVO atrzVO);
	//전자결재 업데이트
	public int storageDocUpdate(AtrzVO atrzVO);
	//연차신청서 테이블 임시저장(MERGE INTO)
	public void insertOrUpdateHoliday(HolidayVO documHolidayVO);
	//결재선 삭제!
	public void deleteAtrzLineByDocNo(String atrzDocNo);
	
	//임시저장후 get
	public AtrzVO getAtrzStorage(String atrzDocNo);
	
	//임시저장후 post update
	public void updateOrInsertHoliday(HolidayVO documHolidayVO);
	//연차신청서 post update
	public void updateHolidayAtrz(AtrzVO atrzVO);
	//임시저장후 결재선 인서트(업데이트처럼 활용)
	public void updateAtrzLine(AtrzLineVO atrzLineVO);
	
	//연차신청서 기안완료 select 셀렉트
	public HolidayVO selectHolidayByDocNo(String atrzDocNo);
	//연차신청서 기안완료시 근태현황에 인서트 
	public void holidayDclzUpdate(DclzTypeVO dclzTypeVO);
	//연차갯수 소진하기
	public void updateVacationUseDays(VacationVO vacationVO);
	
	//연차신청서 남은 연차갯수가져오기
	public Double readHoCnt(String empNo);
	//기안자의 연차정보 가져오기
	public VacationVO emplVacationCnt(String draftEmpNo);
	
	//재기안 select
	public AtrzVO selectDocumentReturn(String atrzDocNo);
	
	//임시저장 전자결재선 삭제
	public void deleteStorageAtrzLines(@Param("atrzDocNos")List<String> atrzDocNos);
	//임시저장 연차신청서 삭제
	public void deleteStorageDocumHoliday(@Param("atrzDocNos")List<String> atrzDocNos);
	//임시저장 전자결재 삭제
	public void deleteStorageAtrz(@Param("atrzDocNos")List<String> atrzDocNos);
	
	//결재완료 문서리스트
	public List<AtrzVO> atrzCompleteList(String emplNo);
	//기안작성중 취소시 전자결재 삭제
	public void deleteAtrzWriting(String atrzDocNo);
	//기안작성중 취소시 결재선 삭제
	public void deleteAtrzLineWriting(String atrzDocNo);

	// 결재대기문서목록 행의 수
	public int approvalTotal(Map<String, Object> map);

	//첨부파일 상세보기를 위한것
	public List<AttachFileVO> getAtchFile(long atchFileNo);

	//지출결의서 임시저장을 위한것
	public int storageSpendingUpdate(AtrzVO atrzVO);

	//지출결의서 임시저장 지출결의서 테이블 
	public void insertOrUpdateSpending(SpendingVO spendingVO);

	//지출결의서 상세보기
	public SpendingVO spendingDetail(String atrzDocNo);
	
	
}
