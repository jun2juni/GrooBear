package kr.or.ddit.sevenfs.vo.project;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.util.Date;

@Data
public class TaskVO {

    @JsonProperty("id")
    private Long taskId; // TASK_NO

    @JsonProperty("text")
    private String taskText; // TASK_NM

    @JsonIgnore
    private Date startDate; // TASK_BEGIN_DT (내부용)

    @JsonIgnore
    private Date endDate; // TASK_END_DT (내부용)

    @JsonProperty("start_date")
    private String startDateStr; // Gantt에 넘기는 문자열 날짜

    @JsonProperty("end_date")
    private String endDateStr;   // Gantt에 넘기는 문자열 날짜

    @JsonProperty("progress")
    private Double progress; // PROGRSRT

    @JsonProperty("parent")
    private Long parentId; // UPPER_TASK_NO

    @JsonProperty("owner")
    private String owner; // CHARGER_EMPNO or 이름

    @JsonProperty("status")
    private Integer status; // TASK_STTUS

    @JsonProperty("priority")
    private Integer priority; // PRIORT

    @JsonProperty("duration")
    private Integer duration; // 계산된 일수 (선택사항)
}
