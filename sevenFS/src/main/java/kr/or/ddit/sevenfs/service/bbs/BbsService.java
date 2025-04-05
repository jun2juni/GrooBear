package kr.or.ddit.sevenfs.service.bbs;

import java.util.List;

import kr.or.ddit.sevenfs.utils.ArticlePage;
import kr.or.ddit.sevenfs.vo.bbs.BbsVO;

public interface BbsService {

	public List<BbsVO> bbsList(ArticlePage<BbsVO> articlePage);

	public int bbsInsert(BbsVO bbsVO);

	public BbsVO bbsDetail(int bbsSn);

	public int bbsUpdate(BbsVO bbsVO);

	public int bbsDelete(int bbsSn);
	
	

}
