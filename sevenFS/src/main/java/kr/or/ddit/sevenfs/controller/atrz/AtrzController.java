package kr.or.ddit.sevenfs.controller.atrz;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import kr.or.ddit.sevenfs.service.AttachFileService;
import kr.or.ddit.sevenfs.service.atrz.AtrzService;
import kr.or.ddit.sevenfs.service.organization.OrganizationService;
import kr.or.ddit.sevenfs.utils.CommonCode;
import kr.or.ddit.sevenfs.vo.CustomUser;
import kr.or.ddit.sevenfs.vo.atrz.AtrzLineVO;
import kr.or.ddit.sevenfs.vo.atrz.AtrzVO;
import kr.or.ddit.sevenfs.vo.atrz.DocumHolidayVO;
import kr.or.ddit.sevenfs.vo.atrz.DraftVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/atrz")
public class AtrzController {

	@Autowired
	private AtrzService atrzService;

	// 사원 정보를 위해 가져온것
	@Autowired
	private OrganizationService organizationService;

	// 공통코드 텍스트를 가져오기위한것
	@Autowired
	CommonCode commonCode;
	
	//파일 전송을 위한 방법
	@Autowired
	private AttachFileService attachFileService;

	
	//그냥 전역변수로 시큐리티를 만들어놓는다.

	@GetMapping("/home")
	public String homeList(Model model, HttpServletRequest req, @AuthenticationPrincipal CustomUser customUser) {
		// 로그인한 사람정보 가져오기(사번 이름)
		EmployeeVO empVO = customUser.getEmpVO();
		log.info("empVO : ", empVO);
		
		String emplNo = empVO.getEmplNo();
		log.info("emplNo : ", emplNo);
			
		//공통코드로 사원 정보가져오기
		//로그인한 사원의 정보를 다 가져온다.
		List<AtrzVO> atrzVOList = this.atrzService.homeList(emplNo);
		//로그인한 사람이 결재자 인경우 결재 대기문서에 가져온다.
		//기안자의 정보를 가지고 기안자의 부서, 기안자의 직급 등 상세정보를 가져옴
		EmployeeVO employeeVO;
		for(AtrzVO atrzVO : atrzVOList) {
			employeeVO = organizationService.emplDetail(atrzVO.getDrafterEmpno());
			
			log.info("homeList-> employeeVO(기안자의상세정보) :"+employeeVO);
//			private String emplNo; 
//			private String emplNm;
//			private String clsfCode; // 직급코드
//			private String clsfCodeNm; // 직급코드명 
//			private String deptCode;//부서코드
//			private String deptCodeNm;//부서코드명
			
			atrzVO.setClsfCodeNm(employeeVO.getPosNm());
			atrzVO.setDeptCodeNm(employeeVO.getDeptNm());
			
			log.info("homeList-> atrzVO(기안자의정보를 atrz에 넣어줌) :"+atrzVO);
			
		}
		
		//로그인한 사람이 기안자인경우 대기문서를 가져온다.
		
		//로그인한 사람이 기안자 이며 , 완료 된 문서를 가져온다.
		for(AtrzVO atrzVO : atrzVOList) {
			organizationService.emplDetail(atrzVO.getDrafterEmpno()); 
			model.addAttribute("atrzVO", atrzVO);
			log.info("homeList -> atrzVO : "+ atrzVO);
		}
		log.info("homeList -> atrzVOList : "+ atrzVOList);
		model.addAttribute("atrzVOList", atrzVOList);
		
		
		//여기서 상태 코드에 따라 리스트가 출력되어야 한다.
		
		
		
		// 결재대기문서 갯수
		int beDocCnt = atrzService.beDocCnt(emplNo);
		model.addAttribute("beDocCnt", beDocCnt);

		// 전자 결재대기
//		List<AtrzVO> homeBeDoc = atrzService.selectHomeBeDoc(emplNo);
//		model.addAttribute("homeBeDoc", homeBeDoc);

		// 기안진행문서
//		List<AtrzVO> homeReqDoc = atrzService.selectHomeReqDoc(emplNo);
//		model.addAttribute("homeReqDoc", homeReqDoc);

		// 결재수신문서갯수
		int recDocCnt = atrzService.recDocCnt(emplNo);
		model.addAttribute("recDocCnt", recDocCnt);
		


//		// 사원정보 가져오는것 산나님 EmployeeVO에 추가한것있음 나중에 첫글자 소문자로 변경해야함
//		List<AtrzVO> atrzEmploInfo = this.atrzService.atrzEmploInfo();
//		model.addAttribute("atrzEmploInfo", atrzEmploInfo);
		model.addAttribute("title","전자결재");
		log.info("전자결재홈");
		return "atrz/home";
	}

