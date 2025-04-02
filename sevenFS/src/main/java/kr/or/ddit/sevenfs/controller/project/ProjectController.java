package kr.or.ddit.sevenfs.controller.project;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.sevenfs.service.AttachFileService;
import kr.or.ddit.sevenfs.service.project.ProjectService;
import kr.or.ddit.sevenfs.utils.ArticlePage;
import kr.or.ddit.sevenfs.vo.AttachFileVO;
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
	
	private AttachFileService attachFileService;
	
	
	@GetMapping("/tab")
	public String projectTab(Model model){

		
		
		return "project/projectTab";
	}
	
	@GetMapping("/projectList")
	public String projectList(Model model, ProjectVO projectVO,
			@RequestParam(value="currentPage", required = false, defaultValue = "1") int currentPage, 
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword) {
		
		//파라미터 맵 생성
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("keyword", keyword);
		map.put("size", 5);
		
		//전체 프로젝트 개수 조회
		int total = projectService.getTotal(map);
		
		List<ProjectVO> projectList = projectService.projectList(map);
		
		ArticlePage<ProjectVO> articlePage = new ArticlePage<ProjectVO>(total, currentPage, 5);
		articlePage.setSearchVo(projectVO);
		
	    System.out.println("Total records: " + total);
	    System.out.println("Total pages: " + articlePage.getTotalPages());
	    
		model.addAttribute("articlePage", articlePage);
		model.addAttribute("projectList", projectList);
		
		return "project/projectList";
	}
	


	@GetMapping("/taskList")
	public String taskList() {
		return "project/taskList";
	}



	@GetMapping("/insert")
	 public String projectInsertForm() {
		
		 return "project/insert";
	 }

	@PostMapping("/insert")
	public String projectInsert(ProjectVO projectVO, Model model, MultipartFile[] uploadFile, 
			@RequestParam("uploadFile") MultipartFile file) {
		log.info("프로젝트 등록 요청");
		
		long attachFileNm = attachFileService.insertFileList("insertFile", uploadFile);
		projectVO.setAtchFileNo(attachFileNm);
		
		//게시글 저장
		int result = projectService.projectInsert(projectVO);
		
		String fileName = file.getOriginalFilename();
		log.info("파일이름 : "+fileName);
		
		return "redirect:/proejct/projectList";
	}
	
	
}