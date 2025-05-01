package kr.or.ddit.sevenfs.controller.atrz;

import java.io.IOException;
import java.net.URLEncoder;
import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
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
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.sevenfs.mapper.atrz.AtrzMapper;
import kr.or.ddit.sevenfs.service.AttachFileService;
import kr.or.ddit.sevenfs.service.atrz.AtrzService;
import kr.or.ddit.sevenfs.service.organization.OrganizationService;
import kr.or.ddit.sevenfs.utils.ArticlePage;
import kr.or.ddit.sevenfs.utils.CommonCode;
import kr.or.ddit.sevenfs.vo.AttachFileVO;
import kr.or.ddit.sevenfs.vo.CustomUser;
import kr.or.ddit.sevenfs.vo.atrz.AtrzLineVO;
import kr.or.ddit.sevenfs.vo.atrz.AtrzVO;
import kr.or.ddit.sevenfs.vo.atrz.BankAccountVO;
import kr.or.ddit.sevenfs.vo.atrz.DraftVO;
import kr.or.ddit.sevenfs.vo.atrz.HolidayVO;
import kr.or.ddit.sevenfs.vo.atrz.SalaryVO;
import kr.or.ddit.sevenfs.vo.atrz.SpendingVO;
import kr.or.ddit.sevenfs.vo.organization.DclzTypeVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/atrz")
public class AtrzController {
	/**
	 * 파일업로드 경로를 담기위한것
	 */
	@Value("${file.save.abs.path}")
	private String saveDir;
	
	@Autowired
	private AtrzService atrzService;

	/**
	 *  사원 정보를 위해 가져온것
	 */
	@Autowired
	private OrganizationService organizationService;

	/**
	 *  파일 전송을 위한 방법
	 */
	@Autowired
	private AttachFileService attachFileService;
	
	/**
	 * 전자결재 홈 화면
	 */
	@GetMapping("/home")
	public String home(Model model, @AuthenticationPrincipal CustomUser customUser) {
		// 로그인한 사람정보 가져오기(사번 이름)
		EmployeeVO empVO = customUser.getEmpVO();
		log.info("empVO : ", empVO);
		String emplNo = empVO.getEmplNo();
		log.info("emplNo : ", emplNo);

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("emplNo", emplNo);

		// home 결재대기문서목록
		List<AtrzVO> homeAtrzApprovalList = atrzService.homeAtrzApprovalList(emplNo);
		model.addAttribute("homeAtrzApprovalList", homeAtrzApprovalList);

		// 기안진행 문서 기안중에 문서에 해당 기안일시 최신순으로 10개만 출력
		List<AtrzVO> atrzSubmitList = atrzService.atrzSubmitList(emplNo);
		model.addAttribute("atrzSubmitList", atrzSubmitList);

		// 기안진행문서 최신순 5개만 보여주기
		List<AtrzVO> atrzMinSubmitList = atrzService.atrzMinSubmitList(emplNo);
		model.addAttribute("atrzMinSubmitList", atrzMinSubmitList);

		// 기안완료문서 최신순 5개만 보여주기
		List<AtrzVO> atrzMinCompltedList = atrzService.atrzMinCompltedList(emplNo);
		model.addAttribute("atrzMinCompltedList", atrzMinCompltedList);

		model.addAttribute("title", "전자결재");
		return "atrz/home";
	}

	/**
	 *  전자결재 문서함
	 * @param model
	 * @param customUser
	 * @param currentPage
	 * @param size
	 * @param keyword
	 * @param searchType
	 * @param tab
	 * @param duration
	 * @param fromDate
	 * @param toDate
	 * @return
	 */
	@GetMapping("/approval")
	public String approvalList(Model model, @AuthenticationPrincipal CustomUser customUser,
			@RequestParam(defaultValue = "1") int currentPage, 
			@RequestParam(defaultValue = "10") int size,
			@RequestParam(defaultValue = "", required = false) String keyword,
			@RequestParam(defaultValue = "title", required = false) String searchType,
			@RequestParam(defaultValue = "tab", required = true) String tab,
			@RequestParam(defaultValue = "all", required = false) String duration,
			@RequestParam(required = false) String fromDate, 
			@RequestParam(required = false) String toDate) {
		// 로그인한 사람정보 가져오기(사번 이름)
		EmployeeVO empVO = customUser.getEmpVO();
		String emplNo = empVO.getEmplNo();

		// I. 결재대기문서목록
		// I-1) 검색조건
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("size", size);
		map.put("emplNo", emplNo);
		map.put("keyword", keyword);
		map.put("searchType", searchType);
		map.put("tab", tab);
		map.put("duration", duration);
		map.put("fromDate", fromDate);
		map.put("toDate", toDate);
		// 2. 검색조건 map.put하기

		// {duration=all, fromDate=2025-04-22, size=10, searchType=title,
		// toDate=2025-04-22, emplNo=20250004, currentPage=1, keyword=계란}
		log.info("atrzApprovalList-> 검색 조건 map : " + map);

		List<AtrzVO> atrzApprovalList = atrzService.atrzApprovalList(map);
		log.info("atrzApprovalList : " + atrzApprovalList);

		// I-2) 결재대기문서목록 행의 수
		int approvalTotal = atrzService.approvalTotal(map);
		log.info("I-2->approvalTotal : " + approvalTotal);

		model.addAttribute("approvalTotal", approvalTotal);
		// I-3) 결재대기문서목록 페이징
		ArticlePage<AtrzVO> approvalArticlePage = new ArticlePage<AtrzVO>("/atrz/approval",approvalTotal, currentPage, size,
				atrzApprovalList, map);
		model.addAttribute("atrzApprovalList", atrzApprovalList);
		model.addAttribute("approvalArticlePage", approvalArticlePage);

		
		
		// 참조대기문서
		List<AtrzVO> atrzReferList = atrzService.atrzReferList(map);
		int referTotal = atrzService.referTotal(map);
		ArticlePage<AtrzVO> referArticlePage = new ArticlePage<AtrzVO>("/atrz/approval",referTotal, currentPage, size,atrzReferList, map);
		model.addAttribute("referTotal",referTotal);
		model.addAttribute("referArticlePage",referArticlePage);
		model.addAttribute("atrzReferList", atrzReferList);

		// 결재예정문서
		List<AtrzVO> atrzExpectedList = atrzService.atrzExpectedList(map);
		int expectedTotal = atrzService.expectedTotal(map);
		ArticlePage<AtrzVO> expectedArticlePage = new ArticlePage<AtrzVO>("/atrz/approval",expectedTotal, currentPage, size,atrzExpectedList, map);
		model.addAttribute("expectedTotal",expectedTotal);
		model.addAttribute("expectedArticlePage",expectedArticlePage);
		model.addAttribute("atrzExpectedList", atrzExpectedList);

		
		// 결재문서함
		List<AtrzVO> atrzAllApprovalList = atrzService.atrzAllApprovalList(map);
		int allApprovalTotal = atrzService.allApprovalTotal(map);
		ArticlePage<AtrzVO> allApprovalArticlePage = new ArticlePage<AtrzVO>("/atrz/approval",allApprovalTotal, currentPage, size,atrzAllApprovalList, map);
		model.addAttribute("allApprovalTotal", allApprovalTotal);
		model.addAttribute("allApprovalArticlePage", allApprovalArticlePage);
		model.addAttribute("atrzAllApprovalList", atrzAllApprovalList);
		
		model.addAttribute("title", "수신문서함");
		return "atrz/approval";

	}
	
