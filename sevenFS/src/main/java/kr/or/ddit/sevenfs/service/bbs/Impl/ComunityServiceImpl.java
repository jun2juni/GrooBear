package kr.or.ddit.sevenfs.service.bbs.Impl;

import java.util.List;
import java.util.Map;

import kr.or.ddit.sevenfs.vo.bbs.BbsCategoryVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.sevenfs.mapper.bbs.BbsMapper;
import kr.or.ddit.sevenfs.mapper.bbs.ComunityMapper;
import kr.or.ddit.sevenfs.service.bbs.BbsService;
import kr.or.ddit.sevenfs.service.bbs.ComunityService;
import kr.or.ddit.sevenfs.utils.ArticlePage;
import kr.or.ddit.sevenfs.vo.AttachFileVO;
import kr.or.ddit.sevenfs.vo.bbs.BbsVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ComunityServiceImpl implements ComunityService{

	@Autowired
	ComunityMapper comunityMapper;

	@Override
	public int comunityMenuInsert(BbsVO bbsVO) {
		return comunityMapper.comunityMenuInsert(bbsVO);
	}
	
	@Override
	public int getTotal(Map<String, Object> map) {
		
		return 0;
	}
	
	@Override
	public List<BbsVO> comunityMonthMenuList(ArticlePage<BbsVO> articlePage) {
		log.info("아티클페이지 : " + articlePage);
		return comunityMapper.comunityMonthMenuList(articlePage);
	}
	@Override
	public BbsVO comunityMonthMenuDetail(int bbsSn) {
		return comunityMapper.comunityMonthMenuDetail(bbsSn);
	}
	@Override
	public int comunityMonthMenuUpdate(BbsVO bbsVO) {
		return comunityMapper.comunityMonthMenuUpdate(bbsVO);
	}
	

}
