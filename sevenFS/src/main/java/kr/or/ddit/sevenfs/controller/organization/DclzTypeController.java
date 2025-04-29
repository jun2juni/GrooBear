package kr.or.ddit.sevenfs.controller.organization;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
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

import kr.or.ddit.sevenfs.service.organization.DclztypeService;
import kr.or.ddit.sevenfs.utils.ArticlePage;
import kr.or.ddit.sevenfs.utils.CommonCode;
import kr.or.ddit.sevenfs.vo.CommonCodeVO;
import kr.or.ddit.sevenfs.vo.organization.DclzTypeDetailVO;
import kr.or.ddit.sevenfs.vo.organization.DclzTypeVO;
import kr.or.ddit.sevenfs.vo.organization.VacationVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/dclz")
public class DclzTypeController {
	
	@Autowired
	DclztypeService dclztypeService;
	
	@GetMapping("/dclzType")
	public String dclzType(Model model, Principal principal, DclzTypeVO dclzTypeVO,
			@RequestParam(defaultValue = "1") int currentPage,
			@RequestParam(defaultValue = "10") int size,
			@RequestParam(defaultValue = "") String keyword,
			@RequestParam(defaultValue = "") String keywordSearch
			) {
		model.addAttribute("title" , "나의 근태 현황");
		
		// 페이징처리
				String emplNo = principal.getName();
				//log.info("username : " + emplNo);
				dclzTypeVO.setEmplNo(emplNo);
		
		// 근태 selectBox를 위한 근태현황 조회
		List<DclzTypeVO> dclzSelList = dclztypeService.dclzSelList(emplNo);
		Date beginDt = dclzSelList.get(0).getDclzBeginDt();
		
		String paramKeyword = "";
		
		if(keywordSearch != null && !keywordSearch.trim().isEmpty()) {
			keyword = "";
		} else {
			// 키워드 없을때
			if(keyword == null || keyword.trim().isEmpty()) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				sdf.applyPattern("yyyy-MM");
				String simepleFormatted = sdf.format(beginDt);
				//log.info("simepleFormatted : " + simepleFormatted);
				keyword = simepleFormatted;
			}
		}
		
		model.addAttribute("paramKeyword" , keyword);
		
		log.info("dclz keyword : " + keyword);
		log.info("dclz keywordSearch : " + keywordSearch);
		
		
		model.addAttribute("emplNo" , emplNo);
		Map<String, Object> map = new HashMap<>();
		map.put("emplNo" , emplNo);
		map.put("currentPage", currentPage);
		map.put("size", size);
		map.put("keyword", keyword);
		map.put("keywordSearch", keywordSearch);
		
		// 게시글의 총 갯수
		int total = dclztypeService.getTotal(map);
		log.info("total : " + total);
		ArticlePage<DclzTypeVO> articlePage = new ArticlePage<>(total, currentPage, size);
		log.info("articlePage : " + articlePage);
		
		// 근태현황 대분류 개수
		DclzTypeVO dclzCnt = dclztypeService.dclzCnt(map);
		log.info("dclzCnt : " + dclzCnt);
		model.addAttribute("dclzCnt" , dclzCnt);
		
		// 대분류에 따른 사원 상세 근태현황 목록
		List<DclzTypeDetailVO> empDetailDclzTypeCnt = dclztypeService.empDetailDclzTypeCnt(map);
		log.info("empDetailDclzTypeCnt" + empDetailDclzTypeCnt);
		model.addAttribute("empDetailDclzTypeCnt", empDetailDclzTypeCnt);		
		
		// 사원의 전체 근태현황 조회
		List<DclzTypeVO> empDclzList = dclztypeService.emplDclzTypeList(map);
		log.info("controller -> empDclzList : " + empDclzList);
		model.addAttribute("empDclzList",empDclzList);
		model.addAttribute("articlePage" , articlePage);
     	
