package kr.or.ddit.sevenfs.controller.atrz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import kr.or.ddit.sevenfs.service.atrz.AtrzService;
import kr.or.ddit.sevenfs.service.organization.OrganizationService;
import kr.or.ddit.sevenfs.utils.CommonCode;
import kr.or.ddit.sevenfs.vo.CommonCodeVO;
import kr.or.ddit.sevenfs.vo.CustomUser;
import kr.or.ddit.sevenfs.vo.atrz.AtrzVO;
import kr.or.ddit.sevenfs.vo.atrz.DraftVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/atrz")
public class AtrzController {

	@Autowired
	AtrzService atrzService;
	
	//사원 정보를 위해 가져온것
	@Autowired
	OrganizationService organizationService;
	
	//공통코드 텍스트를 가져오기위한것
	@Autowired
	CommonCode commonCode;

	
	
	//로그인한 정보 가져오기
	@GetMapping("/some-path")
    public String someMethod(@AuthenticationPrincipal CustomUser customUser) {
    EmployeeVO empVO = customUser.getEmpVO();
    String emplNo = empVO.getEmplNo();
    // empVO 사용
    return "view";
}
	
	
	@GetMapping("/home")
	public String home(Model model,
			HttpServletRequest req,
			@AuthenticationPrincipal CustomUser customUser) {
		//로그인한 사람정보 가져오기(사번 이름)
		EmployeeVO empVO = customUser.getEmpVO();
	    String emplNo = empVO.getEmplNo();
		log.info("emplNo : " ,emplNo);
//		String emplNm = employeeVO.getEmplNm();
		
		//결재대기문서 갯수
		int beDocCnt = atrzService.beDocCnt(emplNo);
		model.addAttribute("beDocCnt",beDocCnt);
		
		//전자 결재대기
		List<AtrzVO> homeBeDoc = atrzService.selectHomeBeDoc(emplNo);
		model.addAttribute("homeBeDoc",homeBeDoc);
		
		//기안진행문서
		List<AtrzVO> homeReqDoc = atrzService.selectHomeReqDoc(emplNo);
		model.addAttribute("homeReqDoc",homeReqDoc);
		
		//결재수신문서갯수
		int recDocCnt = atrzService.recDocCnt(emplNo);
		model.addAttribute("recDocCnt" ,recDocCnt);
		
		
		List<AtrzVO> atrzVOList = this.atrzService.list();
		model.addAttribute("atrzVOList", atrzVOList);
		
		//사원정보 가져오는것 산나님 EmployeeVO에 추가한것있음 나중에 첫글자 소문자로 변경해야함
		List<AtrzVO> atrzEmploInfo = this.atrzService.atrzEmploInfo();
		model.addAttribute("atrzEmploInfo",atrzEmploInfo);
		
		log.info("전자결재홈");
		return "atrz/home";
	}
	
