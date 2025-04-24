package kr.or.ddit.sevenfs.controller.organization;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import kr.or.ddit.sevenfs.service.AttachFileService;
import kr.or.ddit.sevenfs.service.organization.OrganizationService;
import kr.or.ddit.sevenfs.utils.CommonCode;
import kr.or.ddit.sevenfs.vo.AttachFileVO;
import kr.or.ddit.sevenfs.vo.CommonCodeVO;
import kr.or.ddit.sevenfs.vo.CustomUser;
import kr.or.ddit.sevenfs.vo.auth.EmpAuthVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import kr.or.ddit.sevenfs.vo.organization.OrganizationVO;
import lombok.extern.slf4j.Slf4j;

// 조직도 Controller

@Slf4j
@Controller
public class OrganizationController {
	
	@Autowired
	OrganizationService organizationService;
	@Autowired
	BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Autowired
	AttachFileService attachFileService;
	
	// 조직도 목록 조회
	@GetMapping("/orglist")
	public String organizationList(Model model) {
		//Gson gson = new Gson();

		model.addAttribute("title" , "조직도");
		return "organization/organizationList";
	}
	
	// 부서와 사원 전체 목록 조회
	@ResponseBody
	@GetMapping("/organization")
	public OrganizationVO organization() {
		OrganizationVO organization = organizationService.organization();
		organization.setPosList(organizationService.posList()); // 포지션 추가함 -채성실
		log.info("orgData : " + organization);
		
		return organization;
	}

	// 부서 상세
	@GetMapping("/deptDetail")
	public String deptDetail(@RequestParam(value = "cmmnCode") String cmmnCode
			, Model model) {
		
		log.info("사원번호 와라와라 : " + cmmnCode);
		CommonCodeVO deptDetail = organizationService.deptDetail(cmmnCode);
		log.info("부서 상세 : " + deptDetail);
		
		model.addAttribute("deptDetail", deptDetail);
		
		return "organization/deptDetail";
	}
	

	// 관리자일때 조직관리 페이지로 이동
	@GetMapping("/orglistAdmin")
	public String orglistAdmin(Model model) {
		
		model.addAttribute("title", "조직관리");
		
		return "organization/orglistAdmin";
	}
	
	// 부서 수정 클릭했을때 수정페이지로 이동
	@GetMapping("/depUpdate")
	public String depUpdate(@RequestParam String cmmnCode, Model model) {
		
		model.addAttribute("title" , "부서 수정");
		
		// 전체 부서 목록
		List<CommonCodeVO> deptList = this.organizationService.depList();
		
		// 상위부서만 조회
		List<CommonCodeVO> upperDepList = organizationService.upperDepList();
		
		log.info("부서코드 : " + cmmnCode);
		CommonCodeVO deptDetail = organizationService.deptDetail(cmmnCode);

		Map<String, Object> deptData = new HashMap<>();
		deptData.put("deptList", deptList);
		deptData.put("deptDetail", deptDetail);
		deptData.put("upperDepList", upperDepList);
		
		
		model.addAttribute("deptData", deptData);

		return "organization/depUpdate";
	}
	
	// 부서수정확인 눌렀을때 이동
	@PostMapping("/depUpdatePost")
	public String depUpdatePost(CommonCodeVO commonCodeVO) {
		
		log.info("commonCodeVO 수정확인 : " + commonCodeVO);
		
		String cmmnCode = commonCodeVO.getCmmnCode();
		log.info("cmmnCode : " + cmmnCode);
		
		this.organizationService.deptUpdate(commonCodeVO);
		
		return "redirect:/orglistAdmin";
	}
	
	// 부서 등록 - jsp return
	@GetMapping("/depInsert")
	public String depInsert(Model model) {
		List<CommonCodeVO> depList = organizationService.depList();
		model.addAttribute("depList", depList);
		
		List<CommonCodeVO> upperList = organizationService.upperDepList();
		model.addAttribute("upperList" , upperList);
		model.addAttribute("title" , "부서 등록");
		
		// 최상위부서 선택했을때 소속된 팀 출력하기
		
		return "organization/depInsert";
	}
	
