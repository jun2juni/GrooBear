package kr.or.ddit.sevenfs.vo.organization;

import java.sql.Date;

import lombok.Data;

// 연차 VO

@Data
public class VacationVO {

	private String emplNo;
	private String yrycYear;
	private String yrycUseBeginDate;
	private String yrycUseEndDate;
	private String yrycDetail;
	private int totYrycDaycnt;
	private int yrycUseDaycnt;
	private int yrycMdatDaycnt;
	private int yrycRemndrDaycnt;
	private int excessWorkYryc;
	private int cmpnstnYryc;
	
	
	// 사원이름
	private String emplNm;
	// 연차 유형명
	private String cmmnCodeNm;
	// 연차 시작일
	private Date dclzBeginDt;
	// 연차 종료일
	private Date dclzEndDt;
	// 근태 사유
	private String dclzReason;
	

}
