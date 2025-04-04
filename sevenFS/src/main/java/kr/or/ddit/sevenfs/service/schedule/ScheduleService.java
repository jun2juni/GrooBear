package kr.or.ddit.sevenfs.service.schedule;

import java.util.List;
import java.util.Map;

import kr.or.ddit.sevenfs.vo.schedule.ScheduleVO;

public interface ScheduleService {

	int scheduleInsert(ScheduleVO scheduleVO);

	List<ScheduleVO> scheduleList();

	int scheduleUpdate(ScheduleVO scheduleVO);

	int delCalendar(int schdulNo);

	int scheduleUpdateMap(Map<String, Object> uptMap);

}
