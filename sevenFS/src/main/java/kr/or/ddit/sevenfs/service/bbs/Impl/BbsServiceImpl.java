package kr.or.ddit.sevenfs.service.bbs.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.sevenfs.mapper.bbs.BbsMapper;
import kr.or.ddit.sevenfs.service.bbs.BbsService;
import kr.or.ddit.sevenfs.utils.ArticlePage;
import kr.or.ddit.sevenfs.vo.AttachFileVO;
import kr.or.ddit.sevenfs.vo.bbs.BbsVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class BbsServiceImpl implements BbsService{

	@Autowired
	BbsMapper bbsMapper;
	
	@Override
	public List<BbsVO> bbsList(ArticlePage<BbsVO> articlePage) {
		// TODO Auto-generated method stub
		log.info("아티클페이지 : " + articlePage);
		return bbsMapper.bbsList(articlePage);
	}

	@Override
	public int bbsInsert(BbsVO bbsVO) {
		// TODO Auto-generated method stub
		return bbsMapper.bbsInsert(bbsVO);
	}

	@Override
	public BbsVO bbsDetail(int bbsSn) {
		// TODO Auto-generated method stub
		return bbsMapper.bbsDetail(bbsSn);
	}

	@Override
	public int bbsUpdate(BbsVO bbsVO) {
		// TODO Auto-generated method stub
		return bbsMapper.bbsUpdate(bbsVO);
	}

	@Override
	public int bbsDelete(int bbsSn) {
		// TODO Auto-generated method stub
		return bbsMapper.bbsDelete(bbsSn);
	}

}
