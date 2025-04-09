package kr.or.ddit.sevenfs.vo.bbs;

import lombok.Data;

import java.util.Date;

@Data
public class BbsCategoryVO {
    private int bbsCtgryNo;
    private int upperCtgryNo;
    private String ctgryNm;
    private Date ctgryCreatDt;
    private String ctgryUseYn;
    private String deptCode;
}
