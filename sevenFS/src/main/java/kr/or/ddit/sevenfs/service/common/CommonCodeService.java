package kr.or.ddit.sevenfs.service.common;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.ddit.sevenfs.vo.CommonCodeVO;
@Service
public interface CommonCodeService {

    List<CommonCodeVO> selectCodesByGroup(String groupCode);
    List<CommonCodeVO> selectByGroup(String groupId);
}
