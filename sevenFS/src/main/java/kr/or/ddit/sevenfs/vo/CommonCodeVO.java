package kr.or.ddit.sevenfs.vo;

import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import lombok.Data;

import java.util.List;

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

    // 허성진
    private List<CommonCodeVO> lowerDeptList; // 하위부서 목록
    private List<EmployeeVO> employeeList; // 부서 사원 정보
}
