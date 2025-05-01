package kr.or.ddit.sevenfs.controller.project;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.HtmlUtils;

import kr.or.ddit.sevenfs.vo.CustomUser;
import kr.or.ddit.sevenfs.vo.notification.NotificationVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import kr.or.ddit.sevenfs.vo.project.ProjectTaskVO;
import kr.or.ddit.sevenfs.vo.project.ProjectVO;
import kr.or.ddit.sevenfs.vo.project.TaskAnsertVO;
import lombok.extern.slf4j.Slf4j;
import kr.or.ddit.sevenfs.service.notification.NotificationService;
import kr.or.ddit.sevenfs.service.project.ProjectTaskService;
import kr.or.ddit.sevenfs.service.project.TaskAnsertService;

@RestController
@RequestMapping("/task")
@Slf4j
public class TaskAnsertController {

    @Autowired
    TaskAnsertService taskAnsertService ;

    @Autowired
    NotificationService notificationService;
    
    @Autowired
    ProjectTaskService projectTaskService;

    // 댓글 등록
    @PostMapping("/answer")
    public ResponseEntity<?> insertTaskAnswer(@RequestParam int taskNo,
                                              @RequestParam String answerCn,
                                              @RequestParam(required = false) Integer parentAnswerNo,
                                              @RequestParam(defaultValue = "0") int answerDepth,
                                              @AuthenticationPrincipal(expression = "username") String emplNo,
                                              ProjectVO projectVO) {
    	
        log.info("업무 댓글 등록");

        TaskAnsertVO vo = new TaskAnsertVO();
        vo.setTaskNo(taskNo);
        String sanitizedAnswerCn = HtmlUtils.htmlEscape(answerCn);
        vo.setAnswerCn(sanitizedAnswerCn);
        vo.setAnswerWritngEmpno(emplNo);
        vo.setParentAnswerNo(parentAnswerNo != null ? parentAnswerNo : 0);
        vo.setAnswerDepth(parentAnswerNo != null ? answerDepth : 0);
        vo.setAnswerCreatDt(new Date());

        taskAnsertService.saveTaskAnswer(vo);
        
        // ================= 알림 처리 =================
        // 담당자 정보 조회
        ProjectTaskVO task = projectTaskService.getTaskById((long) taskNo); // 업무 정보 조회
        String receiverEmpNo = String.valueOf(task.getChargerEmpno());
        String receiverName = task.getChargerEmpNm(); // 표시용
        long projectNo = task.getPrjctNo(); // ← 이게 진짜 프로젝트 번호!
        String taskNm = task.getTaskNm();
        log.info("프로젝트 번호 : " + projectNo);
        
        
        if (!receiverEmpNo.equals(emplNo)) { // 본인이 작성한 댓글이 아닐 경우에만 알림
            EmployeeVO receiver = new EmployeeVO();
            receiver.setEmplNo(receiverEmpNo);

            NotificationVO notificationVO = new NotificationVO();
            notificationVO.setNtcnSj("[업무 댓글 알림]");
            notificationVO.setNtcnCn(receiverName + "님, 담당 업무("+taskNm+")에 피드백이 등록되었습니다.");
            notificationVO.setOriginPath("/project/projectDetail?prjctNo=" + projectNo); // 업무 상세 페이지
            notificationVO.setSkillCode("02"); // 업무 관련 알림 코드

            notificationService.insertNotification(notificationVO, List.of(receiver));
        }
        
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("taskNo", (long) taskNo);
        paramMap.put("ansertReadingAt", "N");
        projectTaskService.uptAnsertReadingAt(paramMap);

        return ResponseEntity.ok("댓글 등록 완료");
    }


    // 댓글 조회
    @GetMapping("/answer")
    public List<TaskAnsertVO> getTaskAnswer(@RequestParam Map<String, Object> params, @AuthenticationPrincipal CustomUser customUser) {
    	log.info("getTaskAnswer -> params : "+params);
    	ProjectTaskVO projectTaskVO = projectTaskService.getTaskById(Long.parseLong((String)params.get("taskNo")));
    	log.info("getTaskAnswer -> projectTaskVO : "+projectTaskVO);
    	log.info("getTaskAnswer -> 담당자 번호 : "+projectTaskVO.getChargerEmpno());
    	log.info("getTaskAnswer -> 내 번호 : "+customUser.getEmpVO().getEmplNo());
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
