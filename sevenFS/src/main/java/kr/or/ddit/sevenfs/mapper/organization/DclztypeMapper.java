package kr.or.ddit.sevenfs.mapper.organization;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.sevenfs.vo.CommonCodeVO;
import kr.or.ddit.sevenfs.vo.organization.DclzTypeVO;

@Mapper
public interface DclztypeMapper {

	// 사원 근태현황 대분류로 조회
	public CommonCodeVO dclzCnt(String emplNo);
	
}
