package kr.or.ddit.sevenfs.controller.project;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import kr.or.ddit.sevenfs.vo.project.TaskAnsertVO;
import lombok.extern.slf4j.Slf4j;
import kr.or.ddit.sevenfs.service.notification.NotificationService;
import kr.or.ddit.sevenfs.service.project.TaskAnsertService;

@RestController
@RequestMapping("/task")
@Slf4j
public class TaskAnsertController {

    @Autowired
    TaskAnsertService taskAnsertService ;

    @Autowired
    NotificationService notificationService;

    // 댓글 등록
    @PostMapping("/answer")
    public ResponseEntity<?> insertTaskAnswer(@RequestParam int taskNo,
                                              @RequestParam String answerCn,
                                              @RequestParam(required = false) Integer parentAnswerNo,
                                              @RequestParam(defaultValue = "0") int answerDepth,
                                              @AuthenticationPrincipal(expression = "username") String emplNo) {

        log.info("업무 댓글 등록");

        TaskAnsertVO vo = new TaskAnsertVO();
        vo.setTaskNo(taskNo);
        vo.setAnswerCn(answerCn);
        vo.setAnswerWritngEmpno(emplNo);

        vo.setParentAnswerNo(parentAnswerNo != null ? parentAnswerNo : 0);
        vo.setAnswerDepth(parentAnswerNo != null ? answerDepth : 0);

        vo.setAnswerCreatDt(new Date());

        taskAnsertService.saveTaskAnswer(vo);

        return ResponseEntity.ok("댓글 등록 완료");
    }


    // 댓글 조회
    @GetMapping("/answer")
    public List<TaskAnsertVO> getTaskAnswer(@RequestParam Map<String, Object> params) {
        return taskAnsertService.selectTaskAnswer(params);
    }

    // 댓글 수정
    @PostMapping("/answer/update")
    public ResponseEntity<String> updateTaskAnswer(@RequestParam int taskAnswerSn,
                                                   @RequestParam String answerCn) {
    	taskAnsertService.updateTaskAnswer(taskAnswerSn, answerCn);
        return ResponseEntity.ok("댓글 수정 완료");
    }

    // 댓글 삭제
    @PostMapping("/answer/delete")
    public ResponseEntity<String> deleteTaskAnswer(@RequestParam int taskAnswerSn) {
    	taskAnsertService.deleteTaskAnswer(taskAnswerSn);
        return ResponseEntity.ok("댓글 삭제 완료");
    }
}
