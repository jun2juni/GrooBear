package kr.or.ddit.sevenfs.controller.project;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import kr.or.ddit.sevenfs.mapper.common.CommonCodeMapper;
import kr.or.ddit.sevenfs.service.project.GanttService;
import kr.or.ddit.sevenfs.service.project.ProjectService;
import kr.or.ddit.sevenfs.vo.CommonCodeVO;
import kr.or.ddit.sevenfs.vo.project.LinkVO;
import kr.or.ddit.sevenfs.vo.project.ProjectVO;
import kr.or.ddit.sevenfs.vo.project.TaskVO;

import java.text.SimpleDateFormat;
import java.util.*;

@Slf4j
@Controller
@RequestMapping("/project/gantt")
public class GanttController {

    @Autowired
    private GanttService ganttService;

    @Autowired
    private ProjectService projectService;

    @Autowired
    private CommonCodeMapper commonCodeMapper;

    // 간트 차트 기본 화면 출력
    @GetMapping
    public String showGanttView(@RequestParam(value = "prjctNo", required = false) Integer prjctNo, Model model) {
        if (prjctNo == null) {
            prjctNo = projectService.selectMaxProjectNo();
        }

        ProjectVO project = projectService.projectDetail(prjctNo);
        List<CommonCodeVO> taskSttusList = commonCodeMapper.selectCodesByGroup("TASK_STTUS");
        List<CommonCodeVO> priortList = commonCodeMapper.selectCodesByGroup("PRIORT");

        model.addAttribute("prjctNo", prjctNo);
        model.addAttribute("taskSttusList", taskSttusList);
        model.addAttribute("priortList", priortList);
        model.addAttribute("project", project);

        return "project/gantt";
    }

    @GetMapping("/latest")
    public String latestGantt(Model model) {
        int latestPrjctNo = projectService.selectMaxProjectNo();
        return "redirect:/project/gantt?prjctNo=" + latestPrjctNo;
    }

    /** Gantt.js용 업무 + 링크 전체 데이터 */
    @GetMapping("/data")
    @ResponseBody
    public Map<String, Object> getTasks(@RequestParam("prjctNo") int prjctNo) {
        Map<String, Object> response = new HashMap<>();
        try {
            List<TaskVO> tasks = ganttService.getTasksByProject(prjctNo);
            List<LinkVO> links = ganttService.getAllLinks();

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

            for (TaskVO task : tasks) {
                // 날짜 보정
                Date start = task.getStartDate();
                Date end = task.getEndDate();

                if (start == null) start = new Date();
                if (end == null) {
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(start);
                    cal.add(Calendar.DAY_OF_MONTH, 1);
                    end = cal.getTime();
                }

                task.setStartDate(start);
                task.setEndDate(end);

                task.setStartDateStr(sdf.format(start));
                task.setEndDateStr(sdf.format(end));

                if (task.getProgress() == null) task.setProgress(0.0);
            }

            response.put("data", tasks);
            response.put("links", links);
            log.info("✅ 간트 데이터 로드 완료: 업무 {}건, 링크 {}건", tasks.size(), links.size());
        } catch (Exception e) {
            log.error("❌ 간트 데이터 로드 실패", e);
            response.put("data", new ArrayList<>());
            response.put("links", new ArrayList<>());
        }
        return response;
    }

    /** 업무 생성 */
    @PostMapping("/task")
    @ResponseBody
    public ResponseEntity<?> createTask(@RequestBody TaskVO task) {
        try {
            TaskVO created = ganttService.createTask(task);
            return ResponseEntity.status(HttpStatus.CREATED).body(created);
        } catch (Exception e) {
            log.error("❌ 업무 생성 실패", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("업무 생성 실패");
        }
    }

    /** 업무 수정 */
    @PutMapping("/task/{taskId}")
    @ResponseBody
    public ResponseEntity<?> updateTask(@PathVariable long taskId, @RequestBody TaskVO task) {
        task.setTaskId(taskId);
        try {
            TaskVO updated = ganttService.updateTask(task);
            return ResponseEntity.ok(updated);
        } catch (Exception e) {
            log.error("❌ 업무 수정 실패", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("업무 수정 실패");
        }
    }

    /** 업무 삭제 */
    @DeleteMapping("/task/{taskId}")
    @ResponseBody
    public ResponseEntity<?> deleteTask(@PathVariable long taskId) {
        try {
            ganttService.deleteTask(taskId);
            return ResponseEntity.noContent().build();
        } catch (Exception e) {
            log.error("❌ 업무 삭제 실패", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("업무 삭제 실패");
        }
    }

    /** 링크 생성 */
    @PostMapping("/link")
    @ResponseBody
    public ResponseEntity<?> createLink(@RequestBody LinkVO link) {
        try {
            LinkVO created = ganttService.createLink(link);
            return ResponseEntity.status(HttpStatus.CREATED).body(created);
        } catch (Exception e) {
            log.error("❌ 링크 생성 실패", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("링크 생성 실패");
        }
    }

    /** 링크 수정 */
    @PutMapping("/link/{linkId}")
    @ResponseBody
    public ResponseEntity<?> updateLink(@PathVariable long linkId, @RequestBody LinkVO link) {
        link.setLinkId(linkId);
        try {
            LinkVO updated = ganttService.updateLink(link);
            return ResponseEntity.ok(updated);
        } catch (Exception e) {
            log.error("❌ 링크 수정 실패", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("링크 수정 실패");
        }
    }

    /** 링크 삭제 */
    @DeleteMapping("/link/{linkId}")
    @ResponseBody
    public ResponseEntity<?> deleteLink(@PathVariable long linkId) {
        try {
            ganttService.deleteLink(linkId);
            return ResponseEntity.noContent().build();
        } catch (Exception e) {
            log.error("❌ 링크 삭제 실패", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("링크 삭제 실패");
        }
    }
}
