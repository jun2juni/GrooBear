package kr.or.ddit.sevenfs.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.sevenfs.vo.bbs.BbsVO;

public interface MainService {
	
	// 대기중인 결재 개수
	public int getAtrzApprovalCnt(String emplNo);
	
	// 진행중인 결재 개수
	public int getAtrzSubminCnt(String emplNo);
	
	// 완료된 결재 개수
	public int getAtrzCompletedCnt(String emplNo);
	
	// 반려된 결재 개수
	public int getAtrzRejectedCnt(String emplNo);
	
	// 미확인 메일 개수
	public int notReadMailCnt(String emplNo);
	
	// 공지사항 게시글 가져오기
	public List<BbsVO> getBbsNoticeList(Map<String, Object> map);

	// 공지사항 총 게시글 수
	public int noticeAllCnt();
	
	// 사원 한명의 오늘 일정 갯수
	public int getEmplTodayCalendar(Map<String, Object> map);
	
}
