package kr.or.ddit.sevenfs.mapper.project;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.sevenfs.vo.project.ProjectVO;


@Mapper
public interface ProjectMapper {

	public List<ProjectVO> projectList();

}
