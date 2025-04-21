package kr.or.ddit.sevenfs.vo.project;

import lombok.Data;

@Data
public class KanbanTaskVO implements TaskInterface{
    private Long taskNo;
    private Long prjctNo;
    private String taskNm;
    private String taskSttus;       // 상태코드 ("00" ~ "04")
    private String chargerEmpNm;
    private String taskGrad;
    private String priort;
    private Integer progrsrt;

    // 필요 시 진행률 퍼센트 반환
    public int getProgressPercent() {
        return progrsrt != null ? progrsrt : 0;
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
        
        return kanbanTask;
    }
}
