package kr.or.ddit.sevenfs.service.schedule.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.sevenfs.mapper.schedule.ScheduleMapper;
import kr.or.ddit.sevenfs.service.schedule.ScheduleLabelService;
import kr.or.ddit.sevenfs.service.schedule.ScheduleService;
import kr.or.ddit.sevenfs.vo.schedule.ScheduleLabelVO;
import kr.or.ddit.sevenfs.vo.schedule.ScheduleVO;

@Service
public class ScheduleServiceImpl implements ScheduleService{
	
	@Autowired
	ScheduleMapper scheduleMapper;
	
	@Autowired
	ScheduleLabelService labelService;

	
	@Override
	public Map<String,Object> scheduleList(ScheduleVO scheduleVO) {
		Map<String,Object> myCalendar = new HashMap<String,Object>();
		List<ScheduleVO> scheduleList = scheduleMapper.scheduleList(scheduleVO);
		List<ScheduleLabelVO> labelList = labelService.getLabel(scheduleVO);
		myCalendar.put("scheduleList", scheduleList);
		myCalendar.put("labelList", labelList);
		return myCalendar;
	}
	
	@Override
	public int scheduleInsert(ScheduleVO scheduleVO) {
		int result = scheduleMapper.scheduleInsert(scheduleVO);
		return result;
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