	@GetMapping("/document")
	public String documentList(Model model, @AuthenticationPrincipal CustomUser customUser,
			@RequestParam(defaultValue = "1") int currentPage, 
			@RequestParam(defaultValue = "10") int size,
			@RequestParam(defaultValue = "", required = false) String keyword,
			@RequestParam(defaultValue = "title", required = false) String searchType,
			@RequestParam(defaultValue = "tab", required = true) String tab,
			@RequestParam(defaultValue = "all", required = false) String duration,
			@RequestParam(required = false) String fromDate, 
			@RequestParam(required = false) String toDate) {
		// 로그인한 사람정보 가져오기(사번 이름)
		EmployeeVO empVO = customUser.getEmpVO();
		String emplNo = empVO.getEmplNo();
		log.info("documentList-> emplNo : " + emplNo);
		log.info("documentList-> currentPage : " + currentPage);
		log.info("documentList-> size : " + size);
		log.info("documentList-> keyword : " + keyword);
		log.info("documentList-> searchType : " + searchType);
		log.info("documentList-> tab : " + tab);
		log.info("documentList-> duration : " + duration);
		
		
		
		
		
		//검색조건
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("size", size);
		map.put("emplNo", emplNo);
		map.put("keyword", keyword);
		map.put("searchType", searchType);
		map.put("tab", tab);
		map.put("duration", duration);
		map.put("fromDate", fromDate);
		map.put("toDate", toDate);
			
		// 기안문서함
		List<AtrzVO> atrzAllSubmitList = atrzService.atrzAllSubmitList(map);
		int allSubmitTotal = atrzService.allSubmitTotal(map);
		ArticlePage<AtrzVO> allSubmitArticlePage = new ArticlePage<AtrzVO>("/atrz/document",allSubmitTotal, currentPage, size,atrzAllSubmitList, map);
		model.addAttribute("allSubmitTotal", allSubmitTotal);
		model.addAttribute("allSubmitArticlePage", allSubmitArticlePage);
		log.info("documentList-> allSubmitArticlePage : " + allSubmitArticlePage.getContent());
		model.addAttribute("atrzAllSubmitList", atrzAllSubmitList);
		
		// 임시저장함(로그인한 사람의 아이디를 받아서 select한다.)
		List<AtrzVO> atrzStorageList = this.atrzService.atrzStorageList(map);
		int storageTotal = atrzService.storageTotal(map);
		ArticlePage<AtrzVO> storageArticlePage = new ArticlePage<AtrzVO>("/atrz/document",storageTotal, currentPage, size,atrzStorageList, map);
		model.addAttribute("storageTotal", storageTotal);
		model.addAttribute("storageArticlePage", storageArticlePage);
		model.addAttribute("atrzStorageList", atrzStorageList);
		

		//결재완료함()
		List<AtrzVO> atrzCompletedList = this.atrzService.atrzCompletedList(map);
		int completedTotal = atrzService.completedTotal(map);
		ArticlePage<AtrzVO> completedArticlePage = new ArticlePage<AtrzVO>("/atrz/document",completedTotal, currentPage, size,atrzCompletedList, map);
		model.addAttribute("completedTotal", completedTotal);
		model.addAttribute("completedArticlePage", completedArticlePage);
		model.addAttribute("atrzCompletedList", atrzCompletedList);

		model.addAttribute("title", "개인문서함");
		return "atrz/documentBox";
	}

	@GetMapping("/companion")
	public String companionList(Model model, @AuthenticationPrincipal CustomUser customUser,
			@RequestParam(defaultValue = "1") int currentPage, 
			@RequestParam(defaultValue = "10") int size,
			@RequestParam(defaultValue = "", required = false) String keyword,
			@RequestParam(defaultValue = "title", required = false) String searchType,
			@RequestParam(defaultValue = "tab", required = true) String tab,
			@RequestParam(defaultValue = "all", required = false) String duration,
			@RequestParam(required = false) String fromDate, 
			@RequestParam(required = false) String toDate
			) {
		// 로그인한 사람정보 가져오기(사번 이름)
		EmployeeVO empVO = customUser.getEmpVO();
		String emplNo = empVO.getEmplNo();
		log.info("documentList-> emplNo : " + emplNo);

		//검색조건
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("size", size);
		map.put("emplNo", emplNo);
		map.put("keyword", keyword);
		map.put("searchType", searchType);
		map.put("tab", tab);
		map.put("duration", duration);
		map.put("fromDate", fromDate);
		map.put("toDate", toDate);
		
		//반려문서함
		List<AtrzVO> atrzCompanionList = atrzService.atrzCompanionList(map);
		int companionTotal = atrzService.companionTotal(map);
		ArticlePage<AtrzVO> companionArticlePage = new ArticlePage<AtrzVO>("/atrz/companion",companionTotal, currentPage, size,atrzCompanionList, map);
		model.addAttribute("companionTotal", companionTotal);
		model.addAttribute("companionArticlePage", companionArticlePage);
		log.info("documentList-> companionArticlePage : " + companionArticlePage);
		model.addAttribute("atrzCompanionList", atrzCompanionList);

		model.addAttribute("title", "반려문서함");
		return "atrz/companion";

	}
	
//	//전자결재 엑셀 다운로드
//    @GetMapping("/atrzExcelDownload")
//    public void downloadExcel(
//            HttpServletResponse response,
//            Principal principal,
//            @RequestParam(defaultValue = "") String keyword,
//    		@RequestParam(defaultValue = "") String keywordSearch) throws IOException {
//        
//    	
//    	String emplNo = principal.getName();
//    	
//        Map<String, Object> map = new HashMap<>();
//        map.put("emplNo", emplNo);
//        map.put("keyword", keyword);
//        map.put("keywordSearch", keywordSearch);
//        
//        List<DclzTypeVO> empDclzList = dclztypeService.emplDclzTypeList(map);
//        
//        // Excel 파일 생성
//        XSSFWorkbook workbook = new XSSFWorkbook();
//        XSSFSheet sheet = workbook.createSheet("근태현황 목록");
//        
//        // 헤더 스타일
//        CellStyle headerStyle = workbook.createCellStyle();
//        XSSFFont headerFont = workbook.createFont();
//        headerFont.setBold(true);
//        headerStyle.setFont(headerFont);
//        headerStyle.setAlignment(HorizontalAlignment.CENTER);
//        
//        // 헤더 행 생성
//        Row headerRow = sheet.createRow(0);
//        String[] headers = {"번호", "근무일자", "근태유형", "업무시작", "업무종료", "총 근무시간"};
//        for (int i = 0; i < headers.length; i++) {
//            Cell cell = headerRow.createCell(i);
//            cell.setCellValue(headers[i]);
//            cell.setCellStyle(headerStyle);
//            sheet.setColumnWidth(i, 4000); // 칼럼 너비 설정
//        }
//        
//        // 데이터 행 생성
//        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
//        
//        int rowNum = 1;
//        for (DclzTypeVO dclz : empDclzList) {
//        	// 총 근무시간
//        	String workHour = dclz.getWorkHour();
//        	String workMinutes = dclz.getWorkMinutes();
//        	
//            Row row = sheet.createRow(rowNum++);
//            row.createCell(0).setCellValue(rowNum - 1);
//            row.createCell(1).setCellValue(dclz.getDclzNo().substring(0, 4)+"-"+dclz.getDclzNo().substring(4, 6)+"-"+dclz.getDclzNo().substring(6, 8));
//            row.createCell(2).setCellValue(dclz.getCmmnCodeNm());
//            row.createCell(3).setCellValue(dclz.getDclzBeginDt() != null ? sdf.format(dclz.getDclzBeginDt()) : "");
//            row.createCell(4).setCellValue(dclz.getDclzEndDt() != null ? sdf.format(dclz.getDclzEndDt()) : "");
//            if(workHour == null || workMinutes == null) {
//            	row.createCell(5).setCellValue("미등록");
//            }else {
//            	row.createCell(5).setCellValue(workHour+"시간 "+workMinutes+"분");
//            }
//        }
//        
//        // 파일 다운로드 설정
//        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
//        String fileName = URLEncoder.encode(keyword + "월" + "_근태현황_목록" + ".xlsx", "UTF-8");
//        response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
//        
//        // 파일 출력
//        ServletOutputStream outputStream = response.getOutputStream();
//        workbook.write(outputStream);
//        workbook.close();
//        outputStream.close();
//    }
//    //전자결재 엑셀 다운로드 수정하기
    
	// 문서양식번호 생성
	// 양식선택후 확인 클릭시 입력폼 뿌려지고, DB의 데이터를 가져오는 작업
	@ResponseBody
	@PostMapping(value = "/insertDoc", produces = "text/plain;charset=UTF-8")
	public String insertDoc(@RequestParam(name = "form", required = false) String form, ModelAndView mav, Model model,
			@AuthenticationPrincipal CustomUser customUser) {
		// insertDoc->form : 연차신청서
		log.info("insertDoc->form : " + form);
		// 공백 제거
		form = form.trim();

		// 문서양식코드를 위한것
		String df_code = ""; // 문서 양식 코드
		String docPrefix = ""; // 전자결재문서번호 접두어
		AtrzVO resultDoc = null;
		String empNo = customUser.getEmpVO().getEmplNo();   //로그인한 사람의 정보

		// 문서양식 테이블에 db저장
		int result = 0;
		// 선택한 문서 양식이 "연차신청서"일 경우
		if ("연차신청서".equals(form)) {
			// 남은 휴가일수 확인(사원번호를 가져와야함)
			// Double checkHo = atrzService.readHoCnt();
			// model.addAttribute("checkHo",checkHo);
			// 문서양식번호 띄울 정보
			// model.addAttribute("resultDoc",resultDoc);
			// 여기서 이 결과 값을 documentForm/holiday에 보내야함
			df_code = "A";
			return "연차신청서";

		} else if ("지출결의서".equals(form)) {
			df_code = "B";
			return "지출결의서";

		} else if ("기안서".equals(form)) {
			df_code = "C";
			return "기안서";
			//여기서부터 수정해라 
		} else if ("급여명세서".equals(form)) {
			df_code = "A";
		    return "급여명세서";
		} else if ("급여계좌변경신청서".equals(form)) {
			df_code = "E";
			return "급여계좌변경신청서";

		} else if ("재직증명서".equals(form)) {
			df_code = "F";
			return "재직증명서";
		} else {
			df_code = "G";
			return "퇴사신청서";
		}

	}

