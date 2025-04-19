package kr.or.ddit.sevenfs.vo.project;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
public class TaskVO {

    private Long taskId;
    private String taskText;

    private Date startDate;
    private Date endDate;
    private String startDateStr;
    private String endDateStr;

    private Double progress;
    private Long parentId;

    private String owner;

    // DB에서 온 값들
    private Long taskNo;
    private Long prjctNo;
    private String taskNm;
    private String taskCn;
    private String taskBeginDt;
    private String taskEndDt;
    private String priort;
    private String taskGrad;
    private String taskSttus;
    private Integer progrsrt;
    private Integer taskDaycnt;
    private Long upperTaskNo;
    private Long chargerEmpno;
    private String chargerEmpNm;
    private Long atchFileNo;

    // Gantt용 필드 변환용 Getter
    @JsonProperty("status")
    public String getStatus() {
        return taskSttus;
    }

    @JsonProperty("status")
    public void setStatus(String status) {
        this.taskSttus = status;
    }

    @JsonProperty("priority")
    public String getPriority() {
        return priort;
    }

    @JsonProperty("priority")
    public void setPriority(String priority) {
        this.priort = priority;
    }

    @JsonProperty("duration")
    public Integer getDuration() {
        return taskDaycnt;
    }

    @JsonProperty("duration")
    public void setDuration(Integer duration) {
        this.taskDaycnt = duration;
    }
}
