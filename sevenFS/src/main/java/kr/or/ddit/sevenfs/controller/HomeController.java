package kr.or.ddit.sevenfs.controller;

import java.security.Principal;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.sevenfs.service.organization.DclztypeService;
import kr.or.ddit.sevenfs.utils.ArticlePage;
import kr.or.ddit.sevenfs.vo.organization.DclzTypeVO;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("/main")
public class HomeController {
	
	@Autowired
	DclztypeService dclztypeService;
	
	@GetMapping("/home")
	public String main(Model model, DclzTypeVO dclzTypeVO) {

		
		return "home";
	}
	
	// 출퇴근 버튼 jsp
//	@GetMapping
//	public String main(Model model) {
//		// 오늘날짜
//		Date today = new Date();
//		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
//		dateFormat.applyPattern("yyyy년 MM월 dd일");
//		log.info("today : " + dateFormat.format(today));
//		model.addAttribute("today" , dateFormat.format(today));
//		
//		return "/organization/dclz/workButton";
//	}
//	
	// 출근 버튼 눌렀을때 실행
	@ResponseBody
	@GetMapping("/todayWorkStart")
	public String todayWorkStart(Principal principal, Model model, DclzTypeVO dclzTypeVO) {
		
		String emplNo = principal.getName();
		dclzTypeVO.setEmplNo(emplNo);

		 LocalTime now = LocalTime.now();
		 int nowHour = now.getHour();
		 
		 //log.info("nowHour : " + nowHour);
		 
		 // 시간이 9시 이전이면 출근 insert 근태넘버 11
		 if(nowHour < 9) {
			 dclzTypeVO.setDclzCode("11");
		 }
		 else { // 시간이 9시 이후면 지각 insert 근태넘버 01
			 dclzTypeVO.setDclzCode("01");
		 }
		
		//log.info("출근한사람~~ : " + emplNo);
		
		 // 현재 로그인한 사원번호 가져오기
         // 출근시간 insert
    	 int result = dclztypeService.workBeginInsert(dclzTypeVO);
    	 //log.info("result : " + result);
    	 
    	 // 오늘 출퇴근시간 조회
         if(result == 1) {
         	DclzTypeVO workTime = dclztypeService.getTodayWorkTime(dclzTypeVO);
         	//log.info("workTime : " + workTime);
         	
         	// 출근시간 return
         	String todayWorkTime = workTime.getTodayWorkStartTime();
         	//log.info("controller 출근시간 : " + todayWorkTime);
         	return todayWorkTime;
         }
		return "실패";
	}
		
		
	// 퇴근 버튼 눌렀을때 실행
	@ResponseBody
	@GetMapping("/todayWorkEnd")
	public String todayWorkEnd(Principal principal, Model model, DclzTypeVO dclzTypeVO,
			@RequestParam(defaultValue="1") int currentPage,
			@RequestParam(defaultValue = "10") int size) {
		
		String emplNo = principal.getName();
		dclzTypeVO.setEmplNo(emplNo);
		
		Map<String, Object> map = new HashMap<>();
		map.put("emplNo" , emplNo);
		map.put("currentPage", currentPage);
		map.put("size", size);
		
		// 게시글의 총 갯수
		int total = dclztypeService.getTotal(map);
		log.info("total : " + total);
		
		ArticlePage<DclzTypeVO> articlePage = new ArticlePage<>(total, currentPage, size);

		List<DclzTypeVO> empDclzList = dclztypeService.emplDclzTypeList(map);
		//log.info("empDclzList : " + empDclzList);
		String dclzCode = empDclzList.get(0).getDclzCode();
		
		dclzTypeVO.setDclzCode(dclzCode);
		
		//log.info("퇴근한사람~~~~~ : " + emplNo);
		
		int result = dclztypeService.workEndInsert(dclzTypeVO);
		
		// 퇴근시간 insert
		if(result == 1) {
			DclzTypeVO workTime = dclztypeService.getTodayWorkTime(dclzTypeVO);
         	//log.info("workTime : " + workTime);
         	
         	// 출근시간 return
         	String todayWorkEndTime = workTime.getTodayWorkEndTime();
         	//log.info("controller 퇴근시간 : " + todayWorkEndTime);
         	
         	return todayWorkEndTime;
		}
		return "실패";
	}
	
	
	

}
