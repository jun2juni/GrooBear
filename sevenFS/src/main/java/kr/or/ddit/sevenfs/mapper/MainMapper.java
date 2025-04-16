package kr.or.ddit.sevenfs.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MainMapper {
	
	// 대기중인 결재 갯수
	public int getAtrzApprovalCnt(String emplNo);
	
	// 진행중인 결재 갯수
	public int getAtrzSubminCnt(String emplNo);
	
	// 완료된 결재 갯수
	public int getAtrzCompletedCnt(String emplNo);
	
	// 반려된 결재 갯수
	public int getAtrzRejectedCnt(String emplNo);
	
}
