package kr.or.ddit.sevenfs.vo.organization;

import lombok.Data;

// 연차 VO

@Data
public class VacationVO {

	private String emplNo;
	private String yrycYear;
	private String yrycUseBeginDate;
	private String yrycUseEndDate;
	private int totYrycDaycnt;
	private int yrycUseDaycnt;
	private int yrycMdatDaycnt;
	private int yrycRemndrDaycnt;
	private int excessWorkYryc;
	private int cmpnstnYryc;
	
	
}
