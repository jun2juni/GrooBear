package kr.or.ddit.sevenfs.service.impl.bbs;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.sevenfs.mapper.bbs.BbsMapper;
import kr.or.ddit.sevenfs.service.bbs.BbsService;
import kr.or.ddit.sevenfs.vo.bbs.BbsVO;

@Service
public class BbsServiceImpl implements BbsService{

	@Autowired
	BbsMapper bbsMapper;
	
	@Override
	public List<BbsVO> bbsList() {
		// TODO Auto-generated method stub
		return bbsMapper.bbsList();
	}

}
