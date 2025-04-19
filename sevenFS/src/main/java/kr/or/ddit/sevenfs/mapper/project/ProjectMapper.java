package kr.or.ddit.sevenfs.mapper.project;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.sevenfs.vo.project.ProjectEmpVO;
import kr.or.ddit.sevenfs.vo.project.ProjectVO;

/**
 * 프로젝트 관련 데이터베이스 매퍼 인터페이스
 */
@Mapper
public interface ProjectMapper {
    /**
     * 조건에 맞는 프로젝트 목록 조회
     * @param map 검색 조건 맵
     * @return 프로젝트 목록
     */
    public List<ProjectVO> projectList(Map<String, Object> map);
    
    /**
     * 프로젝트 전체 건수 조회
     * @param map 검색 조건 맵
     * @return 전체 건수
     */
    public int getTotal(Map<String, Object> map);
    
    /**
     * 프로젝트 등록
     * @param projectVO 프로젝트 정보
     * @return 등록된 행 수
     */
    public int insertProject(ProjectVO projectVO);
    
    /**
     * 프로젝트 참여자 일괄 등록
     * @param projectEmpVOList 프로젝트 참여자 목록
     * @return 등록된 행 수
     */
    public int insertProjectEmpBatch(@Param("list") List<ProjectEmpVO> projectEmpVOList);
    
    /**
     * 프로젝트 상세 정보 조회 (long 파라미터)
     * @param prjctNo 프로젝트 번호
     * @return 프로젝트 상세 정보
     */
    public ProjectVO projectDetail(long prjctNo);
    
    /**
     * 프로젝트 번호로 상세 정보 조회 (문자열 파라미터)
     * @param projectNo 프로젝트 번호
     * @return 프로젝트 상세 정보
     */
    public ProjectVO selectProjectByNo(String projectNo);
    
    /**
     * 프로젝트 삭제 (long 파라미터)
     * @param prjctNo 프로젝트 번호
     * @return 삭제된 행 수
     */
    public int deleteProject(long prjctNo);
    
    
    /**
     * 프로젝트 번호로 참여자 삭제
     * @param prjctNo 프로젝트 번호
     */
    public void deleteProjectEmpsByProjectNo(long prjctNo);
    
    /**
     * 프로젝트 번호로 참여자 삭제 (별칭)
     * @param prjctNo 프로젝트 번호
     */
    public void deleteProjectEmpsByProject(long prjctNo);
    
    
    /**
     * 프로젝트 수정 (int 반환)
     * @param project 수정할 프로젝트 정보
     * @return 수정된 행 수
     */
    public int updateProject(ProjectVO project);
    
    /**
     * 프로젝트 카테고리 목록 조회
     * @return 카테고리 목록
     */
    public List<Map<String, Object>> getProjectCategoryList();
    
    /**
     * 프로젝트 상태 목록 조회
     * @return 상태 목록
     */
    public List<Map<String, Object>> getProjectStatusList();
    
    /**
     * 프로젝트 등급 목록 조회
     * @return 등급 목록
     */
    public List<Map<String, Object>> getProjectGradeList();
    
    /**
     * 최대 프로젝트 번호 조회
     * @return 최대 프로젝트 번호
     */
    public int selectMaxProjectNo();
    
    /**
     * 모든 프로젝트 목록 조회
     * @return 프로젝트 목록
     */
    public List<ProjectVO> selectAllProjects();
    
    /**
     * 상태별 프로젝트 목록 조회
     * @param status 프로젝트 상태 (00:대기, 01:진행중, 02:완료, 03:취소)
     * @return 상태별 프로젝트 목록
     */
    public List<ProjectVO> selectProjectsByStatus(String status);
    
    /**
     * 프로젝트 상태 업데이트
     * @param projectNo 프로젝트 번호
     * @param status 변경할 상태
     * @return 업데이트된 행 수
     */
    public int updateProjectStatus(@Param("projectNo") String projectNo, @Param("status") String status);
}