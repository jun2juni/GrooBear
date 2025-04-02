package kr.or.ddit.sevenfs.service.project;

import java.util.List;
import java.util.Map;

import kr.or.ddit.sevenfs.utils.ArticlePage;
import kr.or.ddit.sevenfs.vo.AttachFileVO;
import kr.or.ddit.sevenfs.vo.project.ProjectVO;

public interface ProjectService {

	public List<ProjectVO> projectList(Map<String, Object> map);
	public int getTotal(Map<String, Object> map);
}
