package kr.or.ddit.sevenfs.service.schedule;

import java.util.List;
import java.util.Map;

import kr.or.ddit.sevenfs.vo.schedule.ScheduleLabelVO;
import kr.or.ddit.sevenfs.vo.schedule.ScheduleVO;

/**
 * <pre>
 *  scheduleInsert -> 추가
 *  scheduleList -> 리스트
 * </pre>
 * */
public interface ScheduleService {
	// 서비스
	
	/**
	 * <pre>
	 * 일정 입력 하는 메소드 
	 * 파라미터 : ScheduleVO
	 * 
	 * VO에 담기는 데이터 
	 * - 사원 번호 : String emplNo	
	 * - 일정 유형 : String schdulTy	비고 : 일정 유형 0:개인공개 1:부서공개 2:전체공개
	 * - 일정 제목 : String schdulSj	
	 * - 일정 내용 : String schdulCn   비고 : null이어도 됨.
	 * - 시작 일자 : Date schdulBeginDt
	 * - 종료 일자 : Date schdulEndDt
	 * - 부서 번호 : String deptCode
	 * </pre>
	 * */
	int scheduleInsert(ScheduleVO scheduleVO);
	
	/**
	 *  <pre>
	 *  일정 리스트 가져오는 메소드(라벨도 가져옴)
	 *  파라미터 : ScheduleVO
	 *  
	 *  VO에 담기는 데이터
	 *  - String emplNo
	 *  - String deptCode
	 *  </pre>
	 * */
	Map<String,Object> scheduleList(ScheduleVO scheduleVO);

	int scheduleUpdate(ScheduleVO scheduleVO);

	int delCalendar(int schdulNo);

	int scheduleUpdateMap(Map<String, Object> uptMap);

	Map<String, Object> calendarLabeling(Map<String, Object> fltrLbl);

}
