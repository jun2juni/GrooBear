package kr.or.ddit.sevenfs.service.bbs.Impl;

import kr.or.ddit.sevenfs.mapper.bbs.LikeMapper;
import kr.or.ddit.sevenfs.service.bbs.LikeService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class LikeServiceImpl implements LikeService {

    private final LikeMapper likeMapper;

    @Override
    public boolean toggleLike(int bbsSn, int bbsCtgryNo, String emplNo) {
        Map<String, Object> param = new HashMap<>();
        param.put("bbsSn", bbsSn);
        param.put("bbsCtgryNo", bbsCtgryNo);
        param.put("emplNo", emplNo);

        if (likeMapper.existsLike(param)) {
            likeMapper.deleteLike(param);
            return false; // 좋아요 취소됨
        } else {
            likeMapper.insertLike(param);
            return true;  // 좋아요 추가됨
        }
    }

    @Override
    public int countLikes(int bbsSn, int bbsCtgryNo) {
        Map<String, Object> param = new HashMap<>();
        param.put("bbsSn", bbsSn);
        param.put("bbsCtgryNo", bbsCtgryNo);
        return likeMapper.countLikes(param);
    }

    @Override
    public boolean existsLike(int bbsSn, int bbsCtgryNo, String emplNo) {
        Map<String, Object> param = new HashMap<>();
        param.put("bbsSn", bbsSn);
        param.put("bbsCtgryNo", bbsCtgryNo);
        param.put("emplNo", emplNo);
        return likeMapper.existsLike(param);
    }
}
