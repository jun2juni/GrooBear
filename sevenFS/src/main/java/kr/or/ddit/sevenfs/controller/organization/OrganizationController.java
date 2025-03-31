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
				Gson gson = new Gson();

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

	
	@GetMapping("/emplDetail")
	public String emplDetail(@RequestParam(value = "emplNo") String emplNo
							, Model model) {
		
		//log.info("사원번호 와라와라 : " + emplNo);
		EmployeeVO empDetail = organizationService.emplDetail(emplNo);
		log.info("사원상세 : " + empDetail);
		
		model.addAttribute("empDetail", empDetail);
		
		return "organization/employeeDetail";
	}
	
	
	
}
