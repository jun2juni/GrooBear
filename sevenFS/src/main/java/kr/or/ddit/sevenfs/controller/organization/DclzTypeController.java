package kr.or.ddit.sevenfs.controller.organization;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.sevenfs.service.organization.DclztypeService;
import kr.or.ddit.sevenfs.vo.CommonCodeVO;
import kr.or.ddit.sevenfs.vo.organization.DclzTypeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/dclz")
public class DclzTypeController {
	
	@Autowired
	DclztypeService dclztypeService;
	
	@GetMapping("/dclzType")
	public String dclzType(Model model, Principal principal) {
		
		log.info("근태 현황 와씀");
		
		//if(principal != null) {
			String emplNo = principal.getName();
			log.info("username : " + emplNo);
			
			CommonCodeVO dclzCnt = dclztypeService.dclzCnt(emplNo);
			log.info("dclzCnt : " + dclzCnt);
		//}
		
		model.addAttribute("title" , "나의 근태 현황");
		
		return "organization/dclz/dclzType";
	}
}
