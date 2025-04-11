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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpServletRequest;
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
	 public String projectInsertForm(Model model) {
		model.addAttribute("title", "프로젝트 생성");
		 return "project/insert";
	 }

	
	@PostMapping("/insert")
	public String insertProject(@ModelAttribute ProjectVO projectVO,
	                            RedirectAttributes redirectAttrs,
	                            MultipartHttpServletRequest multiReq) {
	    log.info("====== [insertProject] 요청 도착 ======");

	    try {
	        // 1. 업무 리스트 처리
	        Map<String, String[]> paramMap = multiReq.getParameterMap();
	        List<ProjectTaskVO> taskList = new ArrayList<>();
	        int index = 0;

	        while (true) {
	            String prefix = "taskList[" + index + "].";
	            if (!paramMap.containsKey(prefix + "taskNm")) break;

	            ProjectTaskVO task = new ProjectTaskVO();
	            task.setTaskNm(multiReq.getParameter(prefix + "taskNm"));
	            task.setChargerEmpno(multiReq.getParameter(prefix + "chargerEmpno"));
	            task.setTaskBeginDt(Date.valueOf(multiReq.getParameter(prefix + "taskBeginDt")));
	            task.setTaskEndDt(Date.valueOf(multiReq.getParameter(prefix + "taskEndDt")));
	            task.setPriort(multiReq.getParameter(prefix + "priort"));
	            task.setTaskGrad(multiReq.getParameter(prefix + "taskGrad"));
	            task.setTaskCn(multiReq.getParameter(prefix + "taskCn"));

	            String upperTaskNo = multiReq.getParameter(prefix + "upperTaskNo");
	            if (upperTaskNo != null && !upperTaskNo.isBlank() && !"null".equals(upperTaskNo)) {
	                task.setUpperTaskNo(Long.parseLong(upperTaskNo));
	            }

	            // 프론트에서 uploadFiles_task_{index}로 보내는 걸 맞춰 받기
	            String fileKey = "uploadFiles_task_" + index;
	            List<MultipartFile> fileList = multiReq.getFiles(fileKey);

	            System.out.println("▶ 업무 " + index + " 파일 개수: " + fileList.size());
	            for (MultipartFile file : fileList) {
	                System.out.println("  🔸 파일명: " + file.getOriginalFilename() + ", 크기: " + file.getSize());
	            }

	            if (!fileList.isEmpty() && !fileList.get(0).isEmpty()) {
	                MultipartFile[] fileArray = fileList.toArray(new MultipartFile[0]);
	                long atchFileNo = attachFileService.insertFileList("task", fileArray);
	                System.out.println("  ✅ 저장된 파일 번호: " + atchFileNo);
	                task.setAtchFileNo(atchFileNo);
	            }

	            taskList.add(task);
	            index++;
	        }

	        // 2. 참여자 목록 처리
	        Set<String> uniqueEmpnos = new HashSet<>();
	        List<ProjectEmpVO> empList = new ArrayList<>();
	        int empIdx = 0;
	        while (true) {
	            String empNo = multiReq.getParameter("projectEmpVOList[" + empIdx + "].prtcpntEmpno");
	            String role = multiReq.getParameter("projectEmpVOList[" + empIdx + "].prtcpntRole");
	            if (empNo == null || role == null) break;

	            String uniqueKey = projectVO.getPrjctNo() + "_" + empNo;
	            if (!uniqueEmpnos.add(uniqueKey)) {
	                log.warn("중복 사원 건너뜀: {}", empNo);
	                empIdx++;
	                continue;
	            }

	            ProjectEmpVO emp = new ProjectEmpVO();
	            emp.setPrtcpntEmpno(empNo);
	            emp.setPrtcpntRole(role);
	            empList.add(emp);

	            empIdx++;
	        }
	        projectVO.setProjectEmpVOList(empList);

	        // 3. 프로젝트 서비스 호출
	        projectService.createProject(projectVO, taskList);

	    } catch (Exception e) {
	        log.error("프로젝트 생성 중 오류", e);
	        redirectAttrs.addFlashAttribute("errorMessage", "프로젝트 등록 실패: " + e.getMessage());
	        return "redirect:/project/insert";
	    }

	    return "redirect:/project/tab";
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
    
	@GetMapping("/projectDetail/{prjctNo}")
	public String projectDetail(@PathVariable int prjctNo, Model model) {
	    log.info("projectDetail -> projectVO {} : ", prjctNo);
	    ProjectVO projectVO = projectService.projectDetail(prjctNo);
	    model.addAttribute("project", projectVO);
	    return "project/projectDetail";
	}
}