	// 부서 등록 - json return
//	@ResponseBody
//	@GetMapping("/depInsert")
//	public Map<String, Object> depInsert(Model model) {
//		List<CommonCodeVO> depList = organizationService.depList();
//		model.addAttribute("depList", depList);
//		
//		List<CommonCodeVO> upperList = organizationService.upperDepList();
//		//model.addAttribute("upperList" , upperList);
//		//model.addAttribute("title" , "부서 등록");
//		
//		Map<String, Object> map = new HashMap<>();
//		map.put("depList", depList);
//		map.put("upperList", upperList);
//		
//		// 최상위부서 선택했을때 소속된 팀 출력하기
//		
//		return map;
//	}
	
	// 최상위부서 선택시 소속된 부서를 반환
	@ResponseBody
	@GetMapping("/getLowerdeptList")
	public Map<String, Object> getLowerdeptList(
			@RequestParam String upperCmmnCode
		   ,@RequestParam(defaultValue = "") String emplNo) {

		//log.info("emplNo 왔을까유 ?? : " + emplNo);
		List<CommonCodeVO> lowerDep = organizationService.lowerDepList(upperCmmnCode);
		
		Map<String, Object> map = new HashMap<>();
		if(emplNo != null && emplNo != "") {
			// 사원 상세
			EmployeeVO emplDetail = organizationService.emplDetail(emplNo);
			map.put("emplDetail", emplDetail);
		}
		
		map.put("lowerDep", lowerDep);
		
		// 하위부서 리스트 반환
		return map;
	}
	
	// 확인 눌렀을때 조직도 목록으로 이동 
	@PostMapping("/depInsertPost")
	public String depInsertPost(CommonCodeVO commonCodeVO) {
		
		String upperCmmnCode = commonCodeVO.getUpperCmmnCode();
		//log.info("선택한 공통코드 : " + upperCmmnCode);
		
		organizationService.depInsert(commonCodeVO);
		
		return "redirect:/orglistAdmin";
	}
	
	// 부서 삭제
	@ResponseBody
	@GetMapping("/deptDelete")
	public int deptDelete(String cmmnCode) {
		//log.info("삭제 cmmnCode : " + cmmnCode);
		int result = organizationService.deptDelete(cmmnCode);
		return result;
	}
	

	// 사원상세 Header - jsp return
	@GetMapping("/emplDetailHeader")
	public String emplDetailHeader(@RequestParam(value = "emplNo") String emplNo
			, Model model) {
		
		//log.info("사원번호 와라와라 : " + emplNo);
		EmployeeVO empDetail = organizationService.emplDetail(emplNo);
		//log.info("사원상세 : " + empDetail);
		
		// 사원 파일 번호 가져오기
		int fileNo = empDetail.getAtchFileNo();
		
		AttachFileVO attachFileVO = new AttachFileVO();
		List<AttachFileVO> fileAttachList = attachFileService.getFileAttachList(fileNo);
		String empFileName = fileAttachList.get(0).getFileStrePath();
		
		// 사원 프로필 url가져오기
		empDetail.setProflPhotoUrl(empFileName);
		//log.info("사원상세 프로필 url : " + empFileName);
		
		//model.addAttribute("empFileName" , empFileName);
		
		model.addAttribute("title" , "사원 정보");
		
		model.addAttribute("empDetail", empDetail);
		
		return "organization/employeeDetailHeader";
	}
	
	// 사용자가 선택한 사원상세 - jsp return
	@GetMapping("/emplDetail")
	public String emplDetail(@RequestParam(value = "emplNo") String emplNo
							, Model model) {
		
		//log.info("사원번호 와라와라 : " + emplNo);
		EmployeeVO empDetail = organizationService.emplDetail(emplNo);
		//log.info("사원상세 : " + empDetail);
		
		// 사원 파일 번호 가져오기
		int fileNo = empDetail.getAtchFileNo();
		
//		AttachFileVO attachFileVO = new AttachFileVO();
//		List<AttachFileVO> fileAttachList = attachFileService.getFileAttachList(fileNo);
//		String empFileName = fileAttachList.get(0).getFileStrePath();
//
//		// 사원 프로필 url가져오기
//		empDetail.setProflPhotoUrl(empFileName);
//		log.info("사원상세 프로필 url : " + empFileName);
		
		//model.addAttribute("empFileName" , empFileName);
		
		model.addAttribute("title" , "사원 정보");

		model.addAttribute("empDetail", empDetail);
		
		return "organization/employeeDetail";
	}
	
