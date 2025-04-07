package kr.or.ddit.sevenfs.controller;

import kr.or.ddit.sevenfs.service.organization.OrganizationService;
import kr.or.ddit.sevenfs.vo.CustomUser;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@Slf4j
@ControllerAdvice
public class GlobalControllerAdvice {
    @Autowired
    OrganizationService organizationService;

    // 모델에 기본 적으로 emp값에 사원 정보를 넣어줬다
    @ModelAttribute("myEmpInfo")
    public EmployeeVO getLoggedInUser(Authentication authentication) {
        if (authentication != null && authentication.getPrincipal() instanceof CustomUser userDetails) {
            EmployeeVO empVO = userDetails.getEmpVO();
            // 사원 알림 불러오기
            return empVO;
        }

        return null;
    }
}

