package kr.or.ddit.sevenfs.controller.atrz;

import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
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
import kr.or.ddit.sevenfs.vo.atrz.HolidayVO;
import kr.or.ddit.sevenfs.vo.atrz.SalaryVO;
import kr.or.ddit.sevenfs.vo.atrz.SpendingVO;
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

	// 파일 전송을 위한 방법
	@Autowired
	private AttachFileService attachFileService;

	@GetMapping("/home")
	public String homeList(Model model, @AuthenticationPrincipal CustomUser customUser) {
		// 로그인한 사람정보 가져오기(사번 이름)
		EmployeeVO empVO = customUser.getEmpVO();
		log.info("empVO : ", empVO);
		String emplNo = empVO.getEmplNo();
		log.info("emplNo : ", emplNo);

		// 여기는 결재 대기문서
		List<AtrzVO> atrzApprovalList = atrzService.atrzApprovalList(emplNo);
		// 결재대기문서의 기안자상세정보 따로 코드를 통해 넣어줘야 함
		EmployeeVO employeeVO;
		for (AtrzVO atrzVO : atrzApprovalList) {
			String drafterEmpNo = atrzVO.getDrafterEmpno();
			employeeVO = organizationService.emplDetail(drafterEmpNo);
//			log.info("employeeVO (기안자 상세정보를 위하여): "+employeeVO);
			// 직급코드 atrzVO담기
			atrzVO.setClsfCodeNm(employeeVO.getClsfCodeNm());
			atrzVO.setDeptCodeNm(employeeVO.getDeptNm());
//			log.info("atrzVO (기안자 상세정보 추가): "+atrzVO);

		}
		// 여기는 내가 결재차례인경우에 해당
		model.addAttribute("atrzApprovalList", atrzApprovalList);

		// 가안중에 문서에 해당 기안일시 최신순으로 10개만 출력
		List<AtrzVO> atrzSubmitList = atrzService.atrzSubmitList(emplNo);
		for (AtrzVO atrzVO : atrzSubmitList) {
			String drafterEmpNo = atrzVO.getDrafterEmpno();
			employeeVO = organizationService.emplDetail(drafterEmpNo);
			atrzVO.setClsfCodeNm(employeeVO.getClsfCodeNm());
			atrzVO.setDeptCodeNm(employeeVO.getDeptNm());
		}
		model.addAttribute("atrzSubmitList", atrzSubmitList);

		// 기안완료된 문서에 해당 완료일시 최신순으로 10개만 출력
		List<AtrzVO> atrzCompletedList = atrzService.atrzCompletedList(emplNo);
		for (AtrzVO atrzVO : atrzCompletedList) {
			String drafterEmpNo = atrzVO.getDrafterEmpno();
			employeeVO = organizationService.emplDetail(drafterEmpNo);
			atrzVO.setClsfCodeNm(employeeVO.getClsfCodeNm());
			atrzVO.setDeptCodeNm(employeeVO.getDeptNm());
		}

		model.addAttribute("atrzCompletedList", atrzCompletedList);

		model.addAttribute("title", "전자결재");
		return "atrz/home";
	}

	// 결재대기문서 페이징 처리중
	@GetMapping("/approval")
	public String approvalList(Model model, @AuthenticationPrincipal CustomUser customUser,
			@RequestParam(defaultValue = "1") int total, @RequestParam(defaultValue = "1") int currentPage,
			@RequestParam(defaultValue = "10") int size) {

		ArticlePage<AttachFileVO> articlePage = new ArticlePage<>(total, currentPage, size);
		List<AttachFileVO> fileAttachList = attachFileService.getFileAttachList(1);
		// 로그인한 사람정보 가져오기(사번 이름)
		EmployeeVO empVO = customUser.getEmpVO();
		String emplNo = empVO.getEmplNo();

		List<AtrzVO> atrzVOList = this.atrzService.homeList(emplNo);

		EmployeeVO employeeVO;
		for (AtrzVO atrzVO : atrzVOList) {
			employeeVO = organizationService.emplDetail(atrzVO.getDrafterEmpno());
			atrzVO.setClsfCodeNm(employeeVO.getPosNm());
			atrzVO.setDeptCodeNm(employeeVO.getDeptNm());
		}
		model.addAttribute("atrzVOList", atrzVOList);
		model.addAttribute("title", "결재대기문서");

		return "atrz/approval";

	}

	@GetMapping("/document")
	public String documentList(Model model, HttpServletRequest req, @AuthenticationPrincipal CustomUser customUser) {
		// 로그인한 사람정보 가져오기(사번 이름)
		EmployeeVO empVO = customUser.getEmpVO();
		String emplNo = empVO.getEmplNo();

		List<AtrzVO> atrzVOList = this.atrzService.homeList(emplNo);

		EmployeeVO employeeVO;
		for (AtrzVO atrzVO : atrzVOList) {
			employeeVO = organizationService.emplDetail(atrzVO.getDrafterEmpno());
			atrzVO.setClsfCodeNm(employeeVO.getPosNm());
			atrzVO.setDeptCodeNm(employeeVO.getDeptNm());
		}

		log.info("homeList -> atrzVOList : " + atrzVOList);
		model.addAttribute("atrzVOList", atrzVOList);
		model.addAttribute("title", "전자결재문서함");
		return "atrz/documentBox";
	}

	// 문서양식번호 생성
	// 양식선택후 확인 클릭시 입력폼 뿌려지고, DB의 데이터를 가져오는 작업
	@ResponseBody
	// 여기선 modelAnd
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

		} else if ("급여명세서".equals(form)) {
			df_code = "D";
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
	public String selectHoliday(Model model) {
		model.addAttribute("title", "연차신청서");
		return "documentForm/holiday";
	}

	
	
	
	// 연차신청서 상세보기
	@GetMapping("/selectForm/atrzDetail")
	public String selectAtrzDetail(@RequestParam String atrzDocNo, Model model) {
		if (atrzDocNo == null || atrzDocNo.length() < 1) {
			return "redirect:/error"; // 유효하지 않은 문서번호
		}

		char docPrefix = atrzDocNo.charAt(0); // 예: H, S, D, A, B, C, R

		AtrzVO atrzVO = atrzService.getAtrzDetail(atrzDocNo);
		log.info("selectAtrzDetail->atrzVO: " + atrzVO);
		String emplNo = atrzVO.getDrafterEmpno();
		log.info("selectAtrzDetail->emplNo: " + emplNo);
		EmployeeVO employeeVO = organizationService.emplDetail(emplNo);
		log.info("selectAtrzDetail->employeeVO: " + employeeVO);
		atrzVO.setEmplNm(employeeVO.getEmplNm());
		
		//직급 코드를 통해 직급 얻기
		String drafClsf = atrzVO.getDrafterClsf();
		String ClsfCodeNm = CommonCode.PositionEnum.INTERN.getLabelByCode(drafClsf);
		atrzVO.setClsfCodeNm(ClsfCodeNm);
		atrzVO.setDeptCodeNm(employeeVO.getDeptNm());
		
		atrzVO.getAtrzLineVOList();
		List<AtrzLineVO> atrzLineVOList = atrzVO.getAtrzLineVOList();
		log.info("atrzLineVOList : "+atrzLineVOList);
		
		List<EmployeeVO> sanEmplVOList = new ArrayList<>();
		for(AtrzLineVO atrzLineVO : atrzLineVOList) {
			String sancterEmpNo = atrzLineVO.getSanctnerEmpno();
			EmployeeVO sanEmplVO =organizationService.emplDetail(sancterEmpNo);
			
			
			String sanctClsfCd = atrzLineVO.getSanctnerClsfCode();
			String sanctClsfNm = CommonCode.PositionEnum.INTERN.getLabelByCode(sanctClsfCd);
			atrzLineVO.setSanctnerClsfNm(sanctClsfNm);
			//결재자의 이름 담기
			atrzLineVO.setSanctnerEmpNm(sanEmplVO.getEmplNm());
			log.info("sanctClsfNm : "+sanctClsfNm);
			//여기서 하나하나 담긴애들을 리스트로 보내야한다.
			
			log.info("sanEmplVO : "+sanEmplVO);
			log.info("sancterEmpNo : "+sancterEmpNo);
		}
		
		// 
		atrzVO.setHolidayVO(atrzService.holidayDetail(atrzDocNo));
		
		
		model.addAttribute("sanEmplVOList",sanEmplVOList);
		
		model.addAttribute("atrzVO", atrzVO);
		model.addAttribute("employeeVO", employeeVO);
		
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
	case 'H' -> "documentForm/holidayDetail";            // 연차신청서
	case 'S' -> "documentForm/spendingDetail";           // 지출결의서
	case 'D' -> "documentForm/draftDetail";              // 기안서
	case 'A' -> "documentForm/salarySlipDetail";         // 급여명세서
	case 'B' -> "documentForm/accountChangeDetail";      // 급여계좌변경신청서
	case 'C' -> "documentForm/employmentCertDetail";     // 재직증명서
	case 'R' -> "documentForm/resignDetail";             // 퇴직신청서
	default -> "redirect:/error";                        // 알 수 없는 양식
	};
	
return viewName;
}
	

	//전자결재 승인시 상세보기 get
	
	
	
	//전자결재 승인시
	@ResponseBody
	@PostMapping("selectForm/atrzDetailUpdate")
	public String atrzDetailUpdate(AtrzVO atrzVO,
			Model model,@AuthenticationPrincipal CustomUser customUser) {
		// 로그인한 사람정보 가져오기(사번 이름)
		EmployeeVO empVO = customUser.getEmpVO();
		String emplNo = empVO.getEmplNo();
		
		atrzVO.setEmplNo(emplNo);
		//여기서 파라미터로 문서번호를 넘겨줘야한다.
		//결재한사람의 정보를 받아온다. 
		//모달창에서 승인을 누르면 업데이트가 되어야한다.
		/*
		 AtrzVO(atrzDocNo=H_20250411_00003, drafterEmpno=null, drafterClsf=null, drafterEmpnm=null, drafterDept=null, bkmkYn=null, 
		 atchFileNo=0, atrzSj=null, atrzCn=null, atrzOpinion=null, atrzTmprStreDt=null, atrzDrftDt=null, atrzComptDt=null, atrzRtrvlDt=null, atrzSttusCode=null, 
		 eltsgnImage=null, docFormNo=0, atrzDeleteYn=null, schdulRegYn=null, docFormNm=null, emplNoArr=null, emplNo=20250000, emplNm=null, clsfCode=null, clsfCodeNm=null,
         deptCode=null, deptCodeNm=null, uploadFile=null, 
		  	atrzLineVOList=[AtrzLineVO(atrzDocNo=null, atrzLnSn=0, sanctnerEmpno=null, sanctnerClsfCode=null, contdEmpno=null, 
			  contdClsfCode=null, dcrbManEmpno=null, dcrbManClsfCode=null, atrzTy=null, sanctnProgrsSttusCode=null, dcrbAuthorYn=null, contdAuthorYn=null, sanctnOpinion=승인합니다., 
			  eltsgnImage=null, sanctnConfmDt=null, atrzLineList=null, sanctnerClsfNm=null, sanctnerEmpNm=null)
			  ], 
		 holidayVO=null, spendingVO=null, salaryVO=null, 
		 bankAccountVO=null, draftVO=null, emplDetailList=null, authorStatus=false, sanctnProgrsSttusCode=10)
		 */
		
		//
		int atrzUpdateResult = atrzService.atrzDetailAppUpdate(atrzVO);
		
		log.info("atrzDetailUpdate-> atrzVO : "+atrzVO);
		//전자결재 승인시 다음결재권자로 넘어간다.
		
		//전자결재 반려시 반려처리가된다.
		//이러고 어디로 가야할지 모르겠다.
//		return "redirect:/selectForm/atrzDetail?atrzDocNo=" + atrzVO.getAtrzDocNo();
		return "success";
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

	// 기안자 정보 등록 전자결재 등록
	// 결재선지정 시 직원명 클릭하면 emplNo을 파라미터로 받아 DB select를 하여 JSON String으로 해당 직원 정보를 응답해줌
	// 요청파라미터 : {"emplNo":emplNo}
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
		// appLineEmp->emplDetail : null
		log.info("appLineEmp->emplDetail : " + emplDetail);

		log.info("appLineEmp->emplDetailNm.getDeptNm : " + emplDetail.getDeptNm());
		log.info("appLineEmp->emplDetailNm.getPosNm : " + emplDetail.getPosNm());

		return emplDetail;
	}

	// 결재자 정보등록 결재선 등록
	// 모달에서 선택한 결재선이 비동기로 담아서 보내서 확인해야함
	// String[] empNoList : 없음
	// String[] empAttNoList, : 없음
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
		log.info("empVO : " + empVO);
		String emplNo = empVO.getEmplNo();
		log.info("emplNo : " + emplNo);
		String emplNm = empVO.getEmplNm();
		log.info("emplNm : " + emplNo);
		String clsfCode = empVO.getClsfCode();
		log.info("clsfCode : " + clsfCode);
		String deptCode = empVO.getDeptCode();
		log.info("deptCode : " + deptCode);

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

	// 연차신청서 등록(문서번호가 이미 있는 상태임)
	@ResponseBody
	@PostMapping(value = "atrzHolidayInsert")
	public String insertHolidayForm(AtrzVO atrzVO, @RequestPart("atrzLineList") List<AtrzLineVO> atrzLineList,
			@RequestPart("docHoliday") HolidayVO documHolidayVO) {

		log.info("atrz(최초) : {}", atrzVO);
		log.info("atrzLineList(최초) : {}", atrzLineList);
		log.info("documHolidayVO(최초) : {}", documHolidayVO);

		// 여기서 담기지 않았음.. 사원정보가 오지 않음

		EmployeeVO emplDetail = organizationService.emplDetail(atrzVO.getEmplNo());
		// 여기서 VO를 하나 씩 담아야 하는건가...싶다.
		String clsfCode = emplDetail.getClsfCode();
		String deptCode = emplDetail.getDeptCode();
		atrzVO.setClsfCode(clsfCode);
		atrzVO.setDeptCode(deptCode);
//		atrzVO.setDrafterClsf(emplDetail.get);

		/*
		 * atrzSj, atrzCn, atrzDrftDt, atrzSttusCode AtrzVO(atrzDocNo=null,
		 * drafterEmpno=null, drafterClsf=null, drafterEmpnm=null, drafterDept=null,
		 * bkmkYn=null, atchFileNo=0, atrzSj=미리작성한 제목입니다., atrzCn=sfda,
		 * atrzOpinion=null, atrzTmprStreDt=null, atrzDrftDt=null, atrzComptDt=null,
		 * atrzRtrvlDt=null, atrzSttusCode=null, eltsgnImage=null, docFormNo=1,
		 * atrzDeleteYn=null, schdulRegYn=null, docFormNm=H, emplNoArr=null,
		 * emplNo=20250004, emplNm=길준희, clsfCode=02, clsfCodeNm=null, deptCode=91,
		 * deptCodeNm=null, uploadFile=null, atrzLineVOList=null, holidayVO=null,
		 * spendingVO=null, emplDetailList=null)
		 */
		log.info("insertAppLineList-> atrzVO(사원추가후) : " + atrzVO);
//			organizationService.emplDetail(atrzVO.get)
		// 전자결재 테이블 등록
//		int atrzResult = atrzService.insertAtrz(atrzVO);

		// 문서번호등록
//		String atrzDocNo = atrzVO.getAtrzDocNo();
//		log.info("atrzDocNo :  문서번호 등록 : "+atrzDocNo);
		// 변수에 있는 문서번호를 넣어주기 atrzLineVO에 넣어주기
//		for(AtrzLineVO atrzLineVO : atrzLineList) {
//			atrzLineVO.setAtrzDocNo(atrzDocNo);
//			log.info("atrzLineVO :  문서번호 등록후 : "+atrzLineVO);	
//			atrzService.insertAtrzLine(atrzLineVO);
//
//		}

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

		/*
		 * HolidayVO(holiActplnNo=0, atrzDocNo=null, holiCode=22,
		 * holiStartArr=[2025-04-08, 09:00:00], holiStart=Tue Apr 08 09:00:00 KST 2025,
		 * holiEndArr=[2025-04-10, 18:00:00], holiEnd=Thu Apr 10 18:00:00 KST 2025,
		 * atrzLineVOList=null, atrzVO=null)
		 */
		log.info("insertHolidayForm->documHolidayVO :  문서번호 등록후 : " + documHolidayVO);

		// 1) atrz 테이블 update
		/*
		 * atrzSj, atrzCn, atrzDrftDt, atrzSttusCode AtrzVO(atrzDocNo=null,
		 * drafterEmpno=null, drafterClsf=null, drafterEmpnm=null, drafterDept=null,
		 * bkmkYn=null, atchFileNo=0, atrzSj=미리작성한 제목입니다., atrzCn=sfda,
		 * atrzOpinion=null, atrzTmprStreDt=null, atrzDrftDt=null, atrzComptDt=null,
		 * atrzRtrvlDt=null, atrzSttusCode=null, eltsgnImage=null, docFormNo=1,
		 * atrzDeleteYn=null, schdulRegYn=null, docFormNm=H, emplNoArr=null,
		 * emplNo=20250004, emplNm=길준희, clsfCode=02, clsfCodeNm=null, deptCode=91,
		 * deptCodeNm=null, uploadFile=null, atrzLineVOList=null, holidayVO=null,
		 * spendingVO=null, emplDetailList=null)
		 */
		// 2) 결재선지정 후에 제목, 내용, 등록일자, 상태 update
		int result = atrzService.insertUpdateAtrz(atrzVO);
		log.info("insertHolidayForm->result : " + result);

		// 3) 연차신청서 등록
		int documHolidayResult = atrzService.insertHoliday(documHolidayVO);
		log.info("insertHolidayForm->documHolidayResult : " + documHolidayResult);

		return "쭈니성공";
	}

	// 지출결의서 등록
	@ResponseBody
	@PostMapping(value = "atrzSpendingInsert")
	public String insertSpendingForm(AtrzVO atrzVO, @RequestPart("atrzLineList") List<AtrzLineVO> atrzLineList,
			SpendingVO spendingVO) {

		atrzVO.setDrafterEmpno(atrzVO.getEmplNo());

		log.info("insertSpendingForm-> atrz : " + atrzVO);
		log.info("insertSpendingForm-> atrzLineList : " + atrzLineList);
		log.info("insertSpendingForm-> spendingVO : " + spendingVO);

		EmployeeVO emplDetail = organizationService.emplDetail(atrzVO.getEmplNo());
		log.info("insertSpendingForm->emplDetail : " + emplDetail);
		// 여기서 VO를 하나 씩 담아야 하는건가...싶다.
		String clsfCode = emplDetail.getClsfCode();
		String deptCode = emplDetail.getDeptCode();
		atrzVO.setClsfCode(clsfCode);
		atrzVO.setDeptCode(deptCode);

		log.info("insertSpendingForm-> atrzVO(사원추가후) : " + atrzVO);

		// 전자결재 테이블 등록
		int atrzResult = atrzService.insertAtrz(atrzVO);

		// 전자결재 문서번호등록
		String atrzDocNo = atrzVO.getAtrzDocNo();
		log.info("insertSpendingForm-> atrzDocNo :  문서번호 등록 : " + atrzDocNo);
		// 변수에 있는 문서번호를 넣어주기 atrzLineVO에 넣어주기
		for (AtrzLineVO atrzLineVO : atrzLineList) {
			atrzLineVO.setAtrzDocNo(atrzDocNo);
			log.info("atrzLineVO :  문서번호 등록후 : " + atrzLineVO);
			atrzService.insertAtrzLine(atrzLineVO);
		}

		// 문서번호등록
		spendingVO.setAtrzDocNo(atrzDocNo);
		log.info("spendingVO :  문서번호 등록후 : " + spendingVO);
		// 지출결의서 등록
		int documSpendingResult = atrzService.insertSpending(spendingVO);

		return "쭈니성공";
	}

	// 급여명세서 등록
	@ResponseBody
	@PostMapping(value = "atrzSalaryInsert")
	public String insertSalaryForm(AtrzVO atrzVO, @RequestPart("atrzLineList") List<AtrzLineVO> atrzLineList,
			SalaryVO salaryVO) {

		atrzVO.setDrafterEmpno(atrzVO.getEmplNo());

		log.info("insertSalaryForm-> atrz : " + atrzVO);
		log.info("insertSalaryForm-> atrzLineList : " + atrzLineList);
		log.info("insertSalaryForm-> spendingVO : " + salaryVO);

		EmployeeVO emplDetail = organizationService.emplDetail(atrzVO.getEmplNo());
		log.info("insertSalaryForm->emplDetail : " + emplDetail);
		// 여기서 VO를 하나 씩 담아야 하는건가...싶다.
		String clsfCode = emplDetail.getClsfCode();
		String deptCode = emplDetail.getDeptCode();
		atrzVO.setClsfCode(clsfCode);
		atrzVO.setDeptCode(deptCode);

		log.info("insertSalaryForm-> atrzVO(사원추가후) : " + atrzVO);

		// 전자결재 테이블 등록
		int atrzResult = atrzService.insertAtrz(atrzVO);

		// 전자결재 문서번호등록
		String atrzDocNo = atrzVO.getAtrzDocNo();
		log.info("insertSpendingForm-> atrzDocNo :  문서번호 등록 : " + atrzDocNo);
		// 변수에 있는 문서번호를 넣어주기 atrzLineVO에 넣어주기
		for (AtrzLineVO atrzLineVO : atrzLineList) {
			atrzLineVO.setAtrzDocNo(atrzDocNo);
			log.info("atrzLineVO :  문서번호 등록후 : " + atrzLineVO);
			atrzService.insertAtrzLine(atrzLineVO);
		}

		// 문서번호등록
		salaryVO.setAtrzDocNo(atrzDocNo);
		log.info("salaryVO :  문서번호 등록후 : " + salaryVO);
		// 지출결의서 등록
		int documSalaryResult = atrzService.insertSalary(salaryVO);

		return "쭈니성공";
	}

	// 급여계좌변경신청서 등록
	@ResponseBody
	@PostMapping(value = "atrzBankAccountInsert")
	public String insertBankAccountForm(AtrzVO atrzVO, @RequestPart("atrzLineList") List<AtrzLineVO> atrzLineList,
			BankAccountVO bankAccountVO) {

		atrzVO.setDrafterEmpno(atrzVO.getEmplNo());

		log.info("insertBankAccountForm-> atrz : " + atrzVO);
		log.info("insertBankAccountForm-> atrzLineList : " + atrzLineList);
		log.info("insertBankAccountForm-> bankAccountVO : " + bankAccountVO);

		EmployeeVO emplDetail = organizationService.emplDetail(atrzVO.getEmplNo());
		log.info("insertBankAccountForm->emplDetail : " + emplDetail);
		// 여기서 VO를 하나 씩 담아야 하는건가...싶다.
		String clsfCode = emplDetail.getClsfCode();
		String deptCode = emplDetail.getDeptCode();
		atrzVO.setClsfCode(clsfCode);
		atrzVO.setDeptCode(deptCode);

		log.info("insertBankAccountForm-> atrzVO(사원추가후) : " + atrzVO);

		// 전자결재 테이블 등록
		int atrzResult = atrzService.insertAtrz(atrzVO);

		// 전자결재 문서번호등록
		String atrzDocNo = atrzVO.getAtrzDocNo();
		log.info("insertBankAccountForm-> atrzDocNo :  문서번호 등록 : " + atrzDocNo);
		// 변수에 있는 문서번호를 넣어주기 atrzLineVO에 넣어주기
		for (AtrzLineVO atrzLineVO : atrzLineList) {
			atrzLineVO.setAtrzDocNo(atrzDocNo);
			log.info("atrzLineVO :  문서번호 등록후 : " + atrzLineVO);
			atrzService.insertAtrzLine(atrzLineVO);
		}

		// 문서번호등록
		bankAccountVO.setAtrzDocNo(atrzDocNo);
		log.info("spendingVO :  문서번호 등록후 : " + bankAccountVO);
		// 급여계좌변경신청서 등록
		int documBankAccountResult = atrzService.insertBankAccount(bankAccountVO);

		return "쭈니성공";
	}

	// 기안서 등록
	@ResponseBody
	@PostMapping(value = "atrzDraftInsert")
	public String insertDraftForm(AtrzVO atrzVO, @RequestPart("atrzLineList") List<AtrzLineVO> atrzLineList,
			DraftVO draftVO) {

		atrzVO.setDrafterEmpno(atrzVO.getEmplNo());

		log.info("insertDraftForm-> atrz : " + atrzVO);
		log.info("insertDraftForm-> atrzLineList : " + atrzLineList);
		log.info("insertDraftForm-> draftVO : " + draftVO);

		EmployeeVO emplDetail = organizationService.emplDetail(atrzVO.getEmplNo());
		log.info("insertDraftForm->emplDetail : " + emplDetail);
		// 여기서 VO를 하나 씩 담아야 하는건가...싶다.
		String clsfCode = emplDetail.getClsfCode();
		String deptCode = emplDetail.getDeptCode();
		atrzVO.setClsfCode(clsfCode);
		atrzVO.setDeptCode(deptCode);

		log.info("insertDraftForm-> atrzVO(사원추가후) : " + atrzVO);

		// 전자결재 테이블 등록
		int atrzResult = atrzService.insertAtrz(atrzVO);

		// 전자결재 문서번호등록
		String atrzDocNo = atrzVO.getAtrzDocNo();
		log.info("insertDraftForm-> atrzDocNo :  문서번호 등록 : " + atrzDocNo);
		// 변수에 있는 문서번호를 넣어주기 atrzLineVO에 넣어주기
		for (AtrzLineVO atrzLineVO : atrzLineList) {
			atrzLineVO.setAtrzDocNo(atrzDocNo);
			log.info("atrzLineVO :  문서번호 등록후 : " + atrzLineVO);
			atrzService.insertAtrzLine(atrzLineVO);
		}

		// 문서번호등록
		draftVO.setAtrzDocNo(atrzDocNo);
		log.info("insertDraftForm->draftVO :  문서번호 등록후 : " + draftVO);
		// 급여계좌변경신청서 등록
		int documDraftResult = atrzService.insertDraft(draftVO);

		return "쭈니성공";
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

}
