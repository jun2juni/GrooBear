package kr.or.ddit.sevenfs.service.organization;

import java.util.List;

import kr.or.ddit.sevenfs.vo.CommonCodeVO;
import kr.or.ddit.sevenfs.vo.OrganizationVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;

public interface OrganizationService {
	
	// 조직도 목록 조회
		public OrganizationVO organization();
		
		// 전체 부서 조회
		public List<CommonCodeVO> depList();
		
		// 전체 사원 조회
		public List<EmployeeVO> empList();
		
		// 사원 상세조회
		public EmployeeVO emplDetail(String emplNo);
		
		// 사원 상세부서
		public CommonCodeVO empDetailDep(String emplNo);
		
		// 사원 상세직급
		public CommonCodeVO empDetailPos(String emplNo);

}
