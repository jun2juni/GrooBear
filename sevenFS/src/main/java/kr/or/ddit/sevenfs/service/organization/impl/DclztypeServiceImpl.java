package kr.or.ddit.sevenfs.service.organization.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.sevenfs.mapper.organization.DclztypeMapper;
import kr.or.ddit.sevenfs.service.organization.DclztypeService;
import kr.or.ddit.sevenfs.vo.CommonCodeVO;
import kr.or.ddit.sevenfs.vo.organization.DclzTypeDetailVO;
import kr.or.ddit.sevenfs.vo.organization.DclzTypeVO;
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
	public List<DclzTypeVO> emplDclzTypeList(String emplNo) {
		
		DclzTypeVO dclzTypeVO = new DclzTypeVO();
		
		List<DclzTypeVO> empDclzList = dclztypeMapper.emplDclzTypeList(emplNo);
		
		// 사원에 해당하는 근태현황 유형 가져오기
//		List<String> dclzLabel = new ArrayList<>();
//		for(int i=0; i<empDclzList.size(); i++) {
//			String dclzCode = empDclzList.get(i).getDclzCode();
//			 dclzTypeVO.setDclzCode(dclzCode);
//			 dclzLabel.add(dclzTypeVO.getDclzNm());
//		}
//		log.info("dclzLabel : " + dclzLabel);
		
		
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
	public List<DclzTypeVO> getSelectYear(DclzTypeVO dclzTypeVO) {
		return dclztypeMapper.getSelectYear(dclzTypeVO);
	}

	// 년도와 월 모두 선택했을경우
	@Override
	public List<DclzTypeVO> getSelectMonth(DclzTypeVO dclzTypeVO) {
		return dclztypeMapper.getSelectMonth(dclzTypeVO);
	}

}
