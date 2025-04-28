package kr.or.ddit.sevenfs.vo.atrz;

import java.util.List;

import lombok.Data;

@Data
public class SalaryVO {
	private int salaryNo;		//급여명세서번호
	private String atrzDocNo; 	//전자결재문서번호
	private int baseSalary; 	//기본급
	private int mealAllowance;	//식대
	private int incomeTax;		//소득세
	private int localTax;		//지방소득세
	private int pension;		//국민연금
	private int employmentIns;	//고용보험
	private int healthIns;		//건강보험료
	private int careIns;		//장기요양보험
	private String payDate;		//지급일 지급달
	private int totalPay;     //합계금액
	private int totalDed;     //공제금액
	private int netPay;		//실지급액
	
	//테이블을 3가지를 조인하는경우 이것이 필요함
	//DOCUM_HOLIDAY : ATRZ_LINE = 1 : N
	private List<AtrzLineVO> atrzLineVOList;
	
	// 1:1 인경우
	private AtrzVO atrzVO;
}
