package kr.or.ddit.sevenfs.controller.project;

import kr.or.ddit.sevenfs.mapper.AttachFileMapper;
import kr.or.ddit.sevenfs.service.AttachFileService;
import kr.or.ddit.sevenfs.service.project.ProjectService;
import kr.or.ddit.sevenfs.service.project.ProjectTaskService;
import kr.or.ddit.sevenfs.vo.AttachFileVO;
import kr.or.ddit.sevenfs.vo.project.ProjectEmpVO;
import kr.or.ddit.sevenfs.vo.project.ProjectTaskVO;
import kr.or.ddit.sevenfs.vo.project.ProjectVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequestMapping("/projectTask")
@RequiredArgsConstructor
public class ProjectTaskController {

	private final ProjectTaskService projectTaskService;
	@Autowired
	AttachFileService attachFileService;
	
	@Autowired
	ProjectService projectService;

	// 프로젝트 업무 상세보기
	@GetMapping("/detail")
	public String taskDetail(@RequestParam("taskNo") Long taskNo, Model model) {
		ProjectTaskVO task = projectTaskService.selectTaskById(taskNo);
		model.addAttribute("task", task);
		log.info("task 불러온 결과: {}", task);

		return "project/taskDetailContent";
	}

	// 프로젝트 업무 수정 폼 불러오기
	@GetMapping("/editForm")
	public String editTaskForm(@RequestParam("taskNo") Long taskNo, Model model) {
	    // 1. 해당 업무(taskNo) 정보 조회
	    ProjectTaskVO task = projectTaskService.selectTaskById(taskNo);
	    model.addAttribute("task", task);

	    // 2. 프로젝트 참여자 목록 조회 (참여자 중에서 담당자 선택용)
	    int prjctNo = (int)task.getPrjctNo(); // 업무에 연결된 프로젝트 번호
	    ProjectVO project = projectService.projectDetail(prjctNo); // 프로젝트 상세 + 참여자 분리됨
	    model.addAttribute("project", project);

	    return "project/taskEditForm"; // 뷰 경로에 맞게 수정
	}


	// 간트,칸반 차트용 업무 수정 모달 폼 불러오기
	@GetMapping("/taskEditModal")
	public String taskEditModal(@RequestParam("taskNo") Long taskNo, Model model) {
	    ProjectTaskVO task = projectTaskService.selectTaskById(taskNo);
	    
	    if (task == null) {
	        throw new IllegalArgumentException("해당 업무를 찾을 수 없습니다: taskNo=" + taskNo);
	    }
	    
	    int prjctNo = (int) task.getPrjctNo();
	    ProjectVO project = projectService.projectDetail(prjctNo);

	    model.addAttribute("task", task);
	    model.addAttribute("project", project);

	    return "project/taskEditModal";
	}

	
	@GetMapping("/taskAddModal")
	public String taskAddModal(@RequestParam("prjctNo") int prjctNo,
	                           @RequestParam(value = "mode", defaultValue = "default") String mode,
	                           Model model) {
	    ProjectVO project = projectService.projectDetail(prjctNo);
	    model.addAttribute("project", project);

	    
	    if ("gantt".equals(mode)) {
	        return "project/taskAddModal_gantt";
	    } else {
	        return "project/taskAddModal"; // 기존 projectDetail용
	    }
	}


