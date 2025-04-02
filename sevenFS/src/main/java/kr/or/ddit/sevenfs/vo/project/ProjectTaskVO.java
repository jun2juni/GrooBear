package kr.or.ddit.sevenfs.vo.project;

import java.util.Date;

import lombok.Data;

@Data
public class ProjectTaskVO {
	private int progrsrt;
	private String taskSttus;
	private int atchFileNo;
	private Date taskBeginDt;
	private int taskDaycnt;
	private Date taskEndDt;
	private int taskNo;
	private int prjctNo;
	private int upperTaskNo;
	private String chargerEmpno;
	private String taskNm;
	private String taskCn;
	private String priort;
	private String taskGrad;
}
