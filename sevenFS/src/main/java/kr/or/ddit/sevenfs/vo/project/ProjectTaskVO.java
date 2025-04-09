package kr.or.ddit.sevenfs.vo.project;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class ProjectTaskVO {
	private int progrsrt;
	private String taskSttus;
	private int atchFileNo;
	private Date taskBeginDt;
	private int taskDaycnt;
	private Date taskEndDt;
	private int taskNo;
	private long prjctNo;
	private long upperTaskNo;
	private String chargerEmpno;
	private String taskNm;
	private String taskCn;
	private String priort;
	private String taskGrad;
	
	private List<MultipartFile> files;


}
