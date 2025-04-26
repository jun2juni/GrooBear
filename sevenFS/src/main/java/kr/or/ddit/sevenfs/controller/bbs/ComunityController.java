package kr.or.ddit.sevenfs.controller.bbs;

import java.security.Principal;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpSession;
import kr.or.ddit.sevenfs.service.AttachFileService;
import kr.or.ddit.sevenfs.service.bbs.BbsService;
import kr.or.ddit.sevenfs.service.bbs.ComunityService;
import kr.or.ddit.sevenfs.service.bbs.Impl.ComunityServiceImpl;
import kr.or.ddit.sevenfs.service.organization.impl.OrganizationServiceImpl;
import kr.or.ddit.sevenfs.utils.ArticlePage;
import kr.or.ddit.sevenfs.utils.AttachFile;
import kr.or.ddit.sevenfs.vo.AttachFileVO;
import kr.or.ddit.sevenfs.vo.bbs.BbsVO;
import kr.or.ddit.sevenfs.vo.bbs.ComunityVO;


// 썰풀사람 => log.info 를 통해서 console에 데이터흐름을 확인하기 위함
// 컨트롤러 스프링에게 이게 컨트롤러임을 가르쳐줌
//
@Slf4j
@Controller
@RequestMapping("/comunity")
public class ComunityController {
	
	@Value("${file.save.abs.path}")
	private String saveDir;
	
	@Autowired
	AttachFileService attachFileService;
	
	@Autowired
	ComunityServiceImpl comunityServiceImpl;
	
	@Autowired
	AttachFile attachFile;
	
	
	
	@GetMapping("/comunityClubList")
	public String comunityClubList(
									Model model,	
								   @ModelAttribute ComunityVO comunityVO,
								   Principal principal
								  ) {	
        
        
		List<ComunityVO> list = comunityServiceImpl.comunityClubList(comunityVO);
	    model.addAttribute("clubList", list);
	  
	    
	    String emplNo = principal.getName();  // 🔹 로그인된 사용자 아이디 갸져오기 (username)
	    comunityVO.setEmplNo(emplNo); // 🔹 로그인된 사용자 아이디 저장하기  (username)
	    model.addAttribute("loginEmplNo", emplNo);
		
		// sns임 
		return "comunity/comunityClubList";	
	} // comunityClubList (sns 스느스 클럽)
	
	//restController를 사용하지 않으니까 비동기 통신을 위해서 @ResponseBody를 사용해야함
	// 비동기 무한스크롤 데이터 요청 처리
	@ResponseBody
    @GetMapping("/clubListMore")
    public List<ComunityVO> getClubListMore(
            @RequestParam("offset") int offset,
            @RequestParam("limit") int limit) {

        ComunityVO comunityVO = new ComunityVO();
        comunityVO.setOffset(offset);
        comunityVO.setLimit(limit);

        List<ComunityVO> result = comunityServiceImpl.comunityClubListPaging(comunityVO);
        return result; // @RestController 덕분에 JSON 자동 응답됨!
    }
	
	
	// TTMI 게시판 
	@PostMapping("/insertTTMI")
	public String insertTTMI(@ModelAttribute ComunityVO comunityVO,
	                         @RequestParam("ttmiContent") String ttmiContent,
	                         Principal principal) {

	    if (principal == null) return "redirect:/auth/login";

	    comunityVO.setBbscttCn(ttmiContent);     
	    comunityVO.setBbsCtgryNo(14);            
	    comunityVO.setBbscttUseYn("N");
	    comunityVO.setEmplNo(principal.getName());

	    comunityServiceImpl.insertContent(comunityVO);  // 

	    return "redirect:/comunity/comunityClubList";
	}
	
	
	
	@PostMapping("/insertToday")
	public String insertTodayTTMi(@ModelAttribute ComunityVO comunityVO, Principal principal) {
			
		    // 세션에서 사번 가져오기
//	    	String emplNo = (String) session.getAttribute("emplNo");
	    	String emplNo = principal.getName(); // Principal 객체에서 사번 가져오기 
	    	
	    	log.info("세션에서 가져온 사번: " + emplNo);
	    	if (emplNo == null) {
	    	        // 세션에 사번 없으면 로그인 페이지로 보내기
	    	        return "redirect:/auth/login";
	    	 }
		
	    	comunityVO.setBbsCtgryNo(15); // 예시: insertTodayTTMi 전용 카테고리 번호
	    	comunityVO.setBbscttUseYn("N"); // 게시글 사용 여부
	    	comunityVO.setEmplNo(emplNo); // Principal 객체에서 사번 가져오기 , 임시값
		
		    comunityServiceImpl.insertContent(comunityVO);
		    
			// 입력 이후 => redirect를 통해서 상세보기로 가주려함 
		return  "redirect:/comunity/comunityClubList"; // 성공 시 리다이렉트
	} // insertTodayTTMi 삽입
	
	
	@PostMapping("/insertEmoji")
	public String insertEmoji(@ModelAttribute ComunityVO comunityVO,
							  @RequestParam("emoji") String emoji ,
							  Principal principal) {
			
	    	String emplNo = principal.getName(); // Principal 객체에서 사번 가져오기 
	    	
	    	if (emplNo == null) {
	    	        // 세션에 사번 없으면 로그인 페이지로 보내기
	    	        return "redirect:/auth/login";
	    	 }
		
	    	comunityVO.setBbsCtgryNo(16); // 예시: insertEmoji 전용 카테고리 번호
	    	comunityVO.setBbscttUseYn("N"); // 게시글 사용 여부
	    	comunityVO.setEmplNo(emplNo); // Principal 객체에서 사번 가져오기 , 임시값
	    	comunityVO.setBbscttCn(emoji); // 이모지 내용
	    	
		    comunityServiceImpl.insertContent(comunityVO);
		    
		    
			// 입력 이후 => redirect를 통해서 상세보기로 가주려함 
		return  "redirect:/comunity/comunityClubList"; // 성공 시 리다이렉트
	} // insertEmoji 삽입
	
	//프로필 이미지 변경
	@PostMapping("/insertProfile")
	public String insertProfile(@ModelAttribute ComunityVO comunityVO,
			MultipartFile[] uploadFile,
			Principal principal) {
		
		String emplNo = principal.getName(); // Principal 객체에서 사번 가져오기
		log.info("insertProfile->emplNo : " + emplNo);
		
		if (emplNo == null) {
			// 세션에 사번 없으면 로그인 페이지로 보내기
			return "redirect:/auth/login";
		}
		
		// 프로필	매우중요 앞으로 쓸거면 이거 땡겨 써야.함 코드 리팩터링 필수 
		 long attachFileNm = attachFileService.insertFileList("insertProfile", uploadFile);
		 log.info("insertProfile->attachFileNm : " + attachFileNm);
		 
		 comunityVO.setAtchFileNo(attachFileNm);
		
		comunityVO.setBbsCtgryNo(17); // 예시: insertEmoji 전용 카테고리 번호
		comunityVO.setBbscttCn("sns프로필사진 NULL방지용"); // 예시: insertEmoji 전용 카테고리 번호
		comunityVO.setBbscttUseYn("N"); // 게시글 사용 여부
		comunityVO.setEmplNo(emplNo); // Principal 객체에서 사번 가져오기 , 임시값
		
		log.info("insertProfile->comunityVO : " + comunityVO);
		
		comunityServiceImpl.insertContent(comunityVO);
		
		
		// 입력 이후 => redirect를 통해서 상세보기로 가주려함 
		return  "redirect:/comunity/comunityClubList"; // 성공 시 리다이렉트
	} // insertProfile 삽입
	
	
	
	
	
}
