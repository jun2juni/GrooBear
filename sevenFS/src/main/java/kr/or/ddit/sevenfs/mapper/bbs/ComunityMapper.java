package kr.or.ddit.sevenfs.mapper.bbs;

import java.util.List;
import java.util.Map;

import kr.or.ddit.sevenfs.vo.bbs.BbsCategoryVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.sevenfs.utils.ArticlePage;
import kr.or.ddit.sevenfs.vo.bbs.BbsVO;

@Mapper
public interface ComunityMapper {

	//월별 메뉴삽입
	public int comunityMenuInsert(BbsVO bbsVO);
	//월별 메뉴 조회
	public List<BbsVO> comunityMonthMenuList(@Param("articlePage") ArticlePage<BbsVO> articlePage);
}
