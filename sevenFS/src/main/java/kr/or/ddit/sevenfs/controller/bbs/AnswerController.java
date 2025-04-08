package kr.or.ddit.sevenfs.controller.bbs;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.sevenfs.service.bbs.AnswerService;
import kr.or.ddit.sevenfs.vo.bbs.AnswerVO;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/bbs")
@Slf4j
public class AnswerController {

	@Autowired
    AnswerService answerService;

    // 댓글 등록
    @PostMapping("/answer")
    public ResponseEntity<?> insertAnswer(@RequestParam int bbsSn,
                                          @RequestParam int bbsCtgryNo,
                                          @RequestParam String answerCn,
                                          @RequestParam String emplNo
                                          ) {
    	
        AnswerVO vo = new AnswerVO();
        vo.setBbsSn(bbsSn);
        vo.setBbsCtgryNo(bbsCtgryNo);
        vo.setAnswerCn(answerCn);
        vo.setEmplNo(emplNo);

        answerService.saveAnswer(vo);
        return ResponseEntity.ok("등록 완료");
    }

    // 댓글 조회
    @GetMapping("/answer")
    public List<AnswerVO> getAnswer(@RequestParam Map<String, Object> params) {
        return answerService.selectAnswer(params);
    }
}
