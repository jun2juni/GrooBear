package kr.or.ddit.sevenfs.controller.project;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.sevenfs.service.project.DashboardService;
import kr.or.ddit.sevenfs.vo.project.ProjectTaskVO;

@Controller
@RequestMapping("/dashboard")
public class DashboardController {
    @Autowired
    private DashboardService dashboardService;

    @GetMapping
    public String dashboard(Model model, Principal principal) {
        // 로그인된 사용자 아이디가 사번이라면, 숫자로 변환
        int emplNo = Integer.parseInt(principal.getName());

        model.addAttribute("projectStatus", dashboardService.countProjectByStatus());
        model.addAttribute("taskMainStatus", dashboardService.countTaskMainStatus());
        model.addAttribute("taskGrade", dashboardService.countTaskByGrade());
        model.addAttribute("taskProgress", dashboardService.countTaskByProgressGroup());
        model.addAttribute("urgentTasks", dashboardService.selectUrgentTasks());
        model.addAttribute("myProjects", dashboardService.selectMyProjects(emplNo));
        model.addAttribute("taskPriort", dashboardService.countTaskByPriort());
        model.addAttribute("commonCodes", dashboardService.getCommonCodes());


        return "project/dashboard";
    }

    @GetMapping("/")
    public String home(Model model, Principal principal) {
       
        // 임박한 업무 전체 조회
        List<ProjectTaskVO> urgentTasks = dashboardService.selectUrgentTasks(); 

        Map<String, Map<String, String>> commonCodes = dashboardService.getCommonCodes(); 

        model.addAttribute("urgentTasks", urgentTasks);
        model.addAttribute("commonCodes", commonCodes);

        return "home"; //
    }


}
