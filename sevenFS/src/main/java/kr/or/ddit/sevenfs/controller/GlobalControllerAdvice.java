package kr.or.ddit.sevenfs.controller;

import kr.or.ddit.sevenfs.service.bbs.BbsService;
import kr.or.ddit.sevenfs.service.organization.OrganizationService;
import kr.or.ddit.sevenfs.vo.CustomUser;
import kr.or.ddit.sevenfs.vo.bbs.BbsCategoryVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.util.List;

@Slf4j
@ControllerAdvice
public class GlobalControllerAdvice {
    @Autowired
    OrganizationService organizationService;
    @Autowired
    BbsService bbsService;

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

    // 모델에 게시판 정보 추가해주기
    @ModelAttribute("bbsCategory")
    public List<BbsCategoryVO> getCategories() {
        List<BbsCategoryVO> bbsCategoryVOS = this.bbsService.bbsCategoryList();
        log.debug("bbsCategoryVOS: {}", bbsCategoryVOS);
        return bbsCategoryVOS;
    }
}

