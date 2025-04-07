package kr.or.ddit.sevenfs.mapper.schedule;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.sevenfs.vo.schedule.ScheduleLabelVO;
import kr.or.ddit.sevenfs.vo.schedule.ScheduleVO;

@Mapper
public interface ScheduleMapper {

	int scheduleInsert(ScheduleVO scheduleVO);

	List<ScheduleVO> scheduleList(ScheduleVO scheduleVO);

	int scheduleUpdate(ScheduleVO scheduleVO);

	int delCalendar(int schdulNo);

	List<ScheduleVO> calendarLabeling(Map<String, Object> fltrLbl);

	int delLabelFromSchdule(ScheduleVO scheduleVO);

}
