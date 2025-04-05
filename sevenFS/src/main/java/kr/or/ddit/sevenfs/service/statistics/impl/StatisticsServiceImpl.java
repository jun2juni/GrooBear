package kr.or.ddit.sevenfs.service.statistics.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.sevenfs.mapper.statistics.StatisticsMapper;
import kr.or.ddit.sevenfs.service.statistics.StatisticsService;
import kr.or.ddit.sevenfs.vo.statistics.StatisticsVO;

@Service
public class StatisticsServiceImpl implements StatisticsService {
	
	@Autowired
	StatisticsMapper statisticsMapper;
	
	@Override
	public List<Map<String, Object>> AWOLAjax(StatisticsVO statisticsVO) {
		return this.statisticsMapper.AWOLAjax(statisticsVO);
	}
	
}
