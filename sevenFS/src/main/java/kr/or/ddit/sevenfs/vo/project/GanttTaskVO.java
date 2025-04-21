package kr.or.ddit.sevenfs.vo.project;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.text.SimpleDateFormat;
import java.util.Date;

@Data
public class GanttTaskVO {

    private Long taskId;
    private Long taskNo;
    private Long prjctNo;
    private String taskNm;
    private String taskCn;
    private String priort;
    private String taskGrad;
    private String taskSttus;
    private Integer progrsrt;
    private Long upperTaskNo;
    private String chargerEmpNm;
    private Long chargerEmpno;
    private Long atchFileNo;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm")
    private Date taskBeginDt;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm")
    private Date taskEndDt;

    private Integer taskDaycnt;

    // ========== DHTMLX Gantt 변환 필드 ==========

    @JsonProperty("id")
    public Long getId() {
        return taskNo != null ? taskNo : taskId;
    }

    @JsonProperty("text")
    public String getText() {
        return taskNm;
    }

    @JsonProperty("start_date")
    public String getStartDateStr() {
        return formatDate(taskBeginDt);
    }

    @JsonProperty("end_date")
    public String getEndDateStr() {
        return formatDate(taskEndDt);
    }

    @JsonProperty("duration")
    public Integer getDuration() {
        return taskDaycnt != null ? taskDaycnt : 1;
    }

    @JsonProperty("progress")
    public Double getProgress() {
        return progrsrt != null ? progrsrt / 100.0 : 0.0;
    }

    @JsonProperty("parent")
    public Long getParent() {
        return upperTaskNo;
    }

    @JsonProperty("owner")
    public String getOwner() {
        return chargerEmpNm;
    }

    @JsonProperty("priority")
    public String getPriority() {
        return priort;
    }

    @JsonProperty("status")
    public String getStatus() {
        return taskSttus;
    }

    // ========== 날짜 포맷 도우미 ==========
    private String formatDate(Date date) {
        if (date == null) return null;
        return new SimpleDateFormat("yyyy-MM-dd HH:mm").format(date);
    }
}
