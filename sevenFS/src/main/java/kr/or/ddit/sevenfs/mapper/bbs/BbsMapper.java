package kr.or.ddit.sevenfs.mapper.bbs;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.sevenfs.utils.ArticlePage;
import kr.or.ddit.sevenfs.vo.AttachFileVO;
import kr.or.ddit.sevenfs.vo.bbs.BbsVO;

@Mapper
public interface BbsMapper {

	public List<BbsVO> bbsList(ArticlePage<AttachFileVO> articlePage);

	public int bbsInsert(BbsVO bbsVO);

	public BbsVO bbsDetail(int bbsSn);

	public int bbsUpdate(BbsVO bbsVO);

	public int bbsDelete(int bbsSn);

}
