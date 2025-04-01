package kr.or.ddit.sevenfs.controller.statics;

import org.springframework.stereotype.Controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@Slf4j
public class StaticsConrtoller {
	
	@GetMapping("/statistics/statisticsHome")
	public String statisticsHome() {
		
		return "statistics/statisticsHome";
	}
	
	// Absent without leave 결근 약자 
	@GetMapping("/statistics/statisticsAWOL")
	public String statisticsAWOL() {
		
		return "statistics/statisticsAWOL";
	}
	

}
