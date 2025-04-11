package kr.or.ddit.sevenfs.controller.statistics;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.sevenfs.service.statistics.impl.StatisticsServiceImpl;
import kr.or.ddit.sevenfs.vo.statistics.StatisticsVO;
import lombok.extern.slf4j.Slf4j;
	


@Slf4j
@RequestMapping("/statistics")
@Controller
public class StatisticsConrtoller {
	
	@Autowired
	StatisticsServiceImpl statisticsServiceImpl;
	
	
	// 통계 홈 
	@GetMapping("/statisticsHome")
	public String statisticsHome() {
		
		return "statistics/statisticsHome";
	}
	
	//통계 직원관리 -> 결근 
	// Absent without leave 결근 약자 
//	@GetMapping("/statisticsAWOL")	
//	public Map<String, Object> statisticsAWOL() {
//		
//		Map<String, Object> result = new HashMap<>();
//		String[] header = {"인사부","경영지원부","영업부","생산부","구매부","품질부","디자인부","연구소"};
//		String[] dclzArr = {"01", "03"};
//		List<Map<String, Object>> AWOL = statisticsServiceImpl.getAWOL("202401", "202512", header);
//		result.put("AWOL", AWOL);
//		
//		return "/statisticsAWOL.jsp";
//	}
	
	// 통계 AWOL
	@GetMapping("/statisticsAWOL")
	public String statisticsAWOL() {
		
		return "statistics/statisticsAWOL";
	}
	
	// ResponseBody -> json으로내보낼 때 필요한 어노테이션 
	@ResponseBody
	@GetMapping("/resultAWOL")	
	public Map<String, Object> resultAWOL(Model model
								,@RequestParam(value ="started",required=false) String started
								,@RequestParam(value ="ended",required=false)String ended) {
		
		log.info("스타트" +started+"엔디드"+ended);
		
		Map<String, Object> result = new HashMap<>();
        String[] header = {"인사부","경영지원부","영업부","생산부","구매부","품질부","디자인부","연구소"};
        String[] dclzArr = {"01", "03"};
        List<Map<String, Object>> AWOL = statisticsServiceImpl.getAWOL(started,ended, header);
        result.put("AWOL", AWOL);
		  
        model.addAttribute("result",result);
//        model.addAttribute("AWOL",AWOL);
        
		return result ;
	}
	
	// 비동기 처리 
	/*
	 1. 연간
	 	*interval : dclzBeginDt
	 	*chartType : 
	 	startYearsY : 
	 	endYearsY : 
	 	*dept : deptCode
	 	
	 2. 월간
	 	*interval : dclzBeginDt
	 	*chartType : 
	  	startYearsM
	  	startMonths
	  	endMonths
	  	*dept : deptCode
	  	
	 3. 일간
	 	*interval : dclzBeginDt
	 	*chartType : 
	 	startDays
	 	endDays
	 	*dept : deptCode
	 */
//	@ResponseBody
//	@PostMapping("/statistics/statisticsAWOL/AWOLAjax")
//	public List<String[]> statisticsAWOLAjax(StatisticsVO statisticsVO) {
//		/*1. 연간
//		StatisticsVO(interval=year, chartType=line, startYearsY=2024, endYearsY=2025, dept=[인사부, 영업부], startYearsM=, startMonths=null, endMonths=null, startDays=, endDays=)
//		StatisticsVO(interval=year, chartType=null, startYearsY=2024, endYearsY=2025, dept=[10, 30, 40], startYearsM=, startMonths=null, endMonths=null, startDays=, endDays=, deptCodelength=0)
//		2. 월간
//		StatisticsVO(interval=month, chartType=bars, startYearsY=null, endYearsY=null, dept=[경영지원부, 영업부, 구매부], startYearsM=2025, startMonths=03, endMonths=05, startDays=, endDays=)
//		
//		3. 일간
//		StatisticsVO(interval=day, chartType=area, startYearsY=null, endYearsY=null, dept=[구매부, 디자인부, 연구소], startYearsM=, startMonths=null, endMonths=null, startDays=2025-04-04, endDays=2025-04-30)
//		 */
//		log.info("statisticsAWOLAjax : " + statisticsVO);
//		
//		if(statisticsVO.getDept()!=null) {
//			List<String> deptList = new ArrayList<String>();
//			
//			for(String dept : statisticsVO.getDept()) {
//				deptList.add(dept);
//			}
//			
//			//부서배열 dept=[10, 30, 40] => deptList : ['10', '30', '40']
//			statisticsVO.setDeptList(deptList);
//			log.info("deptList : " + deptList);
//		}//부서 선택을 했을때만 실행	
//		
//		
//		List<Map<String,Object>> mapList = this.statisticsServiceImpl.getAWOL();
//		// awolList잘받아왓나 
//		//1. 연간 : mapList : [{EMP_COUNT=27, DEPT_RANGE=7FS}, {EMP_COUNT=9, DEPT_RANGE=구매부},..
//		//2. 월간 : mapList : [{EMP_COUNT=20, DEPT_RANGE=7FS}, {EMP_COUNT=8, DEPT_RANGE=구매부}...
//		//3. 일간 : mapList : [{EMP_COUNT=9, DEPT_RANGE=7FS}, {EMP_COUNT=2, DEPT_RANGE=구매부}, {EMP_COUNT=6, DEPT_RANGE=인사부}, ..
//		log.info("AWOLAjax->mapList : " + mapList);
//		
//		
//		List<String[]> arrList = new ArrayList<String[]>();
//		
//		String[] arr = new String[2];
//		arr[0] = "";
//		arr[1] = "";
//		arrList.add(arr);
//		
//		
//		return arrList;
//	}
	

}