	// 연차신청서 양식조회
	@GetMapping("/selectForm/holidayForm")
	public String selectHolidayForm() {
		return "documentForm/holidayForm";
	}

	// 연차신청서 입력양식
	@GetMapping("/selectForm/holiday")
	public String selectHoliday(Model model, @AuthenticationPrincipal CustomUser customUser) {
		// 로그인한 사람정보 가져오기(사번 이름)
		EmployeeVO empVO = customUser.getEmpVO();
		String empNo = empVO.getEmplNo();
		// 기안자의 연차정보가져오기
		Double checkHo = atrzService.readHoCnt(empNo);
		model.addAttribute("checkHo", checkHo);
		model.addAttribute("title", "연차신청서");
		return "documentForm/holiday";
	}

	// 전자결재 상세보기
	@GetMapping("/selectForm/atrzDetail")
	public String selectAtrzDetail(@RequestParam String atrzDocNo, Model model,
			@AuthenticationPrincipal CustomUser customUser, String fileName) {
		// 로그인한 사람정보 가져오기(사번 이름)
		EmployeeVO empVO = customUser.getEmpVO();
		String empNo = empVO.getEmplNo();
		log.info("로그인 사용자 사번: " + empNo);

		if (atrzDocNo == null || atrzDocNo.isEmpty()) {
			return "redirect:/error"; // 유효하지 않은 문서번호
		}
		char docPrefix = atrzDocNo.charAt(0); // 예: H, S, D, A, B, C, R
		// 상세정보를 가져오기 위한것
		AtrzVO atrzVO = atrzService.getAtrzDetail(atrzDocNo);
		log.info("selectAtrzDetail->atrzVO: " + atrzVO);

		// 첨부파일 조회를 위한것
		List<AttachFileVO> attachFileVOList = attachFileService.getFileAttachList(atrzVO.getAtchFileNo());
		log.info("selectAtrzDetail->attachFileVOList: " + attachFileVOList);
		String drafterEmplNo = atrzVO.getDrafterEmpno();
		EmployeeVO drafterInfo = organizationService.emplDetail(drafterEmplNo);
		atrzVO.setEmplNm(drafterInfo.getEmplNm());

		// 직급 코드를 통해 직급 얻기 직급명 , 부서명셋팅
		String drafClsf = atrzVO.getDrafterClsf();
		String ClsfCodeNm = CommonCode.PositionEnum.INTERN.getLabelByCode(drafClsf);
		atrzVO.setClsfCodeNm(ClsfCodeNm);
		atrzVO.setDeptCodeNm(drafterInfo.getDeptNm());

		// 권한별 상세보기 조회 막는곳
		// 기본권한 여부 : 기안자
		Boolean isAuthorize = false;
		Boolean canView = empNo.equals(atrzVO.getDrafterEmpno());

		List<AtrzLineVO> atrzLineVOList = atrzVO.getAtrzLineVOList();
		List<EmployeeVO> sanEmplVOList = new ArrayList<>();

		log.info("atrzLineVOList : " + atrzLineVOList);

		int lastAtrzLnSn = 0;

		for (AtrzLineVO atrzLineVO : atrzLineVOList) {
			String atrzTy = atrzLineVO.getAtrzTy(); // 1: 결재자, 0: 참조자

			boolean isMatched = empNo.equals(atrzLineVO.getSanctnerEmpno()) || empNo.equals(atrzLineVO.getContdEmpno())
					|| empNo.equals(atrzLineVO.getDcrbManEmpno()) || empNo.equals(atrzLineVO.getAftSanctnerEmpno());

			if ("1".equals(atrzTy)) {
				lastAtrzLnSn++;
				if (isMatched) {
					isAuthorize = true;
					canView = true;
					log.info("결재 권한 있음 - 사용자 사번: " + empNo);
				}
			} else { // 참조자
				if (isMatched) {
					canView = true;
					log.info("참조 권한 있음 - 사용자 사번: " + empNo);
				}
			}

			log.info("ATRZ_TY: " + atrzTy);
			log.info("결재자 사번(SANCTNER_EMPNO): " + atrzLineVO.getSanctnerEmpno());
			log.info("대결자 사번(CONTD_EMPNO): " + atrzLineVO.getContdEmpno());
			log.info("전결자 사번(DCRB_MAN_EMPNO): " + atrzLineVO.getDcrbManEmpno());

			// 결재자 이름/직급 셋팅
			String sancterEmpNo = atrzLineVO.getSanctnerEmpno();
			EmployeeVO sanEmplVO = organizationService.emplDetail(sancterEmpNo);
			sanEmplVOList.add(sanEmplVO);

			String sanctClsfCd = atrzLineVO.getSanctnerClsfCode();
			String sanctClsfNm = CommonCode.PositionEnum.INTERN.getLabelByCode(sanctClsfCd);
			atrzLineVO.setSanctnerClsfNm(sanctClsfNm);
			atrzLineVO.setSanctnerEmpNm(sanEmplVO.getEmplNm());

			log.info("sanctClsfNm : " + sanctClsfNm);
			log.info("sanEmplVO : " + sanEmplVO);
			log.info("sancterEmpNo : " + sancterEmpNo);
		}

		// 🔐 열람 권한 없는 경우 리다이렉트
		if (!canView) {
			log.warn("전자결재 상세보기 접근 차단 - 사용자 사번: " + empNo);
			return "redirect:/error";
		}

		// 다음결재할사람이 없는것(결재자가 없는것)을 계산함
		int curAtrzLnSn = atrzLineVOList.stream()
				.filter(vo -> "1".equals(vo.getAtrzTy()) && "00".equals(vo.getSanctnProgrsSttusCode()))
				.mapToInt(AtrzLineVO::getAtrzLnSn).min().orElse(-1); // -1이면 더 이상 결재할 사람 없음
		// atrzLnSn :결재순번 (본인:로그인한사람)
		// curAtrzLnSn : 결재선 마지막번호
		model.addAttribute("curAtrzLnSn", curAtrzLnSn);
		model.addAttribute("lastAtrzLnSn", lastAtrzLnSn);

		// 기안별 상세정보 셋팅  !! 하나씩 추가하기
		atrzVO.setHolidayVO(atrzService.holidayDetail(atrzDocNo));
		atrzVO.setSpendingVO(atrzService.spendingDetail(atrzDocNo));
		atrzVO.setSalaryVO(atrzService.salaryDetail(atrzDocNo));

		// 권한 여부는 model로 넘겨서 화면에서 결재버튼 노출여부 조절
		model.addAttribute("isAuthorize", isAuthorize);
		model.addAttribute("sanEmplVOList", sanEmplVOList);
		model.addAttribute("atrzVO", atrzVO);
		model.addAttribute("employeeVO", drafterInfo);

		// 파일불러오기모델이 담기
		model.addAttribute("attachFileVOList", attachFileVOList);
		attachFileService.downloadFile(fileName);

		// 제목설정을 위한것
		String title = switch (docPrefix) {
		case 'H' -> "연차신청서";
		case 'S' -> "지출결의서";
		case 'D' -> "기안서";
		case 'A' -> "급여명세서";
		case 'B' -> "급여계좌변경신청서";
		case 'C' -> "재직증명서";
		case 'R' -> "퇴직신청서";
		default -> "전자결재상세보기";
		};
		model.addAttribute("title", title);

		// 뷰설정을 위한것
		String viewName = switch (docPrefix) {
		case 'H' -> "documentForm/holidayDetail"; // 연차신청서
		case 'S' -> "documentForm/spendingDetail"; // 지출결의서
		case 'D' -> "documentForm/draftDetail"; // 기안서
		case 'A' -> "documentForm/salaryDetail"; // 급여명세서
		case 'B' -> "documentForm/accountChangeDetail"; // 급여계좌변경신청서
		case 'C' -> "documentForm/employmentCertDetail"; // 재직증명서
		case 'R' -> "documentForm/resignDetail"; // 퇴직신청서
		default -> "redirect:/error"; // 알 수 없는 양식
		};

		return viewName;
	}

	// 전자결재 승인시 상세보기 get
	/**
	 *  전자결재 승인시
	 * @param atrzVO
	 * @param model
	 * @param customUser
	 * @return
	 */
	@ResponseBody
	@PostMapping("selectForm/atrzDetailAppUpdate")
	public String atrzDetailAppUpdate(AtrzVO atrzVO, Model model, @AuthenticationPrincipal CustomUser customUser) {
		// 로그인한 사람정보 가져오기(사번 이름)
		EmployeeVO empVO = customUser.getEmpVO();
		String emplNo = empVO.getEmplNo();

		atrzVO.setEmplNo(emplNo);

		int atrzAppUpdateResult = atrzService.atrzDetailAppUpdate(atrzVO);

		return "success";
	}

