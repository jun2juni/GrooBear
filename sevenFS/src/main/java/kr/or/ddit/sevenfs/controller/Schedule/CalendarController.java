package kr.or.ddit.sevenfs.controller.Schedule;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.annotation.RequestScope;

import kr.or.ddit.sevenfs.service.Schedule.ScheduleSertvice;
import kr.or.ddit.sevenfs.vo.Schedule.ScheduleVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/myCalendar")
@Slf4j
public class CalendarController {
	// I'm fucking coder I'm not a developer 
	@Autowired
	ScheduleSertvice scheduleSertvice;
	// 드래그나 리사이즈로 변경하는건 map으로 담아서 로그아웃이나 페이지 벗아날시 한번에 db에 update한다.
	// 
	
	private Map<String, Object> uptMap = new HashMap<>();  
	
	@GetMapping("")
	public String calendarMain() {
		log.info("calendarMain 실행");
//		return "calendar/calendarMain";
		return "home";
	}
	
	@GetMapping("/calendarList")
	@ResponseBody
	public List<ScheduleVO> calendarList(){
		log.info("calendarList 실행");
		log.info("업데이트 항목 개수 : "+uptMap.size());
		if(uptMap.size()!=0) {
			log.info("업데이트 항목 : "+uptMap);
			int result = scheduleSertvice.scheduleUpdateMap(uptMap);
			log.info("업데이트 실행 -> 결과 : "+result);
			if(result!=0) {
				uptMap.clear();
			}
		}
		List<ScheduleVO> scheduleList = scheduleSertvice.scheduleList();
		log.info("calendarList -> scheduleList : "+scheduleList);
		return scheduleList;
	}
	
	@PostMapping("/addCalendar")
	@ResponseBody
	public List<ScheduleVO> addCalendar(@ModelAttribute  ScheduleVO scheduleVO){
		log.info("addCalendar -> scheduleVO : "+scheduleVO);
		int result = scheduleSertvice.scheduleInsert(scheduleVO);
		List<ScheduleVO> scheduleList = scheduleSertvice.scheduleList();
		return scheduleList;
	}
	
	@ResponseBody
	@PostMapping("/uptCalendar")
	public List<ScheduleVO> uptCalendar(@ModelAttribute  ScheduleVO scheduleVO){
		log.info("uptCalendar -> scheduleVO : "+scheduleVO);
		int result = scheduleSertvice.scheduleUpdate(scheduleVO);
		List<ScheduleVO> scheduleList = scheduleSertvice.scheduleList();
		return scheduleList;
	}
	
	@ResponseBody
	@PostMapping("/delCalendar")
	public List<ScheduleVO> delCalendar(@RequestBody ScheduleVO scheduleVO){
		int schdulNo = scheduleVO.getSchdulNo();
		uptMap.remove(schdulNo+"");
		log.info("delCalendar -> schdulNo : "+schdulNo);
		int result = scheduleSertvice.delCalendar(schdulNo);
		List<ScheduleVO> scheduleList = scheduleSertvice.scheduleList();
		return scheduleList;
	}
	
	@ResponseBody
	@PostMapping("/uptEvent")
	public int uptEvent(@RequestBody ScheduleVO scheduleVO) {
//	public void uptEvent(@RequestBody ScheduleVO scheduleVO) {
		log.info("uptEvent -> scheduleVO"+scheduleVO);
		uptMap.put(scheduleVO.getSchdulNo()+"", scheduleVO);
		log.info("uptMap -> "+uptMap);
		log.info("uptMap -> uptMap.size : "+uptMap.size());
		return uptMap.size();
	}
	
}
