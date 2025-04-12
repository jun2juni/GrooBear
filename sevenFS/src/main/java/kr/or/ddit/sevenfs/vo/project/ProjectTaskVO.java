package kr.or.ddit.sevenfs.vo.project;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import kr.or.ddit.sevenfs.vo.AttachFileVO;
import lombok.Data;

@Data
/*
 * VO에 없는 필드가 있음 chargerEmpNm, parentTaskNm, parentIndex jaxkson이 오류 없이 무시할 수 있음
 */
@JsonIgnoreProperties(ignoreUnknown = true)  
public class ProjectTaskVO {
    private int progrsrt;
    private String taskSttus;
    private long atchFileNo;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date taskBeginDt;
    private int taskDaycnt;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date taskEndDt;
    private int taskNo;
    private long prjctNo;
    private Long upperTaskNo;
    private String chargerEmpno;
    private String taskNm;
    private String taskCn;
    private String priort;
    private String taskGrad;
    
    private String parentTaskNm; //상위 업무명
    private Integer depth; // 계층 구조 들여쓰기용
    private String role; // 예: 업무 담당자의 역할 등
    private String chargerEmpNm;
    
    private List<MultipartFile> files;
    private List<AttachFileVO> attachFileList;



}