	// 결재대기문서
	@GetMapping("/beforeDoc")
	public String selectBeforeDoc(Model model, HttpServletRequest req,
			@RequestParam(name = "page", defaultValue = "1") int currentPage,
			@RequestParam(name = "type", required = false) String type,
			@RequestParam(name = "keyword", required = false) String keyword, AtrzVO atrzVO) {

		// 로그인한 사람정보 가져오기(사번 이름)
		EmployeeVO employeeVO = (EmployeeVO) req.getSession().getAttribute("login");
		String emplNo = employeeVO.getEmplNo();

//			ArticlePage<AtrzVO> articlePage = new ArticlePage<>()
		atrzVO.setDrafterEmpno(emplNo);
		atrzVO.setType(type);
		atrzVO.setKeyword(keyword);

//			ArticlePage<AtrzVO> articlePage = new ArticlePage<>()
		final int pageSize = 6;
		final int pageBlock = 2;
		List<AtrzVO> beforeDoc = atrzService.selectBeforeDoc(currentPage, pageSize, atrzVO);

		int totalCnt = (keyword == null || keyword.isEmpty()) ? atrzService.beforeTotalCnt(atrzVO) : beforeDoc.size();

		// paging 처리
		int pageCnt = totalCnt / pageSize + (totalCnt % pageSize == 0 ? 0 : 1);
		int startPage = (currentPage % pageBlock == 0) ? ((currentPage / pageBlock) - 1) * pageBlock + 1
				: (currentPage / pageBlock) * pageBlock + 1;
		int endPage = Math.min(startPage + pageBlock - 1, pageCnt);

		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("pageCnt", pageCnt);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("beforeDoc", beforeDoc);

		return "atrz/beforeDoc";
	}

	// 결재 수신문서
	@GetMapping("/receiptdoc")
	public String selectReceiptDoc(Model model, HttpServletRequest req,
			@RequestParam(name = "page", defaultValue = "1") int currentPage,
			@RequestParam(name = "type", required = false) String type,
			@RequestParam(name = "keyword", required = false) String keyword, AtrzVO atrzVO) {

		// 로그인한 사람정보 가져오기(사번)
		EmployeeVO employeeVO = (EmployeeVO) req.getSession().getAttribute("login");
		String emplNo = employeeVO.getEmplNo();

		atrzVO.setDrafterEmpno(emplNo);
		atrzVO.setType(type);
		atrzVO.setKeyword(keyword);

		final int pageSize = 6;
		final int pageBlock = 2;

		List<AtrzVO> receiptDoc = atrzService.selectReceiptDoc(currentPage, pageSize, atrzVO);

		int totalCnt = (keyword == null || keyword.isEmpty()) ? atrzService.receiptTotalCnt(atrzVO) : receiptDoc.size();

		// paging 처리
		int pageCnt = totalCnt / pageSize + (totalCnt % pageSize == 0 ? 0 : 1);
		int startPage = (currentPage % pageBlock == 0) ? ((currentPage / pageBlock) - 1) * pageBlock + 1
				: (currentPage / pageBlock) * pageBlock + 1;
		int endPage = Math.min(startPage + pageBlock - 1, pageCnt);

		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("pageCnt", pageCnt);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("receiptDoc", receiptDoc);
		return "atrz/receiptdoc";
	}

