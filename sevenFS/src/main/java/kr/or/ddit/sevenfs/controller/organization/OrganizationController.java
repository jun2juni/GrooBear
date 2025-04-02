package kr.or.ddit.sevenfs.controller.organization;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import kr.or.ddit.sevenfs.service.organization.OrganizationService;
import kr.or.ddit.sevenfs.utils.CommonCode;
import kr.or.ddit.sevenfs.vo.CommonCodeVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import kr.or.ddit.sevenfs.vo.organization.OrganizationVO;
import lombok.extern.slf4j.Slf4j;

// 조직도 Controller

@Slf4j
@Controller
public class OrganizationController {
	
	@Autowired
	OrganizationService organizationService;
	
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
		
		log.info("부서코드 : " + cmmnCode);
		CommonCodeVO deptDetail = organizationService.deptDetail(cmmnCode);
		model.addAttribute("deptDetail", deptDetail);
		
		return "organization/depUpdate";
	}
	
	// 수정확인 눌렀을때 이동
	@PostMapping("/depUpdatePost")
	public String depUpdatePost(CommonCodeVO commonCodeVO) {
		
		log.info("commonCodeVO : " + commonCodeVO);
		
		String cmmnCode = commonCodeVO.getCmmnCode();
		log.info("cmmnCode : " + cmmnCode);
		
		this.organizationService.deptUpdate(commonCodeVO);
		
		return "redirect:/orglist";
	}
	
	// 부서 등록
	@GetMapping("/depInsert")
	public String depInsert(Model model) {
		List<CommonCodeVO> depList = organizationService.depList();
		model.addAttribute("depList", depList);
		
		model.addAttribute("title" , "부서 등록");
		
		return "organization/depInsert";
	}
	
	// 확인 눌렀을때 조직도 목록으로 이동 
	@PostMapping("/depInsertPost")
	public String depInsertPost(CommonCodeVO commonCodeVO) {
		
		String upperCmmnCode = commonCodeVO.getUpperCmmnCode();
		log.info("선택한 공통코드 : " + upperCmmnCode);
		
		organizationService.depInsert(commonCodeVO);
		
		return "redirect:/orglistAdmin";
	}
	
	// 부서 삭제
	@ResponseBody
	@GetMapping("/deptDelete")
	public int deptDelete(String cmmnCode) {
		log.info("삭제 cmmnCode : " + cmmnCode);
		int result = organizationService.deptDelete(cmmnCode);
		return result;
	}
	

	// 사용자가 선택한 사원상세
	@GetMapping("/emplDetail")
	public String emplDetail(@RequestParam(value = "emplNo") String emplNo
							, Model model) {
		
		//log.info("사원번호 와라와라 : " + emplNo);
		EmployeeVO empDetail = organizationService.emplDetail(emplNo);
		log.info("사원상세 : " + empDetail);
		
		model.addAttribute("title" , "사원 정보");
		String maleCode = CommonCode.GenderEnum.MALE.getCode();
		String femaleCode = CommonCode.GenderEnum.FEMALE.getCode();
		String mailLabel = CommonCode.GenderEnum.MALE.getLabel();
		String femailLabel = CommonCode.GenderEnum.FEMALE.getLabel();
		
		if(empDetail.getGenderCode().equals(maleCode)) {
			empDetail.setGenderCode(mailLabel);
		}else {
			empDetail.setGenderCode(femailLabel);
		}
		model.addAttribute("empDetail", empDetail);
		
		return "organization/employeeDetail";
	}
	
	// 관리자가 선택한 사원상세
	@GetMapping("/emplDetailAdmin")
	public String emplDetailAdmin(@RequestParam(value = "emplNo") String emplNo
							, Model model) {
		
		//log.info("사원번호 와라와라 : " + emplNo);
		EmployeeVO empDetail = organizationService.emplDetail(emplNo);
		log.info("사원상세 : " + empDetail);
		
		model.addAttribute("title" , "사원 정보");
		String maleCode = CommonCode.GenderEnum.MALE.getCode();
		String femaleCode = CommonCode.GenderEnum.FEMALE.getCode();
		String mailLabel = CommonCode.GenderEnum.MALE.getLabel();
		String femailLabel = CommonCode.GenderEnum.FEMALE.getLabel();
		
		if(empDetail.getGenderCode().equals(maleCode)) {
			empDetail.setGenderCode(mailLabel);
		}else {
			empDetail.setGenderCode(femailLabel);
		}
		model.addAttribute("empDetail", empDetail);
		
		return "organization/employeeDetail";
	}
	
	// 사원 수정
	@GetMapping("/emplUpdate")
	public String emplUpdate(String emplNo, Model model) {
		
		model.addAttribute("title" , "사원 수정");
		
		EmployeeVO emplDetail = organizationService.emplDetail(emplNo);
		
		String maleCode = CommonCode.GenderEnum.MALE.getCode();
		String femaleCode = CommonCode.GenderEnum.FEMALE.getCode();
		String mailLabel = CommonCode.GenderEnum.MALE.getLabel();
		String femailLabel = CommonCode.GenderEnum.FEMALE.getLabel();
		
		if(emplDetail.getGenderCode().equals(maleCode)) {
			emplDetail.setGenderCode(mailLabel);
		}else {
			emplDetail.setGenderCode(femailLabel);
		}
		log.info("사원상세 : " + emplDetail);
		
		model.addAttribute("emplDetail", emplDetail);
		
		return "organization/empUpdate";
	}
	
	// 사원 수정 확인 눌렀을때 이동
	@PostMapping("/emplUpdatePost")
	public String emplUpdatePost(EmployeeVO employeeVO) {
		organizationService.emplUpdatePost(employeeVO);
		return "redirect:/emplDetail";
	}
	
	
}