	@PostMapping("/update")
	public String updateTask(@ModelAttribute ProjectTaskVO taskVO,
	                         BindingResult bindingResult,
	                         @RequestParam(value = "uploadFiles", required = false) MultipartFile[] uploadFiles,
	                         @RequestParam(value = "removeFileId", required = false) int[] removeFileIds,
	                         @RequestParam(value = "source", required = false) String source,
	                         RedirectAttributes ra) {

	    if (bindingResult.hasErrors()) {
	        log.error("📛 업무 수정 시 바인딩 오류 발생: {}", bindingResult);
	        ra.addFlashAttribute("message", "업무 수정 실패: 입력값 오류");
	        return "redirect:/project/projectDetail?prjctNo=" + taskVO.getPrjctNo();
	    }

	    log.info("📌 업무 수정 요청 - taskNo: {}", taskVO.getTaskNo());

	    // 업무 상태 기본값 처리
	    if (taskVO.getTaskSttus() == null) {
	        taskVO.setTaskSttus("00");
	        log.info("📌 업무 상태 NULL 감지, 기본값 '00'(대기) 설정");
	    }

	    // 파일 처리 준비
	    boolean hasUpload = uploadFiles != null && uploadFiles.length > 0;
	    boolean hasDelete = removeFileIds != null && removeFileIds.length > 0;

//	    if (hasUpload || hasDelete) {
//	        AttachFileVO fileVO = new AttachFileVO();
//	        fileVO.setRemoveFileId(removeFileIds);
//
//	        // 파일이 새로 추가되고 기존에 파일이 없던 업무일 경우
//	        if (taskVO.getAtchFileNo() == 0 && hasUpload) {
//	            long newAtchFileNo = attachFileService.getAttachFileNo();
//	            taskVO.setAtchFileNo(newAtchFileNo);
//	            fileVO.setAtchFileNo(newAtchFileNo);
//	            log.debug("🆕 새 첨부파일 번호 생성됨: {}", newAtchFileNo);
//	        } else {
//	            fileVO.setAtchFileNo(taskVO.getAtchFileNo());
//	        }
//
//	        int result = attachFileService.updateFileList("project/task", uploadFiles, fileVO);
//	        log.debug("📎 파일 업데이트 결과: {}", result);
//	    }

	    // 실제 업무 업데이트
	    int updated = projectTaskService.updateTask(taskVO, uploadFiles, removeFileIds);
	    ra.addFlashAttribute("message", updated > 0 ? "수정 성공" : "수정 실패");

	    if ("gantt".equals(source)) {
	        return "redirect:/project/tab?tab=gantt&prjctNo=" + taskVO.getPrjctNo();
	    } else {
	        return "redirect:/project/projectDetail?prjctNo=" + taskVO.getPrjctNo();
	    }
	}


