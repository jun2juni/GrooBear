package kr.or.ddit.sevenfs.service.statistics;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import kr.or.ddit.sevenfs.vo.statistics.StatisticsVO;

public interface StatisticsService {
	
	//AWOL 근태 지각 조퇴 통계
	public List<Map<String,Object>> getAWOL(String started, String ended, String[] dclzCodeList);
}
