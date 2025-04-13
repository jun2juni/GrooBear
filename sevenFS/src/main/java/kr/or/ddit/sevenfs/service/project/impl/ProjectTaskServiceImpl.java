package kr.or.ddit.sevenfs.service.project.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.sevenfs.mapper.AttachFileMapper;
import kr.or.ddit.sevenfs.mapper.project.ProjectTaskMapper;
import kr.or.ddit.sevenfs.service.AttachFileService;
import kr.or.ddit.sevenfs.service.project.ProjectTaskService;
import kr.or.ddit.sevenfs.vo.AttachFileVO;
import kr.or.ddit.sevenfs.vo.project.ProjectTaskVO;
import kr.or.ddit.sevenfs.vo.project.ProjectVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ProjectTaskServiceImpl implements ProjectTaskService {

	@Autowired
	ProjectTaskMapper projectTaskMapper;
	
	@Autowired
	AttachFileMapper attachFileMapper;
	
	@Autowired
	AttachFileService attachFileService;


    @Override
    public void insertProjectTask(ProjectTaskVO taskVO) {
    	
    	if (taskVO.getTaskBeginDt() != null && taskVO.getTaskEndDt() != null) {
    	    long diffInMillies = taskVO.getTaskEndDt().getTime() - taskVO.getTaskBeginDt().getTime();
    	    int daycnt = (int) (diffInMillies / (1000 * 60 * 60 * 24)) + 1;
    	    taskVO.setTaskDaycnt(daycnt);
    	}
    	
        if (taskVO.getTaskSttus() == null || taskVO.getTaskSttus().isBlank()) {
            taskVO.setTaskSttus("00"); 
        }
    	
        if (taskVO.getProgrsrt() == 0) {
            taskVO.setProgrsrt(0);
        }
        
        projectTaskMapper.insertProjectTask(taskVO);
    }


    @Override
    public List<ProjectTaskVO> getParentTasks(int prjctNo) {
        return projectTaskMapper.getParentTasks(prjctNo);
    }

    @Override
    public void insertProjectTaskBatch(List<ProjectTaskVO> taskList) {
        for (ProjectTaskVO taskVO : taskList) {
            projectTaskMapper.insertProjectTask(taskVO);
        }
    }


    @Override
    public ProjectTaskVO getTaskById(Long taskNo) {
    	
        return projectTaskMapper.selectTaskById(taskNo);
    }

    @Override
    public int updateTask(ProjectTaskVO taskVO) {
        if (taskVO != null && taskVO.getAtchFileNo() > 0) {
            List<AttachFileVO> attachFiles = attachFileMapper.getFileAttachList(taskVO.getAtchFileNo());
            taskVO.setAttachFileList(attachFiles);
        }
        return projectTaskMapper.updateTask(taskVO);
    }



    @Override
    public ProjectTaskVO selectTaskById(Long taskNo) {
        ProjectTaskVO task = projectTaskMapper.selectTaskById(taskNo);

        // 첨부 파일 조회
        if (task != null && task.getAtchFileNo() > 0) {
            List<AttachFileVO> attachFiles = attachFileMapper.getFileAttachList(task.getAtchFileNo());
            task.setAttachFileList(attachFiles);
        }

        return task;
    }

    @Override
    public Long insertProjectTaskAndGetId(ProjectTaskVO taskVO) {
        if (taskVO.getTaskBeginDt() != null && taskVO.getTaskEndDt() != null) {
            long diffInMillies = taskVO.getTaskEndDt().getTime() - taskVO.getTaskBeginDt().getTime();
            int daycnt = (int) (diffInMillies / (1000 * 60 * 60 * 24)) + 1;
            taskVO.setTaskDaycnt(daycnt);
        }
        
        // 업무 기본 설정
        taskVO.setTaskSttus("00");
        taskVO.setProgrsrt(0);
        
        projectTaskMapper.insertProjectTask(taskVO);
        return (long) taskVO.getTaskNo(); // MyBatis에서 생성된 키 반환
    }

    @Override
    public void updateTaskParent(Long taskNo, Long parentTaskNo) {
        Map<String, Object> params = new HashMap<>();
        params.put("taskNo", taskNo);
        params.put("parentTaskNo", parentTaskNo);
        projectTaskMapper.updateTaskParent(params);
    }

    @Transactional
    public void updateTaskParentRelations(List<ProjectTaskVO> tasks) {
        for (ProjectTaskVO task : tasks) {
            if (task.getTempParentIndex() != null && !task.getTempParentIndex().isEmpty()) {
                int parentIndex = Integer.parseInt(task.getTempParentIndex());
                if (parentIndex >= 0 && parentIndex < tasks.size()) {
                    ProjectTaskVO parentTask = tasks.get(parentIndex);
                    
                    Map<String, Object> params = new HashMap<>();
                    params.put("taskNo", task.getTaskNo());
                    params.put("parentTaskNo", parentTask.getTaskNo());
                    
                    projectTaskMapper.updateTaskParent(params);
                }
            }
        }
    }
    
    @Override
    public Long insertProjectTaskWithFiles(ProjectTaskVO taskVO, MultipartFile[] uploadFiles) {
        // 기본값 설정
        if (taskVO.getTaskSttus() == null || taskVO.getTaskSttus().isBlank()) {
            taskVO.setTaskSttus("00");
        }
        if (taskVO.getProgrsrt() == 0) {
            taskVO.setProgrsrt(0);
        }

        // 기간 계산
        if (taskVO.getTaskBeginDt() != null && taskVO.getTaskEndDt() != null) {
            long diff = taskVO.getTaskEndDt().getTime() - taskVO.getTaskBeginDt().getTime();
            taskVO.setTaskDaycnt((int)(diff / (1000 * 60 * 60 * 24)) + 1);
        }

        // 파일 처리
        if (uploadFiles != null && uploadFiles.length > 0) {
            AttachFileVO fileVO = new AttachFileVO();
            int result = attachFileService.updateFileList("project/task", uploadFiles, fileVO);
            taskVO.setAtchFileNo(fileVO.getAtchFileNo());
        }

        projectTaskMapper.insertProjectTask(taskVO);
        return (long) taskVO.getTaskNo();
    }


 
	@Override
	public boolean deleteTask(Long taskNo) {
	    return projectTaskMapper.deleteTask(taskNo) > 0;
	}

}
