package kr.or.ddit.sevenfs.service.organization;

import java.util.List;
import java.util.Map;

import kr.or.ddit.sevenfs.vo.CommonCodeVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import kr.or.ddit.sevenfs.vo.organization.OrganizationVO;

public interface OrganizationService {
	
		// 조직도 목록 조회
		public OrganizationVO organization();
		
		// 전체 부서만 조회
		public List<CommonCodeVO> depList();
		
		// 최상위 부서만 조회
		public List<CommonCodeVO> upperDepList();
		
		// 하위 부서 조회
		public List<CommonCodeVO> lowerDepList(String upperCmmnCode);
		
		// 전체 직급만 조회
		public List<CommonCodeVO> posList();
		
		// 전체 사원 조회
		public List<EmployeeVO> empList();
		
		// 부서 상세조회
		public CommonCodeVO deptDetail(String cmmnCode);
		
		// 사원 상세조회
		public EmployeeVO emplDetail(String emplNo);
		
		// 사원 상세부서
		public CommonCodeVO empDetailDep(String emplNo);
		
		// 사원 상세직급
		public CommonCodeVO empDetailPos(String emplNo);
		
		// 사원 수정
		public int emplUpdatePost(EmployeeVO employeeVO);

		// 부서 등록
		public int depInsert(CommonCodeVO commonCodeVO);
		
		// 부서 수정
		public int deptUpdate(CommonCodeVO commonCodeVO);
		
		// 부서 삭제
		public int deptDelete(String cmmnCode);
		
		// 사원 등록
		public int emplInsert(EmployeeVO employeeVO);
		
		// 사원 삭제
		public int emplDelete(String emplNo);
		
		// 권한 등록
		public int empAuthInsert(String emplNo);

		//해당 직원의 상세정보 목록을 select
		public List<EmployeeVO> emplDetailList(List<String> list);

		// 사용자 알림정보 불러오기
		public Map<String, Object> getEmpNotification(EmployeeVO emplDetail);

		public List<EmployeeVO> selectEmpListWithDeptAndPos();
}
