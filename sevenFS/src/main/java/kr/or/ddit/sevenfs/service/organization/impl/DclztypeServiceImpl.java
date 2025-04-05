package kr.or.ddit.sevenfs.service.organization.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.sevenfs.mapper.organization.DclztypeMapper;
import kr.or.ddit.sevenfs.service.organization.DclztypeService;
import kr.or.ddit.sevenfs.vo.CommonCodeVO;
import kr.or.ddit.sevenfs.vo.organization.DclzTypeVO;

@Service
public class DclztypeServiceImpl implements DclztypeService {

	@Autowired
	DclztypeMapper dclztypeMapper;
	
	@Override
	public CommonCodeVO dclzCnt(String emplNo) {
		return dclztypeMapper.dclzCnt(emplNo);
	}

}
