package kr.or.ddit.sevenfs.service.schedule;

import java.util.List;
import java.util.Map;

import kr.or.ddit.sevenfs.vo.schedule.ScheduleLabelVO;
import kr.or.ddit.sevenfs.vo.schedule.ScheduleVO;

public interface ScheduleService {
	// 서비스
	int scheduleInsert(ScheduleVO scheduleVO);

	Map<String,Object> scheduleList(ScheduleVO scheduleVO);

	int scheduleUpdate(ScheduleVO scheduleVO);

	int delCalendar(int schdulNo);

	int scheduleUpdateMap(Map<String, Object> uptMap);

	Map<String, Object> calendarLabeling(Map<String, Object> fltrLbl);

}
