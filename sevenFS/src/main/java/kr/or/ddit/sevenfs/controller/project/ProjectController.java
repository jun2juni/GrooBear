package kr.or.ddit.sevenfs.controller.project;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpServletRequest;
import kr.or.ddit.sevenfs.mapper.project.ProjectTaskMapper;
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
	@Autowired
	private ProjectTaskService projectTaskService;
	@Autowired
	ProjectTaskMapper projectTaskMapper;
	
	
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
	 public String projectInsertForm(Model model) {
		model.addAttribute("title", "프로젝트 생성");
		 return "project/insert";
	 }

	
	@PostMapping("/insert")
	public String insertProject(@ModelAttribute ProjectVO projectVO,
	                           @RequestParam("projectTasksJson") String projectTasksJson,
	                           @RequestParam("projectEmpListJson") String projectEmpListJson,
	                           RedirectAttributes redirectAttrs,
	                           MultipartHttpServletRequest multiReq) {
	    log.info("====== [insertProject] 요청 도착 ======");

	    try {
	        // 1. JSON 문자열에서 업무 목록 파싱
	        ObjectMapper objectMapper = new ObjectMapper();
	        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
	        
	        List<ProjectTaskVO> taskList = objectMapper.readValue(projectTasksJson, 
	            new TypeReference<List<ProjectTaskVO>>() {});
	        
	        List<ProjectEmpVO> empList = objectMapper.readValue(projectEmpListJson,
	            new TypeReference<List<ProjectEmpVO>>() {});
	            
	        log.info("파싱된 업무 개수: {}", taskList.size());
	        log.info("파싱된 참여자 개수: {}", empList.size());

	        // 2. 업무 파일 처리
	        for (int index = 0; index < taskList.size(); index++) {
	            ProjectTaskVO task = taskList.get(index);
	            
	            // 파일 처리
	            String fileKey = "uploadFiles_task_" + index;
	            List<MultipartFile> fileList = multiReq.getFiles(fileKey);

	            if (fileList != null && !fileList.isEmpty() && !fileList.get(0).isEmpty()) {
	                MultipartFile[] fileArray = fileList.toArray(new MultipartFile[0]);
	                long atchFileNo = attachFileService.insertFileList("task", fileArray);
	                task.setAtchFileNo(atchFileNo);
	            }
	        }

	        // 3. 참여자 목록 설정
	        projectVO.setProjectEmpVOList(empList);

	        // 4. 프로젝트 서비스 호출 (업무 목록 포함)
	        projectService.createProject(projectVO, taskList);

	        // 5. 상위-하위 업무 관계 처리
	        updateTaskHierarchy(taskList);

	    } catch (Exception e) {
	        log.error("프로젝트 생성 중 오류", e);
	        redirectAttrs.addFlashAttribute("errorMessage", "프로젝트 등록 실패: " + e.getMessage());
	        return "redirect:/project/insert";
	    }

	    return "redirect:/project/projectDetail?prjctNo=" + projectVO.getPrjctNo();
	}

	// 업무 계층 구조 업데이트 메서드
	private void updateTaskHierarchy(List<ProjectTaskVO> taskList) {
	    // 임시 인덱스를 사용하여 실제 TASK_NO로 매핑
	    Map<Integer, Long> indexToTaskNoMap = new HashMap<>();
	    
	    // 1. 각 업무의 인덱스와 실제 TASK_NO 매핑 (0부터 시작하는 인덱스 사용)
	    for (int i = 0; i < taskList.size(); i++) {
	        indexToTaskNoMap.put(i, (long)taskList.get(i).getTaskNo());
	        log.debug("인덱스 매핑: {} -> {}", i, taskList.get(i).getTaskNo());
	    }
	    
	    // 2. 상위-하위 관계 업데이트
	    for (ProjectTaskVO task : taskList) {
	        log.debug("업무 처리: {}, tempParentIndex: {}", task.getTaskNm(), task.getTempParentIndex());
	        
	        if (task.getTempParentIndex() != null && !task.getTempParentIndex().isEmpty()) {
	            try {
	                int parentIndex = Integer.parseInt(task.getTempParentIndex());
	                Long parentTaskNo = indexToTaskNoMap.get(parentIndex);
	                
	                log.debug("상위 업무 처리: 인덱스 {} -> taskNo {}", parentIndex, parentTaskNo);
	                
	                if (parentTaskNo != null) {
	                    // 상위 업무 번호 업데이트
	                    Map<String, Object> params = new HashMap<>();
	                    params.put("taskNo", task.getTaskNo());
	                    params.put("parentTaskNo", parentTaskNo);
	                    
	                    log.info("업무 관계 업데이트: 업무 {} -> 상위 업무 {}", task.getTaskNo(), parentTaskNo);
	                    
	                    // ProjectTaskMapper에 추가할 메서드
	                    projectTaskMapper.updateTaskParent(params);
	                }
	            } catch (NumberFormatException e) {
	                log.warn("상위 업무 인덱스 변환 실패: {}", task.getTempParentIndex());
	            }
	        }
	    }
	}

	private Date parseDate(String value) {
	    if (value == null || value.isBlank()) return null;
	    try {
	        return Date.valueOf(value);
	    } catch (IllegalArgumentException e) {
	        log.warn("날짜 변환 실패: {}", value);
	        return null;
	    }
	}


    // 프로젝트 상세보기
	@GetMapping("/projectDetail")
	public String projectDetail(Model model, @RequestParam("prjctNo") int prjctNo) {
	    ProjectVO projectVO = projectService.projectDetail(prjctNo);
	    model.addAttribute("project", projectVO);
	    return "project/projectDetail";

	}


	

	
	
}