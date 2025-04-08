package kr.or.ddit.sevenfs.mapper.organization;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.poi.ss.formula.functions.Today;

import kr.or.ddit.sevenfs.vo.CommonCodeVO;
import kr.or.ddit.sevenfs.vo.organization.DclzTypeDetailVO;
import kr.or.ddit.sevenfs.vo.organization.DclzTypeVO;

@Mapper
public interface DclztypeMapper {
	
	// 사원의 근태현황 총 갯수
	public int getTotal(Map<String, Object> map);

	// 사원 근태현황 대분류로 조회
	public DclzTypeVO dclzCnt(String emplNo);
	
	// 사원의 출퇴근 현황 목록
	public List<DclzTypeVO> emplDclzTypeList(Map<String, Object> map);
	
	// 사원 근태 갯수
	public List<DclzTypeDetailVO> empDetailDclzTypeCnt(String emplNo);
	
	// 출근시간 등록
	public int workBeginInsert(DclzTypeVO dclzTypeVO);
	
	// 퇴근시간 등록
	public int workEndInsert(DclzTypeVO dclzTypeVO);
	
	// 오늘 등록한 출퇴근 시간 가져오기
	public DclzTypeVO getTodayWorkTime(DclzTypeVO dclzTypeVO);
	
	// 선택한 년도의 데이터 가져오기
	public List<DclzTypeVO> getSelectYear(Map<String, Object> map);
	
	// 년도와 월 모두 선ㅇ택했을 경우
	public List<DclzTypeVO> getSelectMonth(Map<String, Object> map);
	
}
