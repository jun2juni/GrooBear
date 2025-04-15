package kr.or.ddit.sevenfs.service.statistics.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.sevenfs.mapper.statistics.StatisticsMapper;
import kr.or.ddit.sevenfs.service.statistics.StatisticsService;
import kr.or.ddit.sevenfs.vo.statistics.StatisticsVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class StatisticsServiceImpl implements StatisticsService {
	
	@Autowired
	StatisticsMapper statisticsMapper;

	@Override
	public List<Map<String, Object>> getAWOL(String started, String ended, String[] dclzCodeList) {
		 List<Map<String, Object>> rawList = statisticsMapper.getAWOL(started, ended, dclzCodeList);
		 log.debug("rawList: {}", rawList);
		return rawList;
	}
	
	@Override
	public List<Map<String, Object>> getLATE(String started, String ended, String[] dclzCodeList) {
			List<Map<String, Object>> rawList = statisticsMapper.getLATE(started, ended, dclzCodeList);
			log.debug("rawList: {}", rawList);
		return rawList;
	}

	
	
}
