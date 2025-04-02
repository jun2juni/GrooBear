package kr.or.ddit.sevenfs.mapper.organization;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.sevenfs.vo.CommonCodeVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;

@Mapper
public interface OrganizationMapper {

		// 전체 부서 조회
		public List<CommonCodeVO> depList();
		
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

	
}
