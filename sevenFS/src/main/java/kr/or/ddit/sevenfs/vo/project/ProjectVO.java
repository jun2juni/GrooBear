package kr.or.ddit.sevenfs.vo.project;
import java.text.SimpleDateFormat;
import java.util.Date;

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
	
	private int progrsrt;
	private String taskSttus;
	private long atchFileNo;
	private Date taskBeginDt;
	private int taskDaycnt;
	private Date taskEndDt;
	private int taskNo;
	private long upperTaskNo;
	private String chargerEmpno;
	private String taskNm;
	private String taskCn;
	private String priort;
	private String taskGrad;
	
	
	
	
    // 날짜 형식을 변경하는 getter 메소드 추가
    public String getPrjctBeginDateFormatted() {
        if (prjctBeginDate == null) return "";
        // 날짜가 String 타입인 경우
        try {
            SimpleDateFormat originalFormat = new SimpleDateFormat("yyyyMMdd"); // 원래 형식
            SimpleDateFormat targetFormat = new SimpleDateFormat("yyyy-MM-dd"); // 변경할 형식
            Date date = originalFormat.parse(prjctBeginDate);
            return targetFormat.format(date);
        } catch (Exception e) {
            return prjctBeginDate; // 변환 실패 시 원본 반환
        }
    }
    
    public String getPrjctEndDateFormatted() {
        if (prjctEndDate == null) return "";
        // 날짜가 String 타입인 경우
        try {
            SimpleDateFormat originalFormat = new SimpleDateFormat("yyyyMMdd"); // 원래 형식
            SimpleDateFormat targetFormat = new SimpleDateFormat("yyyy-MM-dd"); // 변경할 형식
            Date date = originalFormat.parse(prjctEndDate);
            return targetFormat.format(date);
        } catch (Exception e) {
            return prjctEndDate; // 변환 실패 시 원본 반환
        }
    }

	
}
