package kr.or.ddit.sevenfs.controller.project;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.sevenfs.service.AttachFileService;
import kr.or.ddit.sevenfs.service.project.ProjectService;
import kr.or.ddit.sevenfs.service.project.ProjectTaskService;
import kr.or.ddit.sevenfs.utils.ArticlePage;
import kr.or.ddit.sevenfs.vo.AttachFileVO;
import kr.or.ddit.sevenfs.vo.project.ProjectEmpVO;
import kr.or.ddit.sevenfs.vo.project.ProjectTaskVO;
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
	
	@Autowired
	private AttachFileService attachFileService;
	
	private ProjectTaskService projectTaskService;
	
	
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
	

	@GetMapping("/insert")
	 public String projectInsertForm() {
		
		 return "project/insert";
	 }

	
    @PostMapping("/insert")
    public String insertProject(@ModelAttribute ProjectVO projectVO, RedirectAttributes redirectAttrs,
    		@RequestParam("taskListJson") String taskListJson) {
        // 1. 프로젝트 정보 저장 
    	log.info("insertProject -> projectVO(전) {} :" ,projectVO);
        // 프로젝트 아이디 가져옴
    	
        
        ObjectMapper mapper = new ObjectMapper();
        List<ProjectTaskVO> taskList;
		try {
			taskList = mapper.readValue(taskListJson, new TypeReference<List<ProjectTaskVO>>() {});
			// 프로젝트 추가
			projectService.createProject(projectVO, taskList);
			
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		int newPrjctId = projectVO.getPrjctNo();
		
		
        // 2. 리다이렉트로 업무 등록 페이지로 이동
        return "redirect:/project/" + newPrjctId + "/taskForm";
    }
	
	
/*
	@PostMapping("/insert")
	public String projectInsert(ProjectVO projectVO,
	        List<ProjectEmpVO> projectEmpVOList,
	        @RequestParam(value = "uploadFile", required = false) MultipartFile[] uploadFiles,
	        Model model) {
	    try {
	        // 1. 첨부파일
	        if (uploadFiles != null && uploadFiles.length > 0 && !uploadFiles[0].isEmpty()) {
	            long attachFileNo = attachFileService.insertFileList("project", uploadFiles);
	            projectVO.setAtchFileNo(attachFileNo);
	        }

	        // 2. 프로젝트 등록
	        int result = projectService.projectInsert(projectVO);
	        if (result <= 0) throw new Exception("프로젝트 등록 실패");

	        // 3. 참여자 등록
	        if (projectEmpVOList != null) {
	            for (ProjectEmpVO empVO : projectEmpVOList) {
	                empVO.setPrjctNo(projectVO.getPrjctNo());
	                if ("00".equals(empVO.getPrtcpntRole())) {
	                    empVO.setEvlManEmpno(empVO.getPrtcpntEmpno());
	                }
	                empVO.setEvlCn("");
	                empVO.setEvlGrad("01");
	                empVO.setSecsnYn("N");
	            }
	            projectService.insertProjectEmpBatch(projectEmpVOList);
	        }

	        
	        return "redirect:/project/" + projectVO.getPrjctNo() + "/taskForm";

	    } catch (Exception e) {
	        log.error("프로젝트 등록 실패", e);
	        model.addAttribute("errorMessage", "프로젝트 등록 실패: " + e.getMessage());
	        return "project/insert";
	    }
	}
*/	
    
    @GetMapping("/projectDetail")
    public String projectDetail(Model model, 
    		@RequestParam(value="prjctNo", required = true) int prjctNo) {
    	log.info("projectDetail -> projectVO {} : ", prjctNo);
    	
    	ProjectVO projectVO = projectService.projectDetail(prjctNo);
    	log.info("projectDetail -> projectVO(후) : {}", projectVO);
    	
    	model.addAttribute("project", projectVO);
    	
    	return "project/projectDetail";
    	
    	
    }
}