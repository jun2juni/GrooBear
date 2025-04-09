package kr.or.ddit.sevenfs.controller.bbs;

import kr.or.ddit.sevenfs.service.bbs.LikeService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/bbs/like")
@RequiredArgsConstructor
@Slf4j
public class LikeController {

    private final LikeService likeService;

    @PostMapping("/toggle")
    public Map<String, Object> toggleLike(@RequestParam int bbsSn,
                                          @RequestParam int bbsCtgryNo) {

        // 로그인한 사원 번호 꺼내오기 (Spring Security)
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String emplNo = auth.getName(); // 사원번호
        
        log.info("사원번호 : " + emplNo);

        boolean liked = likeService.toggleLike(bbsSn, bbsCtgryNo, emplNo);
        int likeCount = likeService.countLikes(bbsSn, bbsCtgryNo);

        Map<String, Object> result = new HashMap<>();
        result.put("liked", liked);
        result.put("likeCount", likeCount);

        return result;
    }

    @GetMapping("/count")
    public int getLikeCount(@RequestParam int bbsSn, @RequestParam int bbsCtgryNo) {
        return likeService.countLikes(bbsSn, bbsCtgryNo);
    }

    @GetMapping("/exists")
    public boolean checkIfLiked(@RequestParam int bbsSn,
                                 @RequestParam int bbsCtgryNo) {

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String emplNo = auth.getName();

        return likeService.existsLike(bbsSn, bbsCtgryNo, emplNo);
    }
}
