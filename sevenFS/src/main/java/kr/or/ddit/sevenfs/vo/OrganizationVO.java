package kr.or.ddit.sevenfs.vo;

import java.util.List;

import kr.or.ddit.sevenfs.vo.CommonCodeVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import lombok.Data;

@Data
public class OrganizationVO {
	// 공통코드
	private String cmmnCode;
	private String cmmnCodeNm;
	
	private List<kr.or.ddit.sevenfs.vo.CommonCodeVO> deptList;	// 부서명
	private List<EmployeeVO> empList;	// 직급명
}
