package kr.or.ddit.sevenfs.service.common.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.sevenfs.mapper.common.CommonCodeMapper;
import kr.or.ddit.sevenfs.service.common.CommonCodeService;
import kr.or.ddit.sevenfs.vo.CommonCodeVO;

@Service
public class CommonCodeServiceImpl implements CommonCodeService {
    @Autowired
    private CommonCodeMapper commonCodeMapper;

    @Override
    public List<CommonCodeVO> selectCodesByGroup(String groupCode) {
        return commonCodeMapper.selectCodesByGroup(groupCode);
    }

    @Override
    public List<CommonCodeVO> selectByGroup(String groupId) {
        return commonCodeMapper.selectByGroup(groupId);
    }
}