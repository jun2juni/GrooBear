package kr.or.ddit.sevenfs.controller.atrz;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import kr.or.ddit.sevenfs.service.AttachFileService;
import kr.or.ddit.sevenfs.service.atrz.AtrzService;
import kr.or.ddit.sevenfs.service.organization.OrganizationService;
import kr.or.ddit.sevenfs.vo.CustomUser;
import kr.or.ddit.sevenfs.vo.atrz.AtrzLineVO;
import kr.or.ddit.sevenfs.vo.atrz.AtrzVO;
import kr.or.ddit.sevenfs.vo.atrz.HolidayVO;
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

	//파일 전송을 위한 방법
	@Autowired
	private AttachFileService attachFileService;


	@GetMapping("/home")
	public String homeList(Model model, HttpServletRequest req, @AuthenticationPrincipal CustomUser customUser) {
		// 로그인한 사람정보 가져오기(사번 이름)
		EmployeeVO empVO = customUser.getEmpVO();
		log.info("empVO : ", empVO);
		String emplNo = empVO.getEmplNo();
		log.info("emplNo : ", emplNo);
			
		
		//여기는 결재 대기문서
		List<AtrzVO> atrzApprovalList = atrzService.atrzApprovalList(emplNo);
		//결재대기문서의 기안자상세정보 따로 코드를 통해 넣어줘야 함
		EmployeeVO employeeVO;
		for(AtrzVO atrzVO : atrzApprovalList) {
			String drafterEmpNo=  atrzVO.getDrafterEmpno();
			employeeVO = organizationService.emplDetail(drafterEmpNo);
//			log.info("employeeVO (기안자 상세정보를 위하여): "+employeeVO);
			//직급코드 atrzVO담기
			atrzVO.setClsfCodeNm(employeeVO.getClsfCodeNm());
			atrzVO.setDeptCodeNm(employeeVO.getDeptNm());
//			log.info("atrzVO (기안자 상세정보 추가): "+atrzVO);
			
		}
		//여기는 내가 결재차례인경우에 해당
		model.addAttribute("atrzApprovalList", atrzApprovalList);
		
		//가안중에 문서에 해당 기안일시 최신순으로 10개만 출력
		List<AtrzVO> atrzSubmitList = atrzService.atrzSubmitList(emplNo);
		for(AtrzVO atrzVO : atrzSubmitList) {
			String drafterEmpNo=  atrzVO.getDrafterEmpno();
			employeeVO = organizationService.emplDetail(drafterEmpNo);
			atrzVO.setClsfCodeNm(employeeVO.getClsfCodeNm());
			atrzVO.setDeptCodeNm(employeeVO.getDeptNm());
		}
		model.addAttribute("atrzSubmitList", atrzSubmitList);
		
		//기안완료된 문서에 해당 완료일시 최신순으로 10개만 출력
		List<AtrzVO> atrzCompletedList = atrzService.atrzCompletedList(emplNo);
		for(AtrzVO atrzVO : atrzCompletedList) {
			String drafterEmpNo=  atrzVO.getDrafterEmpno();
			employeeVO = organizationService.emplDetail(drafterEmpNo);
			atrzVO.setClsfCodeNm(employeeVO.getClsfCodeNm());
			atrzVO.setDeptCodeNm(employeeVO.getDeptNm());
		}
		
		model.addAttribute("atrzCompletedList", atrzCompletedList);

		model.addAttribute("title","전자결재");
		return "atrz/home";
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

		//문서양식코드를 위한것
		String df_code = "";      // 문서 양식 코드
	    String docPrefix = "";    // 전자결재문서번호 접두어
	    AtrzVO resultDoc = null;
		
		// 문서양식 테이블에 db저장
		int result = 0;
		// 선택한 문서 양식이 "연차신청서"일 경우
		if ("연차신청서".equals(form)) {
//			result = atrzService.insertHoDoc();
			//전자결재문서번호를 양식선택시 생성해서 insert해준다.
//			resultDoc =atrzService.selectDoc(df_code);
			//남은 휴가일수 확인(사원번호를 가져와야함)
//			Double checkHo = atrzService.readHoCnt();
//			model.addAttribute("checkHo",checkHo);
			//문서양식번호 띄울 정보
//			model.addAttribute("resultDoc",resultDoc);
			//여기서 이 결과 값을 documentForm/holiday에 보내야함
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
			
		} else if ("급여통장변경신청서".equals(form)) {
			df_code = "E";
			return "급여통장변경신청서";
			
		}else if ("재직증명서".equals(form)) {
			df_code = "F";
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
	// 연차신청서 상세보기
	@GetMapping("selectForm/holidayDetail")
	public String holidayDetail(Model model, @RequestParam(value = "holiActplnNo", required = true) int holiActplnNo,
			HolidayVO documHolidayVO) {
		log.info("holidayDetail-> holiActplnNo :"+holiActplnNo);
		
		documHolidayVO = this.atrzService.holidayDetail(holiActplnNo);
		
		model.addAttribute("title", "연차신청서 상세보기");
		model.addAttribute("documHolidayVO",documHolidayVO);
		log.info("selectHolidayDetail-> documHolidayVO : "+documHolidayVO);
		return "documentForm/holidayDetail";
		
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
	@PostMapping(value = "/insertAtrzEmp", produces = "application/json;charset=UTF-8")
	public EmployeeVO insertAtrzEmp(
			@RequestParam(name = "emplNo", required = false) String emplNo
		  , @RequestParam Map<String, List<String>> requestData, Model model) {
		// insertDoc->form : 연차신청서
		// appLineEmp->emplNo : 20250000
		//appLineEmp->emplNo :
		log.info("appLineEmp->emplNo : " + emplNo);

		// 여기서 사원번호를 꺼내서 사원 디테일까지가져옴
		EmployeeVO emplDetail = organizationService.emplDetail(emplNo);
		//appLineEmp->emplDetail : null
		log.info("appLineEmp->emplDetail : " + emplDetail);

		log.info("appLineEmp->emplDetailNm.getDeptNm : " + emplDetail.getDeptNm());
		log.info("appLineEmp->emplDetailNm.getPosNm : " + emplDetail.getPosNm());
		
		return emplDetail;
	}

	
	//모달에서 선택한 결재선이 비동기로 담아서 보내서 확인해야함
	@ResponseBody
	@PostMapping(value = "insertAtrzLine")
	public List<EmployeeVO> insertAtrzLine(
							String[] emplNoArr,	HttpServletRequest req, Model model,
							String[] empNoList,	String[] empAttNoList,String[] authList
							) {
		
		List<String> appLinelist = new ArrayList<String>();
		
		log.debug("empNoList {}", Arrays.toString(empNoList)); // 결재자
		log.debug("empAttNoList {}", Arrays.toString(empAttNoList)); // 참조자
		
		for(String emplNo : emplNoArr) {
			//selectAppLineList->emplNo : 20250008
			//selectAppLineList->emplNo : 20250016
			log.info("selectAppLineList->emplNo : " + emplNo);
			
			
			appLinelist.add(emplNo);
		}
		
		//여기서 결재자와 참조자를 나눠야 한다.
		log.info("empNoList: " +Arrays.toString(empNoList));
		log.info("empAttNoList : " +Arrays.toString(empAttNoList));
		
//		해당 직원의 상세정보 목록을 select
		List<EmployeeVO> emplDetailList = organizationService.emplDetailList(appLinelist);
		log.info("selectAppLineList->emplDetailList : " + emplDetailList);
		
		//여기서 담아서 보내야함
		return emplDetailList;
		
	}
	
	
	@ResponseBody
	@PostMapping(value = "atrzHolidayInsert")
	public String insertHolidayForm(AtrzVO atrzVO,
			     @RequestPart("atrzLineList")List<AtrzLineVO> atrzLineList, 
			     @RequestPart("docHoliday") HolidayVO documHolidayVO
			    ){
		
		log.info("atrz {}",atrzVO);
		log.info("atrzLineList {}",atrzLineList);
		log.info("documHolidayVO {}",documHolidayVO);
		
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
		//전자결재 테이블 등록
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
	    
		//연차신청서 등록
		int documHolidayResult = atrzService.insertHoliday(documHolidayVO);
		
		
		return "쭈니성공";
	}
	
	
	@ResponseBody
	@PostMapping(value = "atrzSpendingInsert")
	public String insertSpendingForm(AtrzVO atrzVO,
			     @RequestPart("atrzLineList")List<AtrzLineVO> atrzLineList, 
			     SpendingVO spendingVO){
		
		/*emplNo = drafterEmpno : 기안자 사번 / emplNm = drafterEmpnm : 기안자 명
		AtrzVO(atrzDocNo=null, drafterEmpno=null, drafterClsf=null, drafterEmpnm=null, drafterDept=null, bkmkYn=null, 
		atchFileNo=0, atrzSj=미리작성한 제목입니다., atrzCn=ㅁㄴㅇㄹ, atrzOpinion=null, atrzTmprStreDt=null, atrzDrftDt=null, 
		atrzComptDt=null, atrzRtrvlDt=null, atrzSttusCode=null, eltsgnImage=null, docFormNo=2, atrzDeleteYn=null, 
		schdulRegYn=null, docFormNm=S, emplNo=20250004, emplNm=null, clsfCode=null, clsfCodeNm=null, deptCode=null, deptCodeNm=null, 
		uploadFile=null, atrzLineVOList=null, type=null, keyword=null, drafts=null, empAtrzVO=null, documHolidayVO=null, spendingVO=null)
		 */
		atrzVO.setDrafterEmpno(atrzVO.getEmplNo());
		
		log.info("atrzSpendingInsert-> atrz : "+atrzVO);
		/*
		atrzLineList : [AtrzLineVO(atrzDocNo=null, atrzLnSn=1, sanctnerEmpno=20250000, sanctnerClsfCode=null, 
		contdEmpno=null, contdClsfCode=null, dcrbManEmpno=null, dcrbManClsfCode=null, atrzTy=N, sanctnProgrsSttusCode=null, 
		dcrbAuthorYn=0, contdAuthorYn=null, sanctnOpinion=null, eltsgnImage=null, sanctnConfmDt=null, 
		atrzLineList=null), 
		AtrzLineVO(atrzDocNo=null, atrzLnSn=2, sanctnerEmpno=20250020, sanctnerClsfCode=null, contdEmpno=null, contdClsfCode=null, 
		dcrbManEmpno=null, dcrbManClsfCode=null, atrzTy=N, sanctnProgrsSttusCode=null, dcrbAuthorYn=0, contdAuthorYn=null, sanctnOpinion=null, 
		eltsgnImage=null, sanctnConfmDt=null, atrzLineList=null), 
		AtrzLineVO(atrzDocNo=null, atrzLnSn=3, sanctnerEmpno=20250008, sanctnerClsfCode=null, contdEmpno=null, contdClsfCode=null,
		 dcrbManEmpno=null, dcrbManClsfCode=null, atrzTy=N, sanctnProgrsSttusCode=null, dcrbAuthorYn=1, contdAuthorYn=null, sanctnOpinion=null, 
		 eltsgnImage=null, sanctnConfmDt=null, atrzLineList=null)]
		 */
		log.info("atrzSpendingInsert-> atrzLineList : "+atrzLineList);
		/*
		 SpendingVO(spendingReportNo=0, atrzDocNo=null, expenseOrder=0, expenseDate=null, itemDescription=null, 
		 itemQuantity=0, itemAmount=null, paymentMethod=null, atrzLineVOList=null, atrzVO=null)
		 */
		log.info("atrzSpendingInsert-> spendingVO : "+spendingVO);
		
		
		EmployeeVO emplDetail = organizationService.emplDetail(atrzVO.getEmplNo());
		
		log.info("insertSpendingForm->emplDetail : "+emplDetail);
		//여기서 VO를 하나 씩 담아야 하는건가...싶다. 
		String clsfCode = emplDetail.getClsfCode();
		String deptCode = emplDetail.getDeptCode();
		atrzVO.setClsfCode(clsfCode);
		atrzVO.setDeptCode(deptCode);
		
		log.info("insertSpendingForm-> atrzVO(사원추가후) : "+atrzVO);
		
		//전자결재 테이블 등록
		int atrzResult = atrzService.insertAtrz(atrzVO);
		
		//전자결재 문서번호등록
		String atrzDocNo = atrzVO.getAtrzDocNo();
		log.info("insertSpendingForm-> atrzDocNo :  문서번호 등록 : "+atrzDocNo);
		//변수에 있는 문서번호를 넣어주기 atrzLineVO에 넣어주기
		for(AtrzLineVO atrzLineVO : atrzLineList) {
			atrzLineVO.setAtrzDocNo(atrzDocNo);
			log.info("atrzLineVO :  문서번호 등록후 : "+atrzLineVO);	
			atrzService.insertAtrzLine(atrzLineVO);
		}
		
		//문서번호등록
		spendingVO.setAtrzDocNo(atrzDocNo);
		log.info("spendingVO :  문서번호 등록후 : "+spendingVO);	
		//지출결의서 등록
		int documSpendingResult = atrzService.insertSpending(spendingVO);
		
		return "쭈니성공";
	}

}
