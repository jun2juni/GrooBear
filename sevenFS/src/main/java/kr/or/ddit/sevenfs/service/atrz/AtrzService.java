package kr.or.ddit.sevenfs.service.atrz;

import java.util.List;

import kr.or.ddit.sevenfs.vo.atrz.AtrzVO;
import kr.or.ddit.sevenfs.vo.atrz.DraftVO;

public interface AtrzService {
	//목록 출력
	public List<AtrzVO> list();
	
	//기안문서 post
	public int draftInsert(DraftVO draftVO);
	
	//기안문서 상세보기
	public DraftVO draftDetail(String draftNo);
	
	//전자결재와 기안문서 조인을 위한것
	public AtrzVO atrzDetail(String atrzDocNo);
	
	//비즈니스 로직 이란???
	//컨드롤러에서는 화면에서 보여지는것만 
	//mapper에는 db연결만 
	//service는 로직처리한다.
	
	
}
