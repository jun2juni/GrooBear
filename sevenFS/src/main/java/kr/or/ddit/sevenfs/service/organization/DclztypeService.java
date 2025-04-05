package kr.or.ddit.sevenfs.service.organization;

import kr.or.ddit.sevenfs.vo.CommonCodeVO;
import kr.or.ddit.sevenfs.vo.organization.DclzTypeVO;

public interface DclztypeService {

	// 사원 근태현황 대분류로 조회
	public CommonCodeVO dclzCnt(String emplNo);
	
}
