package kr.or.ddit.sevenfs.service.Schedule.impl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.sevenfs.mapper.ScheduleMapper.ScheduleMapper;
import kr.or.ddit.sevenfs.service.Schedule.ScheduleSertvice;
import kr.or.ddit.sevenfs.vo.Schedule.ScheduleVO;

@Service
public class ScheduleServiceImpl implements ScheduleSertvice{
	
	@Autowired
	ScheduleMapper scheduleMapper;

	@Override
	public int scheduleInsert(ScheduleVO scheduleVO) {
		int result = scheduleMapper.scheduleInsert(scheduleVO);
		return result;
	}

	@Override
	public List<ScheduleVO> scheduleList() {
		List<ScheduleVO> list = scheduleMapper.scheduleList();
		return list;
	}

	@Override
	public int scheduleUpdate(ScheduleVO scheduleVO) {
		int result = scheduleMapper.scheduleUpdate(scheduleVO);
		return result;
	}

	@Override
	public int delCalendar(int schdulNo) {
		return scheduleMapper.delCalendar(schdulNo);
	}

	@Override
	public int scheduleUpdateMap(Map<String, Object> uptMap) {
		int result = 0;
		ScheduleVO scheduleVO;
		List<ScheduleVO> list = new ArrayList<ScheduleVO>();
		Iterator<String> keys = uptMap.keySet().iterator();
		while(keys.hasNext()) {
			String key = keys.next();
			scheduleVO= (ScheduleVO)uptMap.get(key);
			result += scheduleMapper.scheduleUpdate(scheduleVO);
		}
		return result;
	}
}
