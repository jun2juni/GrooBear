package kr.or.ddit.sevenfs.mapper.scheduleMapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.sevenfs.vo.schedule.ScheduleVO;

@Mapper
public interface ScheduleMapper {

	int scheduleInsert(ScheduleVO scheduleVO);

	List<ScheduleVO> scheduleList();

	int scheduleUpdate(ScheduleVO scheduleVO);

	int delCalendar(int schdulNo);


}
