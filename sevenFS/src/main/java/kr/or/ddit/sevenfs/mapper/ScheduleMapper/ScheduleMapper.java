package kr.or.ddit.sevenfs.mapper.ScheduleMapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.sevenfs.vo.Schedule.ScheduleVO;

@Mapper
public interface ScheduleMapper {

	int scheduleInsert(ScheduleVO scheduleVO);

	List<ScheduleVO> scheduleList();

	int scheduleUpdate(ScheduleVO scheduleVO);

	int delCalendar(int schdulNo);


}
