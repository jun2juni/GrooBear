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
	private int totYrycDaycnt; // 총 연차일수
	private int yrycUseDaycnt; // 사용 연차일수
	private int yrycMdatDaycnt; // 연차조정일수
	private int yrycRemndrDaycnt; // 연차 잔여일수
	private int excessWorkYryc; // 초과근무연차
	private int cmpnstnYryc; // 보상연차
	
	
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
