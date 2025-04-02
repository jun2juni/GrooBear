package kr.or.ddit.sevenfs.vo.project;

import java.util.Date;

import lombok.Data;

@Data
public class TaskAnsertVO {
	private int taskNo;
	private int taskAnswerSn;
	private String answerCn;
	private Date answerCreatDt;
	private Date answerUpdtDt;
	private String answerWritngEmpno;
}
