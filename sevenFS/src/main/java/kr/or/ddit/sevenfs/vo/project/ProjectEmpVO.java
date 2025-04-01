package kr.or.ddit.sevenfs.vo.project;

import java.util.Date;

import lombok.Data;

@Data
public class ProjectEmpVO {
	private int prjctNo;
	private String prtcpntEmpno;
	private String prtcpntRole;
	private String prjctAuthor;
	private String evlManEmpno;
	private String evlCn;
	private String evlGrad;
	private Date evlWritngDt;
	private Date evlUpdtDt;
	private String secsnYn;
}
