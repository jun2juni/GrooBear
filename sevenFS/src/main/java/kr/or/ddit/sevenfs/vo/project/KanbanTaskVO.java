package kr.or.ddit.sevenfs.vo.project;

import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.Data;

@Data
public class KanbanTaskVO implements TaskInterface {
    private Long taskNo;
    private Long prjctNo;
    private String taskNm;
    private String taskSttus; // 상태코드 ("00" ~ "04")
    private String chargerEmpNm;
    private String taskGrad;
    private String priort;
    private Integer progrsrt;
    private Date taskEndDt; // 마감일 필드 추가
    private boolean hasNewComments; // 댓글 알림 표시 여부

    // 필요 시 진행률 퍼센트 반환
    public int getProgressPercent() {
        return progrsrt != null ? progrsrt : 0;
    }

    // 마감일 문자열 반환 (JSP에서 사용)
    public String getEndDe() {
        if (taskEndDt == null) return null;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(taskEndDt);
    }

    public static KanbanTaskVO fromGantt(GanttTaskVO ganttTask) {
        if (ganttTask == null) return null;

        KanbanTaskVO kanbanTask = new KanbanTaskVO();
        kanbanTask.setTaskNo(ganttTask.getTaskNo());
        kanbanTask.setPrjctNo(ganttTask.getPrjctNo());
        kanbanTask.setTaskNm(ganttTask.getTaskNm());
        kanbanTask.setTaskSttus(ganttTask.getTaskSttus());
        kanbanTask.setChargerEmpNm(ganttTask.getChargerEmpNm());
        kanbanTask.setTaskGrad(ganttTask.getTaskGrad());
        kanbanTask.setPriort(ganttTask.getPriort());
        kanbanTask.setProgrsrt(ganttTask.getProgrsrt());
        kanbanTask.setTaskEndDt(ganttTask.getTaskEndDt()); // 마감일 설정

        return kanbanTask;
    }
}