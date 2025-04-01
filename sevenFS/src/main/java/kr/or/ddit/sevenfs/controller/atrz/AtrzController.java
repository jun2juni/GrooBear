package kr.or.ddit.sevenfs.controller.atrz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.sevenfs.service.atrz.AtrzService;
import kr.or.ddit.sevenfs.vo.atrz.AtrzVO;
import kr.or.ddit.sevenfs.vo.atrz.DraftVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/atrz")
public class AtrzController {

	@Autowired
	AtrzService atrzService;

	@GetMapping("/home")
	public String home(Model model) {
		List<AtrzVO> atrzVOList = this.atrzService.list();
		model.addAttribute("atrzVOList", atrzVOList);
		log.info("전자결재홈");
		return "atrz/home";
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
	public String insertDoc(@RequestParam(name = "form" ,required = false)String form, ModelAndView mav,Model model) {
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
