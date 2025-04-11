package kr.or.ddit.sevenfs.controller.bbs;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.sevenfs.service.AttachFileService;
import kr.or.ddit.sevenfs.service.bbs.BbsService;
import kr.or.ddit.sevenfs.service.bbs.ComunityService;
import kr.or.ddit.sevenfs.service.bbs.Impl.ComunityServiceImpl;
import kr.or.ddit.sevenfs.utils.ArticlePage;
import kr.or.ddit.sevenfs.utils.AttachFile;
import kr.or.ddit.sevenfs.vo.bbs.BbsVO;


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
	
	
	@GetMapping("/comunityHome")
	public String comunityHome(
								) {
		return "comunity/comunityHome";	
	} // comunityHome
	
	
	@GetMapping("/comunityMonthMenuList")
	public String comunityMonthMenuList(Model model
			 							,@ModelAttribute BbsVO bbsVO
			 							,@RequestParam(defaultValue = "1") int currentPage
			 							,@RequestParam(defaultValue = "10") int size ) {
		// 월별 식단표 카테고리 
		int bbsCtgryNo = 3;
		bbsVO.setBbsCtgryNo(bbsCtgryNo);	
		
		  // 검색 키워드 및 카테고리 로깅 (디버깅 용도)
        log.info("서치키워드 확인: " + bbsVO.getSearchKeyword());
        log.info("서치카테고리 확인: " + bbsVO.getCategory());

        // 뷰에 검색 키워드 전달
        model.addAttribute("SearchKeyword", bbsVO.getSearchKeyword());
        
        // 페이징 및 검색 조건을 담을 맵 생성
        Map<String, Object> map = new HashMap<>();
        map.put("searchKeyword", bbsVO.getSearchKeyword());
        map.put("currentPage", currentPage);
        map.put("size", size);
        map.put("category", bbsVO.getCategory());
        map.put("bbsCtgryNo", bbsVO.getBbsCtgryNo());
		
        // 전체 게시글 수 조회 (페이징 계산을 위해 필요)
        int total = this.comunityServiceImpl.getTotal(map);
        map.put("total", total);
        
        // 맵 디버깅 로그
        log.info("맵 : " + map);

        // 페이징 처리 객체 생성
        ArticlePage<BbsVO> articlePage = new ArticlePage<>(total, currentPage, size);

        // 게시글 정렬 조건 설정 (날짜 기준 내림차순)
        bbsVO.setOrderByDate("desc");
        
        // 페이징 객체에 검색 조건 VO 설정 및 전체 게시글 수 설정
        articlePage.setSearchVo(bbsVO);
        articlePage.setTotal(total);

        // 게시글 리스트 조회
        List<BbsVO> bbsList = comunityServiceImpl.comunityMonthMenuList(articlePage);
        int startRowNumber = total - (currentPage - 1) * size;

        for (int i = 0; i < bbsList.size(); i++) {
            bbsList.get(i).setRowNumber(startRowNumber - i); // 게시글 번호
        }
		
     // 뷰에 전달할 모델 속성 설정
        model.addAttribute("selectedCategory", bbsVO.getCategory());
        model.addAttribute("articlePage", articlePage);
        model.addAttribute("bbsList", bbsList);
        model.addAttribute("bbsCtgryNo", bbsCtgryNo);
        
		return "comunity/comunityMonthMenuList";	
	} // comunityMonthMenuList 월별 식단표 메뉴 목록 출력 
	
	
	// 월별 메뉴 인서트 페이지 
	@GetMapping("/comunityMonthMenuInsert")
	public String comunityMonthMenuInsertForm(@ModelAttribute BbsVO bbsVO) {
		
		// 월별 식단표 카테고리 
		int bbsCtgryNo = 3;
		bbsVO.setBbsCtgryNo(bbsCtgryNo);
		

		
		return "comunity/comunityMonthMenuInsert";	
	} // comunityMonthMenuInsert 월별 메뉴 삽입 insert페이지를 불러오기위함 그래서 메소드이름은 입력Form을 불러오기위해 Form이라 지음
	 // 같은 이름으로 하면 post,get으로 매핑의종류가달라도 오류를 부르기때문에 이름을 바꿔줬다.
	// 카테고리번호별로 insert를 다르게 해줘야 하기 때문에 카테고리 넘버를 잡고 새로 넣어준다.ㅏ
	
	
	@PostMapping("/comunityMonthMenuInsert")
	public String comunityMonthMenuInsert(@ModelAttribute BbsVO bbsVO, Model model, MultipartFile[] uploadFile, @RequestParam("uploadFile") MultipartFile file) {
		
		// 월별 식단표 카테고리 -파라미터로 넘기지 않고 여기 세팅함
		int bbsCtgryNo = 3;
		bbsVO.setBbsCtgryNo(bbsCtgryNo);
		
		// 파일 number를 받음
		long attachFileNm = attachFileService.insertFileList("insertFile", uploadFile);
        bbsVO.setAtchFileNo(attachFileNm);
        
        //게시글저장 -> 
        int result = comunityServiceImpl.comunityMenuInsert(bbsVO);
        int bbsSn = bbsVO.getBbsSn(); // INSERT 후 bbsSn 가져오기
        log.info("게시글 등록 결과 -> " + result);
        log.info("생성된 게시글 ID: " + bbsSn);

        String fileName = file.getOriginalFilename();
        log.info("파일이름 : " + fileName);
		
		
			// 입력 이후 => redirect를 통해서 상세보기로 가주려함 
//		 return "redirect:/comunity/comunityMonthMenuList?bbsCtgryNo="+bbsVO.getBbsCtgryNo();
		 return "redirect:/comunity/comunityMonthMenuList";
	} // comunityMonthMenuInsert 월별 메뉴 삽입 insert페이지를 불러오기위함 
	
	
	
}
