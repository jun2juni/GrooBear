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
    ProjectService projectService;
    
    @Autowired
    CommonCodeMapper commonCodeMapper;

    @GetMapping
    public String showGanttView(@RequestParam(value = "prjctNo", required = false) Integer prjctNo, Model model) {
        // prjctNo가 null이면 최근 프로젝트 번호를 가져옴
        if (prjctNo == null) {
            prjctNo = projectService.selectMaxProjectNo();
        }
        
        model.addAttribute("prjctNo", prjctNo);

        // 직접 호출해서 리스트 불러오기
        List<CommonCodeVO> taskSttusList = commonCodeMapper.selectCodesByGroup("TASK_STTUS");
        List<CommonCodeVO> priortList = commonCodeMapper.selectCodesByGroup("PRIORT");

        model.addAttribute("taskSttusList", taskSttusList);
        model.addAttribute("priortList", priortList);

        return "project/gantt";
    }
    
    @GetMapping("/latest")
    public String latestGantt(Model model) {
        int latestPrjctNo = projectService.selectMaxProjectNo();

        List<CommonCodeVO> taskSttusList = commonCodeMapper.selectCodesByGroup("TASK_STTUS");
        List<CommonCodeVO> priortList = commonCodeMapper.selectCodesByGroup("PRIORT");

        model.addAttribute("taskSttusList", taskSttusList);
        model.addAttribute("prjctNo", latestPrjctNo);
        model.addAttribute("priortList", priortList);
        return "project/gantt";
    }


    

    /** Gantt.js에서 요청하는 업무 + 링크 데이터 */
    @GetMapping("/data")
    @ResponseBody
    public Map<String, Object> getTasks(@RequestParam("prjctNo") int prjctNo) {
        Map<String, Object> response = new HashMap<>();
        try {
            List<TaskVO> tasks = ganttService.getTasksByProject(prjctNo);
            List<LinkVO> links = ganttService.getAllLinks();

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

            for (TaskVO task : tasks) {
                if (task.getStartDate() == null) {
                    task.setStartDate(new Date());
                }
                if (task.getEndDate() == null) {
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(task.getStartDate());
                    cal.add(Calendar.DAY_OF_MONTH, 1);
                    task.setEndDate(cal.getTime());
                }

                task.setStartDateStr(sdf.format(task.getStartDate()));
                task.setEndDateStr(sdf.format(task.getEndDate()));

                if (task.getProgress() == null) {
                    task.setProgress(0.0);
                }
            }

            response.put("data", tasks);
            response.put("links", links);
            log.info("간트 데이터 로드 성공 - 프로젝트: {}, 업무 개수: {}, 링크 개수: {}", prjctNo, tasks.size(), links.size());
        } catch (Exception e) {
            log.error("간트 데이터 로드 실패", e);
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
            log.error("업무 생성 실패", e);
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
            log.error("업무 수정 실패", e);
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
            log.error("업무 삭제 실패", e);
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
            log.error("링크 생성 실패", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("링크 생성 실패");
        }
    }

    /** 링크 수정 */
    @PutMapping("/link/{linkId}")
    @ResponseBody
    public ResponseEntity<?> updateLink(@PathVariable long linkId, @RequestBody LinkVO link) {
        try {
            link.setLinkId(linkId);
            LinkVO updated = ganttService.updateLink(link);
            return ResponseEntity.ok(updated);
        } catch (Exception e) {
            log.error("링크 수정 실패", e);
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
            log.error("링크 삭제 실패", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("링크 삭제 실패");
        }
    }
    
    
    
}