	@GetMapping("/approval")
	public String approvalList(Model model,@AuthenticationPrincipal CustomUser customUser) {
		// 로그인한 사람정보 가져오기(사번 이름)
		EmployeeVO empVO = customUser.getEmpVO();
		String emplNo = empVO.getEmplNo();
		
		List<AtrzVO> atrzVOList = this.atrzService.homeList(emplNo);
		
		
		EmployeeVO employeeVO;
		for(AtrzVO atrzVO : atrzVOList) {
			employeeVO = organizationService.emplDetail(atrzVO.getDrafterEmpno());
			atrzVO.setClsfCodeNm(employeeVO.getPosNm());
			atrzVO.setDeptCodeNm(employeeVO.getDeptNm());
		}
		
		//로그인한 사람이 기안자 이며 , 완료 된 문서를 가져온다.
		for(AtrzVO atrzVO : atrzVOList) {
			organizationService.emplDetail(atrzVO.getDrafterEmpno()); 
			model.addAttribute("atrzVO", atrzVO);
			log.info("homeList -> atrzVO : "+ atrzVO);
		}
		log.info("homeList -> atrzVOList : "+ atrzVOList);
		model.addAttribute("atrzVOList", atrzVOList);
		
		
		
		model.addAttribute("title", "결재하기");
		model.addAttribute("atrzVOList", atrzVOList);
		log.info("결재하기 출력되낭?");
		
		return "atrz/approval";
		
	}

	@GetMapping("/document")
	public String documentList(Model model ,HttpServletRequest req ,@AuthenticationPrincipal CustomUser customUser) {
		// 로그인한 사람정보 가져오기(사번 이름)
		EmployeeVO empVO = customUser.getEmpVO();
		String emplNo = empVO.getEmplNo();
		
		
		List<AtrzVO> atrzVOList = this.atrzService.homeList(emplNo);
		
		EmployeeVO employeeVO;
		for(AtrzVO atrzVO : atrzVOList) {
			employeeVO = organizationService.emplDetail(atrzVO.getDrafterEmpno());
			atrzVO.setClsfCodeNm(employeeVO.getPosNm());
			atrzVO.setDeptCodeNm(employeeVO.getDeptNm());
		}
		
		//로그인한 사람이 기안자 이며 , 완료 된 문서를 가져온다.
		for(AtrzVO atrzVO : atrzVOList) {
			organizationService.emplDetail(atrzVO.getDrafterEmpno()); 
			model.addAttribute("atrzVO", atrzVO);
			log.info("homeList -> atrzVO : "+ atrzVO);
		}
		log.info("homeList -> atrzVOList : "+ atrzVOList);
		model.addAttribute("atrzVOList", atrzVOList);
		model.addAttribute("title", "전자결재문서함");
		return "atrz/documentBox";
	}

