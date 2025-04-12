package kr.or.ddit.sevenfs.mapper.organization;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.poi.ss.formula.functions.Today;

import kr.or.ddit.sevenfs.vo.CommonCodeVO;
import kr.or.ddit.sevenfs.vo.organization.DclzTypeDetailVO;
import kr.or.ddit.sevenfs.vo.organization.DclzTypeVO;
import kr.or.ddit.sevenfs.vo.organization.VacationVO;

@Mapper
public interface DclztypeMapper {
	
	// 사원의 근태현황 총 갯수
	public int getTotal(Map<String, Object> map);
	
	// 사원의 연차사용내역 총 갯수
	public int getVacTotal(Map<String, Object> map);
	
	// 모든 사원의 연차 현황 총 행의 갯수
	public int getEmplAllVacTotal();

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
	
	// 사원 한명의 이번년도 연차 정보 가져오기
	public VacationVO emplVacationCnt(String emplNo);
	
	// 공통코드가 연차에 해당하는 사원의 모든 년도 데이터 가져오기
	public List<DclzTypeVO> emplVacationDataList(Map<String, Object> map);

	// 기본연차 지급
	public int basicVacInsert(VacationVO vacationVO);
	
	// 추가 연차지급시 update
	public int addVacInsert(VacationVO vacationVO);
	
	// 모든 사원의 연차 현황
	public List<DclzTypeVO> allEmplVacList(Map<String, Object> map);
	
}
