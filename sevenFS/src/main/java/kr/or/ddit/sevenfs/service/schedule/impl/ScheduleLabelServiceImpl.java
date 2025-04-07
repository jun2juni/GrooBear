package kr.or.ddit.sevenfs.service.schedule.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.sevenfs.mapper.schedule.ScheduleLabelMapper;
import kr.or.ddit.sevenfs.mapper.schedule.ScheduleMapper;
import kr.or.ddit.sevenfs.service.schedule.ScheduleLabelService;
import kr.or.ddit.sevenfs.service.schedule.ScheduleService;
import kr.or.ddit.sevenfs.vo.schedule.ScheduleLabelVO;
import kr.or.ddit.sevenfs.vo.schedule.ScheduleVO;

@Service
public class ScheduleLabelServiceImpl implements ScheduleLabelService {
	
	@Autowired
	ScheduleLabelMapper labelMapper;
	
	@Autowired
	ScheduleMapper scheduleMapper;
	
//	@Autowired
//	ScheduleService scheduleService;
	
	@Override
	public List<ScheduleLabelVO> getLabel(ScheduleVO scheduleVO) {
		return labelMapper.getLabel(scheduleVO);
	}

	@Override
	public int labelAdd(ScheduleLabelVO labelVO) {
		return labelMapper.labelAdd(labelVO);
	}

	@Override
	public int delLabel(ScheduleVO scheduleVO) {
		int result = scheduleMapper.delLabelFromSchdule(scheduleVO);
		result += labelMapper.delLabel(scheduleVO);
		return result;
	}

	@Override
	public int labelUpdate(ScheduleLabelVO labelVO) {
		return labelMapper.labelUpdate(labelVO);
	}

}
