package kr.or.ddit.sevenfs.mapper.common;

import kr.or.ddit.sevenfs.vo.CommonCodeVO;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface CommonCodeMapper {
    List<CommonCodeVO> selectCodesByGroup(String groupCode);
    List<CommonCodeVO> selectByGroup(String groupId);

}