	/**
	 *  전자결재 반려시
	 * @param atrzVO
	 * @param model
	 * @param customUser
	 * @return
	 */
	@ResponseBody
	@PostMapping("selectForm/atrzDetilCompUpdate")
	public String atrzDetilCompUpdate(AtrzVO atrzVO, Model model, @AuthenticationPrincipal CustomUser customUser) {

		// 로그인한 사람정보 가져오기(사번 이름)
		EmployeeVO empVO = customUser.getEmpVO();
		String emplNo = empVO.getEmplNo();

		atrzVO.setEmplNo(emplNo);
		int atrzCompUpdateResult = atrzService.atrzDetilCompUpdate(atrzVO);

		log.info("atrzDetilCompUpdate-> atrzVO : " + atrzVO);
		return "success";
	}

	/**
	 *  전자결재 기안취소
	 * @param atrzVO
	 * @param model
	 * @param customUser
	 * @return
	 */
	@ResponseBody
	@PostMapping("selectForm/atrzCancelUpdate")
	public String atrzCancelUpdate(AtrzVO atrzVO, Model model, @AuthenticationPrincipal CustomUser customUser) {

		// 로그인한 사람정보 가져오기(사번 이름)
		EmployeeVO empVO = customUser.getEmpVO();
		String emplNo = empVO.getEmplNo();
		atrzVO.setEmplNo(emplNo);

		int atrzCancelResult = atrzService.atrzCancelUpdate(atrzVO);
		log.info("atrzCancleUpdate-> atrzCancelResult : " + atrzCancelResult);

		return atrzCancelResult > 0 ? "success" : "fail";
	}

	/**
	 *  반려문서 재기안
	 * @param atrzDocNo
	 * @param model
	 * @param customUser
	 * @return
	 */
	@GetMapping("/selectForm/selectDocumentReturn")
	public String selectDocumentReturn(@RequestParam String atrzDocNo, Model model,
			@AuthenticationPrincipal CustomUser customUser) {
		// 로그인한 사람정보 가져오기(사번 이름)
		EmployeeVO empVO = customUser.getEmpVO();
		String empNo = empVO.getEmplNo();

		AtrzVO atrzVO = atrzService.selectDocumentReturn(atrzDocNo);
		log.info("selectDocumentReturn->atrzVO : " + atrzVO);

		Double checkHo = atrzService.readHoCnt(empNo);
		model.addAttribute("checkHo", checkHo);
		model.addAttribute("atrzVO", atrzVO);
		model.addAttribute("empVO", empVO);

		char docPrefix = atrzDocNo.charAt(0); // 예: H, S, D, A, B, C, R

		// 제목설정을 위한것
		String title = switch (docPrefix) {
		case 'H' -> "연차신청서";
		case 'S' -> "지출결의서";
		case 'D' -> "기안서";
		case 'A' -> "급여명세서";
		case 'B' -> "급여계좌변경신청서";
		case 'C' -> "재직증명서";
		case 'R' -> "퇴직신청서";
		default -> "전자결재상세보기";
		};
		model.addAttribute("title", title);

		String viewName = switch (docPrefix) {
		case 'H' -> "documentForm/holidayReturn"; // 연차신청서
		case 'S' -> "documentForm/spendingReturn"; // 지출결의서
		case 'D' -> "documentForm/draftReturn"; // 기안서
		case 'A' -> "documentForm/salaryReturn"; // 급여명세서
		case 'B' -> "documentForm/bankAccountReturn"; // 급여계좌변경신청서
		case 'C' -> "documentForm/employmentCertReturn"; // 재직증명서
		case 'R' -> "documentForm/resignReturn"; // 퇴직신청서
		default -> "redirect:/error"; // 알 수 없는 양식
		};

		return viewName;
	}

	// 임시저장함 삭제하기
	@PostMapping("/storageListDelete")
	@ResponseBody
	public ResponseEntity<?> storageListDelete(@RequestBody Map<String, List<String>> params) {
		List<String> atrzDocNos = params.get("atrzDocNos");
		atrzService.storageListDelete(atrzDocNos);
		return ResponseEntity.ok().build();
	}


	/** 
	 * 기안자 정보 등록 전자결재 등록
	 * @param emplNo
	 * @param requestData
	 * @param model
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/insertAtrzEmp", produces = "application/json;charset=UTF-8")
	public EmployeeVO insertAtrzEmp(@RequestParam(name = "emplNo", required = false) String emplNo,
			@RequestParam Map<String, List<String>> requestData, Model model) {
		// insertDoc->form : 연차신청서
		// appLineEmp->emplNo : 20250000
		// appLineEmp->emplNo :
		log.info("appLineEmp->emplNo : " + emplNo);

		// 여기서 사원번호를 꺼내서 사원 디테일까지가져옴
		EmployeeVO emplDetail = organizationService.emplDetail(emplNo);

		return emplDetail;
	}

	/** 
	 * 결재자 정보 등록 결재선 등록
	 * @param atrzVO
	 * @param emplNoArr
	 * @param req
	 * @param model
	 * @param authList
	 * @param customUser
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "insertAtrzLine")
	public AtrzVO insertAtrzLine(AtrzVO atrzVO, String[] emplNoArr, HttpServletRequest req, Model model,
			String[] authList, @AuthenticationPrincipal CustomUser customUser) {

		List<String> appLinelist = new ArrayList<String>();

		log.debug("insertAtrzLine->emplNoArr : {}", Arrays.toString(emplNoArr)); // 결재자(o)
		log.debug("insertAtrzLine->atrzVO : {}", atrzVO); // 결재문서
		log.debug("insertAtrzLine->authList : {}", Arrays.toString(authList)); // 참조자

		for (String emplNo : emplNoArr) {
			// selectAppLineList->emplNo : 20250008
			// selectAppLineList->emplNo : 20250016
			log.info("selectAppLineList->emplNo : " + emplNo);

			appLinelist.add(emplNo);
		}

		// 1) insert(결재선 insert) - 문서번호가 있어야 함
		/*
		 * {emplNo},{clsfCode},{emplNm},{deptCode}
		 */
		// 로그인 시 입력한 아이디(username : 로그인 아이디)
		// 로그인한 사람정보 가져오기(사번 이름)
		EmployeeVO empVO = customUser.getEmpVO();
		String emplNo = empVO.getEmplNo();
		String emplNm = empVO.getEmplNm();
		String clsfCode = empVO.getClsfCode();
		String deptCode = empVO.getDeptCode();

		atrzVO.setEmplNo(emplNo);
		atrzVO.setClsfCode(clsfCode);
		atrzVO.setEmplNm(emplNm);
		atrzVO.setDeptCode(deptCode);

		int atrzResult = atrzService.insertAtrz(atrzVO);
		// 인서트를 하고난뒤에는 문서번호가 생성되있음
		// 그 문서번호를 가지고 전자결재선 문서번호를 인서트 해줘야함

		log.info("insertAtrzLine->atrzVO(문서번호 생성 후) : " + atrzVO);

		// AtrzLineVO atrzLineVO = new AtrzLineVO();
		// String atrzDocNo = atrzVO.getAtrzDocNo();
		// atrzLineVO.setAtrzDocNo(atrzDocNo);
		// log.info("insertAppLineList-> atrzLineVO : "+atrzLineVO);

		// 3) /atrz/selectForm/holiday의 출력용
		// 해당 직원의 상세정보 목록을 select
		List<EmployeeVO> emplDetailList = organizationService.emplDetailList(appLinelist);
		log.info("selectAppLineList->emplDetailList : " + emplDetailList);

		atrzVO.setEmplDetailList(emplDetailList);

