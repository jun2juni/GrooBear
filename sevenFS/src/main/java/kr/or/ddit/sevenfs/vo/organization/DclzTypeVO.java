package kr.or.ddit.sevenfs.vo.organization;

import java.util.Date;
import java.util.List;

import kr.or.ddit.sevenfs.utils.CommonCode;
import kr.or.ddit.sevenfs.vo.CommonCodeVO;
import lombok.Data;

// 근태 유형 VO
@Data
public class DclzTypeVO {

	private String emplNo;
	private String dclzNo;
	private String dclzCode;
	private Date dclzBeginDt;
	private Date dclzEndDt;
	
	// 근태 대분류 유형 이름
	private String bad; // 근태불량
	private String work; // 근무
	private String vacation; // 휴가
	private String businessTrip; // 출장
	
	// 근태 현황 이름
	private String cmmnCodeNm;
	// 공통코드
	private List<CommonCodeVO> cmmnCode; 
	// 근태 시작 시간
	private String workBeginTime;
	// 근태 종료 시간
	private String workEndTime;
	
	private String workBeginDate;
	private String workEndDate;
	
	// 출근시간
	private String todayWorkStartTime;
	// 퇴근시간
	private String todayWorkEndTime;
	
	// 총 근무 - 시간 기준
	private String workHour;
	// 총 근무 - 분 기준
	private String workMinutes;


}
