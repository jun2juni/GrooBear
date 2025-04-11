package kr.or.ddit.sevenfs.vo.project;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

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
    private Date taskBeginDt;
    private int taskDaycnt;
    private Date taskEndDt;
    private int taskNo;
    private long prjctNo;
    private Long upperTaskNo;
    private String chargerEmpno;
    private String taskNm;
    private String taskCn;
    private String priort;
    private String taskGrad;

    private List<MultipartFile> files;


}
