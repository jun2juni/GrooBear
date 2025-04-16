package kr.or.ddit.sevenfs.service;

public interface MainService {
	
	// 대기중인 결재 갯수
	public int getAtrzApprovalCnt(String emplNo);
	
	// 진행중인 결재 갯수
	public int getAtrzSubminCnt(String emplNo);
	
	// 완료된 결재 갯수
	public int getAtrzCompletedCnt(String emplNo);
	
	// 반려된 결재 갯수
	public int getAtrzRejectedCnt(String emplNo);

}
