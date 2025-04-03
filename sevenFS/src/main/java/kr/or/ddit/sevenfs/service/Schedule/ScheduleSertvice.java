package kr.or.ddit.sevenfs.service.Schedule;

import java.util.List;
import java.util.Map;

import kr.or.ddit.sevenfs.vo.Schedule.ScheduleVO;

public interface ScheduleSertvice {

	int scheduleInsert(ScheduleVO scheduleVO);

	List<ScheduleVO> scheduleList();

	int scheduleUpdate(ScheduleVO scheduleVO);

	int delCalendar(int schdulNo);

	int scheduleUpdateMap(Map<String, Object> uptMap);

}
