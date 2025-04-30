package kr.or.ddit.sevenfs.controller.organization;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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
	
	// 근태현황 엑셀 다운로드
    @GetMapping("/dclzExcelDownload")
    public void downloadExcel(
            HttpServletResponse response,
            Principal principal,
            @RequestParam(defaultValue = "") String keyword,
    		@RequestParam(defaultValue = "") String keywordSearch) throws IOException {
        
    	
    	String emplNo = principal.getName();
    	
        Map<String, Object> map = new HashMap<>();
        map.put("emplNo", emplNo);
        map.put("keyword", keyword);
        map.put("keywordSearch", keywordSearch);
        
        List<DclzTypeVO> empDclzList = dclztypeService.emplDclzTypeList(map);
        
        // Excel 파일 생성
        XSSFWorkbook workbook = new XSSFWorkbook();
        XSSFSheet sheet = workbook.createSheet("근태현황 목록");
        
        // 헤더 스타일
        CellStyle headerStyle = workbook.createCellStyle();
        XSSFFont headerFont = workbook.createFont();
        headerFont.setBold(true);
        headerStyle.setFont(headerFont);
        headerStyle.setAlignment(HorizontalAlignment.CENTER);
        
        // 헤더 행 생성
        Row headerRow = sheet.createRow(0);
        String[] headers = {"번호", "근무일자", "근태유형", "업무시작", "업무종료", "총 근무시간"};
        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
            cell.setCellStyle(headerStyle);
            sheet.setColumnWidth(i, 4000); // 칼럼 너비 설정
        }
        
        // 데이터 행 생성
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        
        int rowNum = 1;
        for (DclzTypeVO dclz : empDclzList) {
        	// 총 근무시간
        	String workHour = dclz.getWorkHour();
        	String workMinutes = dclz.getWorkMinutes();
        	
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(rowNum - 1);
            row.createCell(1).setCellValue(dclz.getDclzNo().substring(0, 4)+"-"+dclz.getDclzNo().substring(4, 6)+"-"+dclz.getDclzNo().substring(6, 8));
            row.createCell(2).setCellValue(dclz.getCmmnCodeNm());
            row.createCell(3).setCellValue(dclz.getDclzBeginDt() != null ? sdf.format(dclz.getDclzBeginDt()) : "");
            row.createCell(4).setCellValue(dclz.getDclzEndDt() != null ? sdf.format(dclz.getDclzEndDt()) : "");
            if(workHour == null || workMinutes == null) {
            	row.createCell(5).setCellValue("미등록");
            }else {
            	row.createCell(5).setCellValue(workHour+"시간 "+workMinutes+"분");
            }
        }
        
        // 파일 다운로드 설정
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        String fileName = URLEncoder.encode(keyword + "월" + "_근태현황_목록" + ".xlsx", "UTF-8");
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
        
        // 파일 출력
        ServletOutputStream outputStream = response.getOutputStream();
        workbook.write(outputStream);
        workbook.close();
        outputStream.close();
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
	
	// 연차관리 엑셀 다운로드
	@GetMapping("/vacationExcelDownload")
	public void vacationExcelDownload(HttpServletResponse response
				, @RequestParam(defaultValue = "1") int currentPage
				, @RequestParam(defaultValue = "") String keywordName
				, @RequestParam(defaultValue = "") String keywordDept) throws IOException{
		         
		
		  // 모든 프로젝트를 가져오기 위해 페이지 크기를 크게 설정
        Map<String, Object> map = new HashMap<>();
        map.put("currentPage", 1);  // 모든 데이터를 가져오기 위해 첫 페이지로 설정
        map.put("size", 1000);      // 큰 값으로 설정하여 모든 데이터 가져오기
        map.put("keywordName", keywordName);
        map.put("keywordDept", keywordDept);
        
        log.info("vacation keywordName : " + keywordName);
        log.info("vacation keywordDept : " + keywordDept);
        
        // 모든 사원의 연차 현황
 		List<VacationVO> allEmplVacList = this.dclztypeService.allEmplVacationAdmin(map);
        
        // Excel 파일 생성
        XSSFWorkbook workbook = new XSSFWorkbook();
        XSSFSheet sheet = workbook.createSheet("사원 연차 현황 목록");
        
        // 헤더 스타일
        CellStyle headerStyle = workbook.createCellStyle();
        XSSFFont headerFont = workbook.createFont();
        headerFont.setBold(true);
        headerStyle.setFont(headerFont);
        headerStyle.setAlignment(HorizontalAlignment.CENTER);
        
        // 헤더 행 생성
        Row headerRow = sheet.createRow(0);
        String[] headers = {"번호", "사원이름", "부서명", "입사일자", "성과 보상", "근무 보상", "총 연차일수", "사용 연차일수", "잔여 연차일수"};
        
        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
            cell.setCellStyle(headerStyle);
            sheet.setColumnWidth(i, 4000); // 칼럼 너비 설정
        }
        
        // 데이터 행 생성
        int rowNum = 1;
        for (VacationVO vacation : allEmplVacList) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(rowNum - 1);
            row.createCell(1).setCellValue(vacation.getEmplNm());
            row.createCell(2).setCellValue(vacation.getCmmnCodeNm());
            row.createCell(3).setCellValue(vacation.getEcnyDate());
            row.createCell(4).setCellValue(vacation.getCmpnstnYryc());
            row.createCell(5).setCellValue(vacation.getExcessWorkYryc());
            row.createCell(6).setCellValue(vacation.getTotYrycDaycnt());
            row.createCell(7).setCellValue(vacation.getYrycUseDaycnt());
            row.createCell(8).setCellValue(vacation.getYrycRemndrDaycnt());
        }
        
        // 파일 다운로드 설정
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        String fileName = "";
        
        boolean isNameEmpty = (keywordName == null || keywordName.trim().isEmpty());
        boolean isDeptEmpty = (keywordDept == null || keywordDept.trim().isEmpty());
        
        if(isNameEmpty && isDeptEmpty) {
        	fileName = URLEncoder.encode("전체사원_연차현황_목록" + LocalDate.now() + ".xlsx", "UTF-8");
        }else if(!isDeptEmpty && isNameEmpty){
        	fileName = URLEncoder.encode(keywordDept.replace(" ", "_") + "_연차현황_목록" + LocalDate.now() + ".xlsx", "UTF-8");
        }else{
        	fileName = URLEncoder.encode(keywordName.trim() + "_연차현황_" + LocalDate.now() + ".xlsx", "UTF-8");
        }
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
        
        // 파일 출력
        ServletOutputStream outputStream = response.getOutputStream();
        workbook.write(outputStream);
        workbook.close();
        outputStream.close();

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