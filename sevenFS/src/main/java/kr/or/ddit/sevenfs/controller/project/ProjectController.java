package kr.or.ddit.sevenfs.controller.project;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
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

import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.sevenfs.mapper.common.CommonCodeMapper;
import kr.or.ddit.sevenfs.mapper.project.ProjectTaskMapper;
import kr.or.ddit.sevenfs.service.AttachFileService;
import kr.or.ddit.sevenfs.service.common.CommonCodeService;
import kr.or.ddit.sevenfs.service.project.GanttService;
import kr.or.ddit.sevenfs.service.project.ProjectService;
import kr.or.ddit.sevenfs.service.project.ProjectTaskService;
import kr.or.ddit.sevenfs.utils.ArticlePage;
import kr.or.ddit.sevenfs.vo.AttachFileVO;
import kr.or.ddit.sevenfs.vo.project.ProjectEmpVO;
import kr.or.ddit.sevenfs.vo.project.ProjectTaskVO;
import kr.or.ddit.sevenfs.vo.project.ProjectVO;
import kr.or.ddit.sevenfs.vo.project.GanttTaskVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/project")
public class ProjectController {
	
	@Autowired
	private ProjectService projectService;
	
	@Autowired
	private AttachFileService attachFileService;
	@Autowired
	private ProjectTaskService projectTaskService;
	
	
    @Autowired
    private CommonCodeService commonCodeService;
	
	@Autowired
	GanttService ganttService;
	
	
	@GetMapping("/tab")
	public String projectTab(@RequestParam(required = false) Integer prjctNo, Model model) {

	    // 프로젝트 상세 (있을 경우)
	    if (prjctNo != null) {
	        ProjectVO project = projectService.projectDetail(prjctNo);
	        model.addAttribute("project", project); 
	    }

	    // 프로젝트 목록 (좌측 리스트용)
	    List<ProjectVO> projectList = projectService.selectAllProjects(); // ← 이 메서드가 있어야 함
	    model.addAttribute("projectList", projectList); // ← 좌측 프로젝트 목록으로 사용됨

	    return "project/projectTab";
	}



	
	@GetMapping("/projectList")
	public String projectList(Model model, ProjectVO projectVO,
	    @RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
	    @RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
	    @RequestParam(value = "mode", required = false) String mode) { // 🔍 mode 추가

	    Map<String, Object> map = new HashMap<>();
	    map.put("currentPage", currentPage);
	    map.put("keyword", keyword);

	    int size = (mode != null && mode.equals("kanban")) ? 100 : 5; // 업무보드 전용일 때는 더 많이 보여줘
	    map.put("size", size);

	    int total = projectService.getTotal(map);
	    List<ProjectVO> projectList = projectService.projectList(map);
	    log.info("projectList prjctNo 포함되는지??", projectList);

	    ArticlePage<ProjectVO> articlePage = new ArticlePage<>(total, currentPage, size);
	    articlePage.setSearchVo(projectVO);

	    int startNumber = total - ((currentPage - 1) * size);
	    model.addAttribute("startNumber", startNumber);

	    model.addAttribute("articlePage", articlePage);
	    model.addAttribute("projectList", projectList);
	    model.addAttribute("totalProjectCount", total);
	    model.addAttribute("mode", mode); 

	    return "project/projectList";
	}

