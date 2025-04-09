package kr.or.ddit.sevenfs.service.organization.impl;

import java.time.Duration;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.sevenfs.mapper.organization.DclztypeMapper;
import kr.or.ddit.sevenfs.service.organization.DclztypeService;
import kr.or.ddit.sevenfs.vo.CommonCodeVO;
import kr.or.ddit.sevenfs.vo.organization.DclzTypeDetailVO;
import kr.or.ddit.sevenfs.vo.organization.DclzTypeVO;
import kr.or.ddit.sevenfs.vo.organization.VacationVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class DclztypeServiceImpl implements DclztypeService {

	@Autowired
	DclztypeMapper dclztypeMapper;
	
	@Override
	public DclzTypeVO dclzCnt(String emplNo) {
		return dclztypeMapper.dclzCnt(emplNo);
	}

	// 사원 출퇴근 현황 목록 조회
	@Override
	public List<DclzTypeVO> emplDclzTypeList(Map<String, Object> map) {
		
		//DclzTypeVO dclzTypeVO = new DclzTypeVO();
		
		// 사원의 전체 근태현황
		List<DclzTypeVO> empDclzList = dclztypeMapper.emplDclzTypeList(map);
		log.info("service -> empDclzList : " + empDclzList);
		
		// 총 근무시간 계산 - 다시해야됨
		//String beginTime = empDclzList.get(0).getWorkBeginTime();
		//String endTime = empDclzList.get(0).getWorkEndTime();
		
//		if(endTime != null) {
//			LocalTime begin = LocalTime.parse(beginTime);
//			LocalTime end = LocalTime.parse(endTime);
//
//			Duration duration = Duration.between(begin, end);
//			log.info("시간 : " + duration);
//			
//			long hours = duration.toHours();
//			long minutes = duration.toMinutes();
//			long seconds = duration.toSeconds();
//
//			String allTime = hours+"시간 "+minutes+"분 ";
//			
//			dclzTypeVO.setAllWorkTime(allTime);
//
//		}
		
		return empDclzList;
	}

	// 사원 근태 갯수
	@Override
	public List<DclzTypeDetailVO> empDetailDclzTypeCnt (String emplNo) {
		return dclztypeMapper.empDetailDclzTypeCnt(emplNo);
		
	}

	// 출근시간 등록
	@Override
	public int workBeginInsert(DclzTypeVO dclzTypeVO) {
		return dclztypeMapper.workBeginInsert(dclzTypeVO);
	}

	// 퇴근시간 등록
	@Override
	public int workEndInsert(DclzTypeVO dclzTypeVO) {
		return dclztypeMapper.workEndInsert(dclzTypeVO);
	}

	// 오늘 등록한 출퇴근 시간 가져오기
	@Override
	public DclzTypeVO getTodayWorkTime(DclzTypeVO dclzTypeVO) {
		return dclztypeMapper.getTodayWorkTime(dclzTypeVO);
	}

	// 선택한 년도의 데이터 가져오기
	@Override
	public List<DclzTypeVO>  getSelectYear(Map<String, Object> map) {
		return dclztypeMapper.getSelectYear(map);
	}

	// 년도와 월 모두 선택했을경우
	@Override
	public List<DclzTypeVO> getSelectMonth(Map<String, Object> map) {
		return dclztypeMapper.getSelectMonth(map);
	}

	// 사원의 총 근태현황 갯수
	@Override
	public int getTotal(Map<String, Object> map) {
		return dclztypeMapper.getTotal(map);
	}

	// 사원 한명의 이번년도 연차 정보 가져오기
	@Override
	public VacationVO emplVacationCnt(String emplNo) {
		return dclztypeMapper.emplVacationCnt(emplNo);
	}

	// 공통코드가 연차에 해당하는 사원의 모든 년도 데이터 가져오기
	@Override
	public List<VacationVO> emplVacationDataList(String emplNo) {
		return dclztypeMapper.emplVacationDataList(emplNo);
	}

}
