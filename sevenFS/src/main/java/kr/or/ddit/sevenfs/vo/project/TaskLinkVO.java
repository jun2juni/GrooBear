package kr.or.ddit.sevenfs.vo.project;

import lombok.Data;

@Data
public class TaskLinkVO {
	private int taskLinkNo;
	private int taskNo;
	private int linkSn;
	private int trgtTaskNo;
	private String taskLinkTy;
}
