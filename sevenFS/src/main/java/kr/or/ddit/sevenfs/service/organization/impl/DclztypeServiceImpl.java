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
	
	// 사원의 근태현황 총 갯수
	@Override
	public DclzTypeVO dclzCnt(String emplNo) {
		return dclztypeMapper.dclzCnt(emplNo);
	}
	
	// 사원의 연차사용내역 총 갯수
	@Override
	public int getVacTotal(Map<String, Object> map) {
		return dclztypeMapper.getVacTotal(map);
	}
	
	// 모든 사원의 연차 현황 총 행의 갯수
	@Override
	public int getEmplAllVacTotal() {
		return dclztypeMapper.getEmplAllVacTotal();
	}
	
	// 근태 selectBox를 위한 근태현황 조회
	@Override
	public List<DclzTypeVO> dclzSelList(String emplNo) {
		return dclztypeMapper.dclzSelList(emplNo);
	}
	
	// 사원 출퇴근 현황 목록 조회
	@Override
	public List<DclzTypeVO> emplDclzTypeList(Map<String, Object> map) {
		return dclztypeMapper.emplDclzTypeList(map);
	}
	
	// 대분류에 따른 사원 근태 갯수
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
	
	@Override
	public int addEmplBeginWorkInsert(String emplNo) {
		return dclztypeMapper.addEmplBeginWorkInsert(emplNo);
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
		
		VacationVO emplVacList = dclztypeMapper.emplVacationCnt(emplNo);
		log.info("service사원연차 : " + emplVacList);
		
		// 총 연차일수
		//double totalYryc = emplVacList.getTotYrycDaycnt();
		// 사용 연차일수
		//double useYryc = emplVacList.getYrycUseDaycnt();
		// 잔여 연차일수 계산
		//double remainYryc = totalYryc - useYryc;
		// 잔여 연차일수 set해주기
		//emplVacList.setYrycRemndrDaycnt(remainYryc);
		//log.info("impl 잔여연차 : " + remainYryc );
		
		//VacationVO vacationVO = new VacationVO();
		// 잔여 연차update 해주기
		//vacationVO.setEmplNo(emplNo);
		//vacationVO.setYrycRemndrDaycnt(remainYryc);
		//dclztypeMapper.updateYrycRemndrDaycnt(vacationVO);
		
		// 연차코드가 23(공가), 24(병가)면 사용일수에서 차감 안되게하기
		return emplVacList;
	}

	// 공통코드가 연차에 해당하는 사원의 모든 년도 데이터 가져오기
	@Override
	public List<DclzTypeVO> emplVacationDataList(Map<String, Object> map) {
		return dclztypeMapper.emplVacationDataList(map);
	}
	
	// 사원 계정 부여시 기본 연차 지급
	@Override
	public int basicVacInsert(VacationVO vacationVO) {
		return dclztypeMapper.basicVacInsert(vacationVO);
	}

	// 연차신청서 결재 완료시 잔여연차 update
	@Override
	public int updateYrycRemndrDaycnt(VacationVO vacationVO) {
		return dclztypeMapper.updateYrycRemndrDaycnt(vacationVO);
	}
	
	// 추가 연차지급시 update
	@Override
	public int addVacInsert(VacationVO vacationVO) {
		
		//log.info("선택사원정보 : " + vacationVO);
		
		// 선택된 사원번호
		String emplNo = vacationVO.getEmplNo();
		//log.info("선택사원 번호 : " + emplNo);
		// 선택된 사원의 연차정보 가져오기
		VacationVO emplVacCnt = dclztypeMapper.emplVacationCnt(emplNo);
		//log.info("선택사원의 연차정보 : " + emplVacCnt);
		
		// 선택사원의 총 연차일수
		double totalVac = emplVacCnt.getTotYrycDaycnt();
		
		// 기본지급으로 받은 연차
		double basicWorkVac = vacationVO.getYrycMdatDaycnt();
		emplVacCnt.setYrycMdatDaycnt(basicWorkVac);
		
		// 초과근무로 받은 연차
		double addWorkVac = vacationVO.getExcessWorkYryc();
		emplVacCnt.setExcessWorkYryc(addWorkVac);
		
		// 성과로 받은 연차
		double cmpnVac = vacationVO.getCmpnstnYryc();
		emplVacCnt.setCmpnstnYryc(cmpnVac);
		
		// 추가로 받은 연차 계산 , 총연차일수+받은연차일수
		double sumTotalVac = totalVac+addWorkVac+cmpnVac+basicWorkVac;
		log.info("계산된 총 연차일수 : " + sumTotalVac);
		emplVacCnt.setTotYrycDaycnt(sumTotalVac);
		
		// 선택사원 연차정보 UPDATE 해주기
		int result = this.dclztypeMapper.addVacInsert(emplVacCnt);
		log.info("update결과 : " + result);
				
		return result;
	}

	// 모든 사원의 연차 현황 - 관리자 조회시
	@Override
	public List<DclzTypeVO> allEmplVacList(Map<String, Object> map) {
		return this.dclztypeMapper.allEmplVacList(map);
	}

	// 메인페이지에서 필요한 사원의 근태현황
	@Override
	public List<DclzTypeVO> mainEmplDclzList(String emplNo) {
		return dclztypeMapper.mainEmplDclzList(emplNo);
	}

}
