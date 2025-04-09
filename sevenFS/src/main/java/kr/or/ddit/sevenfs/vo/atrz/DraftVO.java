package kr.or.ddit.sevenfs.vo.atrz;

import java.util.List;

import lombok.Data;

@Data
public class DraftVO {
	private int draftNo;
	private String atrzDocNo;
	
	//테이블을 3가지를 조인하는경우 이것이 필요함
	//DOCUM_HOLIDAY : ATRZ_LINE = 1 : N
	private List<AtrzLineVO> atrzLineVOList;
	
	// 1:1 인경우
	private AtrzVO atrzVO;
}
