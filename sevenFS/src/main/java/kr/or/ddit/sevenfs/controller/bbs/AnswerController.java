package kr.or.ddit.sevenfs.controller.bbs;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.sevenfs.service.bbs.AnswerService;
import kr.or.ddit.sevenfs.service.bbs.Impl.BbsServiceImpl;
import kr.or.ddit.sevenfs.service.notification.NotificationService;
import kr.or.ddit.sevenfs.vo.bbs.AnswerVO;
import kr.or.ddit.sevenfs.vo.bbs.BbsVO;
import kr.or.ddit.sevenfs.vo.notification.NotificationVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/bbs")
@Slf4j
public class AnswerController {

	@Autowired
    AnswerService answerService;
	
	@Autowired
	BbsServiceImpl bbsService;
	
	@Autowired
	NotificationService notificationService;

    // 댓글 등록

	@PostMapping("/answer")
	public ResponseEntity<?> insertAnswer(@RequestParam int bbsSn,
	                                      @RequestParam int bbsCtgryNo,
	                                      @RequestParam String answerCn,
	                                      @AuthenticationPrincipal(expression = "username") String emplNo) {
	    AnswerVO vo = new AnswerVO();
	    vo.setBbsSn(bbsSn);
	    vo.setBbsCtgryNo(bbsCtgryNo);
	    vo.setAnswerCn(answerCn);
	    vo.setEmplNo(emplNo); // 댓글 단 사람

	    answerService.saveAnswer(vo);

	    // ========== 알림 처리 추가 시작 ==========
	    // 게시글 작성자 조회
	    BbsVO board = bbsService.bbsDetail(bbsSn);
	    String receiverEmpNo = board.getEmplNo();
	    String receiverName = board.getEmplNm();  // 게시글 작성자 이름 (있으면 메시지에 활용 가능)


	    if (!receiverEmpNo.equals(emplNo)) { // 자기 자신 제외
	        EmployeeVO receiver = new EmployeeVO();
	        receiver.setEmplNo(receiverEmpNo);

	        NotificationVO notificationVO = new NotificationVO();
	        notificationVO.setNtcnSj("[댓글 알림]");
	        notificationVO.setNtcnCn(receiverName+"님, 게시글에 댓글이 등록되었습니다.");
	        notificationVO.setOriginPath("/bbs/bbsDetail?bbsSn=" + bbsSn);
	        notificationVO.setSkillCode("01");

	        notificationService.insertNotification(notificationVO, List.of(receiver));
	    }
	    // ========== 알림 처리 끝 ==========

	    return ResponseEntity.ok("등록 완료");
	}




    // 댓글 조회
    @GetMapping("/answer")
    @ResponseBody
    public List<AnswerVO> getAnswer(@RequestParam Map<String, Object> params) {
        return answerService.selectAnswer(params);
    }
    
 // 댓글 수정
    @PostMapping("/answer/update")
    public ResponseEntity<String> updateAnswer(@RequestParam int answerNo,
                                               @RequestParam String answerCn) {
        answerService.updateAnswer(answerNo, answerCn);
        return ResponseEntity.ok("수정 완료");
    }

    // 댓글 삭제
    @PostMapping("/answer/delete")
    public ResponseEntity<String> deleteAnswer(@RequestParam int answerNo) {
        answerService.deleteAnswer(answerNo);
        return ResponseEntity.ok("삭제 완료");
    }

}
