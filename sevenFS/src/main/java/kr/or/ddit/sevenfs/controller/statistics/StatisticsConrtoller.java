package kr.or.ddit.sevenfs.controller.statistics;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.sevenfs.service.statistics.impl.StatisticsServiceImpl;
import kr.or.ddit.sevenfs.vo.statistics.StatisticsVO;
import lombok.extern.slf4j.Slf4j;


@Controller
@Slf4j
public class StatisticsConrtoller {
	
	@Autowired
	StatisticsServiceImpl statisticsServiceImpl;
	
	
	// 통계 홈 
	@GetMapping("/statistics/statisticsHome")
	public String statisticsHome() {
		
		return "statistics/statisticsHome";
	}
	
	//통계 직원관리 -> 결근 
	// Absent without leave 결근 약자 
	@GetMapping("/statistics/statisticsAWOL")
	public String statisticsAWOL() {
		
		return "statistics/statisticsAWOL";
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
	@ResponseBody
	@PostMapping("/statistics/statisticsAWOL/AWOLAjax")
	public List<Map<String,Object>> statisticsAWOLAjax(StatisticsVO statisticsVO) {
		/*1. 연간
		StatisticsVO(interval=year, chartType=line, startYearsY=2024, endYearsY=2025, dept=[인사부, 영업부], startYearsM=, startMonths=null, endMonths=null, startDays=, endDays=)
		StatisticsVO(interval=year, chartType=null, startYearsY=2024, endYearsY=2025, dept=[10, 30, 40], startYearsM=, startMonths=null, endMonths=null, startDays=, endDays=, deptCodelength=0)
		2. 월간
		StatisticsVO(interval=month, chartType=bars, startYearsY=null, endYearsY=null, dept=[경영지원부, 영업부, 구매부], startYearsM=2025, startMonths=03, endMonths=05, startDays=, endDays=)
		
		3. 일간
		StatisticsVO(interval=day, chartType=area, startYearsY=null, endYearsY=null, dept=[구매부, 디자인부, 연구소], startYearsM=, startMonths=null, endMonths=null, startDays=2025-04-04, endDays=2025-04-30)
		 */
		log.info("statisticsAWOLAjax : " + statisticsVO);
		
		if(statisticsVO.getDept()!=null) {
			List<String> deptList = new ArrayList<String>();
			
			for(String dept : statisticsVO.getDept()) {
				deptList.add(dept);
			}
			
			//부서배열 dept=[10, 30, 40] => deptList : ['10', '30', '40']
			statisticsVO.setDeptList(deptList);
		}//부서 선택을 했을때만 실행
		
		List<Map<String,Object>> mapList = this.statisticsServiceImpl.AWOLAjax(statisticsVO);
		// awolList잘받아왓나 
		//1. 연간 : mapList : [{EMP_COUNT=27, DEPT_RANGE=7FS}, {EMP_COUNT=9, DEPT_RANGE=구매부},..
		//2. 월간 : mapList : [{EMP_COUNT=20, DEPT_RANGE=7FS}, {EMP_COUNT=8, DEPT_RANGE=구매부}...
		//3. 일간 : mapList : [{EMP_COUNT=9, DEPT_RANGE=7FS}, {EMP_COUNT=2, DEPT_RANGE=구매부}, {EMP_COUNT=6, DEPT_RANGE=인사부}, ..
		log.info("AWOLAjax->mapList : " + mapList);
		
		
		List<String[]> arrList = new ArrayList<String[]>();
		
//		String[] arr = new String[2];
//		arr[0] = "";
//		arr[1] = "";
//		arrList.add(arr);
//		
//		//반복
//		for(Map<String,Object> map : mapList) {
//		arr = new String[2];
//		arr[0] = map.get("").toString();
//		arr[1] = map.get("").toString();
//		arrList.add(arr);			
//				}
//				
//		log.info("AWOLAjax->arrList : " + arrList);
		
		
		return mapList;
	}
	

}
