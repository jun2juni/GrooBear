package kr.or.ddit.sevenfs.vo.project;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import kr.or.ddit.sevenfs.vo.AttachFileVO;
import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class ProjectTaskVO {

    private long taskNo;
    private long prjctNo;
    private String taskNm;
    private String taskCn;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date taskBeginDt;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date taskEndDt;



    private int progrsrt;
    private long atchFileNo;
    private Long upperTaskNo;

    private long chargerEmpno;
    private String chargerEmpNm;
    private String role;
    private String priort;
    private String taskGrad;
    private String taskSttus;
    private String taskText;

    private Integer taskDaycnt;
    private Integer depth;
    private String parentTaskNm;
    private String tempParentIndex;
    
    private Long taskId;
    private String startDate;
    private String endDate;
    private Double progress;
    private Long parentId;
    private String owner;
    private String status;
    private String priority;


    private List<MultipartFile> files;
    private List<AttachFileVO> attachFileList;
    
    private String prjctNm;

    public String getPrjctNm() {
        return prjctNm;
    }

    public void setPrjctNm(String prjctNm) {
        this.prjctNm = prjctNm;
    }

    

    // 💡 간트 연동용 getter
    public String getText() {
        return this.taskNm;
    }

    public String getStart_date() {
        return (taskBeginDt != null) ? new SimpleDateFormat("yyyy-MM-dd").format(taskBeginDt) : null;
    }

    public String getEnd_date() {
        return (taskEndDt != null) ? new SimpleDateFormat("yyyy-MM-dd").format(taskEndDt) : null;
    }

    public int getDuration() {
        if (taskBeginDt != null && taskEndDt != null) {
            long diff = taskEndDt.getTime() - taskBeginDt.getTime();
            return (int) TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS) + 1;
        }
        return 1;
    }

    public String getStatus() {
        return taskSttus;
    }

    public int getParent() {
        return (upperTaskNo != null) ? Math.toIntExact(upperTaskNo) : 0;
    }

    public GanttTaskVO toGanttVO() {
        GanttTaskVO vo = new GanttTaskVO();
        vo.setTaskNo(this.taskNo);
        vo.setTaskId(this.taskNo);  // taskId 설정
        vo.setPrjctNo(this.prjctNo);
        vo.setTaskNm(this.taskNm);
        vo.setTaskCn(this.taskCn);
        vo.setTaskBeginDt(this.taskBeginDt);
        vo.setTaskEndDt(this.taskEndDt);
        vo.setPriort(this.priort);
        vo.setTaskGrad(this.taskGrad);
        vo.setTaskSttus(this.taskSttus);
        vo.setProgrsrt(this.progrsrt);
        vo.setTaskDaycnt(this.taskDaycnt);
        vo.setUpperTaskNo(this.upperTaskNo);
        vo.setChargerEmpNm(this.chargerEmpNm);
        return vo;
    }

    public KanbanTaskVO toKanbanVO() {
        KanbanTaskVO vo = new KanbanTaskVO();
        vo.setTaskNo(this.taskNo);
        vo.setPrjctNo(this.prjctNo);
        vo.setTaskNm(this.taskNm);
        vo.setTaskSttus(this.taskSttus);
        vo.setChargerEmpNm(this.chargerEmpNm);
        vo.setTaskGrad(this.taskGrad);
        vo.setPriort(this.priort);
        vo.setProgrsrt(this.progrsrt);
        return vo;
    }
}
