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

import com.google.gson.Gson;

import kr.or.ddit.sevenfs.vo.OrganizationVO;
import kr.or.ddit.sevenfs.service.organization.OrganizationService;
import kr.or.ddit.sevenfs.vo.CommonCodeVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

// 조직도 Controller

@Slf4j
@Controller
public class OrganizationController {
	
	@Autowired
	OrganizationService organizationService;
	
	// 상위부서 , 하위부서 , 소속사원 조회
	@GetMapping("/orglist")
	public String organizationList(Model model) {
		//Gson gson = new Gson();

		model.addAttribute("title" , "조직도");
		
		//OrganizationVO organization = organizationService.organization();
		
		//String orgData = gson.toJson(organization);
		//model.addAttribute("orgData", orgData);
		//log.info("orgData : " + organization);
		
		return "organization/organizationList";
	}

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
	
	// 사원상세
	@GetMapping("/emplDetail")
	public String emplDetail(@RequestParam(value = "emplNo") String emplNo
							, Model model) {
		
		//log.info("사원번호 와라와라 : " + emplNo);
		EmployeeVO empDetail = organizationService.emplDetail(emplNo);
		log.info("사원상세 : " + empDetail);
		
		model.addAttribute("empDetail", empDetail);
		
		return "organization/employeeDetail";
	}

	// 관리자일때 조직관리 페이지로 이동
	@GetMapping("/orglistAdmin")
	public String orglistAdmin(Model model) {
		
		model.addAttribute("title", "조직관리");
		
		return "organization/orglistAdmin";
	}
	
	// 사원 수정 클릭했을때 수정페이지로 이동
	@GetMapping("/depUpdate")
	public String depUpdate(@RequestParam String cmmnCode, Model model) {
		
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
		
		return "organization/organizationList";
	}
	
	// 부서 등록
	@GetMapping("/depInsert")
	public String depInsert() {
		
		return "organization/depInsert";
	}
	
	@PostMapping("/depInsertPost")
	public String depInsertPost(CommonCodeVO commonCodeVO) {

		int result = organizationService.depInsert(commonCodeVO);
		
		return "organization/organizationList";
	}
	
	// 부서 삭제
	@ResponseBody
	@GetMapping("/deptDelete")
	public int deptDelete(String cmmnCode) {
		
		log.info("삭제 cmmnCode : " + cmmnCode);
		int result = organizationService.deptDelete(cmmnCode);
		
		return result;
	}
	
	
	
}
