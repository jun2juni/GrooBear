package kr.or.ddit.sevenfs.mapper.bbs;

import java.util.List;
import java.util.Map;

import kr.or.ddit.sevenfs.vo.bbs.BbsCategoryVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.sevenfs.utils.ArticlePage;
import kr.or.ddit.sevenfs.vo.bbs.BbsVO;

@Mapper
public interface BbsMapper {

	public List<BbsVO> bbsList(@Param("articlePage") ArticlePage<BbsVO> articlePage);

	public int bbsInsert(BbsVO bbsVO);

	public BbsVO bbsDetail(int bbsSn);

	public int bbsUpdate(BbsVO bbsVO);

	public int bbsDelete(int bbsSn);

	//글의 수 구하기->페이징 블록을 좌우함
	public int getTotal(Map<String, Object> map);

	public void increaseViewCount(int bbsSn);

    List<BbsCategoryVO> bbsCategoryList();

	public void bulkDelete(List<Integer> ids);
}
