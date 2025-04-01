package kr.or.ddit.sevenfs.mapper;

import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AuthMapper {
    // 로그인
    public EmployeeVO login(String username);
}
