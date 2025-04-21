package kr.or.ddit.sevenfs.service.project;

import java.util.List;
import java.util.Map;

import kr.or.ddit.sevenfs.vo.project.ProjectEmpVO;
import kr.or.ddit.sevenfs.vo.project.ProjectTaskVO;
import kr.or.ddit.sevenfs.vo.project.ProjectVO;

/**
 * 프로젝트 관련 서비스 인터페이스
 */
public interface ProjectService {
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
     * @param projectEmpList 프로젝트 참여자 목록
     * @return 등록된 행 수
     */
    public int insertProjectEmpBatch(List<ProjectEmpVO> projectEmpList);
    
    /**
     * 프로젝트 상세 정보 조회
     * @param prjctNo 프로젝트 번호
     * @return 프로젝트 상세 정보
     */
    public ProjectVO projectDetail(long prjctNo);
    
    /**
     * 프로젝트 상세 정보 조회 (문자열 파라미터)
     * @param projectNo 프로젝트 번호 (문자열)
     * @return 프로젝트 상세 정보
     */
    public ProjectVO getProjectDetail(String projectNo);
    
    /**
     * 프로젝트 생성 (업무 포함)
     * @param projectVO 프로젝트 정보
     * @param taskList 업무 목록
     * @return 등록된 행 수
     */
    public int createProject(ProjectVO projectVO, List<ProjectTaskVO> taskList);
    
    /**
     * 프로젝트 삭제
     * @param prjctNo 프로젝트 번호
     * @return 삭제 성공 여부
     */
    public boolean deleteProject(Long prjctNo);
   
    
    
    /**
     * 프로젝트 수정 (불린 반환)
     * @param project 수정할 프로젝트 정보
     * @return 수정 성공 여부
     */
    public boolean updateProject(ProjectVO project);
    
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
     * 모든 프로젝트 목록 조회 (별칭)
     * @return 프로젝트 목록
     */
    public List<ProjectVO> getAllProjects();
    
    /**
     * 상태별 프로젝트 목록 조회
     * @param status 프로젝트 상태 (0:대기, 1:진행중, 2:완료, 3:취소)
     * @return 상태별 프로젝트 목록
     */
    public List<ProjectVO> getProjectsByStatus(String status);
    
    /**
     * 프로젝트 상태 업데이트
     * @param projectNo 프로젝트 번호
     * @param status 변경할 상태
     * @return 업데이트 성공 여부
     */
    public boolean updateProjectStatus(String projectNo, String status);
    
    /**
     * 프로젝트 등록 (새 메서드)
     * @param project 프로젝트 정보
     * @return 등록된 프로젝트 번호
     */
    public int registerProject(ProjectVO project);
    
    public boolean updateTaskParent(Long taskNo, Long parentTaskNo);
    
}