package kr.or.ddit.sevenfs.mapper.bbs;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.sevenfs.vo.bbs.BbsVO;

@Mapper
public interface BbsMapper {

	public List<BbsVO> bbsList();

}
