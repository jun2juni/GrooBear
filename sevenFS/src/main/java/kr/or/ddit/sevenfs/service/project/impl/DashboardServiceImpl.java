package kr.or.ddit.sevenfs.service.project.impl;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.sevenfs.mapper.project.DashboardMapper;
import kr.or.ddit.sevenfs.service.project.DashboardService;
import kr.or.ddit.sevenfs.vo.project.ProjectTaskVO;
import kr.or.ddit.sevenfs.vo.project.ProjectVO;

@Service
public class DashboardServiceImpl implements DashboardService {
    @Autowired
    private DashboardMapper dashboardMapper;

    @Override
    public List<Map<String, Object>> countProjectByStatus() {
        return dashboardMapper.countProjectByStatus();
    }

    @Override
    public List<Map<String, Object>> countTaskMainStatus() {
        return dashboardMapper.countTaskMainStatus();
    }

    @Override
    public List<Map<String, Object>> countTaskByGrade() {
        return dashboardMapper.countTaskByGrade();
    }

    @Override
    public List<Map<String, Object>> countTaskByProgressGroup() {
        return dashboardMapper.countTaskByProgressGroup();
    }

    @Override
    public List<ProjectTaskVO> selectUrgentTasks() {
        return dashboardMapper.selectUrgentTasks();
    }

    @Override
    public List<ProjectVO> selectMyProjects(int emplNo) {
        return dashboardMapper.selectMyProjects(emplNo);
    }

	@Override
	public List<Map<String, Object>> countTaskByPriort() {
		// TODO Auto-generated method stub
		return dashboardMapper.countTaskByPriort();
	}
	
	@Override
	public Map<String, Map<String, String>> getCommonCodes() {
	    List<Map<String, Object>> list = dashboardMapper.selectCommonCodes();
	    Map<String, Map<String, String>> result = new HashMap<>();

	    for (Map<String, Object> row : list) {
	        String group = (String) row.get("CMMN_CODE_GROUP");
	        String code = (String) row.get("CMMN_CODE");
	        String name = (String) row.get("CMMN_CODE_NM");

	        result.computeIfAbsent(group, k -> new LinkedHashMap<>()).put(code, name);
	    }

	    return result;
	}
	
	@Override
	public List<ProjectTaskVO> selectUrgentTasksAll() {
	    return dashboardMapper.selectUrgentTasks();
	}


}
