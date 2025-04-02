package kr.or.ddit.sevenfs.vo.atrz;

import java.util.Date;
import java.util.List;

import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import lombok.Data;

@Data
public class AtrzVO {
	private String atrzDocNo; // 전자결재 문서번호
	private String drafterEmpno; // 기안자 사번
	private String drafterClsf; // 기안자 직급
	private String drafterEmpnm; //기안자 이름
	private String drafterDept; //기안자 부서
	private String bkmkYn; // 즐겨찾기 여부
	private int atchFileNo; // 첨부 파일 번호
	private String atrzSj; // 전자결재 제목
	private String atrzCn; // 작성 문서 내용
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
	
	// 검색필터
	private String type; // 검색타입
	private String keyword; // 검색내용
	
	private List<DraftVO> drafts; // 기안 목록 (1:N 관계)
	
	//기안자의 정보를 가져오기 위한것
	private EmployeeVO empAtrzVO;
}
