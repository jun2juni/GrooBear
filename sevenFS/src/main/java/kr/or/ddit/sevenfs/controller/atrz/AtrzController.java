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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpServletRequest;
import kr.or.ddit.sevenfs.mapper.atrz.AtrzMapper;
import kr.or.ddit.sevenfs.service.AttachFileService;
import kr.or.ddit.sevenfs.service.atrz.AtrzService;
import kr.or.ddit.sevenfs.service.organization.OrganizationService;
import kr.or.ddit.sevenfs.utils.CommonCode;
import kr.or.ddit.sevenfs.vo.CustomUser;
import kr.or.ddit.sevenfs.vo.atrz.AtrzLineVO;
import kr.or.ddit.sevenfs.vo.atrz.AtrzVO;
import kr.or.ddit.sevenfs.vo.atrz.BankAccountVO;
import kr.or.ddit.sevenfs.vo.atrz.DraftVO;
import kr.or.ddit.sevenfs.vo.atrz.HolidayVO;
import kr.or.ddit.sevenfs.vo.atrz.SalaryVO;
import kr.or.ddit.sevenfs.vo.atrz.SpendingVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/atrz")
public class AtrzController {

	@Autowired
	private AtrzService atrzService;
	
	@Autowired
	private AtrzMapper atrzMapper;
	
	// 사원 정보를 위해 가져온것
	@Autowired
	private OrganizationService organizationService;

	// 파일 전송을 위한 방법
	@Autowired
	private AttachFileService attachFileService;

	@GetMapping("/home")
	public String home(Model model, @AuthenticationPrincipal CustomUser customUser) {
		// 로그인한 사람정보 가져오기(사번 이름)
		EmployeeVO empVO = customUser.getEmpVO();
		log.info("empVO : ", empVO);
		String emplNo = empVO.getEmplNo();
		log.info("emplNo : ", emplNo);

		// 결재대기문서목록
		List<AtrzVO> atrzApprovalList = atrzService.atrzApprovalList(emplNo);
		model.addAttribute("atrzApprovalList", atrzApprovalList);

		// 기안진행 문서 기안중에 문서에 해당 기안일시 최신순으로 10개만 출력
		List<AtrzVO> atrzSubmitList = atrzService.atrzSubmitList(emplNo);
		model.addAttribute("atrzSubmitList", atrzSubmitList);

		//기안진행문서 최신순 5개만 보여주기
		List<AtrzVO> atrzMinSubmitList = atrzService.atrzMinSubmitList(emplNo);
		model.addAttribute("atrzMinSubmitList",atrzMinSubmitList);
		
		//기안완료문서 최신순 5개만 보여주기
		List<AtrzVO> atrzMinCompltedList = atrzService.atrzMinCompltedList(emplNo);
		model.addAttribute("atrzMinCompltedList",atrzMinCompltedList);
		
		
		
		
		
		// 기안완료된 문서에 해당 완료일시 최신순으로 10개만 출력
		List<AtrzVO> atrzCompletedList = atrzService.atrzCompletedList(emplNo);
		model.addAttribute("atrzCompletedList", atrzCompletedList);

		model.addAttribute("title", "전자결재");
		return "atrz/home";
	}

