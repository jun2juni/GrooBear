package kr.or.ddit.sevenfs.vo.atrz;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import lombok.Data;

@Data
public class AtrzVO {
	private String atrzDocNo; // 전자결재 문서번호*
	private String drafterEmpno; // 기안자 사번*
	private String drafterClsf; // 기안자 직급코드*
	
	private String drafterEmpnm; //기안자 이름*
	private String drafterDept; //기안자 부서*
	private String bkmkYn; // 즐겨찾기 여부*
	private int atchFileNo; // 첨부 파일 번호
	private String atrzSj; // 전자결재 제목*
	private String atrzCn; // 작성 문서 내용*
	private String atrzOpinion; // 전자결재 의견
	private Date atrzTmprStreDt; // 임시저장 일시
	private Date atrzDrftDt; // 진행중
	private Date atrzComptDt; // 완료/반려/취소 일시
	private Date atrzRtrvlDt; // 회수 일시
	private String atrzSttusCode; // 상태 코드 (00 진행중 / 10 반려 등)
	private String eltsgnImage; // 전자 서명 이미지 (BASE64)
	private int docFormNo; // 문서 양식 번호
	private String atrzDeleteYn; // 삭제 여부
	private String schdulRegYn; //일정등록 추가 여부  (결재완료 되었을경우에 버튼활성화)
	
	private String docFormNm; // 문서 양식 번호
	
	private String[] emplNoArr; // 결재자 사원번호 배열
	
	
	//전자결재 사원정보를 위한것
	private String emplNo;   	//사원번호
	private String emplNm;		//사원이름
	private String clsfCode; 	//직급코드
	private String clsfCodeNm; //직급코드명 
	private String deptCode;	//부서코드
	private String deptCodeNm;	//부서코드명
	
	//페이징 처리를 위한것
	
	//파일첨부
	private MultipartFile[] uploadFile;
	
	//atrz: atrzLine 1: N
	private List<AtrzLineVO> atrzLineVOList;
	
	// 검색필터
//	private String type; // 검색타입
//	private String keyword; // 검색내용
	
//	private List<DraftVO> drafts; // 기안 목록 (1:N 관계)
	
	//기안자의 정보를 가져오기 위한것
//	private EmployeeVO empAtrzVO;
	
	//ARTZ : DOCUM_HOLIDAY = 1 : 1
	private HolidayVO holidayVO; 			//연차신청서
	private SpendingVO spendingVO;  		//지출결의서
	private SalaryVO salaryVO;				//급여명세서
	private BankAccountVO bankAccountVO;	//급여계좌변경신청서 
	private DraftVO draftVO; 				//기안서 
	
	
	//결재 문서의 해당 직원의 상세정보 목록을 select
	private List<EmployeeVO> emplDetailList;
	
	//기타
	private String authorStatus;//전결 상태
	private String sanctnProgrsSttusCode;//결재 상태
}
