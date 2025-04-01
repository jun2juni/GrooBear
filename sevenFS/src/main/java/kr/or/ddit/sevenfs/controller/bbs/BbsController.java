package kr.or.ddit.sevenfs.controller.bbs;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.sevenfs.service.AttachFileService;
import kr.or.ddit.sevenfs.service.bbs.BbsService;
import kr.or.ddit.sevenfs.utils.ArticlePage;
import kr.or.ddit.sevenfs.vo.AttachFileVO;
import kr.or.ddit.sevenfs.vo.bbs.BbsVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/bbs")
public class BbsController {

	@Autowired
	private AttachFileService attachFileService;
	
	@Autowired
    BbsService bbsService;
    
    @GetMapping("/bbs")
    public String bbs() {
    	
    	return "bbs/bbs";
    }
    
    @GetMapping("/bbsList")
    public String bbsList(Model model, BbsVO bbsVO,
    		@RequestParam(defaultValue = "1") int total,
			@RequestParam(defaultValue = "1") int currentPage, 
			@RequestParam(defaultValue = "5") int size) {
    	
    	ArticlePage<AttachFileVO> articlePage = new ArticlePage<>(total, currentPage, size);
    	
    	List<AttachFileVO> fileAttachList = attachFileService.getFileAttachList(1);

		model.addAttribute("fileAttachList", fileAttachList);

		AttachFileVO attachFileVO = new AttachFileVO();
		attachFileVO.setFileNm("파일이름");
		attachFileVO.setFileExtsn("파일확장자");
		attachFileVO.setFileStreNm("저장이름");
		articlePage.setSearchVo(attachFileVO);

		articlePage.setTotal(total);
		articlePage.setCurrentPage(currentPage);

		log.info("페이지" + articlePage);

		model.addAttribute("articlePage", articlePage);
    	
    	List<BbsVO> bbsList = bbsService.bbsList(articlePage);
    	log.info("리스트 출력 : " + bbsList);
    	
    	model.addAttribute("bbsList", bbsList);
    	
    	return "bbs/bbsList";
    }
    
    
    /**
     * 게시글 작성 폼
     */
    @GetMapping("/bbsInsert")
    public String bbsInsertForm() {
        return "bbs/bbsInsert";
    }

    /**
     * 게시글 작성 처리
     */
    @PostMapping("/bbsInsert")
    public String bbsInsert(@ModelAttribute BbsVO bbsVO, Model model) {
        log.info("게시글 등록 요청");

        // 게시글 저장
        int result = bbsService.bbsInsert(bbsVO);
        int bbsSn = bbsVO.getBbsSn(); // INSERT 후 bbsSn 가져오기
        log.info("게시글 등록 결과 -> " + result);
        log.info("생성된 게시글 ID: " + bbsSn);

        if (bbsSn == 0) {
            log.error("게시글 ID(bbsSn)가 0입니다. INSERT 후에도 값이 설정되지 않았습니다.");
            return "redirect:/bbs/bbsList"; // 파일 업로드 진행하지 않음
        }

     

        return "redirect:/bbs/bbsList";
    }


    /**
     * 게시글 상세 조회
     */
    @GetMapping("/bbsDetail")
    public String bbsDetail(Model model, @RequestParam("bbsSn") int bbsSn) {
        log.info("게시글 상세 조회: " + bbsSn);

        BbsVO bbsVO = bbsService.bbsDetail(bbsSn);
        model.addAttribute("bbsVO", bbsVO);

        return "bbs/bbsDetail";
    }

    /**
     * 게시글 수정 폼
     */
    @GetMapping("/bbsUpdate")
    public String bbsUpdateForm(Model model, @RequestParam("bbsSn") int bbsSn) {
        log.info("게시글 수정 폼: " + bbsSn);

        BbsVO bbsVO = bbsService.bbsDetail(bbsSn);
        model.addAttribute("bbsVO", bbsVO);

        return "bbs/bbsUpdate";
    }

    /**
     * 게시글 수정 처리
     */
    @PostMapping("/bbsUpdate")
    public String bbsUpdate(@ModelAttribute BbsVO bbsVO) {
        log.info("게시글 수정 요청: " + bbsVO);

        bbsService.bbsUpdate(bbsVO);
        return "redirect:/bbs/bbsDetail?bbsSn=" + bbsVO.getBbsSn();
    }

    
    
    
}
