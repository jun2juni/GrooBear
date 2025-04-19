package kr.or.ddit.sevenfs.mapper.bbs;

import java.util.List;
import java.util.Map;

import kr.or.ddit.sevenfs.vo.bbs.BbsCategoryVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.sevenfs.utils.ArticlePage;
import kr.or.ddit.sevenfs.vo.bbs.BbsVO;
import kr.or.ddit.sevenfs.vo.bbs.ComunityVO;

@Mapper
public interface ComunityMapper {

	//월별 메뉴삽입
	public int comunityMenuInsert(BbsVO bbsVO);
	//월별 메뉴 조회
	public List<BbsVO> comunityMonthMenuList(@Param("articlePage") ArticlePage<BbsVO> articlePage);
	//월별 메뉴 상세 조회 
	public BbsVO comunityMonthMenuDetail(int bbsSn);
	//월별 메뉴 업데이트 
	public int comunityMonthMenuUpdate(BbsVO bbsVO);
	
	
	// 여기부터 sns
	//커뮤니티 sns list 추출
	public List<ComunityVO> comunityClubList(ComunityVO comunityVO);
	
	//커뮤니티 글 insert (컨트롤러에서 나눕니다,,,,,)
	public int insertContent(ComunityVO comunityVO);
	
}
