package kr.or.ddit.sevenfs.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import kr.or.ddit.sevenfs.service.bbs.BbsService;
import kr.or.ddit.sevenfs.service.organization.OrganizationService;
import kr.or.ddit.sevenfs.vo.CustomUser;
import kr.or.ddit.sevenfs.vo.bbs.BbsCategoryVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

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
//    @ModelAttribute("bbsCategory")
//    public List<BbsCategoryVO> getCategories() {
//        List<BbsCategoryVO> list = this.bbsService.bbsCategoryList();
//        log.debug("bbsCategoryVOS: {}", list);
//        Map<Integer, BbsCategoryVO> map = list.stream()
//                .collect(Collectors.toMap(BbsCategoryVO::getBbsCtgryNo, c -> c));
//
//            List<BbsCategoryVO> tree = new ArrayList<>();
//
//            for (BbsCategoryVO category : list) {
//                Integer parentNo = category.getUpperCtgryNo();
//                if (parentNo == null || parentNo == 0) {
//                    tree.add(category); // 상위 카테고리
//                } else {
//                    BbsCategoryVO parent = map.get(parentNo);
//                    if (parent != null) {
//                        parent.getChildren().add(category);
//                    }
//                }
//            }
//
//            log.debug("bbsCategory Tree: {}", tree);
//            return tree; // 트리 구조로 반환
//    }
}

