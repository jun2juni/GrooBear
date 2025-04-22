package kr.or.ddit.sevenfs.controller.project;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import kr.or.ddit.sevenfs.service.project.GanttService;
import kr.or.ddit.sevenfs.service.project.ProjectTaskService;
import kr.or.ddit.sevenfs.vo.project.GanttTaskVO;
import kr.or.ddit.sevenfs.vo.project.LinkVO;
import kr.or.ddit.sevenfs.vo.project.ProjectTaskVO;
import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/project/gantt")
@Slf4j
public class GanttController {

    @Autowired
    private GanttService ganttService;

    @Autowired
    private ProjectTaskService projectTaskService;

    @GetMapping
    public String ganttView(@RequestParam("prjctNo") int prjctNo, Model model) {
        model.addAttribute("prjctNo", prjctNo);
        return "project/gantt";
    }

    @GetMapping("/data")
    @ResponseBody
    public Map<String, Object> getGanttData(@RequestParam("prjctNo") int prjctNo,
                                            @RequestParam(value = "status", required = false) String status) {
        Map<String, Object> result = new HashMap<>();
        try {
            List<GanttTaskVO> data = ganttService.getProjectTasksByProjectNo(prjctNo);
            if (status != null && !status.isEmpty()) {
                data = data.stream()
                           .filter(t -> status.equals(t.getStatus()))
                           .collect(Collectors.toList());
            }
            List<LinkVO> links = ganttService.getAllLinks();
            result.put("data", data);
            result.put("links", links);
        } catch (Exception e) {
            log.error("Gantt 데이터 조회 중 오류: ", e);
            result.put("error", e.getMessage());
        }
        return result;
    }


    @PostMapping("/updateSchedule")
    @ResponseBody
    public Map<String, Object> updateSchedule(@RequestBody ProjectTaskVO task) {
        Map<String, Object> result = new HashMap<>();
        try {
            log.info("업무 일정 업데이트 요청: {}", task);
            projectTaskService.updateSchedule(task); // 반드시 taskNo, taskBeginDt, taskEndDt, progrsrt 포함되어야 함
            result.put("success", true);
        } catch (Exception e) {
            log.error("업무 일정 저장 실패: ", e);
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }
}
