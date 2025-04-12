package kr.or.ddit.sevenfs.service.project.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.sevenfs.mapper.AttachFileMapper;
import kr.or.ddit.sevenfs.mapper.project.ProjectTaskMapper;
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


    @Override
    public void insertProjectTask(ProjectTaskVO taskVO) {
    	
    	if (taskVO.getTaskBeginDt() != null && taskVO.getTaskEndDt() != null) {
    	    long diffInMillies = taskVO.getTaskEndDt().getTime() - taskVO.getTaskBeginDt().getTime();
    	    int daycnt = (int) (diffInMillies / (1000 * 60 * 60 * 24)) + 1;
    	    taskVO.setTaskDaycnt(daycnt);
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
	public boolean deleteTask(Long taskNo) {
	    return projectTaskMapper.deleteTask(taskNo) > 0;
	}

}
