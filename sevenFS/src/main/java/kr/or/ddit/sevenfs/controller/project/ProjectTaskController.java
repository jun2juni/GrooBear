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





	// 프로젝트 업무 수정
	@PostMapping("/update")
	public String updateTask(ProjectTaskVO taskVO,
	                         @RequestParam(value = "uploadFiles", required = false) MultipartFile[] uploadFiles,
	                         @RequestParam(value = "removeFileId", required = false) int[] removeFileIds,
	                         RedirectAttributes ra) {
	    log.info("📌 업무 수정 요청 - taskNo: {}", taskVO.getTaskNo());

	    // 첨부파일 정보 구성
	    AttachFileVO fileVO = new AttachFileVO();
	    fileVO.setAtchFileNo(taskVO.getAtchFileNo());
	    fileVO.setRemoveFileId(removeFileIds);

	    // 파일 수정 처리
	    if ((uploadFiles != null && uploadFiles.length > 0) || removeFileIds != null) {
	        int result = attachFileService.updateFileList("project/task", uploadFiles, fileVO);
	        log.info("📂 파일 저장 결과: {}", result);

	        // 저장된 파일 번호가 있으면 VO에 설정
	        if (result > 0) {
	            taskVO.setAtchFileNo(fileVO.getAtchFileNo());
	        }
	    }

	    // 로그 출력
	    log.info("📝 수정할 업무명: {}", taskVO.getTaskNm());
	    log.info("📎 파일 수: {}", uploadFiles != null ? uploadFiles.length : 0);
	    if (uploadFiles != null) {
	        for (MultipartFile mf : uploadFiles) {
	            log.info(" - {} ({} bytes)", mf.getOriginalFilename(), mf.getSize());
	        }
	    }

	    // 업무 업데이트 수행
	    int updated = projectTaskService.updateTask(taskVO);
	    ra.addFlashAttribute("message", updated > 0 ? "수정 성공" : "수정 실패");

	    return "redirect:/project/projectDetail?prjctNo=" + taskVO.getPrjctNo();
	}

	
	@GetMapping("/download")
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestParam String fileName) {
	    return attachFileService.downloadFile(fileName);
	}

	@PostMapping("/insert")
	@ResponseBody
	public ResponseEntity<?> insertTask(@ModelAttribute ProjectTaskVO taskVO,
	                                    @RequestParam(value = "uploadFiles", required = false) MultipartFile[] uploadFiles) {
	    try {
	        log.info("프로젝트 업무 등록 시작");
	        log.info("업무명: {}", taskVO.getTaskNm());

	        
	        // 파일 확인 로깅
	        if (uploadFiles != null) {
	            log.info("첨부 파일 개수: {}", uploadFiles.length);
	            for (int i = 0; i < uploadFiles.length; i++) {
	                MultipartFile file = uploadFiles[i];
	                log.info("파일[{}]: 이름={}, 크기={}, 타입={}", 
	                       i, 
	                       file.getOriginalFilename(), 
	                       file.getSize(),
	                       file.getContentType());
	            }
	        } else {
	            log.info("첨부 파일 없음");
	        }
	        // 반드시 직접 attachFileNo를 먼저 설정해줘야 함
	        if (uploadFiles != null && uploadFiles.length > 0) {
	            long atchFileNo = attachFileService.getAttachFileNo(); // 시퀀스 미리 생성
	            taskVO.setAtchFileNo(atchFileNo);
	        }

	        Long taskNo = projectTaskService.insertProjectTaskWithFiles(taskVO, uploadFiles);

	        Map<String, Object> response = new HashMap<>();
	        response.put("success", true);
	        response.put("taskNo", taskNo);
	        response.put("prjctNo", taskVO.getPrjctNo());
	        
	        log.info("업무명: {}", taskVO.getTaskNm());
	        log.info("파일 개수: {}", uploadFiles != null ? uploadFiles.length : 0);
	        if (uploadFiles != null) {
	            for (MultipartFile mf : uploadFiles) {
	                log.info("파일 이름: {}, 크기: {}", mf.getOriginalFilename(), mf.getSize());
	            }
	        }


	        return ResponseEntity.ok(response);
	    } catch (Exception e) {
	        log.error("업무 등록 중 오류", e);
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("fail");
	        
	        
	    }

	}



	@GetMapping("/partialList")
	public String partialTaskList(@RequestParam("prjctNo") Long prjctNo, Model model) {
	    ProjectVO project = projectService.projectDetail(prjctNo); // ← taskList 포함
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

}
