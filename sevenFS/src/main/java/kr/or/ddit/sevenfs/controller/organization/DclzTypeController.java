package kr.or.ddit.sevenfs.controller.organization;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class DclzTypeController {
	
	@GetMapping("/dclzType")
	public String dclzType(Model model) {
		
		log.info("근태 현황");
		
		model.addAttribute("title" , "나의 근태 현황");
		
		return "organization/dclzType";
	}

}
