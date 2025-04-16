package kr.or.ddit.sevenfs.service.bbs;

import java.util.List;
import java.util.Map;

import kr.or.ddit.sevenfs.utils.ArticlePage;
import kr.or.ddit.sevenfs.vo.bbs.BbsCategoryVO;
import kr.or.ddit.sevenfs.vo.bbs.BbsVO;

public interface BbsService {

	public List<BbsVO> bbsList(ArticlePage<BbsVO> articlePage);

	public int bbsInsert(BbsVO bbsVO);

	public BbsVO bbsDetail(int bbsSn);

	public int bbsUpdate(BbsVO bbsVO);

	public int bbsDelete(int bbsSn);

	//글의 수 구하기->페이징 블록을 좌우함
	public int getTotal(Map<String, Object> map);
	
	// 게시판 카테고리 가죠오기
	public List<BbsCategoryVO> bbsCategoryList();

	// 게시판 일괄삭제
	public void bulkDelete(List<Integer> ids);
}