		return "organization/dclz/dclzType";
	}
	
	// 년도 , 달 선택했을때
	@ResponseBody
	@PostMapping("/yearSelect")
	public Map<String, Object> yearSelect(@RequestBody DclzTypeVO dclzTypeVO,
			@RequestParam(defaultValue="1") int currentPage,
			@RequestParam(defaultValue = "10") int size) {
		
		String employeeNo = dclzTypeVO.getEmplNo();
		
		// 년도 조회 쿼리로 보낼 map
		Map<String, Object> map = new HashMap<>();
		map.put("emplNo" , employeeNo);
		map.put("currentPage", currentPage);
		map.put("size", size);
		
		// 년도 + 달 조회 쿼리로 보낼 map
		Map<String, Object> mapMonth = new HashMap<>();
		mapMonth.put("emplNo" , employeeNo);
		mapMonth.put("currentPage", currentPage);
		mapMonth.put("size", size);
		
		// 게시글의 총 갯수
		int total = dclztypeService.getTotal(map);
		log.info("total : " + total);
		
		// 페이지 정보
		ArticlePage<DclzTypeVO> articlePage = new ArticlePage<>(total, currentPage, size);
		map.put("articlePage", articlePage);
		mapMonth.put("articlePage", articlePage);
		
		//log.info("param : " + dclzTypeVO);
		// jsp에서 보낸 년도
		String date = dclzTypeVO.getWorkBeginDate();
		String selYear = date.substring(0, 4);
		map.put("workBeginDate", selYear);
		dclzTypeVO.setWorkBeginDate(selYear);
		//log.info("선택년도 : " + dclzTypeVO.getWorkBeginDate());

		// * 달만 선택시 검색 안됨 ...,
		// jsp에서 보낸 달
		String mon = dclzTypeVO.getWorkEndDate();
		log.info("선택 달 : " + mon);
		
		if(mon == null) {
			// 년도에만 해당하는 목록
			List<DclzTypeVO> selYearList = dclztypeService.getSelectYear(map);
			//log.info("selYearList : " + selYearList);
			map.put("selYearList", selYearList);
			return map;
			
		}else {
			String emplNo = dclzTypeVO.getEmplNo();
			dclzTypeVO.setEmplNo(emplNo);
			
			mapMonth.put("emplNo", emplNo);
			
			String selectYear = dclzTypeVO.getWorkBeginDate();
			
			mapMonth.put("workBeginDate", selectYear);
			mapMonth.put("workEndDate", mon);
			
			//log.info("월선택 실행");
			dclzTypeVO.setWorkBeginDate(selYear);
			dclzTypeVO.setWorkEndDate(mon);
			
			List<DclzTypeVO> selMonList = dclztypeService.getSelectMonth(mapMonth);
			//log.info("selMonList : " + selMonList);
			mapMonth.put("selMonList", selMonList);
			
			return mapMonth;
		}
	}
	
	// 연차 페이지
	@GetMapping("/vacation")
	public String vacation(Model model, Principal principal, VacationVO vacationVO,
			@RequestParam(defaultValue="1") int currentPage,
			@RequestParam(defaultValue = "10") int size,
			@RequestParam(defaultValue = "") String keyword,
			@RequestParam(defaultValue = "") String keywordSearch,
			@RequestParam(defaultValue = "") String vacationType,
			@RequestParam(required = false) String targetEmplNo
			) {
		
		//model.addAttribute("title","나의 연차 내역 by박호산나");
		
		String emplNo = (targetEmplNo != null && !targetEmplNo.isEmpty())
						? targetEmplNo : principal.getName();
		log.info("targetEmplNo : " + targetEmplNo);
		
		String paramKeyword = "";
		
		Map<String, Object> map = new HashMap<>();
		
//		if(keywordSearch != null && !keywordSearch.trim().isEmpty()) {
//			keyword = "";
//			map.put("keywordSearch", keywordSearch);
//			log.info("keywordSearch : " + keywordSearch);
//		}
		
		// 검색한거 있을때 날짜 비워주기
		if(keywordSearch != null && !keywordSearch.trim().isEmpty()) {
			keyword = "";
		} else {
			// 키워드 없을때
			if(keyword == null || keyword.trim().isEmpty()) {
				Date date = new Date();
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
				dateFormat.applyPattern("yyyy-MM");
				String currentDate = dateFormat.format(date);
				keyword = currentDate;
			}
		}
		
		model.addAttribute("paramKeyword" , keyword);
		map.put("keywordSearch", keywordSearch);
		map.put("keyword", keyword);
		map.put("emplNo", emplNo);
		map.put("currentPage", currentPage);
		log.info("keyword ?? : " + keyword);
		
		// 연차사용내역 전체 행 수
		int total = dclztypeService.getVacTotal(map);
		
		// 페이지 정보
		ArticlePage<VacationVO> articlePage = new ArticlePage<>(total, currentPage, size);
		log.info("articlePage : " + articlePage);
		// 페이지정보 넘겨주기
		model.addAttribute("articlePage" , articlePage);
		
		// 사원의 이번년도 연차 현황 가져오기
		VacationVO emplVacation = dclztypeService.emplVacationCnt(emplNo);
		log.info("controller 연차현황 : " + emplVacation);
		
		// 잔여연차 계산된값 확인
		//double remain = emplVacation.getYrycRemndrDaycnt();
		//log.info("controller잔여연차 : " + remain);
		//emplVacation.setYrycRemndrDaycnt(remain);
		
		model.addAttribute("emplVacation",emplVacation);
		log.info("연차내역 : " + emplVacation);
		
		// 공통코드가 연차에 해당하는 사원의 모든 년도 데이터 가져오기
		List<DclzTypeVO> emplCmmnVacationList = dclztypeService.emplVacationDataList(map);
		model.addAttribute("emplCmmnVacationList" , emplCmmnVacationList);
		//log.info("사원의 모든 연차 사용내역 : " + emplCmmnVacationList);
		
		return "organization/dclz/vacation";
	}
	
	// 연차 페이지
	@GetMapping("/vacationAdmin")
	public String vacationAdmin(Model model, Principal principal, VacationVO vacationVO,
			@RequestParam(defaultValue="1") int currentPage,
			@RequestParam(defaultValue = "10") int size,
			@RequestParam(defaultValue = "") String keyword,
			@RequestParam(defaultValue = "") String keywordSearch,
			@RequestParam(defaultValue = "") String targetEmplNo
			) {
		
		//model.addAttribute("title","나의 연차 내역 by박호산나");
		
		String emplNo = targetEmplNo;
		log.info("넘어온 사원번호 : " + emplNo);
		
		log.info("keyword" + keyword);
		log.info("keywordSearch" + keywordSearch);
		
		String paramKeyword = "";
		// 키워드 없을때
		if(keyword == null || keyword.trim().isEmpty()) {
			Date date = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			dateFormat.applyPattern("yyyy-MM");
			String currentDate = dateFormat.format(date);
			keyword = currentDate;
		}
		model.addAttribute("paramKeyword" , keyword);
		Map<String, Object> map = new HashMap<>();
		map.put("emplNo", emplNo);
		map.put("currentPage", currentPage);
		map.put("keyword", keyword);
		map.put("keywordSearch", keywordSearch);
		
		// 연차사용내역 전체 행 수
		int total = dclztypeService.getVacTotal(map);
		
		// 페이지 정보
		ArticlePage<VacationVO> articlePage = new ArticlePage<>(total, currentPage, size);
		log.info("articlePage : " + articlePage);
		log.info("keyword : " + keyword);
		// 페이지정보 넘겨주기
		model.addAttribute("articlePage" , articlePage);
		
		// 사원의 이번년도 연차 현황 가져오기
		VacationVO emplVac = dclztypeService.emplVacationCnt(emplNo);
		log.info("controller 연차현황 : " + emplVac);
		
		// 잔여연차 계산된값 확인
		//double remain = emplVacation.getYrycRemndrDaycnt();
		//log.info("controller잔여연차 : " + remain);
		//emplVacation.setYrycRemndrDaycnt(remain);
		
		model.addAttribute("emplVac",emplVac);
		log.info("연차내역 : " + emplVac);
		
		// 공통코드가 연차에 해당하는 사원의 모든 년도 데이터 가져오기
		List<DclzTypeVO> emplCmmnVacList = dclztypeService.emplVacationDataList(map);
		model.addAttribute("emplCmmnVacList" , emplCmmnVacList);
		//log.info("사원의 모든 연차 사용내역 : " + emplCmmnVacationList);
		
		return "organization/dclz/vacationAdmin";
	}
	
	// 연차관리 페이지(관리자)
	@GetMapping("/vacAdmin")
	public String vacationAdmin( Model model
			,@RequestParam(defaultValue = "1") int currentPage
			,@RequestParam(defaultValue = "10") int size
			,@RequestParam(defaultValue = "") String keywordName
			,@RequestParam(defaultValue = "") String keywordDept
			,@RequestParam(defaultValue = "") String keywordEcny
			,@RequestParam(defaultValue = "") String keywordRetire
			) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("size", size);
		map.put("currentPage", currentPage);
		map.put("keywordName", keywordName);
		map.put("keywordDept", keywordDept);
		map.put("keywordEcny", keywordEcny);
		map.put("keywordRetire", keywordRetire); 
		
		log.info("받은 검색한 이름 :" + keywordName);
		log.info("받은 키워드 :" + keywordDept);
		log.info("받은 키워드 :" + keywordEcny);
		log.info("받은 키워드 :" + keywordRetire);
	
		// 페이지정보
		int total = dclztypeService.allEmplVacationAdminCnt();
		log.info("total : " + total);
		ArticlePage<VacationVO> articlePage = new ArticlePage<>(total, currentPage, size);
		log.info("articlePage : " + articlePage);
		model.addAttribute("articlePage", articlePage);
		model.addAttribute("total", total);
		//map.put("size", size);
		
		// 모든 사원의 연차 현황
		List<VacationVO> allEmplVacList = this.dclztypeService.allEmplVacationAdmin(map);
		log.info("모든 사원 연차 현황 : " + allEmplVacList);
		//map.put("allEmplVacList", allEmplVacList);
		model.addAttribute("allEmplVacList" , allEmplVacList);
		
		return "organization/dclz/vacAdmin";
	}
	
	// 연차관리에서 부여된 연차 update
	@GetMapping("/addVacInsert")
	public String addVacInsert(VacationVO vacationVO
				, @RequestParam(defaultValue = "1") String currentPage
				, @RequestParam(defaultValue = "") String keywordName
				, @RequestParam(defaultValue = "") String keywordDept) {
		
		String keyword = URLEncoder.encode(keywordName, StandardCharsets.UTF_8);
		String keyDept = URLEncoder.encode(keywordDept, StandardCharsets.UTF_8);
		log.info("addVacInsert->vacationVO : " + vacationVO);
		log.info("addVacInsert->currentPage : " + currentPage);
		log.info("addVacInsert->keywordName : " + keyword);
		
		int result = dclztypeService.addVacInsert(vacationVO);
		log.info("지급 결과 : " + result);
		
		// 선택사원 연차정보 UPDATE해주기
		return "redirect:/dclz/vacAdmin?currentPage=" + currentPage + "&keywordName=" + keyword + "&keywordDept=" + keyDept;
	}
}