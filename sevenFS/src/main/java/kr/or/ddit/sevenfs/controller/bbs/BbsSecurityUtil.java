package kr.or.ddit.sevenfs.controller.bbs;

import kr.or.ddit.sevenfs.vo.bbs.BbsVO;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

@Component
public class BbsSecurityUtil {

    public boolean isAdmin(Authentication auth) {
        return auth != null &&
               auth.getAuthorities().stream()
                   .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));
    }

    public boolean isOwner(Authentication auth, BbsVO bbsVO) {
        if (auth == null || bbsVO == null) return false;

        Object principal = auth.getPrincipal();
        if (principal instanceof UserDetails userDetails) {
            String loginEmplNo = userDetails.getUsername();
            return String.valueOf(bbsVO.getEmplNo()).equals(loginEmplNo);
        }
        return false;
    }

    public boolean canEdit(Authentication auth, BbsVO bbsVO) {
        return isAdmin(auth) || isOwner(auth, bbsVO);
    }

    public boolean canDelete(Authentication auth, BbsVO bbsVO) {
        return canEdit(auth, bbsVO); // 삭제 권한 = 수정 권한과 동일하면 그대로 사용
    }

    public boolean canInsertNotice(Authentication auth) {
        return isAdmin(auth); // 공지 등록은 관리자만
    }
}
