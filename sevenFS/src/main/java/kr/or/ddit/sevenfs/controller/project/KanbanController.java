package kr.or.ddit.sevenfs.controller.project;

import kr.or.ddit.sevenfs.service.project.KanbanService;
import kr.or.ddit.sevenfs.service.project.ProjectService;
import kr.or.ddit.sevenfs.service.project.ProjectTaskService;
import kr.or.ddit.sevenfs.vo.project.ProjectVO;
import kr.or.ddit.sevenfs.vo.project.TaskVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletRequest;

import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@Controller
@RequestMapping("/project/kanban")
@RequiredArgsConstructor
public class KanbanController {

    @Autowired
    private final KanbanService kanbanService;
    
    @Autowired
    ProjectService projectService;
    
    @Autowired
    ProjectTaskService projectTaskService;

    // 업무 상태 코드 정의
    private static final String STATUS_WAITING = "00";
    private static final String STATUS_IN_PROGRESS = "01";
    private static final String STATUS_COMPLETED = "02";
    private static final String STATUS_FEEDBACK = "03";
    private static final String STATUS_CHANGED = "04";

    // 칸반 메인 페이지
    @GetMapping("/taskKanban")
    public String taskKanban(@RequestParam(required = false) Long prjctNo,
                             Model model,
                             HttpServletRequest request) {

        // 전체 프로젝트 목록은 항상 제공 (좌측 목록)
        List<ProjectVO> projectList = projectService.selectAllProjects();
        model.addAttribute("projectList", projectList);

        if (prjctNo != null) {
            // 선택된 프로젝트의 업무 전체 조회
            List<TaskVO> allCards = kanbanService.getCardsByProject(prjctNo);

            // 상태별 필터링 후 모델에 추가
            model.addAttribute("queuedCards", filterByStatus(allCards, "00"));    // 대기
            model.addAttribute("servingCards", filterByStatus(allCards, "01"));   // 진행중
            model.addAttribute("completedCards", filterByStatus(allCards, "02")); // 완료
            model.addAttribute("feedbackCards", filterByStatus(allCards, "03"));  // 피드백
            model.addAttribute("changedCards", filterByStatus(allCards, "04"));   // 변경
        }
        

        // AJAX 요청이면 partial JSP 반환
        if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
            return "project/kanbanBoardPartial";
        }

        // 전체 페이지 요청이면 전체 뷰
        return "project/taskKanban";
    }

    // 내부 필터 함수
    private List<TaskVO> filterByStatus(List<TaskVO> taskList, String statusCode) {
        return taskList.stream()
                       .filter(task -> statusCode.equals(task.getTaskSttus()))
                       .toList(); // Java 16+ 또는 .collect(Collectors.toList()) 대체 가능
    }




    // 상태 변경 API (드래그앤드롭 시 호출)
    @PostMapping("/update-status")
    @ResponseBody
    public Map<String, Object> updateCardStatus(@RequestBody Map<String, String> payload) {
        Map<String, Object> response = new HashMap<>();
        try {
            long taskId = Long.parseLong(payload.get("cardId"));
            String newStatus = payload.get("status");
            log.info("🔄 상태 변경 요청: taskId = {}, status = {}", taskId, newStatus);

            // 실제 상태 변경 서비스 호출
            int updated = projectTaskService.updateTaskStatus(taskId, newStatus);

            if (updated > 0) {
                response.put("success", true);
            } else {
                response.put("success", false);
                response.put("message", "상태 업데이트 실패");
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        
        return response;
    }


    // 업무 상세 정보 조회 (모달용)
    @GetMapping("/card/{taskNo}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getTaskDetail(@PathVariable("taskNo") Long taskNo) {
        Map<String, Object> response = new HashMap<>();
        try {
            TaskVO task = kanbanService.getTaskCardById(taskNo); // ✅ TaskVO로 통일됨
            if (task != null) {
                response.put("success", true);
                response.put("card", task);
                return ResponseEntity.ok(response);
            } else {
                response.put("success", false);
                response.put("message", "업무를 찾을 수 없습니다.");
                return ResponseEntity.badRequest().body(response);
            }
        } catch (Exception e) {
            log.error("업무 상세 조회 오류", e);
            response.put("success", false);
            response.put("message", "오류 발생");
            return ResponseEntity.badRequest().body(response);
        }
    }

}
