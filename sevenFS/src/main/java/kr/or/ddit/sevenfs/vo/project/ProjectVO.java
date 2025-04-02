package kr.or.ddit.sevenfs.vo.project;
import lombok.Data;

@Data
public class ProjectVO {
	
	private int prjctNo;
	private int ctgryNo;
	private String prjctNm;
	private String prjctCn;
	private String prjctSttus;
	private String prjctGrad;
	private String prjctAdres;
	private String prjctUrl;
	private int prjctRcvordAmount;
	private String prjctBeginDate;
	private String prjctEndDate;
	
	private String ctgryNm;
	private String prtcpntEmpno; 
	private String prtcpntNm;
	private String prjctSttusNm;
}
