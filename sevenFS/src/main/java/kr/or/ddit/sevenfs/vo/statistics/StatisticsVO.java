package kr.or.ddit.sevenfs.vo.statistics;

import java.util.List;

import lombok.Data;

@Data
public class StatisticsVO {
	//1. 연간
	private String interval;
	private String chartType;
	private String startYearsY;
	private String endYearsY;
	private String[] dept;//checkbox
	private List<String> deptList;
	
	//2. 월간
	private String startYearsM;
	private String startMonths;
	private String endMonths;
	
	//3) 일간
	private String startDays;
	private String endDays;
	
	// 범례로 지정된 날짜에 대한 타입명 -- GOOGLE API DATA HEADERS =>  
	private String monterm;
	
	// 최종본
	private String started;
	private String ended;
}
