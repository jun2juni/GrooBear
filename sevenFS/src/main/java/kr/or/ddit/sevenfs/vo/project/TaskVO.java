package kr.or.ddit.sevenfs.vo.project;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
public class TaskVO {

    @JsonProperty("id")  // Gantt가 요구하는 필드명
    private Long taskId; // TASK_NO

    @JsonProperty("text")
    private String taskText; // TASK_NM

    @JsonProperty("start_date")
    private Date startDate; // TASK_BEGIN_DT

    @JsonProperty("end_date")
    private Date endDate; // TASK_END_DT

    @JsonProperty("progress")
    private Double progress; // PROGRSRT

    @JsonProperty("parent")
    private Long parentId; // UPPER_TASK_NO

    @JsonProperty("owner")
    private String owner; // CHARGER_EMPNO or 이름 (사용 방식에 따라)

    @JsonProperty("status")
    private Integer status; // TASK_STTUS

    @JsonProperty("priority")
    private Integer priority; // PRIORT

    @JsonProperty("duration")
    private Integer duration; // 계산된 기간 (프론트에서 계산 or 백엔드에서 계산)
}