	@PostMapping("/updateAjax")
	@ResponseBody
	public ResponseEntity<?> updateTaskAjax(
	    @ModelAttribute ProjectTaskVO taskVO,
	    BindingResult bindingResult,
	    @RequestParam(value = "uploadFiles", required = false) MultipartFile[] uploadFiles,
	    @RequestParam(value = "removeFileId", required = false) int[] removeFileIds,
	    @RequestParam(value = "source", required = false) String source) {

	    try {
	        if (bindingResult.hasErrors()) {
	            return ResponseEntity.badRequest().body("업무 수정 실패: 입력값 오류");
	        }

	        log.info(" [AJAX] 업무 수정 요청 - taskNo: {}", taskVO.getTaskNo());

	        // 파일 처리
	        AttachFileVO fileVO = new AttachFileVO();
	        fileVO.setAtchFileNo(taskVO.getAtchFileNo());
	        fileVO.setRemoveFileId(removeFileIds);

	        if ((uploadFiles != null && uploadFiles.length > 0) || removeFileIds != null) {
	            int result = attachFileService.updateFileList("project/task", uploadFiles, fileVO);
	            if (result > 0) {
	                taskVO.setAtchFileNo(fileVO.getAtchFileNo());
	            }
	        }

	        int updated = projectTaskService.updateTask(taskVO, uploadFiles, removeFileIds);


	        if (updated > 0) {
	            return ResponseEntity.ok("업무 수정 성공");
	        } else {
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("업무 수정 실패");
	        }

	    } catch (Exception e) {
	        log.error(" [AJAX] 업무 수정 오류", e);
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류");
	    }
	}

	
	@GetMapping("/download")
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestParam String fileName) {
	    return attachFileService.downloadFile(fileName);
	}

	@PostMapping("/insert")
	@ResponseBody
	public ResponseEntity<?> insertTask(
	    @ModelAttribute ProjectTaskVO taskVO,
	    @RequestParam(value = "uploadFiles", required = false) MultipartFile[] uploadFiles,
	    @RequestParam(value = "source", required = false) String source) {
	    
	    try {
	        log.info("프로젝트 업무 등록 시작 - 소스: {}", source);
	        log.info("업무명: {}, 상위업무: {}", taskVO.getTaskNm(), taskVO.getUpperTaskNo());
	        
	        // 파일 확인 로깅
	        if (uploadFiles != null) {
	            log.info("첨부 파일 개수: {}", uploadFiles.length);
	        } else {
	            log.info("첨부 파일 없음");
	        }
	        
	        if (uploadFiles != null && uploadFiles.length > 0) {
	            long atchFileNo = attachFileService.getAttachFileNo();
	            taskVO.setAtchFileNo(atchFileNo);
	        }

	        Long taskNo = projectTaskService.insertProjectTaskWithFiles(taskVO, uploadFiles);

	        Map<String, Object> response = new HashMap<>();
	        response.put("success", true);
	        response.put("taskNo", taskNo);
	        response.put("prjctNo", taskVO.getPrjctNo());
	        
	        return ResponseEntity.ok(response);
	        
	    } catch (Exception e) {
	        log.error("업무 등록 중 오류", e);
	        Map<String, Object> errorResponse = new HashMap<>();
	        errorResponse.put("success", false);
	        errorResponse.put("message", e.getMessage());
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
	    }
	}
	


	@GetMapping("/partialList")
	public String partialTaskList(
	        @RequestParam("prjctNo") Long prjctNo, 
	        @RequestParam(value = "page", required = false, defaultValue = "1") int page,
	        Model model) {
	    
	    // 프로젝트 정보 조회 (taskList 포함)
	    ProjectVO project = projectService.projectDetail(prjctNo);
	    
	    // 프로젝트가 존재하고 태스크 리스트가 있을 경우에만 페이지네이션 처리
	    if (project != null && project.getTaskList() != null && !project.getTaskList().isEmpty()) {
	        List<ProjectTaskVO> allTasks = project.getTaskList();
	        
	        // 페이지 파라미터 및 페이지당 아이템 수 설정
	        int itemsPerPage = 10; // 페이지당 10개 아이템
	        int totalItems = allTasks.size();
	        int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);
	        
	        // 현재 페이지 유효성 검사
	        if (page < 1) page = 1;
	        if (page > totalPages) page = totalPages;
	        
	        // 현재 페이지에 해당하는 태스크만 추출
	        int fromIndex = (page - 1) * itemsPerPage;
	        int toIndex = Math.min(fromIndex + itemsPerPage, totalItems);
	        
	        List<ProjectTaskVO> pagedTasks;
	        if (fromIndex < totalItems) {
	            pagedTasks = allTasks.subList(fromIndex, toIndex);
	            // 원래 프로젝트의 태스크 리스트를 페이징된 리스트로 교체
	            project.setTaskList(pagedTasks);
	        }
	        
	        // 페이지네이션 정보 모델에 추가
	        model.addAttribute("currentPage", page);
	        model.addAttribute("totalPages", totalPages);
	    }
	    
	    model.addAttribute("project", project);
	    return "project/taskListPartial"; 
	}


	@GetMapping("/delete")
	public String deleteTask(@RequestParam("taskNo") Long taskNo,
	                         @RequestParam("prjctNo") Long prjctNo,
	                         RedirectAttributes ra) {
	    // 하위 업무가 있는지 확인
	    if (projectTaskService.hasChildTasks(taskNo)) {
	        ra.addFlashAttribute("message", "하위 업무가 있는 업무는 삭제할 수 없습니다. 먼저 하위 업무를 삭제해주세요.");
	        return "redirect:/project/projectDetail?prjctNo=" + prjctNo;
	    }
	    
	    boolean success = projectTaskService.deleteTask(taskNo);
	    ra.addFlashAttribute("message", success ? "업무가 삭제되었습니다." : "삭제 실패");
	    return "redirect:/project/projectDetail?prjctNo=" + prjctNo;
	}

	// 하위업무 삭제해야 상위업무 삭제할 수 있는 엔드포인트임
	@GetMapping("/hasChildTasks")
	@ResponseBody
	public Map<String, Boolean> hasChildTasks(@RequestParam("taskNo") Long taskNo) {
	    Map<String, Boolean> response = new HashMap<>();
	    response.put("hasChildren", projectTaskService.hasChildTasks(taskNo));
	    return response;
	}
	
    @GetMapping("/checkAssignee")
    @ResponseBody
    public Map<String, Object> checkAssignee(@RequestParam int prjctNo, @RequestParam String empNo) {
        boolean hasTask = projectTaskService.hasTaskAssigned(prjctNo, empNo);
        Map<String, Object> result = new HashMap<>();
        result.put("hasTask", hasTask);
        return result;
    }

}
