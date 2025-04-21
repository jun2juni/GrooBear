package kr.or.ddit.sevenfs.vo.bbs;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BbsCategoryVO {
    private int bbsCtgryNo;
    private int upperCtgryNo;
    private String ctgryNm;
    private Date ctgryCreatDt;
    private String ctgryUseYn;
    private String deptCode;
    private List<BbsCategoryVO> children = new ArrayList<>();
    
    private List<BbsVO> bbsList; // 게시글 목록
}