		// 여기서 담아서 보내야함
		return atrzVO;

	}

	/** 
	 * 결재선 지정후 취소를 하게 되면 결재선과 전자결재 테이블 삭제처리 해야한다.
	 * @param payload
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "deleteAtrzWriting")
	public ResponseEntity<String> deleteAtrzWriting(@RequestBody Map<String, String> payload) {
		String atrzDocNo = payload.get("atrzDocNo");
		try {
			atrzService.deleteAtrzWriting(atrzDocNo);
			return ResponseEntity.ok("success");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("fail");
		}
	}

	/**
	 *  임시저장 불러오기
	 * @param atrzDocNo
	 * @param model
	 * @param customUser
	 * @param fileName
	 * @return
	 */
	@GetMapping("selectForm/getAtrzStorage")
	public String getAtrzStorage(@RequestParam String atrzDocNo, Model model,
			@AuthenticationPrincipal CustomUser customUser, String fileName) {
		// 로그인한 사람정보 가져오기(사번 이름)
		EmployeeVO empVO = customUser.getEmpVO();
		String empNo = empVO.getEmplNo();
		log.info("로그인 사용자 사번: " + empNo);

		AtrzVO atrzVO = atrzService.getAtrzStorage(atrzDocNo);

		// 첨부파일 조회를 위한것
		List<AttachFileVO> attachFileVOList = attachFileService.getFileAttachList(atrzVO.getAtchFileNo());
		log.info("getAtrzStorage->atrzVO: " + atrzVO);
		log.info("getAtrzStorage->attachFileVOList: " + attachFileVOList);

		// 파일불러오기모델이 담기
		attachFileService.downloadFile(fileName);

		Double checkHo = atrzService.readHoCnt(empNo);
		model.addAttribute("attachFileVOList", attachFileVOList);
		model.addAttribute("checkHo", checkHo);
		model.addAttribute("atrzVO", atrzVO);
		model.addAttribute("empVO", empVO);

		char docPrefix = atrzDocNo.charAt(0); // 예: H, S, D, A, B, C, R

		String viewName = switch (docPrefix) {
		case 'H' -> "documentForm/holidayStorage"; // 연차신청서
		case 'S' -> "documentForm/spendingStorage"; // 지출결의서
		case 'D' -> "documentForm/draftStorage"; // 기안서
		case 'A' -> "documentForm/salaryStorage"; // 급여명세서
		case 'B' -> "documentForm/bankAccountStorage"; // 급여계좌변경신청서
		case 'C' -> "documentForm/employmentCertStorage"; // 재직증명서
		case 'R' -> "documentForm/resignStorage"; // 퇴직신청서
		default -> "redirect:/error"; // 알 수 없는 양식
		};

		return viewName;
	}
	// 결재선 업데이트

	/**
	 *  임시저장 연차신청서
	 * @param atrzVO
	 * @param atrzLineList
	 * @param documHolidayVO
	 * @return
	 */
	@ResponseBody
	@PostMapping("atrzHolidayUpdate")
	public String updateHolidayForm(AtrzVO atrzVO, @RequestPart("atrzLineList") List<AtrzLineVO> atrzLineList,
			@RequestPart("docHoliday") HolidayVO documHolidayVO) {

		// 서비스 호출로 로직 위임
		try {
			atrzService.updateHoliday(atrzVO, atrzLineList, documHolidayVO);
			return "성공적으로 등록되었습니다.";
		} catch (Exception e) {
			log.error("연차 기안 중 오류 발생", e);
			return "등록 중 오류가 발생했습니다.";
		}

	}

	// 연차신청서 등록(문서번호가 이미 있는 상태임)
	@ResponseBody
	@PostMapping(value = "atrzHolidayInsert")
	public String insertHolidayForm(AtrzVO atrzVO, @RequestPart("atrzLineList") List<AtrzLineVO> atrzLineList,
			@RequestPart("docHoliday") HolidayVO documHolidayVO, int[] removeFileId,
			@RequestParam(value = "uploadFile", required = false) MultipartFile[] uploadFile) {

		log.info("insertHolidayForm->atrzVO(최초) : " + atrzVO);
		log.info("insertHolidayForm->atrzLineList(최초) : " + atrzLineList);
		log.info("insertHolidayForm->documHolidayVO(최초) : " + documHolidayVO);

		AtrzVO atrzImsiVO = atrzService.getAtrzDetail(atrzVO.getAtrzDocNo());
		log.info("insertHolidayForm->atrzImsiVO :" + documHolidayVO);

		// 파일 업로드 처리 (있는 경우만)
		if (uploadFile != null && uploadFile.length > 0 && uploadFile[0].getOriginalFilename().length() > 0) {
			// 파일 이름이 같고 사이즈도 같으면 같은 파일로 간주 (중복 저장 방지)
			boolean isSameFile = false;

			if (atrzImsiVO.getAtchFileNo() != 0L) {
				List<AttachFileVO> existingFiles = attachFileService.getFileAttachList(atrzImsiVO.getAtchFileNo());

				if (!existingFiles.isEmpty()) {
					String existingFileName = existingFiles.get(0).getFileNm();
					long existingFileSize = existingFiles.get(0).getFileSize();

					String newFileName = uploadFile[0].getOriginalFilename();
					long newFileSize = uploadFile[0].getSize();

					isSameFile = existingFileName.equals(newFileName) && existingFileSize == newFileSize;
				}
			}

			if (!isSameFile) {
				// 새로운 파일이라면 insert/update 수행
				if (atrzImsiVO.getAtchFileNo() == 0L) {
					long attachFileNo = attachFileService.insertFileList("atrzUploadFile", uploadFile);
					atrzVO.setAtchFileNo(attachFileNo);
					log.info("신규 업로드된 파일 번호: " + attachFileNo);
				} else {
					AttachFileVO attachFileVO = new AttachFileVO();
					attachFileVO.setAtchFileNo(atrzImsiVO.getAtchFileNo());

					// 실제 삭제할 파일이 있는 경우에만 설정
					if (removeFileId != null && removeFileId.length > 0) {
						attachFileVO.setRemoveFileId(removeFileId);
						log.info("attachFileVO -> :"+attachFileVO);
					}

					attachFileService.updateFileList("atrzUploadFile", uploadFile, attachFileVO);
					atrzVO.setAtchFileNo(atrzImsiVO.getAtchFileNo());
					log.info("기존 파일 번호 " + atrzImsiVO.getAtchFileNo() + "에 파일 업데이트 완료");
				}
			} else {
				// 동일한 파일이므로 처리 생략
				atrzVO.setAtchFileNo(atrzImsiVO.getAtchFileNo());
				log.info("동일 파일 재업로드 방지 → 기존 파일 유지");
			}

		} else {
			// 업로드 파일 없음 → 기존 파일 유지
			atrzVO.setAtchFileNo(atrzImsiVO.getAtchFileNo());
		}
		// 파일 확인 로그
		log.info("업로드된 파일 배열: " + Arrays.toString(uploadFile));

		// 여기서 담기지 않았음.. 사원정보가 오지 않음

		EmployeeVO emplDetail = organizationService.emplDetail(atrzVO.getEmplNo());
		// 여기서 VO를 하나 씩 담아야 하는건가...싶다.
		String clsfCode = emplDetail.getClsfCode();
		String deptCode = emplDetail.getDeptCode();
		atrzVO.setClsfCode(clsfCode);
		atrzVO.setDeptCode(deptCode);
//		atrzVO.setDrafterClsf(emplDetail.get);

		log.info("insertAppLineList-> atrzVO(사원추가후) : " + atrzVO);

		// 문서번호등록
		documHolidayVO.setAtrzDocNo(atrzVO.getAtrzDocNo());
		log.info("documHolidayVO :  문서번호 등록후 : " + documHolidayVO);

		// 시간배열 다시 하나로 합치기
		String[] holiStartArr = documHolidayVO.getHoliStartArr(); // ["2025-04-11", "09:00:00"]
		String[] holiEndArr = documHolidayVO.getHoliEndArr(); // ["2025-04-11", "18:00:00"]

		// 하나의 문자열로 합치기
		String holiStartStr = holiStartArr[0] + " " + holiStartArr[1] + ":00"; // "2025-04-11 09:00:00"
		String holiEndStr = holiEndArr[0] + " " + holiEndArr[1] + ":00"; // "2025-04-11 18:00:00"

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		Date holiStartDate;
		try {
			holiStartDate = sdf.parse(holiStartStr);
			// VO에 다시 세팅
			documHolidayVO.setHoliStart(holiStartDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		Date holiEndDate;
		try {
			holiEndDate = sdf.parse(holiEndStr);
			// VO에 다시 세팅
			documHolidayVO.setHoliEnd(holiEndDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		log.info("insertHolidayForm->documHolidayVO :  문서번호 등록후 : " + documHolidayVO);

		// 1) atrz 테이블 update

		// 2) 결재선지정 후에 제목, 내용, 등록일자, 상태 update
		int result = atrzService.insertUpdateAtrz(atrzVO);
		log.info("insertHolidayForm->result : " + result);

		// 3) 연차신청서 등록
		int documHolidayResult = atrzService.insertHoliday(documHolidayVO);
		log.info("insertHolidayForm->documHolidayResult : " + documHolidayResult);

		return "쭈니성공";
	}

	// 연차신청서 임시저장
	@ResponseBody
	@PostMapping(value = "atrzHolidayStorage")
	public String atrzHolidayStorage(AtrzVO atrzVO, @RequestPart("atrzLineList") List<AtrzLineVO> atrzLineList,
			@RequestPart("docHoliday") HolidayVO documHolidayVO, int[] removeFileId,
			@RequestParam(value = "uploadFile", required = false) MultipartFile[] uploadFile) {

		log.info("atrzDocStorage->atrzVO : " + atrzVO);
		// 여기서 결재문서번호를 활용해서 atrzVO에 다시 셋팅해준다.
		AtrzVO atrzStorageVO = atrzService.getAtrzStorage(atrzVO.getAtrzDocNo());
		log.info("atrzDocStorage->atrzStorageVO : " + atrzStorageVO);

		// 2) atrzVO의 atrzLineVOList를 atrzLineList에 할당
		log.info("atrzDocStorage->atrzLineList : " + atrzLineList);
		log.info("atrzDocStorage->documHolidayVO : " + documHolidayVO);

		// 파일 업로드 처리 (있는 경우만)
		if (uploadFile != null && uploadFile.length > 0 && uploadFile[0].getOriginalFilename().length() > 0) {
			// 파일 이름이 같고 사이즈도 같으면 같은 파일로 간주 (중복 저장 방지)
			boolean isSameFile = false;

			if (atrzStorageVO.getAtchFileNo() != 0L) {
				List<AttachFileVO> existingFiles = attachFileService.getFileAttachList(atrzStorageVO.getAtchFileNo());

				if (!existingFiles.isEmpty()) {
					String existingFileName = existingFiles.get(0).getFileNm();
					long existingFileSize = existingFiles.get(0).getFileSize();

					String newFileName = uploadFile[0].getOriginalFilename();
					long newFileSize = uploadFile[0].getSize();

					isSameFile = existingFileName.equals(newFileName) && existingFileSize == newFileSize;
				}
			}

			if (!isSameFile) {
				// 새로운 파일이라면 insert/update 수행
				if (atrzStorageVO.getAtchFileNo() == 0L) {
					long attachFileNo = attachFileService.insertFileList("atrzUploadFile", uploadFile);
					atrzVO.setAtchFileNo(attachFileNo);
					log.info("신규 업로드된 파일 번호: " + attachFileNo);
				} else {
					AttachFileVO attachFileVO = new AttachFileVO();
					attachFileVO.setAtchFileNo(atrzStorageVO.getAtchFileNo());

					// 실제 삭제할 파일이 있는 경우에만 설정
					if (removeFileId != null && removeFileId.length > 0) {
						attachFileVO.setRemoveFileId(removeFileId);
					}

					attachFileService.updateFileList("atrzUploadFile", uploadFile, attachFileVO);
					atrzVO.setAtchFileNo(atrzStorageVO.getAtchFileNo());
					log.info("기존 파일 번호 " + atrzStorageVO.getAtchFileNo() + "에 파일 업데이트 완료");
				}
			} else {
				// 동일한 파일이므로 처리 생략
				atrzVO.setAtchFileNo(atrzStorageVO.getAtchFileNo());
				log.info("동일 파일 재업로드 방지 → 기존 파일 유지");
			}

		} else {
			// 업로드 파일 없음 → 기존 파일 유지
			atrzVO.setAtchFileNo(atrzStorageVO.getAtchFileNo());
		}
		// 파일 확인 로그
		log.info("업로드된 파일 배열: " + Arrays.toString(uploadFile));

		EmployeeVO emplDetail = organizationService.emplDetail(atrzVO.getEmplNo());
		// 여기서 VO를 하나 씩 담아야 하는건가...싶다.
		atrzVO.setClsfCode(emplDetail.getClsfCode());
		atrzVO.setDeptCode(emplDetail.getDeptCode());

		int result = atrzService.atrzHolidayStorage(atrzVO, atrzLineList, documHolidayVO);

		return result > 0 ? "임시저장성공" : "실패";
	}

	// 지출결의서 임시저장
	@ResponseBody
	@PostMapping(value = "atrzSpendingStorage")
	public String atrzSpendingStorage(AtrzVO atrzVO, @RequestPart("atrzLineList") List<AtrzLineVO> atrzLineList,
			@RequestPart("docSpending") SpendingVO spendingVO, int[] removeFileId,
			@RequestParam(value = "uploadFile", required = false) MultipartFile[] uploadFile) {

		log.info("atrzSpendingStorage->atrzVO : " + atrzVO);
		// 1)
		// 여기서 결재문서번호를 활용해서 atrzVO에 다시 셋팅해준다.
		AtrzVO atrzStorageVO = atrzService.getAtrzStorage(atrzVO.getAtrzDocNo());
		log.info("atrzSpendingStorage->atrzStorageVO : " + atrzStorageVO);

		// 2) atrzVO의 atrzLineVOList를 atrzLineList에 할당
		// *** atrzDocStorage->atrzLineList : []
		log.info("atrzSpendingStorage->atrzLineList : " + atrzLineList);
		/*
		 * HolidayVO(holiActplnNo=0, atrzDocNo=null, holiCode=23,
		 * holiStartArr=[2025-05-07, 09:00:00], holiStart=null, holiEndArr=[2025-05-07,
		 * 18:00:00], holiEnd=null, holiUseDays=0, holiDelete=null, atrzLineVOList=null,
		 * atrzVO=null)
		 */
		log.info("atrzSpendingStorage->spendingVO : " + spendingVO);

		// 파일 업로드 처리 (있는 경우만)
		if (uploadFile != null && uploadFile.length > 0 && uploadFile[0].getOriginalFilename().length() > 0) {
			// 파일 이름이 같고 사이즈도 같으면 같은 파일로 간주 (중복 저장 방지)
			boolean isSameFile = false;

			if (atrzStorageVO.getAtchFileNo() != 0L) {
				List<AttachFileVO> existingFiles = attachFileService.getFileAttachList(atrzStorageVO.getAtchFileNo());

				if (!existingFiles.isEmpty()) {
					String existingFileName = existingFiles.get(0).getFileNm();
					long existingFileSize = existingFiles.get(0).getFileSize();

					String newFileName = uploadFile[0].getOriginalFilename();
					long newFileSize = uploadFile[0].getSize();

					isSameFile = existingFileName.equals(newFileName) && existingFileSize == newFileSize;
				}
			}

			if (!isSameFile) {
				// 새로운 파일이라면 insert/update 수행
				if (atrzStorageVO.getAtchFileNo() == 0L) {
					long attachFileNo = attachFileService.insertFileList("atrzUploadFile", uploadFile);
					atrzVO.setAtchFileNo(attachFileNo);
					log.info("신규 업로드된 파일 번호: " + attachFileNo);
				} else {
					AttachFileVO attachFileVO = new AttachFileVO();
					attachFileVO.setAtchFileNo(atrzStorageVO.getAtchFileNo());

					// 실제 삭제할 파일이 있는 경우에만 설정
					if (removeFileId != null && removeFileId.length > 0) {
						attachFileVO.setRemoveFileId(removeFileId);
					}

					attachFileService.updateFileList("atrzUploadFile", uploadFile, attachFileVO);
					atrzVO.setAtchFileNo(atrzStorageVO.getAtchFileNo());
					log.info("기존 파일 번호 " + atrzStorageVO.getAtchFileNo() + "에 파일 업데이트 완료");
				}
			} else {
				// 동일한 파일이므로 처리 생략
				atrzVO.setAtchFileNo(atrzStorageVO.getAtchFileNo());
				log.info("동일 파일 재업로드 방지 → 기존 파일 유지");
			}

		} else {
			// 업로드 파일 없음 → 기존 파일 유지
			atrzVO.setAtchFileNo(atrzStorageVO.getAtchFileNo());
		}
		// 파일 확인 로그
		log.info("업로드된 파일 배열: " + Arrays.toString(uploadFile));

		EmployeeVO emplDetail = organizationService.emplDetail(atrzVO.getEmplNo());
		// 여기서 VO를 하나 씩 담아야 하는건가...싶다.
		atrzVO.setClsfCode(emplDetail.getClsfCode());
		atrzVO.setDeptCode(emplDetail.getDeptCode());

		int result = atrzService.atrzSpendingStorage(atrzVO, atrzLineList, spendingVO);

		return result > 0 ? "임시저장성공" : "실패";
	}

	//

	// 임시저장후 결재선 인서트(업데이트처럼 활용)
	@ResponseBody
	@PostMapping(value = "updateAtrzLine")
	public AtrzVO updateAtrzLine(@ModelAttribute AtrzVO atrzVO, @RequestParam(required = false) String[] emplNoArr,
			Model model, @RequestParam(required = false) String[] authList,
			@AuthenticationPrincipal CustomUser customUser) {
		List<String> appLinelist = new ArrayList<String>();
		log.debug("updateAtrzLine->emplNoArr : " + Arrays.toString(emplNoArr)); // 결재자(o)
		log.debug("updateAtrzLine->atrzVO : " + atrzVO); // 결재문서
		log.debug("updateAtrzLine->authList : " + Arrays.toString(authList)); // 참조자

		for (String emplNo : emplNoArr) {
			// selectAppLineList->emplNo : 20250008
			// selectAppLineList->emplNo : 20250016
			log.info("updateAtrzLine->emplNo : " + emplNo);

			appLinelist.add(emplNo);
		}
		String atrzDocNo = "";

		for (String authListStr : authList) {
			try {
				ObjectMapper objectMapper = new ObjectMapper();
				List<Map<String, Object>> authMapList = objectMapper.readValue(authListStr,
						new TypeReference<List<Map<String, Object>>>() {
						});

				// 첫 번째 항목에서 문서번호 추출
				if (!authMapList.isEmpty() && atrzDocNo.isEmpty()) {
					Object docNoObj = authMapList.get(0).get("atrzDocNo");
					if (docNoObj != null) {
						atrzDocNo = docNoObj.toString();
						System.out.println("추출된 atrzDocNo: " + atrzDocNo);
					}
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		log.info("updateAtrzLine->atrzDocNo : " + atrzDocNo);

		// 로그인한 사람정보 가져오기(사번 이름)
		EmployeeVO empVO = customUser.getEmpVO();
		String empNo = empVO.getEmplNo();
		// 임시저장 문서번호 set하기
		atrzVO.setAtrzDocNo(atrzDocNo);
		log.info("updateAtrzLine->atrzVO(문서번호 생성 후) : " + atrzVO);

		atrzVO.setEmplNo(empNo);
		// 문서조회
//		String atrzDocNo = atrzVO.getAtrzDocNo();
		log.info("updateAtrzLine->atrzVO" + atrzVO);
		List<AtrzLineVO> atrzLineList = atrzVO.getAtrzLineVOList();
		// 임시저장후 결재선 다시 지정시 결재선 삭제 처리
		atrzService.deleteAtrzLineByDocNo(atrzDocNo);
		for (AtrzLineVO atrzLineVO : atrzLineList) {
			atrzLineVO.setAtrzDocNo(atrzDocNo);
			atrzService.updateAtrzLine(atrzLineVO);
			log.info("📝 결재선 - empno: {}, code: {}, ty: {}, authorYn: {}, lnSn: {}", atrzLineVO.getSanctnerEmpno(),
					atrzLineVO.getSanctnerClsfCode(), atrzLineVO.getAtrzTy(), atrzLineVO.getDcrbAuthorYn(),
					atrzLineVO.getAtrzLnSn());

		}
		log.info("updateAtrzLine->atrzVO : " + atrzVO);
		return atrzService.getAtrzStorage(atrzDocNo);
	}

	// 지출결의서 등록
	@ResponseBody
	@PostMapping(value = "atrzSpendingInsert")
	public String insertSpendingForm(AtrzVO atrzVO
			,@RequestPart("atrzLineList") List<AtrzLineVO> atrzLineList
			,@RequestPart("docSpending") SpendingVO spendingVO, int[] removeFileId
			,@RequestParam(value = "uploadFile", required = false) MultipartFile[] uploadFile) {

		log.info("insertSpendingForm->atrzVO(최초) : " + atrzVO);
		log.info("insertSpendingForm->atrzLineList(최초) : " + atrzLineList);
		log.info("insertSpendingForm->spendingVO(최초) : " + spendingVO);

		AtrzVO atrzImsiVO = atrzService.getAtrzDetail(atrzVO.getAtrzDocNo());
		log.info("insertSpendingForm->atrzImsiVO :" + spendingVO);

		// 파일 업로드 처리 (있는 경우만)
		if (uploadFile != null && uploadFile.length > 0 && uploadFile[0].getOriginalFilename().length() > 0) {
			// 파일 이름이 같고 사이즈도 같으면 같은 파일로 간주 (중복 저장 방지)
			boolean isSameFile = false;

			if (atrzImsiVO.getAtchFileNo() != 0L) {
				List<AttachFileVO> existingFiles = attachFileService.getFileAttachList(atrzImsiVO.getAtchFileNo());

				if (!existingFiles.isEmpty()) {
					String existingFileName = existingFiles.get(0).getFileNm();
					long existingFileSize = existingFiles.get(0).getFileSize();

					String newFileName = uploadFile[0].getOriginalFilename();
					long newFileSize = uploadFile[0].getSize();

					isSameFile = existingFileName.equals(newFileName) && existingFileSize == newFileSize;
				}
			}

			if (!isSameFile) {
				// 새로운 파일이라면 insert/update 수행
				if (atrzImsiVO.getAtchFileNo() == 0L) {
					long attachFileNo = attachFileService.insertFileList("atrzUploadFile", uploadFile);
					atrzVO.setAtchFileNo(attachFileNo);
					log.info("신규 업로드된 파일 번호: " + attachFileNo);
				} else {
					AttachFileVO attachFileVO = new AttachFileVO();
					attachFileVO.setAtchFileNo(atrzImsiVO.getAtchFileNo());

					// 실제 삭제할 파일이 있는 경우에만 설정
					if (removeFileId != null && removeFileId.length > 0) {
						attachFileVO.setRemoveFileId(removeFileId);
					}

					attachFileService.updateFileList("atrzUploadFile", uploadFile, attachFileVO);
					atrzVO.setAtchFileNo(atrzImsiVO.getAtchFileNo());
					log.info("기존 파일 번호 " + atrzImsiVO.getAtchFileNo() + "에 파일 업데이트 완료");
				}
			} else {
				// 동일한 파일이므로 처리 생략
				atrzVO.setAtchFileNo(atrzImsiVO.getAtchFileNo());
				log.info("동일 파일 재업로드 방지 → 기존 파일 유지");
			}

		} else {
			// 업로드 파일 없음 → 기존 파일 유지
			atrzVO.setAtchFileNo(atrzImsiVO.getAtchFileNo());
		}
		// 파일 확인 로그
		log.info("업로드된 파일 배열: " + Arrays.toString(uploadFile));

		// 여기서 담기지 않았음.. 사원정보가 오지 않음

		EmployeeVO emplDetail = organizationService.emplDetail(atrzVO.getEmplNo());
		// 여기서 VO를 하나 씩 담아야 하는건가...싶다.
		String clsfCode = emplDetail.getClsfCode();
		String deptCode = emplDetail.getDeptCode();
		atrzVO.setClsfCode(clsfCode);
		atrzVO.setDeptCode(deptCode);
//		atrzVO.setDrafterClsf(emplDetail.get);

		log.info("insertAppLineList-> atrzVO(사원추가후) : " + atrzVO);

		// 문서번호등록
		spendingVO.setAtrzDocNo(atrzVO.getAtrzDocNo());
		log.info("spendingVO :  문서번호 등록후 : " + spendingVO);

		log.info("insertSpendingForm->documHolidayVO :  문서번호 등록후 : " + spendingVO);

		// 1) atrz 테이블 update

		// 2) 결재선지정 후에 제목, 내용, 등록일자, 상태 update
		int result = atrzService.insertUpdateAtrz(atrzVO);
		log.info("insertSpendingForm->result : " + result);

		// 3) 지출결의서 등록
		int documHolidayResult = atrzService.insertSpending(spendingVO);
		log.info("insertSpendingForm->documHolidayResult : " + documHolidayResult);

		return "쭈니성공";
	}
	
	// 급여명세서 등록
	@ResponseBody
	@PostMapping(value = "atrzSalaryInsert")
	public String insertSalaryForm(AtrzVO atrzVO
			,@RequestPart("atrzLineList") List<AtrzLineVO> atrzLineList
			,@RequestPart("docSalary") SalaryVO salaryVO) {

		log.info("insertSalaryForm->atrzVO(최초) : " + atrzVO);
		log.info("insertSalaryForm->atrzLineList(최초) : " + atrzLineList);
		log.info("insertSalaryForm->salaryVO(최초) : " + salaryVO);

		atrzService.insertSalaryForm(atrzVO, atrzLineList, salaryVO);
		return "쭈니성공";
	}
	
	
	// 기안서 등록
	@ResponseBody
	@PostMapping(value = "atrzDraftInsert")
	public String insertDraftForm(AtrzVO atrzVO
			,@RequestPart("atrzLineList") List<AtrzLineVO> atrzLineList
			,int[] removeFileId
			,DraftVO draftVO
			,@RequestParam(value = "uploadFile", required = false) MultipartFile[] uploadFile) {

		log.info("insertDraftForm->atrzVO(최초) : " + atrzVO);
		log.info("insertDraftForm->atrzLineList(최초) : " + atrzLineList);
		log.info("insertDraftForm->spendingVO(최초) : " + draftVO);

		AtrzVO atrzImsiVO = atrzService.getAtrzDetail(atrzVO.getAtrzDocNo());
		log.info("insertDraftForm->draftVO :" + draftVO);

		// 파일 업로드 처리 (있는 경우만)
		if (uploadFile != null && uploadFile.length > 0 && uploadFile[0].getOriginalFilename().length() > 0) {
			// 파일 이름이 같고 사이즈도 같으면 같은 파일로 간주 (중복 저장 방지)
			boolean isSameFile = false;

			if (atrzImsiVO.getAtchFileNo() != 0L) {
				List<AttachFileVO> existingFiles = attachFileService.getFileAttachList(atrzImsiVO.getAtchFileNo());

				if (!existingFiles.isEmpty()) {
					String existingFileName = existingFiles.get(0).getFileNm();
					long existingFileSize = existingFiles.get(0).getFileSize();

					String newFileName = uploadFile[0].getOriginalFilename();
					long newFileSize = uploadFile[0].getSize();

					isSameFile = existingFileName.equals(newFileName) && existingFileSize == newFileSize;
				}
			}

			if (!isSameFile) {
				// 새로운 파일이라면 insert/update 수행
				if (atrzImsiVO.getAtchFileNo() == 0L) {
					long attachFileNo = attachFileService.insertFileList("atrzUploadFile", uploadFile);
					atrzVO.setAtchFileNo(attachFileNo);
					log.info("신규 업로드된 파일 번호: " + attachFileNo);
				} else {
					AttachFileVO attachFileVO = new AttachFileVO();
					attachFileVO.setAtchFileNo(atrzImsiVO.getAtchFileNo());

					// 실제 삭제할 파일이 있는 경우에만 설정
					if (removeFileId != null && removeFileId.length > 0) {
						attachFileVO.setRemoveFileId(removeFileId);
					}

					attachFileService.updateFileList("atrzUploadFile", uploadFile, attachFileVO);
					atrzVO.setAtchFileNo(atrzImsiVO.getAtchFileNo());
					log.info("기존 파일 번호 " + atrzImsiVO.getAtchFileNo() + "에 파일 업데이트 완료");
				}
			} else {
				// 동일한 파일이므로 처리 생략
				atrzVO.setAtchFileNo(atrzImsiVO.getAtchFileNo());
				log.info("동일 파일 재업로드 방지 → 기존 파일 유지");
			}

		} else {
			// 업로드 파일 없음 → 기존 파일 유지
			atrzVO.setAtchFileNo(atrzImsiVO.getAtchFileNo());
		}
		// 파일 확인 로그
		log.info("업로드된 파일 배열: " + Arrays.toString(uploadFile));

		// 여기서 담기지 않았음.. 사원정보가 오지 않음

		EmployeeVO emplDetail = organizationService.emplDetail(atrzVO.getEmplNo());
		// 여기서 VO를 하나 씩 담아야 하는건가...싶다.
		String clsfCode = emplDetail.getClsfCode();
		String deptCode = emplDetail.getDeptCode();
		atrzVO.setClsfCode(clsfCode);
		atrzVO.setDeptCode(deptCode);
//			atrzVO.setDrafterClsf(emplDetail.get);

		log.info("insertDraftForm-> atrzVO(사원추가후) : " + atrzVO);

		// 문서번호등록
		draftVO.setAtrzDocNo(atrzVO.getAtrzDocNo());
		log.info("spendingVO :  문서번호 등록후 : " + draftVO);

		log.info("insertDraftForm->documHolidayVO :  문서번호 등록후 : " + draftVO);

		// 1) atrz 테이블 update

		// 2) 결재선지정 후에 제목, 내용, 등록일자, 상태 update
		int result = atrzService.insertUpdateAtrz(atrzVO);
		log.info("insertDraftForm->result : " + result);

		// 3) 지출결의서 등록
		int documDraftResult = atrzService.insertDraft(draftVO);
		log.info("insertDraftForm->documDraftResult : " + documDraftResult);

		return "쭈니성공";
	}
	
	// 기안서 임시저장
	@ResponseBody
	@PostMapping(value = "atrzDraftStorage")
	public String atrzDraftStorage(AtrzVO atrzVO, @RequestPart("atrzLineList") List<AtrzLineVO> atrzLineList,
			DraftVO draftVO, int[] removeFileId,
			@RequestParam(value = "uploadFile", required = false) MultipartFile[] uploadFile) {

		log.info("atrzDraftStorage->atrzVO : " + atrzVO);
		// 1)
		// 여기서 결재문서번호를 활용해서 atrzVO에 다시 셋팅해준다.
		AtrzVO atrzStorageVO = atrzService.getAtrzStorage(atrzVO.getAtrzDocNo());
		log.info("atrzDraftStorage->atrzStorageVO : " + atrzStorageVO);

		// 2) atrzVO의 atrzLineVOList를 atrzLineList에 할당
		// *** atrzDocStorage->atrzLineList : []
		log.info("atrzDraftStorage->atrzLineList : " + atrzLineList);

		log.info("atrzDraftStorage->draftVO : " + draftVO);

		// 파일 업로드 처리 (있는 경우만)
		if (uploadFile != null && uploadFile.length > 0 && uploadFile[0].getOriginalFilename().length() > 0) {
			// 파일 이름이 같고 사이즈도 같으면 같은 파일로 간주 (중복 저장 방지)
			boolean isSameFile = false;

			if (atrzStorageVO.getAtchFileNo() != 0L) {
				List<AttachFileVO> existingFiles = attachFileService.getFileAttachList(atrzStorageVO.getAtchFileNo());

				if (!existingFiles.isEmpty()) {
					String existingFileName = existingFiles.get(0).getFileNm();
					long existingFileSize = existingFiles.get(0).getFileSize();

					String newFileName = uploadFile[0].getOriginalFilename();
					long newFileSize = uploadFile[0].getSize();

					isSameFile = existingFileName.equals(newFileName) && existingFileSize == newFileSize;
				}
			}

			if (!isSameFile) {
				// 새로운 파일이라면 insert/update 수행
				if (atrzStorageVO.getAtchFileNo() == 0L) {
					long attachFileNo = attachFileService.insertFileList("atrzUploadFile", uploadFile);
					atrzVO.setAtchFileNo(attachFileNo);
					log.info("신규 업로드된 파일 번호: " + attachFileNo);
				} else {
					AttachFileVO attachFileVO = new AttachFileVO();
					attachFileVO.setAtchFileNo(atrzStorageVO.getAtchFileNo());

					// 실제 삭제할 파일이 있는 경우에만 설정
					if (removeFileId != null && removeFileId.length > 0) {
						attachFileVO.setRemoveFileId(removeFileId);
					}

					attachFileService.updateFileList("atrzUploadFile", uploadFile, attachFileVO);
					atrzVO.setAtchFileNo(atrzStorageVO.getAtchFileNo());
					log.info("기존 파일 번호 " + atrzStorageVO.getAtchFileNo() + "에 파일 업데이트 완료");
				}
			} else {
				// 동일한 파일이므로 처리 생략
				atrzVO.setAtchFileNo(atrzStorageVO.getAtchFileNo());
				log.info("동일 파일 재업로드 방지 → 기존 파일 유지");
			}

		} else {
			// 업로드 파일 없음 → 기존 파일 유지
			atrzVO.setAtchFileNo(atrzStorageVO.getAtchFileNo());
		}
		// 파일 확인 로그
		log.info("업로드된 파일 배열: " + Arrays.toString(uploadFile));

		EmployeeVO emplDetail = organizationService.emplDetail(atrzVO.getEmplNo());
		// 여기서 VO를 하나 씩 담아야 하는건가...싶다.
		atrzVO.setClsfCode(emplDetail.getClsfCode());
		atrzVO.setDeptCode(emplDetail.getDeptCode());

		int result = atrzService.atrzDraftStorage(atrzVO, atrzLineList, draftVO);

		return result > 0 ? "임시저장성공" : "실패";
	}
		
	// 지출결의서 양식조회
	@GetMapping("/selectForm/spendingForm")
	public String selectSpendingForm() {
		return "documentForm/spendingForm";
	}

	// 지출결의서 입력양식
	@GetMapping("/selectForm/spending")
	public String selectSpending(Model model) {
		model.addAttribute("title", "지출결의서");
		return "documentForm/spending";
	}

	// 기안서 양식조회
	@GetMapping("/selectForm/draftForm")
	public String selectDraftForm(Model model) {
		model.addAttribute("title", "기안서");
		return "documentForm/draftForm";
	}

	// 1) 기안서 입력양식
	@GetMapping("/selectForm/draft")
	public String selectDraft(Model model) {
		model.addAttribute("title", "기안서");
		return "documentForm/draft";
	}

	// 급여명세서 양식조회
	@GetMapping("/selectForm/salaryForm")
	public String selectSalaryForm(Model model) {
		model.addAttribute("title", "급여명세서");
		return "documentForm/salaryForm";
	}

	// 급여명세서 입력양식
	@GetMapping("/selectForm/salary")
	public String selectSalary(Model model) {
		model.addAttribute("title", "급여명세서");
		return "documentForm/salary";
	}

	// 급여계좌변경신청서 양식조회
	@GetMapping("/selectForm/bankAccountForm")
	public String bankAccountForm(Model model) {
		model.addAttribute("title", "급여계좌변경신청서");
		return "documentForm/bankAccountForm";
	}

	// 급여계좌변경신청서 입력양식
	@GetMapping("/selectForm/bankAccount")
	public String bankAccount(Model model) {
		model.addAttribute("title", "급여계좌변경신청서");
		return "documentForm/bankAccount";
	}

}