	// 사원상세 - data return
	@ResponseBody
	@GetMapping("/emplDetailData")
	public Map<String, Object> emplDetail(@RequestParam(value = "emplNo") String emplNo) {
		
		Map<String, Object> empMap = new HashMap<>();
		
		//log.info("사원번호 와라와라 : " + emplNo);
		EmployeeVO empDetail = organizationService.emplDetail(emplNo);
		//log.info("사원상세 : " + empDetail);
		
		// 사원 파일 번호 가져오기
		int fileNo = empDetail.getAtchFileNo();
		
		AttachFileVO attachFileVO = new AttachFileVO();
		List<AttachFileVO> fileAttachList = attachFileService.getFileAttachList(fileNo);
		String empFileName = fileAttachList.get(0).getFileStrePath();
		
		// 사원 프로필 url가져오기
		empDetail.setProflPhotoUrl(empFileName);
		//log.info("사원상세 프로필 url : " + empFileName);
		
		// 사원 비밀번호 공백으로 보내주기
		empDetail.setPassword("");
		
		empMap.put("empFileName", empFileName);
		empMap.put("empDetail", empDetail);
		//empMap.put("empFileName", empFileName);
		
		return empMap;
	}
	
	// 관리자가 선택한 사원상세
	@GetMapping("/emplDetailAdmin")
	public String emplDetailAdmin(@RequestParam(value = "emplNo") String emplNo
							, Model model) {
		
		//log.info("사원번호 와라와라 : " + emplNo);
		EmployeeVO empDetail = organizationService.emplDetail(emplNo);
		//log.info("사원상세 : " + empDetail);
		
		model.addAttribute("empDetail", empDetail);
		
		return "organization/employeeDetail";
	}
	
	// 사원 등록 페이지
	@GetMapping("/emplInsert")
	public String emplInsert(Model model) {
		
		model.addAttribute("title" , "사원 등록");
		
		// 전체부서 목록
		List<CommonCodeVO> depList = organizationService.depList();
		// 전체사원 목록
		List<CommonCodeVO> posList = organizationService.posList();
		// 상위부서 목록
		List<CommonCodeVO> upperDepList = organizationService.upperDepList();

		Map<String, Object> cmmnList = new HashMap<String, Object>();
		cmmnList.put("depList", depList);
		cmmnList.put("posList", posList);
		cmmnList.put("upperDepList", upperDepList);
		
		model.addAttribute("cmmnList", cmmnList);
		//log.info("전체 부서와 직급 목록 : " + cmmnList);
		return "organization/empInsert";
	}
	
	// 사원 등록 확인 눌렀을떄 이동
	@PostMapping("/emplInsertPost")
	public String emplInsertPost(EmployeeVO employeeVO) {
		
		//log.info("암호화 전 데이터 : " + employeeVO);
		String deptCode = employeeVO.getDeptCode();

		if(deptCode=="#") {
			return "organization/empInsert";
		}
		
		// 비밀번호 암호화
		String encode = bCryptPasswordEncoder.encode(employeeVO.getPassword());
		employeeVO.setPassword(encode);
		
		organizationService.emplInsert(employeeVO);
		
		return "redirect:/orglistAdmin";
	}
	
	
	// 사원 수정 페이지
	@GetMapping("/emplUpdate")
	public String emplUpdate(String emplNo, Model model) {

		model.addAttribute("title" , "사원 수정");
		
		EmployeeVO emplDetail = organizationService.emplDetail(emplNo);
		log.info("사원상세 : " + emplDetail);
		
		// 전체 직급 가져오기
		List<CommonCodeVO> posList = organizationService.posList();

		// 전체 부서 가져오기
		List<CommonCodeVO> depList = organizationService.depList();
		
		// 상위 부서만 가져오기
		List<CommonCodeVO> upperDepList = organizationService.upperDepList();
		
		// 사원의 파일넘버 가져오기
		int fileNo = emplDetail.getAtchFileNo();
		
		// 파일정보 가져오기
		List<AttachFileVO> fileAttachList = attachFileService.getFileAttachList(fileNo);
		//log.info("기존파일정보(수정) ->  fileAttachList : " + fileAttachList);
		
		// 입사일자, 생년월일 가져와서 date 형식으로 바꿔주기
		String birthDt = emplDetail.getBrthdy();
		String ecnyDt = emplDetail.getEcnyDate();
		// 날짜 형식으로 만들어주기
		String formattedBrthdy = birthDt.substring(0,4) + "-" +
							     birthDt.substring(4,6) + "-" +
							     birthDt.substring(6,8);
		String formattedEncy = ecnyDt.substring(0,4) + "-" +
							   ecnyDt.substring(4,6) + "-" +
							   ecnyDt.substring(6,8);
		model.addAttribute("formattedBrthdy", formattedBrthdy);
		model.addAttribute("formattedEncy", formattedEncy);
		
		
		Map<String, Object> emplDetailData = new HashMap<>();
		emplDetailData.put("emplDet", emplDetail);
		emplDetailData.put("posList", posList);
		emplDetailData.put("depList", depList);
		emplDetailData.put("upperDepList", upperDepList);
		//emplDetailData.put("fileAttachList", fileAttachList);
		//log.info("emplDetailData : " + emplDetailData);
		
		model.addAttribute("emplDetail", emplDetailData);
		
		model.addAttribute("fileAttachList" , fileAttachList);
		
		return "organization/empUpdate";
	}
	
