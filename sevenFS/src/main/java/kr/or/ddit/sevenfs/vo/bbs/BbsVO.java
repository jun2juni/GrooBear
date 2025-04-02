package kr.or.ddit.sevenfs.vo.bbs;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BbsVO {
	private int bbsSn;
	private int bbsCtgryNo;
	private String emplNo;
	private String bbscttSj;
	private String bbscttCn;
	private String bbscttCreatDt;
	private String bbscttUpdtDt;
	private int rdcnt;
	private String bbscttUseYn;
	private String bbscttDeleteYn;
	private String upendFixingYn;
	private long atchFileNo;
	
	private List<MultipartFile> files;
}