	// 문서양식번호 생성
	// 양식선택후 확인 클릭시 입력폼 뿌려지고, DB의 데이터를 가져오는 작업
	@ResponseBody
	// 여기선 modelAnd
	@PostMapping(value = "/insertDoc", produces = "text/plain;charset=UTF-8")
	public String insertDoc(@RequestParam(name = "form", required = false) String form, ModelAndView mav, Model model
			,@AuthenticationPrincipal CustomUser customUser	) {
		// insertDoc->form : 연차신청서
		log.info("insertDoc->form : " + form);
		// 공백 제거
		form = form.trim();

		// 문서양식 테이블에 db저장
		int result = 0;
		String df_code = "";
		AtrzVO resultDoc = null;
		// 선택한 문서 양식이 "연차신청서"일 경우
		if ("연차신청서".equals(form)) {
//			result = atrzService.insertHoDoc();
			df_code = "A";
			//전자결재문서번호를 양식선택시 생성해서 insert해준다.
//			resultDoc =atrzService.selectDoc(df_code);
			//남은 휴가일수 확인(사원번호를 가져와야함)
//			Double checkHo = atrzService.readHoCnt();
//			model.addAttribute("checkHo",checkHo);
			//문서양식번호 띄울 정보
//			model.addAttribute("resultDoc",resultDoc);
			//여기서 이 결과 값을 documentForm/holiday에 보내야함
			return "연차신청서";
			
		} else if ("지출결의서".equals(form)) {
			df_code = "B";
//			    	mav.setViewName("documentForm/spending"); // 지출결의서 JSP 반환
			return "지출결의서";
			
		} else if ("기안서".equals(form)) {
			df_code = "C";
//	    	mav.setViewName("documentForm/spending"); // 지출결의서 JSP 반환
			return "기안서";
			
		} else if ("급여명세서".equals(form)) {
			df_code = "D";
//	mav.setViewName("documentForm/spending"); // 지출결의서 JSP 반환
			return "급여명세서";
			
		} else if ("급여통장변경신청서".equals(form)) {
			df_code = "E";
//	mav.setViewName("documentForm/spending"); // 지출결의서 JSP 반환
			return "급여통장변경신청서";
			
		}else if ("재직증명서".equals(form)) {
			df_code = "F";
//	mav.setViewName("documentForm/spending"); // 지출결의서 JSP 반환
			return "재직증명서";
		}else {
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
	public String selectHoliday(Model model) {
		model.addAttribute("title", "연차신청서");
		return "documentForm/holiday";
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

	// 임시 테스트 구성다시만들기
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
	
	//급여명세서 양식조회
	@GetMapping("/selectForm/salaryForm")
	public String selectSalaryForm(Model model) {
		model.addAttribute("title", "급여명세서");
		return "documentForm/salaryForm";
	}
	
	//급여명세서 입력양식
	@GetMapping("/selectForm/salary")
	public String selectSalary(Model model) {
		model.addAttribute("title", "급여명세서");
		return "documentForm/salary";
	}
	//급여계좌변경신청서 양식조회
	@GetMapping("/selectForm/bankAccountForm")
	public String bankAccountForm(Model model) {
		model.addAttribute("title", "급여계좌변경신청서");
		return "documentForm/bankAccountForm";
	}
	
	//급여계좌변경신청서 입력양식
	@GetMapping("/selectForm/bankAccount")
	public String bankAccount(Model model) {
		model.addAttribute("title", "급여계좌변경신청서");
		return "documentForm/bankAccount";
	}
	
	
	

	// 2) 기안서 전송양식
	@PostMapping("/draft/insert")
	public String draftInsert(DraftVO draftVO
	// 파일등록추가
	) {
		// draftInsert->draftVO(insert전) : DraftVO(title=sfadadfs, content=sadfsdafd,
		// draftNo=null)
		log.info("draftInsert->draftVO(insert전) : " + draftVO);
		int result = this.atrzService.draftInsert(draftVO);
		log.info("selectDraftInsert-> result : " + result);
		// draftVO(insert 후) : DraftVO(title=asddfs, content=sdafasdfdsfasdfsdaf,
		// draftNo=1)
		log.info("selectDraftInsert-> draftVO(insert 후) : " + draftVO);

		// 1. 상세보기가 없음
		// 2. 상세보기로 들어가야 함
		// 3. 한 양식당 jsp가 2개가 만들어져있음( 1) input, 2) 보여주는 양식 미리보기 )
		return "redirect:/atrz/selectForm/draftDetail?draftNo=" + draftVO.getDraftNo();
	}

	// 3) 기안서 상세
	@GetMapping("/selectForm/draftDetail")
	public String draftDetail(Model model, @RequestParam(value = "draftNo", required = true) String draftNo) {
		log.info("draftDetail->draftNo : " + draftNo);

		// SELECT * FROM DRAFT WHERE DRAFT_NO = 2
		DraftVO draftVO = this.atrzService.draftDetail(draftNo);
		log.info("draftDetail->draftVO : " + draftVO);

		model.addAttribute("title", "기안서 상세보기");
		model.addAttribute("draftVO", draftVO);

		return "documentForm/draftDetail";
	}
	
	

	// 결재선지정 시 직원명 클릭하면 emplNo을 파라미터로 받아 DB select를 하여 JSON String으로 해당 직원 정보를 응답해줌
	// 요청파라미터 : {"emplNo":emplNo}
	@ResponseBody
	@PostMapping(value = "/appLineEmp", produces = "application/json;charset=UTF-8")
	public EmployeeVO appLineEmp(@RequestParam(name = "emplNo", required = false) String emplNo, @RequestParam Map<String, List<String>> requestData, Model model) {
		// insertDoc->form : 연차신청서
		// appLineEmp->emplNo : 20250000
		log.info("appLineEmp->emplNo : " + emplNo);

//		//이제 디테일을 가지고 공통코드에 가서 사원의 정보를 텍스트로 가져와야함
//		CommonCodeVO commonCodeDetail = organizationService.empDetailDep(emplNo);
		// 여기서 사원번호를 꺼내서 사원 디테일까지가져옴
		EmployeeVO emplDetail = organizationService.emplDetail(emplNo);

//		log.info("appLineEmp->commonCodeDetail : " + commonCodeDetail);
		log.info("appLineEmp->emplDetail : " + emplDetail);

		log.info("appLineEmp->emplDetailNm.getDeptNm : " + emplDetail.getDeptNm());
		log.info("appLineEmp->emplDetailNm.getPosNm : " + emplDetail.getPosNm());
		
//		List<String> emplNoList = requestData.get("result");
//		if(emplNoList !=null) {
//			for(String emplNo : emplNoList) {
//				log.info(emplNo)
//			}
//		}
//		
		//requestData 에 있는 애를 하나씩 꺼내서 사용해야한다.
//		for(int i = 0; i<requestData.length; i++) {
//			
//		}
//		requestData
		
		//DB의 사원정보를 조회
//		List<EmployeeVO> employeeVOList = organizationService.emplDetail(emplNums)

		return emplDetail;
	}

	@ResponseBody
	@PostMapping(value = "atrzInsert")
	public String insertAppLineList(AtrzVO atrzVO,
			     @RequestPart("atrzLineList")List<AtrzLineVO> atrzLineList, 
			     @RequestPart("docHoliday") DocumHolidayVO documHolidayVO,
			     @RequestParam(name = "emplNo", required = false) String emplNo){
		
		log.info("atrz {}",atrzVO);
		log.info("atrzLineList {}",atrzLineList);
		log.info("documHolidayVO {}",documHolidayVO);
		log.info("emplNo {}",emplNo);
		
		//여기서 담기지 않았음.. 사원정보가 오지 않음
		
		EmployeeVO emplDetail = organizationService.emplDetail(atrzVO.getEmplNo());
		//여기서 VO를 하나 씩 담아야 하는건가...싶다. 
		String clsfCode = emplDetail.getClsfCode();
		String deptCode = emplDetail.getDeptCode();
		atrzVO.setClsfCode(clsfCode);
		atrzVO.setDeptCode(deptCode);
//		atrzVO.setDrafterClsf(emplDetail.get);
		
		log.info("insertAppLineList-> atrzVO(사원추가후) : "+atrzVO);
//			organizationService.emplDetail(atrzVO.get)
		//전자결재 테이블 인서트
		int atrzResult = atrzService.insertAtrz(atrzVO);
		
		//문서번호등록
		String atrzDocNo = atrzVO.getAtrzDocNo();
		log.info("atrzDocNo :  문서번호 등록 : "+atrzDocNo);
		//변수에 있는 문서번호를 넣어주기 atrzLineVO에 넣어주기
		for(AtrzLineVO atrzLineVO : atrzLineList) {
			atrzLineVO.setAtrzDocNo(atrzDocNo);
			log.info("atrzLineVO :  문서번호 등록후 : "+atrzLineVO);	
			atrzService.insertAtrzLine(atrzLineVO);

		}
		
		
		
		//문서번호등록
		documHolidayVO.setAtrzDocNo(atrzDocNo);
		log.info("documHolidayVO :  문서번호 등록후 : "+documHolidayVO);	
		
		//시간배열 다시 하나로 합치기
		String[] holiStartArr = documHolidayVO.getHoliStartArr(); // ["2025-04-11", "09:00:00"]
	    String[] holiEndArr = documHolidayVO.getHoliEndArr();     // ["2025-04-11", "18:00:00"]

	    // 하나의 문자열로 합치기
	    String holiStartStr = holiStartArr[0] + " " + holiStartArr[1]+":00"; // "2025-04-11 09:00:00"
	    String holiEndStr = holiEndArr[0] + " " + holiEndArr[1]+":00";       // "2025-04-11 18:00:00"
	    
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
	    
//		//연차신청서 인서트
		int documHolidayResult = atrzService.insertHoliday(documHolidayVO);
		
		
		
		
		return "쭈니성공";
	}

	
	//모달에서 선택한 결재선이 비동기로 담아서 보내서 확인해야함
	@ResponseBody
	@PostMapping(value = "appLineList")
	public List<EmployeeVO> selectAppLineList(
			String[] emplNoArr,
			HttpServletRequest req,
			 Model model,
			String[] empNoList,
			String[] empAttNoList,
			String[] authList
			) {
		
//		List<AttachFileVO> fileAttachList = attachFileService.getFileAttachList(1);
		
		List<String> list = new ArrayList<String>();
		
		log.debug("empNoList {}", Arrays.toString(empNoList)); // 결재자
		log.debug("empAttNoList {}", Arrays.toString(empAttNoList)); // 참조자
		
		for(String emplNo : emplNoArr) {
			//selectAppLineList->emplNo : 20250008
			//selectAppLineList->emplNo : 20250016
			log.info("selectAppLineList->emplNo : " + emplNo);
			
			
			list.add(emplNo);
		}
		
		//여기서 결재자와 참조자를 나눠야 한다.
		log.info("empNoList: " +Arrays.toString(empNoList));
		log.info("empAttNoList : " +Arrays.toString(empAttNoList));
//		for(String empAttNo : empNoList) {
//			log.info("selectAppLineList-> empAttNo : "+empAttNo);
//			
//		}
	
		
//		해당 직원의 상세정보 목록을 select
		List<EmployeeVO> emplDetailList = organizationService.emplDetailList(list);
		log.info("selectAppLineList->emplDetailList : " + emplDetailList);
		
		//여기서 담아서 보내야함
		return emplDetailList;
		
	}
	//연차신청서 상세보기
	@GetMapping("selectForm/holidayDetail")
	public String holidayDetail(Model model, @RequestParam(value = "holiActplnNo", required = true) int holiActplnNo,
			DocumHolidayVO documHolidayVO) {
		log.info("holidayDetail-> holiActplnNo :"+holiActplnNo);
		
		documHolidayVO = this.atrzService.holidayDetail(holiActplnNo);
		
		model.addAttribute("title", "연차신청서 상세보기");
		model.addAttribute("documHolidayVO",documHolidayVO);
		log.info("selectHolidayDetail-> documHolidayVO : "+documHolidayVO);
		return "documentForm/holidayDetail";
		
		
	}

//	public String insert() {
//	atrzService.insertFrom() ///xml
//	atrzService.insertapproLine(); //xml
//	}

}
