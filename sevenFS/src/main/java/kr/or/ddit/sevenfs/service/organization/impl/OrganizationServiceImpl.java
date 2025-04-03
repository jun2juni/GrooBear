package kr.or.ddit.sevenfs.service.organization.impl;

import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.or.ddit.sevenfs.mapper.organization.OrganizationMapper;
import kr.or.ddit.sevenfs.service.organization.OrganizationService;
import kr.or.ddit.sevenfs.vo.CommonCodeVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import kr.or.ddit.sevenfs.vo.organization.OrganizationVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class OrganizationServiceImpl implements OrganizationService {

	@Autowired
	OrganizationMapper organizationMapper;

	
	@Override
	public OrganizationVO organization() {
		
		OrganizationVO organizationVO = new OrganizationVO();
		
		// 전체 부서 조회
		List<CommonCodeVO> departmentList = depList();
		log.info("controller->depList : " + departmentList);
		
		// 전체 사원 조회
		List<EmployeeVO> employeeList = empList();
		
		organizationVO.setDeptList(departmentList);
		organizationVO.setEmpList(employeeList);
		
		return organizationVO;
	}

	// 전체 부서만 조회
	@Override
	public List<CommonCodeVO> depList() {
		return organizationMapper.depList();
	}
	
	// 전체 사원만 조회
	@Override
	public List<CommonCodeVO> posList() {
		return organizationMapper.posList();
	};

	// 전체 사원 조회
	@Override
	public List<EmployeeVO> empList() {
		return organizationMapper.empList();
	}
	
	//사원 상세조회
	public EmployeeVO emplDetail(String emplNo) {
		EmployeeVO emplDetail = organizationMapper.emplDetail(emplNo);
		
		// 사원이 속한 부서
		CommonCodeVO employeeDep = empDetailDep(emplNo);
		log.info("사원속한부서 : " + employeeDep);

		// 사원의 직급
		CommonCodeVO employeePos = empDetailPos(emplNo);
		
		emplDetail.setDeptNm(employeeDep.getCmmnCodeNm());
		emplDetail.setPosNm(employeePos.getCmmnCodeNm());
		
		return emplDetail;
	}
	
	// 사원 상세부서
	public CommonCodeVO empDetailDep(String emplNo) {
		return organizationMapper.empDetailDep(emplNo);
	}
	
	// 사원 상세직급
	public CommonCodeVO empDetailPos(String emplNo) {
		return organizationMapper.empDetailPos(emplNo);
	}
	
	// 사원 수정
	public int emplUpdatePost(EmployeeVO employeeVO) {
		
		return organizationMapper.emplUpdatePost(employeeVO);
	}

	// 부서 상세조회
	@Override
	public CommonCodeVO deptDetail(String cmmnCode) {
		return organizationMapper.deptDetail(cmmnCode);
	}
	
	// 부서 등록
	public int depInsert(CommonCodeVO commonCodeVO) {
		log.info("부서등록 insert " + commonCodeVO);

		return organizationMapper.depInsert(commonCodeVO);
	}

	// 부서 수정
	@Override
	public int deptUpdate(CommonCodeVO commonCodeVO) {
		int result = organizationMapper.deptUpdate(commonCodeVO);
		log.info("부서 수정 result : " + result);
		return result;
	}

	// 부서 삭제
	@Override
	public int deptDelete(String cmmnCode) {
		return organizationMapper.deptDelete(cmmnCode);
	}

	// 사원 등록
	@Override
	public int emplInsert(EmployeeVO employeeVO) {

		return organizationMapper.emplInsert(employeeVO);
	}

	// 사원 삭제
	@Override
	public int emplDelete(String emplNo) {
		return organizationMapper.emplDelete(emplNo);
	}


	

	

}
