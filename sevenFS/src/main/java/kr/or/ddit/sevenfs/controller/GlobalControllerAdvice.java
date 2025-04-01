package kr.or.ddit.sevenfs.controller;

import kr.or.ddit.sevenfs.vo.CustomUser;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class GlobalControllerAdvice {

    // 모델에 기본 적으로 emp값에 사원 정보를 넣어줬다
    @ModelAttribute("myEmpInfo")
    public EmployeeVO getLoggedInUser(Authentication authentication) {
        if (authentication != null && authentication.getPrincipal() instanceof CustomUser userDetails) {
            return userDetails.getEmpVO();
        }
        return null;
    }
}

