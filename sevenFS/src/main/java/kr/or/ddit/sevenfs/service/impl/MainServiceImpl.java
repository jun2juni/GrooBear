package kr.or.ddit.sevenfs.service.impl;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.sevenfs.mapper.MainMapper;
import kr.or.ddit.sevenfs.service.MainService;
import kr.or.ddit.sevenfs.vo.bbs.BbsVO;

@Service
public class MainServiceImpl implements MainService {

	@Autowired
	MainMapper mainMapper;
	
	// 대기중인 결재 갯수
	@Override
	public int getAtrzApprovalCnt(String emplNo) {
		return mainMapper.getAtrzApprovalCnt(emplNo);
	}

	// 진행중인 결재 갯수
	@Override
	public int getAtrzSubminCnt(String emplNo) {
		return mainMapper.getAtrzSubminCnt(emplNo);
	}
	
	// 완료된 결재 갯수
	@Override
	public int getAtrzCompletedCnt(String emplNo) {
		return mainMapper.getAtrzCompletedCnt(emplNo);
	}

	// 반려된 결재 갯수
	@Override
	public int getAtrzRejectedCnt(String emplNo) {
		return mainMapper.getAtrzRejectedCnt(emplNo);
	}

	// 공지사항 게시글 가져오기
	@Override
	public List<BbsVO> getBbsNoticeList(Map<String, Object> map) {
		return mainMapper.getBbsNoticeList(map);
	}

	// 공지사항 총 게시글 수
	@Override
	public int noticeAllCnt() {
		return mainMapper.noticeAllCnt();
	}

	@Override
	public int getEmplTodayCalendar(Map<String, Object> map) {
		return mainMapper.getEmplTodayCalendar(map);
	}
	
}
