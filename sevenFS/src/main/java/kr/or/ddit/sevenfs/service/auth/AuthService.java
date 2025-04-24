package kr.or.ddit.sevenfs.service.auth;

import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;

public interface AuthService {
    
    // 비밀번호 변경
    public int emplChangePw(EmployeeVO employeeVO);
}
