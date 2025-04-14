package kr.or.ddit.sevenfs.controller.bbs;

import kr.or.ddit.sevenfs.vo.bbs.BbsVO;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

/**
 * 게시판 관련 권한 체크 유틸리티 클래스
 * - 로그인 사용자의 권한이나 게시글 소유자 여부를 검사하여
 *   컨트롤러에서 간결하게 사용할 수 있도록 도와줌
 */
@Component
public class BbsSecurityUtil {

    /**
     * 현재 사용자가 관리자(ROLE_ADMIN)인지 확인
     *
     * @param auth 현재 로그인한 사용자의 인증 정보
     * @return true: 관리자, false: 일반 사용자
     */
    public boolean isAdmin(Authentication auth) {
        return auth != null &&
               auth.getAuthorities().stream()
                   .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));
    }

    /**
     * 현재 사용자가 게시글 작성자인지 확인
     *
     * @param auth   현재 로그인한 사용자의 인증 정보
     * @param bbsVO  검사할 게시글 객체
     * @return true: 작성자 본인, false: 타인
     */
    public boolean isOwner(Authentication auth, BbsVO bbsVO) {
        if (auth == null || bbsVO == null) return false;

        Object principal = auth.getPrincipal();
        if (principal instanceof UserDetails userDetails) {
            // 로그인 사용자의 사번 (UserDetails.getUsername()을 사번으로 사용한다고 가정)
            String loginEmplNo = userDetails.getUsername();

            // 게시글 작성자의 사번과 비교 (String 변환하여 비교)
            return String.valueOf(bbsVO.getEmplNo()).equals(loginEmplNo);
        }

        return false;
    }

    /**
     * 게시글을 수정할 수 있는 권한이 있는지 확인
     * - 작성자 본인이거나 관리자만 수정 가능
     *
     * @param auth  현재 로그인한 사용자
     * @param bbsVO 게시글 정보
     * @return true: 수정 가능, false: 불가능
     */
    public boolean canEdit(Authentication auth, BbsVO bbsVO) {
        return isAdmin(auth) || isOwner(auth, bbsVO);
    }

    /**
     * 게시글을 삭제할 수 있는 권한이 있는지 확인
     * - 기본적으로 수정 권한과 동일한 조건 사용
     *
     * @param auth  현재 로그인한 사용자
     * @param bbsVO 게시글 정보
     * @return true: 삭제 가능, false: 불가능
     */
    public boolean canDelete(Authentication auth, BbsVO bbsVO) {
        return canEdit(auth, bbsVO); // 수정 권한과 동일
    }

    /**
     * 공지사항을 등록할 수 있는지 확인
     * - 관리자만 가능
     *
     * @param auth 현재 로그인한 사용자
     * @return true: 공지 등록 가능, false: 불가능
     */
    public boolean canInsertNotice(Authentication auth) {
        return isAdmin(auth);
    }
}
