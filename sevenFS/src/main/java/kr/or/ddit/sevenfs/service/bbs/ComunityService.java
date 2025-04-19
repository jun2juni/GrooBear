package kr.or.ddit.sevenfs.service.bbs;

import java.util.List;
import java.util.Map;

import kr.or.ddit.sevenfs.utils.ArticlePage;
import kr.or.ddit.sevenfs.vo.bbs.BbsVO;
import kr.or.ddit.sevenfs.vo.bbs.ComunityVO;

public interface ComunityService {
	
	
	// 보드 인서트  - 커뮤니티> 게시판
	public int comunityMenuInsert(BbsVO bbsVO);
	
	// 글 수 구하기 => 페이징 블록을 좌우함
	public int getTotal(Map<String, Object> map);

	public List<BbsVO> comunityMonthMenuList(ArticlePage<BbsVO> articlePage);

	public BbsVO comunityMonthMenuDetail(int bbsSn);

	public int comunityMonthMenuUpdate(BbsVO bbsVO);

	// 여기부터 sns
	public List<ComunityVO> comunityClubList(ComunityVO comunityVO);
	
	public int insertContent(ComunityVO comunityVO);
	


}
