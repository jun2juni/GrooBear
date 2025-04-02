package kr.or.ddit.sevenfs.mapper.atrz;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.sevenfs.vo.atrz.AtrzVO;
import kr.or.ddit.sevenfs.vo.atrz.DraftVO;

@Mapper
public interface AtrzMapper {
	
	//목록 출력
	public List<AtrzVO> list();
	
	//기안문서 post
	public int draftInsert(DraftVO draftVO);
	
	//기안문서 detail
	public DraftVO draftDetail(String draftNo);
	
	//전자결재와 기안문서 조인하기 위한것
	public AtrzVO atrzDetail(@Param("atrzDocNo") String atrzDocNo);

	
}
