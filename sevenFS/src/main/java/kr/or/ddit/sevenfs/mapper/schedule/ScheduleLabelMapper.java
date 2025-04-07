package kr.or.ddit.sevenfs.mapper.schedule;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.sevenfs.vo.schedule.ScheduleLabelVO;
import kr.or.ddit.sevenfs.vo.schedule.ScheduleVO;

@Mapper
public interface ScheduleLabelMapper {

	List<ScheduleLabelVO> getLabel(ScheduleVO scheduleVO);

	int labelAdd(ScheduleLabelVO labelVO);

}
