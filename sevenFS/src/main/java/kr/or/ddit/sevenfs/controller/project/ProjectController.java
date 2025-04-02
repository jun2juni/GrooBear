package kr.or.ddit.sevenfs.controller.project;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.sevenfs.service.project.ProjectService;
import kr.or.ddit.sevenfs.vo.project.ProjectVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/project")
public class ProjectController {

	/*
	 * @Autowired private GanttService gnGanttService;
	 */
	
	@Autowired
	private ProjectService projectService;
	
	
	@GetMapping("/tab")
	public String projectTab(Model model){

		
		return "project/projectTab";
	}
	
	@GetMapping("/projectList")
	public String projectList(Model model) {
		List<ProjectVO> projectList = projectService.projectList();

		model.addAttribute("projectList", projectList);
		
		return "project/projectList";
	}
	
	@GetMapping("/taskList")
	public String taskList() {
		return "project/taskList";
	}


	@PostMapping("/insert")
	 public String projectInsert() {
		
		 return "project/insert";
	 }

}