	//결재대기문서
	@GetMapping("/beforeDoc")
	public String selectBeforeDoc(
			Model model,
			HttpServletRequest req,
			@RequestParam(name = "page",defaultValue = "1")int currentPage,
			@RequestParam(name = "type", required = false)String type,
			@RequestParam(name = "keyword", required = false)String keyword, AtrzVO atrzVO) {
		
			//로그인한 사람정보 가져오기(사번 이름)
			EmployeeVO employeeVO = (EmployeeVO)req.getSession().getAttribute("login");
			String emplNo = employeeVO.getEmplNo();
			
			
//			ArticlePage<AtrzVO> articlePage = new ArticlePage<>()
			atrzVO.setDrafterEmpno(emplNo);
			atrzVO.setType(type);
			atrzVO.setKeyword(keyword);
			
			
			
//			ArticlePage<AtrzVO> articlePage = new ArticlePage<>()
			final int pageSize = 6;
			final int pageBlock = 2;
			List<AtrzVO> beforeDoc = atrzService.selectBeforeDoc(currentPage,pageSize, atrzVO);
			
			int totalCnt = (keyword == null || keyword.isEmpty()) ?  atrzService.beforeTotalCnt(atrzVO) : beforeDoc.size(); 
			
			// paging 처리
		    int pageCnt = totalCnt / pageSize + (totalCnt % pageSize == 0 ? 0 : 1);
		    int startPage = (currentPage % pageBlock == 0) ? 
		                    ((currentPage / pageBlock) - 1) * pageBlock + 1 :
		                    (currentPage / pageBlock) * pageBlock + 1;
		    int endPage = Math.min(startPage + pageBlock - 1, pageCnt);
		    
		    model.addAttribute("startPage", startPage);
		    model.addAttribute("endPage", endPage);
		    model.addAttribute("pageCnt", pageCnt);
		    model.addAttribute("totalCnt", totalCnt);
		    model.addAttribute("currentPage", currentPage);
		    model.addAttribute("beforeDoc", beforeDoc);
		
		    return "atrz/beforeDoc";
	}
	
	
	//결재 수신문서
	@GetMapping("/receiptdoc")
	public String selectReceiptDoc( Model model,
	        HttpServletRequest req,
	        @RequestParam(name="page", defaultValue = "1") int currentPage,
	        @RequestParam(name="type", required = false) String type,
	        @RequestParam(name="keyword", required = false) String keyword,
	        AtrzVO atrzVO) {
		
		//로그인한 사람정보 가져오기(사번)
		EmployeeVO employeeVO = (EmployeeVO)req.getSession().getAttribute("login");
		String emplNo = employeeVO.getEmplNo();
		
		atrzVO.setDrafterEmpno(emplNo);
		atrzVO.setType(type);
		atrzVO.setKeyword(keyword);

	    final int pageSize = 6;
	    final int pageBlock = 2;
	    
	    List<AtrzVO> receiptDoc = atrzService.selectReceiptDoc(currentPage,pageSize,atrzVO);
	    
	    int totalCnt = (keyword == null|| keyword.isEmpty()) ? atrzService.receiptTotalCnt(atrzVO) : receiptDoc.size();
	    
	    // paging 처리
	    int pageCnt = totalCnt / pageSize + (totalCnt % pageSize == 0 ? 0 : 1);
	    int startPage = (currentPage % pageBlock == 0) ? 
	                    ((currentPage / pageBlock) - 1) * pageBlock + 1 :
	                    (currentPage / pageBlock) * pageBlock + 1;
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
	public String approvalList(Model model) {
		List<AtrzVO> atrzVOList = this.atrzService.list();
		model.addAttribute("title", "목록출력");
		model.addAttribute("atrzVOList", atrzVOList);
		log.info("결재하기 출력되낭?");
		return "atrz/approval";
	}
	@GetMapping("/document")
	public String documentList(Model model) {
		List<AtrzVO> atrzVOList = this.atrzService.list();
		model.addAttribute("title", "목록출력");
		model.addAttribute("atrzVOList", atrzVOList);
		log.info("개인문서함출력되낭?");
		return "atrz/documentBox";
	}

	// 휴가신청서 양식조회
	@GetMapping("/selectForm/holidayForm")
	public String selectHolidayForm() {
		return "documentForm/holidayForm";
	}

	// 휴가신청서 입력양식
	@GetMapping("/selectForm/holiday")
	public String selectHoliday(Model model) {
		model.addAttribute("title", "휴가신청서");
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
	
	// 2) 기안서 전송양식
	@PostMapping("/draft/insert")
	public String draftInsert(DraftVO draftVO
			//파일등록추가
			) {
		//draftInsert->draftVO(insert전) : DraftVO(title=sfadadfs, content=sadfsdafd, draftNo=null)
		log.info("draftInsert->draftVO(insert전) : " + draftVO);
		int result = this.atrzService.draftInsert(draftVO);
		log.info("selectDraftInsert-> result : "+result);
		//draftVO(insert 후) : DraftVO(title=asddfs, content=sdafasdfdsfasdfsdaf, draftNo=1)
		log.info("selectDraftInsert-> draftVO(insert 후) : "+draftVO);
		
		//1. 상세보기가 없음
		//2. 상세보기로 들어가야 함
		//3. 한 양식당 jsp가 2개가 만들어져있음( 1) input, 2) 보여주는 양식 미리보기 )
		return "redirect:/atrz/selectForm/draftDetail?draftNo="+draftVO.getDraftNo();
	}
	
	// 3) 기안서 상세
	@GetMapping("/selectForm/draftDetail")
	public String draftDetail(Model model, @RequestParam(value="draftNo",required=true) String draftNo) {
		log.info("draftDetail->draftNo : " + draftNo);
		
		//SELECT * FROM DRAFT WHERE DRAFT_NO = 2
		DraftVO draftVO = this.atrzService.draftDetail(draftNo);
		log.info("draftDetail->draftVO : " + draftVO);
		
		model.addAttribute("title", "기안서 상세보기");
		model.addAttribute("draftVO", draftVO);
		
		return "documentForm/draftDetail";
	}
	
	//양식선택후 확인 클릭시 입력폼 뿌려지고, DB의 데이터를 가져오는 작업
	@ResponseBody
	//여기선 modelAnd
	@PostMapping(value = "/insertDoc" ,produces = "text/plain;charset=UTF-8")
	public String insertDoc(@RequestParam(name = "form" ,required = false) String form, ModelAndView mav,Model model) {
		//insertDoc->form : 휴가신청서
		log.info("insertDoc->form : " + form);
		
		//공백 제거
		form = form.trim();
		
	//문서양식 테이블에 db저장
//			int result = 0;
		
		
		
		
		
//			String df_code = "";
		//선택한 양식이 휴가신청서인경우
//			if(form.equals("휴가신청서")) {
//				model.addAttribute("title","휴가신청서");
//				return "documentForm/holiday";
//			}else {
//				model.addAttribute("title","지출결의서");
//				return "documentForm/holiday";
//			}
	    // 선택한 문서 양식이 "휴가신청서"일 경우
	    if ("휴가신청서".equals(form)) {
//		    	mav.setViewName("documentForm/holiday"); // 휴가신청서 JSP 반환
	    	return "휴가신청서";
	    } else if("지출결의서".equals(form)){
//		    	mav.setViewName("documentForm/spending"); // 지출결의서 JSP 반환
	    	return "지출결의서";
	    }else {
	    	return "기안서";
	    }

		
	}
	
	//결재선지정 시 직원명 클릭하면 emplNo을 파라미터로 받아 DB select를 하여 JSON String으로 해당 직원 정보를 응답해줌
	//요청파라미터 : {"emplNo":emplNo}
	@ResponseBody
	@PostMapping(value = "/appLineEmp" ,produces = "application/json;charset=UTF-8")
	public EmployeeVO appLineEmp(@RequestParam(name = "emplNo" ,required = false) String emplNo
			,Model model
			) {
		//insertDoc->form : 휴가신청서
		//appLineEmp->emplNo : 20250000
		log.info("appLineEmp->emplNo : " + emplNo);
		
		
//		//이제 디테일을 가지고 공통코드에 가서 사원의 정보를 텍스트로 가져와야함
//		CommonCodeVO commonCodeDetail = organizationService.empDetailDep(emplNo);
		//여기서 사원번호를 꺼내서 사원 디테일까지가져옴
		EmployeeVO emplDetail =  organizationService.emplDetail(emplNo);
		
//		log.info("appLineEmp->commonCodeDetail : " + commonCodeDetail);
		log.info("appLineEmp->emplDetail : " + emplDetail);
		
		
		log.info("appLineEmp->emplDetailNm.getDeptNm : " + emplDetail.getDeptNm());
		log.info("appLineEmp->emplDetailNm.getPosNm : " + emplDetail.getPosNm());
	
		
		
		return emplDetail;
	}
	
	
//	@GetMapping("/{atrzDocNo}")
//	public String atrzDetail(
//			@PathVariable String atrzDocNo, Model model
//			) {
//		AtrzVO atrzVO = atrzService.atrzDetail(atrzDocNo);
//		
//		if(atrzVO != null) {
//			model.addAttribute("atrzVO",atrzVO);
//			return "documentForm/draftDetail";
//		}else {
//			return "errer/404";
//		}
//	}
	
//	public String insert() {
//	atrzService.insertFrom() ///xml
//	atrzService.insertapproLine(); //xml
//	}

}
