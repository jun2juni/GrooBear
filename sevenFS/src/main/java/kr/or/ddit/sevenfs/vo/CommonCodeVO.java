package kr.or.ddit.sevenfs.vo;

import lombok.Data;

@Data
public class CommonCodeVO {
    private String cmmnCodeGroup;
    private String cmmnCode;
    private String cmmnCodeNm;
    private String cmmnCodeDc;
    private String useYn;
    private String upperCmmnCode;
    private int cmmnCodeSn;
    
    // 박호산나 추가 - 근태 에서 사용하기 위해 추가
    private int cnt;
}
