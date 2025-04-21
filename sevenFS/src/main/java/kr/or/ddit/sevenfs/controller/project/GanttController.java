package kr.or.ddit.sevenfs.controller.project;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.sevenfs.service.project.GanttService;
import kr.or.ddit.sevenfs.vo.project.GanttTaskVO;
import kr.or.ddit.sevenfs.vo.project.LinkVO;
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

    @GetMapping
    public String ganttView(@RequestParam("prjctNo") int prjctNo, Model model) {
        model.addAttribute("prjctNo", prjctNo);
        return "project/gantt"; 
    }

    
    
    @GetMapping("/data")
    @ResponseBody
    public Map<String, Object> getGanttData(@RequestParam("prjctNo") int prjctNo) {
        log.debug("✅ GanttController getGanttData() 호출됨 - prjctNo: {}", prjctNo); 
        Map<String, Object> result = new HashMap<>();
        try {
            List<GanttTaskVO> data = ganttService.getProjectTasksByProjectNo(prjctNo);
            List<LinkVO> links = ganttService.getAllLinks();
            result.put("data", data);
            result.put("links", links);
        } catch (Exception e) {
            result.put("error", e.getMessage());
        }
        return result;
    }

}
