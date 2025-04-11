package kr.or.ddit.sevenfs.controller.mail;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.sevenfs.service.mail.MailService;
import kr.or.ddit.sevenfs.service.organization.OrganizationService;
import kr.or.ddit.sevenfs.vo.mail.MailVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/mail")
public class MailController {
	
	@Autowired
	MailService mailService;
	
	@Autowired
	OrganizationService organizationService;

	@GetMapping("")
	public String mailHome(Model model) {
		model.addAttribute("title","메일함");
		return "mail/mailHome";
	}
	
	@GetMapping("/mailSend")
	public String mailSend(Model model) {
		model.addAttribute("title","메일함");
		return "mail/mailSend";
	}
	
	@PostMapping("/selEmail")
	@ResponseBody
	public Map<String,String> selEmail(@RequestBody EmployeeVO employeeVO) {
		log.info("selEmail -> employeeVO : "+employeeVO);
		employeeVO = organizationService.emplDetail(employeeVO.getEmplNo());
		String email = employeeVO.getEmail();
		String emplNm = employeeVO.getEmplNm();
		log.info("selEmail -> emplDetail -> email : "+email);
		log.info("selEmail -> emplDetail -> emplNm : "+emplNm);
		Map<String,String> map = new HashMap<>();
		map.put("email", email);
		map.put("emplNm", emplNm);
		return map;
	}
	@PostMapping("/sendMail")
	public String sendEmail(@RequestBody MailVO mailVO) {
		log.info("sendEmail -> mailVO : "+mailVO);
		return "success";
	}
}
