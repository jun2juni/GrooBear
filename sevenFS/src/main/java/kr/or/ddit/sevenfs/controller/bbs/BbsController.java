package kr.or.ddit.sevenfs.controller.bbs;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.sevenfs.service.bbs.BbsService;
import kr.or.ddit.sevenfs.vo.bbs.BbsVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/bbs")
public class BbsController {

	@Autowired
    BbsService bbsService;
    
    @GetMapping("/bbs")
    public String bbs() {
    	
    	return "bbs/bbs";
    }
    
    @GetMapping("/bbsList")
    public String bbsList(Model model, BbsVO bbsVO) {
    	
    	List<BbsVO> bbsList = bbsService.bbsList();
    	log.info("리스트 출력 : " + bbsList);
    	
    	model.addAttribute("bbsList", bbsList);
    	
    	return "bbs/bbsList";
    }
    
    
    
}
