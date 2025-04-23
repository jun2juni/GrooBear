package kr.or.ddit.sevenfs.service.organization.impl;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import kr.or.ddit.sevenfs.mapper.setting.SettingMapper;
import kr.or.ddit.sevenfs.service.chat.ChatService;
import kr.or.ddit.sevenfs.service.notification.NotificationService;
import kr.or.ddit.sevenfs.service.setting.SettingService;
import kr.or.ddit.sevenfs.vo.chat.ChatRoomVO;
import kr.or.ddit.sevenfs.vo.notification.NotificationVO;
import kr.or.ddit.sevenfs.vo.setting.SkillAuthVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.or.ddit.sevenfs.mapper.organization.DclztypeMapper;
import kr.or.ddit.sevenfs.mapper.organization.OrganizationMapper;
import kr.or.ddit.sevenfs.service.organization.OrganizationService;
import kr.or.ddit.sevenfs.vo.CommonCodeVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import kr.or.ddit.sevenfs.vo.organization.OrganizationVO;
import kr.or.ddit.sevenfs.vo.organization.VacationVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@Transactional
public class OrganizationServiceImpl implements OrganizationService {

	@Autowired
	OrganizationMapper organizationMapper;
	@Autowired
	DclztypeMapper dclztypeMapper;
	@Autowired
	NotificationService notificationService;
	@Autowired
	ChatService chatService;
	@Autowired
	SettingService settingService;

	
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
	
	// 최상위 부서만 조회
	@Override
	public List<CommonCodeVO> upperDepList() {
		return organizationMapper.upperDepList();
	}
	
	// 하위 부서 조회
	@Override
	public List<CommonCodeVO> lowerDepList(String upperCmmnCode) {
		return organizationMapper.lowerDepList(upperCmmnCode);
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
		log.debug("emplDetail : " + emplDetail);

		if (emplDetail == null) return null;



		// 사원이 속한 부서
		CommonCodeVO employeeDep = empDetailDep(emplNo);
		if (employeeDep != null) {
			emplDetail.setDeptNm(employeeDep.getCmmnCodeNm());  // 사원 부서 이름
		} else {
			emplDetail.setDeptCode("01");  // 사원 부서 코드 임시로 추가
			emplDetail.setDeptNm("기타");  // 사원 부서 이름 임시로 추가
		}

		// 사원의 직급
		CommonCodeVO employeePos = empDetailPos(emplNo);
		if (employeePos != null) {
			emplDetail.setPosNm(employeePos.getCmmnCodeNm()); // 사원 직급 이름 추가
		} else {
			emplDetail.setClsfCode("01");  // 사원 부서 코드 임시로 추가
			emplDetail.setClsfCodeNm("사원");  // 사원 부서 이름 임시로 추가
		}
		
		// 권한 추가
		List<SkillAuthVO> skillAuth = settingService.getSkillAuth(emplDetail.getEmplNo());
		emplDetail.setSkillAuth(skillAuth);

		return emplDetail;
	}

	public Map<String, Object> getEmpNotification(EmployeeVO emplDetail) {
		// 읽지 않은 알림
		List<NotificationVO> unreadNotifications = notificationService.getUnreadNotifications(emplDetail);
		emplDetail.setNotificationVOList(unreadNotifications);

		// 읽지 않은 채팅
		Map<String, Object> params = new HashMap<>();
		params.put("emplNo", emplDetail.getEmplNo());
		params.put("bUnRead", true);
		List<ChatRoomVO> chatRoomVOList = chatService.chatList(params);
		emplDetail.setChatRoomVOList(chatRoomVOList);

		return  Map.of(
			"notification", unreadNotifications,
			"chatList", chatRoomVOList
		);
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
		
		// 사원 등록
		int result = organizationMapper.emplInsert(employeeVO);
		
		// 사원 번호 가져오기
		String emplNo = employeeVO.getEmplNo();
		log.info("emp insert -> emplNo : " + emplNo);
		
		log.info("등록한 데이터 : " + employeeVO);
		
		// 사원 등록시 직급코드(clsfCode)가 날라옴
		// 등록하려는 사원코드
		String clsfCode = employeeVO.getClsfCode();
		log.info("insert -> 사원코드 : " + clsfCode);
		
		// 직급 코드에 해당하는 연차 갯수 등록하기
		Map<String, Integer> clsfMap = new HashMap<>();
		clsfMap.put("00", 0);  // 인턴
		clsfMap.put("01", 15); // 사원
		clsfMap.put("02", 16); // 대리
		clsfMap.put("03", 18); // 과장
		clsfMap.put("04", 18); // 부장
		clsfMap.put("05", 20); // 이사
		clsfMap.put("06", 22); // 상무
		clsfMap.put("07", 22); // 전무
		clsfMap.put("08", 25); // 부사장

		VacationVO vacationVO = new VacationVO();
		vacationVO.setEmplNo(emplNo);
		
		// 등록 사원코드와 같으면 해당 총 연차개수 부여하기
		int yrycCnt;
		if(clsfMap.containsKey(clsfCode)) {
			yrycCnt = (int) clsfMap.get(clsfCode);
			vacationVO.setTotYrycDaycnt(yrycCnt);
			vacationVO.setYrycRemndrDaycnt(yrycCnt);
		}else {
			yrycCnt = 0;
		}
		
		// 사원 등록시 연차까지 등록 basicVacInsert()
		int vacResult = dclztypeMapper.basicVacInsert(vacationVO);
		log.info("사원 등록시 연차부여 res : " + vacResult);
		
		// 사원 등록시 근태현황 출퇴근으로 등록해주기 ( 그래야 근태현황이 보임 )
		int emplBeginWorkInsert = dclztypeMapper.addEmplBeginWorkInsert(emplNo);
		log.info("등록됐니 ?????? ");
		
		// 사원이 등록되면 권한 테이블에도 업로드 되어야한다
		if(result == 1) {
			organizationMapper.empAuthInsert(emplNo);
			settingService.insetSkillAuth(emplNo);
		}
		
		return result;
	}

	// 사원 삭제
	@Override
	public int emplDelete(String emplNo) {
		return organizationMapper.emplDelete(emplNo);
	}
	
	// 권한 등록
	@Override
	public int empAuthInsert(String emplNo) {
		return organizationMapper.empAuthInsert(emplNo);
	}

	//해당 직원의 상세정보 목록을 select
	@Override
	public List<EmployeeVO> emplDetailList(List<String> list) {
		return this.organizationMapper.emplDetailList(list);
	}






	

	

}