	// 전자결재 문서함
	@GetMapping("/approval")
	public String approvalList(Model model, @AuthenticationPrincipal CustomUser customUser,
			@RequestParam(defaultValue = "1") int total, @RequestParam(defaultValue = "1") int currentPage,
			@RequestParam(defaultValue = "10") int size) {
		//페이징 처리를 위한 
//		ArticlePage<AttachFileVO> articlePage = new ArticlePage<>(total, currentPage, size);
//		List<AttachFileVO> fileAttachList = attachFileService.getFileAttachList(1);
		// 로그인한 사람정보 가져오기(사번 이름)
		EmployeeVO empVO = customUser.getEmpVO();
		String emplNo = empVO.getEmplNo();
		
		
		// 결재대기문서목록
		List<AtrzVO> atrzApprovalList = atrzService.atrzApprovalList(emplNo);
		model.addAttribute("atrzApprovalList", atrzApprovalList);
		
		//참조대기문서
		List<AtrzVO> atrzReferList = atrzService.atrzReferList(emplNo);
		model.addAttribute("atrzReferList", atrzReferList);
		//참조대기의 경우에는 권한을 확인해서 버튼이 보이지 않게 만들어야한다.
		
		
		//결재예정문서
		List<AtrzVO> atrzExpectedList = atrzService.atrzExpectedList(emplNo);
		model.addAttribute("atrzExpectedList", atrzExpectedList);
		
		return "atrz/approval";

	}

