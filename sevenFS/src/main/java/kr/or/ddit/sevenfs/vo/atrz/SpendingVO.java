package kr.or.ddit.sevenfs.vo.atrz;

import java.util.List;

import lombok.Data;

@Data
public class SpendingVO {
	private int spendingReportNo;      //지출결의서번호R
	private String atrzDocNo;			//전자결재문서번호
	private int expenseOrder;			//지출내역번호
	private String expenseDate;			//지출내역날짜
	private String itemDescription;		//지출내역
	private int itemQuantity;			//지출수량
	private String itemAmount;			//지출금액
	private String paymentMethod;		//지출수단(결재수단)
	private String spendDelete;		//지출결의서 삭제여부
	
	
	//테이블을 3가지를 조인하는경우 이것이 필요함
	//DOCUM_HOLIDAY : ATRZ_LINE = 1 : N
	private List<AtrzLineVO> atrzLineVOList;
	
	// 1:1 인경우
	private AtrzVO atrzVO;
	

}
