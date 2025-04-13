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
		log.info("받은 upperTaskNo: {}", taskVO.getUpperTaskNo());
	    // 파일 수정 처리
	    AttachFileVO fileVO = new AttachFileVO();
	    fileVO.setAtchFileNo(taskVO.getAtchFileNo());
	    fileVO.setRemoveFileId(removeFileIds);

	    // 여기서 updateFileList가 새 번호를 설정해주지는 않기 때문에 수동으로 설정해야 함
	    int result = 0;
	    if (uploadFiles != null && uploadFiles.length > 0 || removeFileIds != null) {
	        result = attachFileService.updateFileList("project/task", uploadFiles, fileVO);

	        // 파일 번호가 없으면 새로 발급됨 (서비스 내부에서 getAttachFileNo 사용)
	        if (fileVO.getAtchFileNo() > 0) {
	            taskVO.setAtchFileNo(fileVO.getAtchFileNo());
	        }
	    }

	    int update = projectTaskService.updateTask(taskVO);
	    ra.addFlashAttribute("message", update > 0 ? "수정 성공" : "수정 실패");

	    
	    return "redirect:/project/projectDetail?prjctNo=" + taskVO.getPrjctNo();
	}
	
	@GetMapping("/download")
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestParam String fileName) {
	    return attachFileService.downloadFile(fileName);
	}

	@PostMapping("/insert")
	@ResponseBody
	public ResponseEntity<?> insertTask(ProjectTaskVO taskVO,
	                                    @RequestParam(value = "uploadFiles", required = false) MultipartFile[] uploadFiles) {
	    try {
	        Long taskNo = projectTaskService.insertProjectTaskWithFiles(taskVO, uploadFiles);
	        return ResponseEntity.ok(taskNo); // 프론트에 taskNo 넘겨줌
	    } catch (Exception e) {
	        log.error("업무 등록 중 오류", e);
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("fail");
	    }
	}

	// 업무 부분 조회 
	@GetMapping("/partialList")
	public String getPartialTaskList(@RequestParam int prjctNo, Model model) {
	    ProjectVO project = projectService.projectDetail(prjctNo);
	    model.addAttribute("project", project);
	    return "project/taskListPartial"; 
	}






	
	@GetMapping("/delete")
	public String deleteTask(@RequestParam("taskNo") Long taskNo,
	                         @RequestParam("prjctNo") Long prjctNo,
	                         RedirectAttributes ra) {
	    boolean success = projectTaskService.deleteTask(taskNo);
	    ra.addFlashAttribute("message", success ? "업무가 삭제되었습니다." : "삭제 실패");
	    return "redirect:/project/projectDetail?prjctNo=" + prjctNo;
	}


}