	@GetMapping("/list/simple")
	@ResponseBody
	public List<Map<String, Object>> getSimpleProjectList() {
	  List<Map<String, Object>> result = new ArrayList<>();
	  List<ProjectVO> projects = projectService.getAllProjects();
	  
	  for (ProjectVO project : projects) {
	    Map<String, Object> projectMap = new HashMap<>();
	    projectMap.put("prjctNo", project.getPrjctNo());
	    projectMap.put("prjctNm", project.getPrjctNm());
	    result.add(projectMap);
	  }
	  
	  return result;
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

	    redirectAttrs.addFlashAttribute("successMessage", "프로젝트가 성공적으로 등록되었습니다!");
	    return "redirect:/project/projectTab?tab=list&highlight=" + projectVO.getPrjctNo();

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
	                    // 매퍼 직접 호출 대신 서비스 메서드 호출
	                    boolean updated = projectTaskService.updateTaskParent(task.getTaskNo(), parentTaskNo);
	                    log.info("업무 관계 업데이트 {}: 업무 {} -> 상위 업무 {}", 
	                            updated ? "성공" : "실패", task.getTaskNo(), parentTaskNo);
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


	/*
	 * @PostMapping("/delete")
	 * 
	 * @ResponseBody public ResponseEntity<String>
	 * deleteProject(@RequestParam("prjctNo") int prjctNo) {
	 * log.info(" 삭제 요청 도착: {}", prjctNo); try {
	 * projectService.deleteProject(prjctNo); return ResponseEntity.ok("삭제 성공"); }
	 * catch (Exception e) { log.error(" 삭제 실패", e); return
	 * ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("삭제 실패"); } }
	 */
	// ProjectController.java

	@DeleteMapping("/delete/{prjctNo}")
	@ResponseBody
	public ResponseEntity<?> deleteProject(@PathVariable Long prjctNo) {
	    try {
	        boolean success = projectService.deleteProject(prjctNo);
	        if (success) {
	        	return ResponseEntity.ok().body(Map.of("success", true, "message", "프로젝트가 삭제되었습니다."));
	        } else {
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	                .body(Map.of("success", false, "message", "프로젝트 삭제 실패"));
	        }
	    } catch (Exception e) {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	            .body(Map.of("success", false, "message", "오류: " + e.getMessage()));
	    }
	}



	@GetMapping("/editForm")
	public String editForm(@RequestParam("prjctNo") int prjctNo, Model model) {
	    ProjectVO project = projectService.projectDetail(prjctNo);
	    model.addAttribute("project", project);
	    return "project/editForm";
	}

	@PostMapping("/update")
	public String updateProject(ProjectVO projectVO, Model model,
	                            @RequestParam(value ="emp_no", required = false) String[] empNos,
	                            @RequestParam(value ="emp_role", required = false) String[] empRoles,
	                            @RequestParam(value = "emp_auth", required = false) String[] empAuths) {
		model.addAttribute("categoryList", projectService.getProjectCategoryList());
		model.addAttribute("projectStatusList", projectService.getProjectStatusList());
		model.addAttribute("projectGradeList", projectService.getProjectGradeList());

	    // 참여자 리스트 재구성
	    List<ProjectEmpVO> empList = new ArrayList<>();
	    if(empNos != null && empNos.length > 0) {
		    for (int i = 0; i < empNos.length; i++) {
		        ProjectEmpVO empVO = new ProjectEmpVO();
		        empVO.setPrtcpntEmpno(empNos[i]);
		        empVO.setPrtcpntRole(empRoles[i]);
		        empVO.setPrjctAuthor("0000");
		        empVO.setEvlManEmpno(empNos[i]);
		        empVO.setEvlCn("수정됨");
		        empVO.setEvlGrad("1");
		        empVO.setPrjctNo(projectVO.getPrjctNo());
		        empList.add(empVO);
		    }
	    }
	    projectVO.setProjectEmpVOList(empList);
	    boolean result = projectService.updateProject(projectVO);
	    return "redirect:/project/projectDetail?prjctNo=" + projectVO.getPrjctNo();
	}

	
	
	
	 /**
     * 프로젝트 칸반보드 화면 표시
     */
    @GetMapping("/kanban")
    public String projectKanban(Model model) {
        log.debug("프로젝트 칸반보드 화면 요청");
        
        // 상태별 프로젝트 목록 조회
        List<ProjectVO> waitingProjects = projectService.getProjectsByStatus("00");
        List<ProjectVO> inProgressProjects = projectService.getProjectsByStatus("01");
        List<ProjectVO> completedProjects = projectService.getProjectsByStatus("02");
        List<ProjectVO> canceledProjects = projectService.getProjectsByStatus("03");
        
        // 모델에 데이터 추가
        model.addAttribute("waitingProjects", waitingProjects);
        model.addAttribute("inProgressProjects", inProgressProjects);
        model.addAttribute("completedProjects", completedProjects);
        model.addAttribute("canceledProjects", canceledProjects);
        model.addAttribute("projectCategoryList", projectService.getProjectCategoryList());
        
        // 프로젝트 상태 및 등급 정보 추가
        model.addAttribute("projectStatusList", projectService.getProjectStatusList());
        model.addAttribute("projectGradeList", projectService.getProjectGradeList());
        
        return "project/projectKanban";
    }
    
    /**
     * 프로젝트 상태 업데이트 (드래그 앤 드롭)
     */
    @PostMapping("/kanban/update-project-status")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateProjectStatus(@RequestBody Map<String, String> requestData) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            String projectNo = requestData.get("projectNo");
            String status = requestData.get("status");
            
            log.debug("프로젝트 상태 업데이트 요청: 프로젝트번호={}, 상태={}", projectNo, status);
            
            // 상태 업데이트 서비스 호출
            boolean updated = projectService.updateProjectStatus(projectNo, status);
            
            if (updated) {
                response.put("success", true);
                response.put("message", "프로젝트 상태가 성공적으로 업데이트되었습니다.");
            } else {
                response.put("success", false);
                response.put("message", "프로젝트 상태 업데이트에 실패했습니다.");
            }
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            log.error("프로젝트 상태 업데이트 오류", e);
            response.put("success", false);
            response.put("message", "서버 오류가 발생했습니다: " + e.getMessage());
            return ResponseEntity.internalServerError().body(response);
        }
    }

    //엑셀 다운로드
    @GetMapping("/downloadExcel")
    public void downloadExcel(
            HttpServletResponse response,
            @RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
            @RequestParam(value = "keyword", required = false, defaultValue = "") String keyword) throws IOException {
        
        // 모든 프로젝트를 가져오기 위해 페이지 크기를 크게 설정
        Map<String, Object> map = new HashMap<>();
        map.put("currentPage", 1);  // 모든 데이터를 가져오기 위해 첫 페이지로 설정
        map.put("size", 1000);      // 큰 값으로 설정하여 모든 데이터 가져오기
        map.put("keyword", keyword);
        
        List<ProjectVO> projects = projectService.projectList(map);
        
        // Excel 파일 생성
        XSSFWorkbook workbook = new XSSFWorkbook();
        XSSFSheet sheet = workbook.createSheet("프로젝트 목록");
        
        // 헤더 스타일
        CellStyle headerStyle = workbook.createCellStyle();
        XSSFFont headerFont = workbook.createFont();
        headerFont.setBold(true);
        headerStyle.setFont(headerFont);
        headerStyle.setAlignment(HorizontalAlignment.CENTER);
        
        // 헤더 행 생성
        Row headerRow = sheet.createRow(0);
        String[] headers = {"순번", "프로젝트명", "카테고리", "책임자", "상태", "등급", "시작일", "종료일"};
        
        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
            cell.setCellStyle(headerStyle);
            sheet.setColumnWidth(i, 4000); // 칼럼 너비 설정
        }
        
        // 데이터 행 생성
        int rowNum = 1;
        for (ProjectVO project : projects) {
            Row row = sheet.createRow(rowNum++);
            
            row.createCell(0).setCellValue(rowNum - 1);
            row.createCell(1).setCellValue(project.getPrjctNm());
            row.createCell(2).setCellValue(project.getCtgryNm());
            row.createCell(3).setCellValue(project.getPrtcpntNm());
            row.createCell(4).setCellValue(project.getPrjctSttusNm());
            row.createCell(5).setCellValue(project.getPrjctGrad());
            row.createCell(6).setCellValue(project.getPrjctBeginDateFormatted());
            row.createCell(7).setCellValue(project.getPrjctEndDateFormatted());
        }
        
        // 파일 다운로드 설정
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        String fileName = URLEncoder.encode("프로젝트_목록_" + LocalDate.now() + ".xlsx", "UTF-8");
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
        
        // 파일 출력
        ServletOutputStream outputStream = response.getOutputStream();
        workbook.write(outputStream);
        workbook.close();
        outputStream.close();
    }
    
}