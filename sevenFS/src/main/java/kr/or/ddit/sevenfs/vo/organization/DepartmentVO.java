package kr.or.ddit.sevenfs.vo.organization;

import lombok.Data;

@Data
public class DepartmentVO {
    private String cmmnCode;       // 부서 코드
    private String upperCmmnCode;  // 상위 부서 코드
    private String cmmnCodeNm;     // 부서 이름
}
