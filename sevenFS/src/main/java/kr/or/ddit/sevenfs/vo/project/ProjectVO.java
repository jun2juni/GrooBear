package kr.or.ddit.sevenfs.vo.project;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

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
    private String prjctRcvordAmount;
    private String prjctBeginDate;  
    private String prjctEndDate;    
    
    private String ctgryNm;
    private String prtcpntEmpno; 
    private String prtcpntNm;
    private String prjctSttusNm;
    
    private List<ProjectEmpVO> projectEmpVOList;
    private List<ProjectTaskVO> projectTaskVOList;
    // 역할별 목록
    private List<ProjectEmpVO> responsibleList;
    private List<ProjectEmpVO> participantList;
    private List<ProjectEmpVO> observerList;
    
    // 업무 리스트
    private List<ProjectTaskVO> taskList;

	
    private long atchFileNo;
    private long upperTaskNo;
	
    // 날짜 형식을 변경하는 getter 메소드 추가
    public String getPrjctBeginDateFormatted() {
        if (prjctBeginDate == null) return "";
        // 날짜가 String 타입인 경우
        try {
            SimpleDateFormat originalFormat = new SimpleDateFormat("yyyyMMdd"); 
            SimpleDateFormat targetFormat = new SimpleDateFormat("yyyy-MM-dd"); 
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
            SimpleDateFormat originalFormat = new SimpleDateFormat("yyyyMMdd");
            SimpleDateFormat targetFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date date = originalFormat.parse(prjctEndDate);
            return targetFormat.format(date);
        } catch (Exception e) {
            return prjctEndDate; // 변환 실패 시 원본 반환
        }
    }


	
}
