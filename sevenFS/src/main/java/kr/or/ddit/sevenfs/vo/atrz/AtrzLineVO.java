package kr.or.ddit.sevenfs.vo.atrz;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class AtrzLineVO {
	private String atrzDocNo;//전자결재 문서 번호*
	private int atrzLnSn;//전자결재 선 순번*
	private String sanctnerEmpno;//처음 결재를 요청 받은 사번*
	private String sanctnerClsfCode;
	private String contdEmpno;
	private String contdClsfCode;
	private String dcrbManEmpno;
	private String dcrbManClsfCode;
	private String atrzTy;//0 결재 1 참조*
	private String sanctnProgrsSttusCode;//00 대기중, 10 승인, 20 반려, 30 전결, 40 대결 *
	private String dcrbAuthorYn;//Y / N 전결권한여부 *
	private String contdAuthorYn;
	private String sanctnOpinion;
	private String eltsgnImage;
	private Date sanctnConfmDt;
	
	private List<AtrzLineVO> atrzLineList;    //전자결재선 리스트
}
