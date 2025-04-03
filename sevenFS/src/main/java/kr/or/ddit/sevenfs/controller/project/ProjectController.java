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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

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
	


	@GetMapping("/taskList")
	public String taskList() {
		return "project/taskList";
	}



	@GetMapping("/insert")
	 public String projectInsertForm() {
		
		 return "project/insert";
	 }


    @PostMapping("/insert")
    public String projectInsert(
            ProjectVO projectVO,
            @RequestParam(value="uploadFile", required=false) MultipartFile[] uploadFiles,
            @RequestParam(value="emp_no", required=false) String[] empNos,
            @RequestParam(value="emp_role", required=false) String[] empRoles,
            @RequestParam(value="emp_auth", required=false) String[] empAuths,
            @RequestParam(value="task_name", required=false) String[] taskNames,
            @RequestParam(value="task_content", required=false) String[] taskContents,
            @RequestParam(value="task_priority", required=false) String[] taskPriorities,
            @RequestParam(value="task_grad", required=false) String[] taskGrads,
            @RequestParam(value="task_charger", required=false) String[] taskChargers,
            @RequestParam(value="task_begin_dt", required=false) String[] taskBeginDates,
            @RequestParam(value="task_end_dt", required=false) String[] taskEndDates,
            @RequestParam(value="task_progrsrt", required=false) String[] taskProgrsrts,
            @RequestParam(value="task_sttus", required=false) String[] taskStatuses,
            @RequestParam(value="parent_task_id", required=false) String[] parentTaskIds,
            Model model) {
        
        log.info("프로젝트 등록 요청: {}", projectVO);
        
        try {
            // 1. 첨부 파일 처리
            if (uploadFiles != null && uploadFiles.length > 0 && !uploadFiles[0].isEmpty()) {
                long attachFileNo = attachFileService.insertFileList("project", uploadFiles);
                projectVO.setAtchFileNo(attachFileNo);
            }
            
            // 2. 프로젝트 등록 (시퀀스는 MyBatis에서 처리)
            int result = projectService.projectInsert(projectVO);
            
            if (result <= 0) {
                throw new Exception("프로젝트 등록 실패");
            }
            
            // 3. 프로젝트 참여자 처리
            if (empNos != null && empNos.length > 0) {
                List<ProjectEmpVO> projectEmps = new ArrayList<>();
                
                for (int i = 0; i < empNos.length; i++) {
                    ProjectEmpVO empVO = new ProjectEmpVO();
                    empVO.setPrjctNo(projectVO.getPrjctNo());
                    empVO.setPrtcpntEmpno(empNos[i]);
                    empVO.setPrtcpntRole(empRoles != null && i < empRoles.length ? empRoles[i] : "1");
                    empVO.setPrjctAuthor(empAuths != null && i < empAuths.length ? empAuths[i] : "0001");
                    
                    // 책임자가 기본 평가자
                    if ("0".equals(empVO.getPrtcpntRole())) {
                        empVO.setEvlManEmpno(empNos[i]);
                    }
                    
                    empVO.setEvlCn("");
                    empVO.setEvlGrad("1");
                    empVO.setSecsnYn("N");
                    
                    projectEmps.add(empVO);
                }
                
                // 참여자 일괄 등록
                projectService.insertProjectEmpBatch(projectEmps);
                log.info("참여자 목록 등록 완료: {}", projectEmps.size());
            }
            
            // 4. 프로젝트 업무(과제) 처리 - 상위/하위 업무 구조 처리
            if (taskNames != null && taskNames.length > 0) {
                Map<String, Integer> taskIdMap = new HashMap<>();  // 클라이언트 ID와 DB ID 매핑
                
                // 먼저 상위 업무 처리 (parentTaskIds가 없는 항목)
                for (int i = 0; i < taskNames.length; i++) {
                    if (parentTaskIds == null || i >= parentTaskIds.length || 
                        parentTaskIds[i] == null || parentTaskIds[i].isEmpty()) {
                        
                        ProjectTaskVO taskVO = new ProjectTaskVO();
                        taskVO.setPrjctNo(projectVO.getPrjctNo());
                        taskVO.setTaskNm(taskNames[i]);
                        taskVO.setTaskCn(taskContents != null && i < taskContents.length ? 
                                        taskContents[i] : taskNames[i]);
                        taskVO.setChargerEmpno(taskChargers != null && i < taskChargers.length ? 
                                             taskChargers[i] : null);
                        taskVO.setPriort(taskPriorities != null && i < taskPriorities.length ? 
                                       taskPriorities[i] : "01");
                        taskVO.setTaskGrad(taskGrads != null && i < taskGrads.length ? 
                                         taskGrads[i] : "C");
                        taskVO.setProgrsrt(taskProgrsrts != null && i < taskProgrsrts.length ? 
                                         Integer.parseInt(taskProgrsrts[i]) : 0);
                        taskVO.setTaskSttus(taskStatuses != null && i < taskStatuses.length ? 
                                          taskStatuses[i] : "0");
                        
                       
                        
                        // 과제 등록 (서비스를 통한 트랜잭션 처리)
                        projectTaskService.insertProjectTask(taskVO);
                        
                        // 클라이언트 ID 매핑에 저장 (상위 업무 식별용)
                        if (i < taskNames.length) {
                            // "task-N" 형태로 저장 (JSP에서 넘어온 형식)
                            taskIdMap.put("task-" + i, taskVO.getTaskNo());
                        }
                    }
                }
                
                // 이후 하위 업무 처리 (parentTaskIds가 있는 항목)
                for (int i = 0; i < taskNames.length; i++) {
                    if (parentTaskIds != null && i < parentTaskIds.length && 
                        parentTaskIds[i] != null && !parentTaskIds[i].isEmpty()) {
                        
                        ProjectTaskVO taskVO = new ProjectTaskVO();
                        taskVO.setPrjctNo(projectVO.getPrjctNo());
                        
                        // 상위 업무 번호 설정
                        String parentTaskId = parentTaskIds[i];
                        Integer upperTaskNo = taskIdMap.get(parentTaskId);
                        if (upperTaskNo != null) {
                            taskVO.setUpperTaskNo(upperTaskNo);
                        } else {
                            log.warn("상위 업무 ID 매핑 실패: {}", parentTaskId);
                        }
                        
                        taskVO.setTaskNm(taskNames[i]);
                        taskVO.setTaskCn(taskContents != null && i < taskContents.length ? 
                                        taskContents[i] : taskNames[i]);
                        taskVO.setChargerEmpno(taskChargers != null && i < taskChargers.length ? 
                                             taskChargers[i] : null);
                        taskVO.setPriort(taskPriorities != null && i < taskPriorities.length ? 
                                       taskPriorities[i] : "01");
                        taskVO.setTaskGrad(taskGrads != null && i < taskGrads.length ? 
                                         taskGrads[i] : "C");
                        taskVO.setProgrsrt(taskProgrsrts != null && i < taskProgrsrts.length ? 
                                         Integer.parseInt(taskProgrsrts[i]) : 0);
                        taskVO.setTaskSttus(taskStatuses != null && i < taskStatuses.length ? 
                                          taskStatuses[i] : "0");
                        
                     
                        
                        // 과제 등록
                        projectTaskService.insertProjectTask(taskVO);
                    }
                }
            }
            
            return "redirect:/project/projectList";
            
        } catch (Exception e) {
            log.error("프로젝트 등록 중 오류 발생", e);
            model.addAttribute("errorMessage", "프로젝트 등록 중 오류가 발생했습니다: " + e.getMessage());
            return "project/insert";
        }
    }
}