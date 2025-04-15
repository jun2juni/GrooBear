package kr.or.ddit.sevenfs.mapper.statistics;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.sevenfs.vo.statistics.StatisticsVO;

@Mapper
public interface StatisticsMapper {
	//AWOL 근태 지각 조퇴 통계
	public List<Map<String, Object>> getAWOL(@Param("started") String started,
											 @Param("ended") String ended,
											 @Param("dclzCodeList") String[] dclzCodeList);

	public List<Map<String, Object>> getLATE(@Param("started") String started,
											 @Param("ended") String ended,
											 @Param("dclzCodeList") String[] dclzCodeList);
}
