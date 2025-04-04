package kr.or.ddit.sevenfs.controller.project;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.sevenfs.service.AttachFileService;
import kr.or.ddit.sevenfs.service.project.ProjectService;
import kr.or.ddit.sevenfs.service.project.ProjectTaskService;
import kr.or.ddit.sevenfs.vo.project.ProjectTaskVO;
import kr.or.ddit.sevenfs.vo.project.ProjectVO;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("/project/task")
public class ProjectTaskController {

	@Autowired
	private ProjectTaskService projectTaskService;
	
	@Autowired
	private AttachFileService attachFileService;
	
	// 단일 업무 등록
    @GetMapping("/insert/{prjctNo}")
    public String insertProjectTaskForm(@PathVariable("prjctNo") int prjctNo, Model model) {
        model.addAttribute("prjctNo", prjctNo);
        return "project/insert";
    }
	
    // 단일업무 등록
    @PostMapping("/insert")
    public String insertProjectTask(ProjectTaskVO taskVO, 
                            @RequestParam(value="uploadFile", required=false) MultipartFile[] uploadFile) {
        log.info("업무 등록 요청: {}", taskVO);
        
      
            // 파일 업로드 처리
            if (uploadFile != null && uploadFile.length > 0 && !uploadFile[0].isEmpty()) {
                long attachFileNo = attachFileService.insertFileList("projectTask", uploadFile);
                taskVO.setAtchFileNo((int)attachFileNo);
            }
            
            // 업무 등록
            projectTaskService.insertProjectTask(taskVO);
            
            return "redirect:/project/projectDetail/" + taskVO.getPrjctNo();
        
    }
    
    
    /**
     * 상위 업무 목록 조회 (AJAX)
     */
    @GetMapping("/parentTasks/{prjctNo}")
    @ResponseBody
    public List<ProjectTaskVO> getParentTasks(@PathVariable("prjctNo") int prjctNo) {
        return projectTaskService.getParentTasks(prjctNo);
    }
    
    // 복수 업무 입력 폼
    @GetMapping("/batchTaskInsert/{prjctNo}")
    public String batchTaskInsertForm(@PathVariable("prjctNo") int prjctNo, Model model) {
        model.addAttribute("prjctNo", prjctNo);
        return "project/batchTaskInsert"; 
    }

    @PostMapping("/batchInsert")
    public String batchTaskInsert(
        @RequestParam("prjctNo") int prjctNo,
        @ModelAttribute("projectTaskVOList") List<ProjectTaskVO> projectTaskVOList,
        @RequestParam(value="uploadFile", required=false) MultipartFile[] uploadFiles) {
        
            for (ProjectTaskVO taskVO : projectTaskVOList) {
                taskVO.setPrjctNo(prjctNo);
                projectTaskService.insertProjectTaskBatch(projectTaskVOList);
            }

            return "redirect:/project/projectDetail/" + prjctNo;

    }

}
