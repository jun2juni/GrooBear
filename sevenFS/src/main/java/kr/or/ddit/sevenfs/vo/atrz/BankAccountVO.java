package kr.or.ddit.sevenfs.vo.atrz;

import java.util.List;

import lombok.Data;

@Data
public class BankAccountVO {
	private int bankAccNo;  //급여계좌변경신청서번호
	private String atrzDocNo; //전자결재 문서번호
	private String oldBank;   //기존 은행명
	private String oldAccNo;	//기존 계좌번호
	private String newBank;		//새 은행명
	private String newAccNo;	//새 계좌번호
	private String reason;		//변경사유
	
	//테이블을 3가지를 조인하는경우 이것이 필요함
	//DOCUM_HOLIDAY : ATRZ_LINE = 1 : N
	private List<AtrzLineVO> atrzLineVOList;
	
	// 1:1 인경우
	private AtrzVO atrzVO;
}
