package kr.or.ddit.sevenfs.service.impl;

import kr.or.ddit.sevenfs.mapper.AuthMapper;
import kr.or.ddit.sevenfs.service.organization.OrganizationService;
import kr.or.ddit.sevenfs.vo.CustomUser;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class EmpDetailImpl implements UserDetailsService { // 스프링 시큐리티에서 사용자 정보를 가져오는 인터페이스(UserDetailsService)
    @Autowired
    OrganizationService organizationService;

    @Override
    public UserDetails loadUserByUsername(String emplNo) throws UsernameNotFoundException {
        // 사용자 정보 검색
        EmployeeVO empVO = organizationService.emplDetail(emplNo);
        CustomUser customUser = new CustomUser(empVO);

        return empVO != null ? customUser : null;
    }
}
