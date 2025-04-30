package kr.or.ddit.sevenfs.vo.atrz;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class AtrzLineVO {
	private String atrzDocNo;//전자결재 문서 번호*
	private int atrzLnSn;//전자결재 선 순번*
	private String sanctnerEmpno;//처음 결재를 요청 받은 사번*
	private String sanctnerClsfCode; //결재자 직급코드*
	private String contdEmpno;
	private String contdClsfCode;
	private String dcrbManEmpno;
	private String dcrbManClsfCode;
	private String atrzTy;//N 결재 Y 참조*
	private String sanctnProgrsSttusCode;//00 대기중/ 10 승인 / 20 반려 / 30 회수(상신취소) / 50 전결 / 60 대결 
	private String dcrbAuthorYn;//0 / 1 전결권한여부 *
	private String contdAuthorYn;
	private String sanctnOpinion;
	private String eltsgnImage;
	private Date sanctnConfmDt;  //결재완료일시
	//마지막 결재자 순번을 위해 추가한것
	private int atrzLastLnSn;//전자결재 선 순번*
	
	private List<AtrzLineVO> atrzLineList;    //전자결재선 리스트
	
	private String sanctnerClsfNm; //결재자 직급명
	private String sanctnerDeptNm; //결재자 부서명
	private String sanctnerEmpNm; //결재자 이름
	
	private String befSanctnerEmpno;
	private String befSanctnProgrsSttusCode;
	private String aftSanctnerEmpno;
	private String aftSanctnProgrsSttusCode;
	private int    maxAtrzLnSn;
}
