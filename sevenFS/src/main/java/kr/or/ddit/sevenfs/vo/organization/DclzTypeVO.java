package kr.or.ddit.sevenfs.vo.organization;

import java.util.Date;

import lombok.Data;

// 근태 유형 VO
@Data
public class DclzTypeVO {

	private String emplNo;
	private String dclzNo;
	private String dclzCode;
	private Date dclzBeginDt;
	private Date dclzEndDt;
	
}
