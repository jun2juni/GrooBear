package kr.or.ddit.sevenfs.service.atrz;

import java.util.List;

import kr.or.ddit.sevenfs.vo.atrz.AtrzLineVO;
import kr.or.ddit.sevenfs.vo.atrz.AtrzVO;
import kr.or.ddit.sevenfs.vo.atrz.DocumHolidayVO;
import kr.or.ddit.sevenfs.vo.atrz.DraftVO;

public interface AtrzService {
	//사원정보 가져오기
	public List<AtrzVO> atrzEmploInfo();
	
	//목록 출력
	public List<AtrzVO> homeList(String emplNo);
	
	//기안문서 post
	public int draftInsert(DraftVO draftVO);
	
	//기안문서 상세보기
	public DraftVO draftDetail(String draftNo);
	
	//전자결재와 기안문서 조인을 위한것
	public AtrzVO atrzDetail(String atrzDocNo);
	
	//결재대기문서 갯수
	public int beDocCnt(String emplNo);
	
	//전자 결재대기
	public List<AtrzVO> selectHomeBeDoc(String emplNo);
	
	//기안진행문서
	public List<AtrzVO> selectHomeReqDoc(String emplNo);
	
	//결재수신문서갯수
	public int recDocCnt(String emplNo);
	
	//결재 대기 문서
	public List<AtrzVO> selectReceiptDoc(int currentPage, int pageSize, AtrzVO atrzVO);
	public int receiptTotalCnt(AtrzVO atrzVO);
	//결재 수신문서
	public List<AtrzVO> selectBeforeDoc(int currentPage, int pageSize, AtrzVO atrzVO);
	public int beforeTotalCnt(AtrzVO atrzVO);
	
	//문서양식- 연차신청서일때
	public int insertHoDoc();
	
	//전자결재 테이블 인서트
	public int insertAtrz(AtrzVO atrzVO);
	//전자결재선 인서트
	public int insertAtrzLine(AtrzLineVO atrzLineVO);
	//연차신청서 인서트
	public int insertHoliday(DocumHolidayVO documHolidayVO);
	
	//연차신청서 상세보기
	public DocumHolidayVO holidayDetail(int holiActplnNo);
	
	//결재 대기중인 문서리스트
	public List<AtrzVO> atrzApprovalList(String emplNo);
	//기안중인 문서리스트
	public List<AtrzVO> atrzSubmitList(String emplNo);
	//기안완료된 문서리스트
	public List<AtrzVO> atrzCompletedList(String emplNo);
	
	
	//비즈니스 로직 이란???
	//컨드롤러에서는 화면에서 보여지는것만 
	//mapper에는 db연결만 
	//service는 로직처리한다.
	
	
}
