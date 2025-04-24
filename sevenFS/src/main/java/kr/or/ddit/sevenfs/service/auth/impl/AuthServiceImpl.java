package kr.or.ddit.sevenfs.service.auth.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.sevenfs.mapper.AuthMapper;
import kr.or.ddit.sevenfs.service.auth.AuthService;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;

@Service
public class AuthServiceImpl implements AuthService {
	
	@Autowired
	private AuthMapper authMapper;

    // 비밀번호 변경
	@Override
	public int emplChangePw(EmployeeVO employeeVO) {
		return authMapper.emplChangePw(employeeVO);
	}
}