	// 사원 수정 확인 눌렀을때 이동
	@PostMapping("/emplUpdatePost")
	public String emplUpdatePost(EmployeeVO employeeVO, MultipartFile[] uploadFile, AttachFileVO attachFileVO, Principal principal) {
		
		//log.info("넘겨받은 employeeVO ?????? : " + employeeVO);
		
		// 비밀번호 암호화
		String encode = bCryptPasswordEncoder.encode(employeeVO.getPassword());
		employeeVO.setPassword(encode);
		
		// file insert로 수정하기
		//attachFileService.updateFileList("organization", uploadFile, attachFileVO);
		AttachFileVO insertFile = attachFileService.insertFile("organization", uploadFile);
		//log.info("수정시 등록된파일 : " + insertFile);
		
		// 사진 수정 안했을경우
		if(insertFile == null) {
			// 원래 있던 파일로 넘겨주기
			String emplNo = employeeVO.getEmplNo();
			EmployeeVO employeeData = organizationService.emplDetail(emplNo);
			int fileNo = employeeData.getAtchFileNo();
			String proflUrl = employeeData.getProflPhotoUrl();
			employeeVO.setAtchFileNo(fileNo);
			employeeVO.setProflPhotoUrl(proflUrl);
		}else {
			long fileNoL = insertFile.getAtchFileNo();
			//log.info("수정시 등록된 파일 번호 : " + fileNoL);
			
			int fileNo = (int) fileNoL;
			employeeVO.setAtchFileNo(fileNo);
			
			String fileNm = insertFile.getFileStrePath();
			employeeVO.setProflPhotoUrl(fileNm);
		}
		
		organizationService.emplUpdatePost(employeeVO);
		
		//log.info("파일까지 수정된 사원 정보 : " + employeeVO);
		
		// 사원번호 꺼내기
		String emplNoParam = employeeVO.getEmplNo();
		
		// 관리자면 조직관리 페이지로 이동시키기
		String adminEmplNo = principal.getName();
		if(adminEmplNo.equals("20250000")) {
			return "redirect:/orglistAdmin";
		}
		
		// 수정 요청한 사원과 같으면 페이지 이동
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null && auth.getPrincipal() instanceof CustomUser) {
		    CustomUser customUser = (CustomUser) auth.getPrincipal();
		    EmployeeVO empVO = customUser.getEmpVO();
		    log.info("sisisisiisis : " + empVO);
		    // empVO 사용
		    if(empVO.getEmplNo().equals(emplNoParam)) {
		    	return "redirect:/orglist";
		    }
		}
			return "redirect:/orglistAdmin"; 
	}
	
	// 사원 삭제
	@GetMapping("/emplDelete")
	public String emplDelete(String emplNo) {
		
		log.info("삭제시 넘어온 사원번호 : " + emplNo);
		
		organizationService.emplDelete(emplNo);
		
		return "redirect:/orglistAdmin";
	}

	// 사용자 알림 정보 가져오기 - 허성진
	@ResponseBody
	@GetMapping("/getNotification")
	public Map<String, Object> getNotification(@AuthenticationPrincipal CustomUser customUser) {
		EmployeeVO empVO = customUser.getEmpVO();
		Map<String, Object> empNotification = this.organizationService.getEmpNotification(empVO);

		return empNotification;
	}
	
}