	@GetMapping("/document")
	public String documentList(Model model, @AuthenticationPrincipal CustomUser customUser) {
		// 로그인한 사람정보 가져오기(사번 이름)
		EmployeeVO empVO = customUser.getEmpVO();
		String emplNo = empVO.getEmplNo();
		log.info("documentList-> emplNo : "+emplNo);

		//여기에 표시될것
		//기안문서함
		//기안문서함의 경우에는 내가 기안 한  목록이 표시된다.
		List<AtrzVO> atrzAllSubmitList = atrzService.atrzAllSubmitList(emplNo);
		model.addAttribute("atrzAllSubmitList",atrzAllSubmitList);
		
		//임시저장함(로그인한 사람의 아이디를 받아서 select한다.)
		List<AtrzVO> atrzStorageList = this.atrzService.atrzStorageList(emplNo);
		model.addAttribute("atrzStorageList",atrzStorageList);
		//결재문서함
		//결재문서함의 경우에는 결재선에 내가 포함되어있는 문서만 확인된다.
		List<AtrzVO> atrzAllApprovalList = atrzService.atrzAllApprovalList(emplNo);
		model.addAttribute("atrzAllApprovalList",atrzAllApprovalList);
		
		model.addAttribute("title", "전자결재문서함");
		return "atrz/documentBox";
	}
	
	
	
	
	@GetMapping("/companion")
	public String companionList(Model model, @AuthenticationPrincipal CustomUser customUser) {
		// 로그인한 사람정보 가져오기(사번 이름)
		EmployeeVO empVO = customUser.getEmpVO();
		String emplNo = empVO.getEmplNo();
		log.info("documentList-> emplNo : "+emplNo);
		
		List<AtrzVO> atrzCompanionList = atrzService.atrzCompanionList(emplNo);
		model.addAttribute("atrzCompanionList",atrzCompanionList);
		
		
		
		model.addAttribute("title", "반려문서함");
		return "atrz/companion";
		
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

	
	
	
	// 전자결재 상세보기
	@GetMapping("/selectForm/atrzDetail")
	public String selectAtrzDetail(@RequestParam String atrzDocNo, Model model
			,@AuthenticationPrincipal CustomUser customUser) {
		// 로그인한 사람정보 가져오기(사번 이름)
		EmployeeVO empVO = customUser.getEmpVO();
		String empNo = empVO.getEmplNo();
		log.info("로그인 사용자 사번: "+ empNo); 
		
		if (atrzDocNo == null || atrzDocNo.isEmpty()) {
			return "redirect:/error"; // 유효하지 않은 문서번호
		}

		char docPrefix = atrzDocNo.charAt(0); // 예: H, S, D, A, B, C, R
		//상세정보를 가져오기 위한것
		AtrzVO atrzVO = atrzService.getAtrzDetail(atrzDocNo);
		log.info("selectAtrzDetail->atrzVO: " + atrzVO);
		
		String drafterEmplNo = atrzVO.getDrafterEmpno();
		EmployeeVO drafterInfo = organizationService.emplDetail(drafterEmplNo);
		atrzVO.setEmplNm(drafterInfo.getEmplNm());
		
		//직급 코드를 통해 직급 얻기  직급명 , 부서명셋팅
		String drafClsf = atrzVO.getDrafterClsf();
		String ClsfCodeNm = CommonCode.PositionEnum.INTERN.getLabelByCode(drafClsf);
		atrzVO.setClsfCodeNm(ClsfCodeNm);
		atrzVO.setDeptCodeNm(drafterInfo.getDeptNm());
		
		//기본권한 여부 :  기안자
		Boolean isAuthorize = false;   								//결재권한
		Boolean canView = empNo.equals(atrzVO.getDrafterEmpno());   //열람가능
		
		//결재선 처리  + 권한 체크
		List<AtrzLineVO> atrzLineVOList = atrzVO.getAtrzLineVOList();
		List<EmployeeVO> sanEmplVOList = new ArrayList<>();
		
		
		log.info("atrzLineVOList : "+atrzLineVOList);
		for(AtrzLineVO atrzLineVO : atrzLineVOList) {
			String atrzTy = atrzLineVO.getAtrzTy();    //N이면 결재자  Y면 참조자
			//결재자, 대결재, 전결자 권한 체크 
			//접근 해지
			
			if("N".equals(atrzTy)) {
				if(	empNo.equals(atrzLineVO.getSanctnerEmpno())
				|| empNo.equals(atrzLineVO.getContdEmpno())
				|| empNo.equals(atrzLineVO.getDcrbManEmpno())) {
					log.info("결재 권한 있음 - 사용자 사번: "+ empNo);
					isAuthorize = true;
				}
			} else {
				if(empNo.equals(atrzLineVO.getSanctnerEmpno())
				|| empNo.equals(atrzLineVO.getContdEmpno())
				|| empNo.equals(atrzLineVO.getDcrbManEmpno())){
					log.info("결재 권한 있음 - 사용자 사번: "+ empNo);
					isAuthorize = true;
				}
			}
			log.info("ATRZ_TY: "+ atrzLineVO.getAtrzTy());
			log.info("결재자 사번(SANCTNER_EMPNO): "+ atrzLineVO.getSanctnerEmpno());
			log.info("대결자 사번(CONTD_EMPNO): "+ atrzLineVO.getContdEmpno());
			log.info("전결자 사번(DCRB_MAN_EMPNO): "+ atrzLineVO.getDcrbManEmpno());
			//참조자든 결재자든 누구든 열람가능
			if(!canView &&(
					empNo.equals(atrzLineVO.getAftSanctnerEmpno())
					|| empNo.equals(atrzLineVO.getContdEmpno())
					|| empNo.equals(atrzLineVO.getDcrbManEmpno()))) {
				log.info("문서 열람 권한 있음 - 사용자 사번: "+ empNo);
				canView = true;
			}
			
			if(!canView && "N".equals(atrzTy)) {
				canView = true; //참조자의 경우에는 열람만 가능
			}
			
//			//열람 권한이 없는 경우만 막기
//			if(!canView) {
//				return "redirect:/error";
//			}
			
			//결재자 이름 / 직급 셋팅
			String sancterEmpNo = atrzLineVO.getSanctnerEmpno();
			EmployeeVO sanEmplVO =organizationService.emplDetail(sancterEmpNo);
			sanEmplVOList.add(sanEmplVO);
			
			//직급명 이름 설정
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
		
		int curAtrzLnSn = atrzLineVOList.stream()
			    .filter(vo -> "N".equals(vo.getAtrzTy()) && "00".equals(vo.getSanctnProgrsSttusCode()))
			    .mapToInt(AtrzLineVO::getAtrzLnSn)
			    .min()
			    .orElse(-1); // -1이면 더 이상 결재할 사람 없음

			model.addAttribute("curAtrzLnSn", curAtrzLnSn);
		
		
		//연차상세정보 셋팅
		atrzVO.setHolidayVO(atrzService.holidayDetail(atrzDocNo));
		//권한 여부는 model로 넘겨서  화면에서 결재버튼 노출여부 조절
		model.addAttribute("isAuthorize", isAuthorize);
		model.addAttribute("sanEmplVOList",sanEmplVOList);
		model.addAttribute("atrzVO", atrzVO);
		model.addAttribute("employeeVO", drafterInfo);
		
		//제목설정을 위한것
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
	
	//뷰설정을 위한것
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
	@PostMapping("selectForm/atrzDetailAppUpdate")
	public String atrzDetailAppUpdate(AtrzVO atrzVO,
			Model model,@AuthenticationPrincipal CustomUser customUser) {
		// 로그인한 사람정보 가져오기(사번 이름)
		EmployeeVO empVO = customUser.getEmpVO();
		String emplNo = empVO.getEmplNo();
		
		atrzVO.setEmplNo(emplNo);
		
		int atrzAppUpdateResult = atrzService.atrzDetailAppUpdate(atrzVO);
		
		log.info("atrzDetailUpdate-> atrzVO : "+atrzVO);

		return "success";
	}
	
	//전자결재 반려시 
	@ResponseBody
	@PostMapping("selectForm/atrzDetilCompUpdate")
	public String atrzDetilCompUpdate(AtrzVO atrzVO, Model model
			,@AuthenticationPrincipal CustomUser customUser	) {
		
		// 로그인한 사람정보 가져오기(사번 이름)
		EmployeeVO empVO = customUser.getEmpVO();
		String emplNo = empVO.getEmplNo();
		
		atrzVO.setEmplNo(emplNo);
		int atrzCompUpdateResult = atrzService.atrzDetilCompUpdate(atrzVO);
		
		log.info("atrzDetilCompUpdate-> atrzVO : "+atrzVO);
		return "success";
	}
	
	//전자결재 기안취소
	@ResponseBody
	@PostMapping("selectForm/atrzCancelUpdate")
	public String atrzCancelUpdate(AtrzVO atrzVO, Model model
			,@AuthenticationPrincipal CustomUser customUser) {
		
		// 로그인한 사람정보 가져오기(사번 이름)
		EmployeeVO empVO = customUser.getEmpVO();
		String emplNo = empVO.getEmplNo();
		atrzVO.setEmplNo(emplNo);
		
		int atrzCancelResult= atrzService.atrzCancelUpdate(atrzVO);
		log.info("atrzCancleUpdate-> atrzCancelResult : "+atrzCancelResult);
		
		
		return atrzCancelResult > 0 ? "success" : "fail";
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
	//연차신청서 임시저장 불러오기 
	@GetMapping("selectForm/getAtrzStorage")
	public String getAtrzStorage(@RequestParam String atrzDocNo, Model model
			,@AuthenticationPrincipal CustomUser customUser) {
		// 로그인한 사람정보 가져오기(사번 이름)
		EmployeeVO empVO = customUser.getEmpVO();
		String empNo = empVO.getEmplNo();
		log.info("로그인 사용자 사번: "+ empNo); 
		
		AtrzVO atrzVO = atrzService.getAtrzStorage(atrzDocNo);
		
		model.addAttribute("atrzVO",atrzVO);
		model.addAttribute("empVO",empVO);
		
		char docPrefix = atrzDocNo.charAt(0); // 예: H, S, D, A, B, C, R
		
		String viewName = switch (docPrefix){
		case 'H' -> "documentForm/holidayStorage";            // 연차신청서
		case 'S' -> "documentForm/spendingStorage";           // 지출결의서
		case 'D' -> "documentForm/draftStorage";              // 기안서
		case 'A' -> "documentForm/salaryStorage";         // 급여명세서
		case 'B' -> "documentForm/bankAccountStorage";      // 급여계좌변경신청서
		case 'C' -> "documentForm/employmentCertStorage";     // 재직증명서
		case 'R' -> "documentForm/resignStorage";             // 퇴직신청서
		default -> "redirect:/error";                        // 알 수 없는 양식
		};
		
		return viewName;
	}
	//결재선 업데이트
	
	
	
	//임시저장 연차신청서  업데이트()
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
	
	//연차신청서 임시저장
	@ResponseBody
	@PostMapping(value = "atrzHolidayStorage")
	public String atrzHolidayStorage(
			AtrzVO atrzVO
			, @RequestPart("atrzLineList") List<AtrzLineVO> atrzLineList
			, @RequestPart("docHoliday") HolidayVO documHolidayVO
			) {
		log.info("atrzHolidayStorage->atrzVO : " + atrzVO);
		log.info("atrzHolidayStorage->atrzLineList : " + atrzLineList);
		log.info("atrzHolidayStorage->documHolidayVO : " + documHolidayVO);
		
		EmployeeVO emplDetail = organizationService.emplDetail(atrzVO.getEmplNo());
		// 여기서 VO를 하나 씩 담아야 하는건가...싶다.
		atrzVO.setClsfCode(emplDetail.getClsfCode());
		atrzVO.setDeptCode(emplDetail.getDeptCode());
		
		int result = atrzService.atrzHolidayStorage(atrzVO, atrzLineList, documHolidayVO);
		
		return result > 0 ? "임시저장성공" : "실패";
	}
	
	//임시저장후 결재선 인서트(업데이트처럼 활용)
	@ResponseBody
	@PostMapping(value = "updateAtrzLine")
	public AtrzVO updateAtrzLine(@ModelAttribute AtrzVO atrzVO 	, @RequestParam(required = false)String[] emplNoArr , Model model
			,@RequestParam(required = false) String[] authList, @AuthenticationPrincipal CustomUser customUser) {
		List<String> appLinelist = new ArrayList<String>();
		log.debug("updateAtrzLine->emplNoArr : "+ Arrays.toString(emplNoArr)); // 결재자(o)
		log.debug("updateAtrzLine->atrzVO : "+ atrzVO); // 결재문서
		log.debug("updateAtrzLine->authList : "+ Arrays.toString(authList)); // 참조자
		
		
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
		        List<Map<String, Object>> authMapList = objectMapper.readValue(authListStr, new TypeReference<List<Map<String, Object>>>() {});

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

		log.info("updateAtrzLine->atrzDocNo : "+atrzDocNo);
		
		
		// 로그인한 사람정보 가져오기(사번 이름)
		EmployeeVO empVO = customUser.getEmpVO();
		String empNo = empVO.getEmplNo();
		//임시저장 문서번호 set하기 
		atrzVO.setAtrzDocNo(atrzDocNo);
		log.info("updateAtrzLine->atrzVO(문서번호 생성 후) : " + atrzVO);
		
		
		atrzVO.setEmplNo(empNo);
		//문서조회
//		String atrzDocNo = atrzVO.getAtrzDocNo();
		log.info("updateAtrzLine->atrzVO"+atrzVO);
		List<AtrzLineVO> atrzLineList = atrzVO.getAtrzLineVOList();
		atrzMapper.deleteAtrzLineByDocNo(atrzDocNo);
		for(AtrzLineVO atrzLineVO : atrzLineList) {
			atrzLineVO.setAtrzDocNo(atrzDocNo);
			atrzService.updateAtrzLine(atrzLineVO);
			log.info("📝 결재선 - empno: {}, code: {}, ty: {}, authorYn: {}, lnSn: {}",
			atrzLineVO.getSanctnerEmpno(), atrzLineVO.getSanctnerClsfCode(),
			atrzLineVO.getAtrzTy(), atrzLineVO.getDcrbAuthorYn(), atrzLineVO.getAtrzLnSn());
			
		}
		log.info("updateAtrzLine->atrzVO : "+atrzVO);
		return atrzService.getAtrzStorage(atrzDocNo);
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
