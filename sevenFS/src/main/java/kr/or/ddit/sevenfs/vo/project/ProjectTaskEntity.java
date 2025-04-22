package kr.or.ddit.sevenfs.vo.project;

import lombok.Data;

import java.time.format.DateTimeFormatter;
import java.util.Date;

@Data
public class ProjectTaskEntity {
    private Long taskNo;
    private Long prjctNo;
    private String taskNm;
    private String taskCn;
    private Date taskBeginDt;
    private Date taskEndDt;
    private String priort;
    private String taskGrad;
    private String taskSttus;
    private Integer progrsrt;
    private Integer taskDaycnt;
    private Long upperTaskNo;
    private Long chargerEmpno;
    private String chargerEmpNm;
    private Long atchFileNo;
    private String parentTaskNm; // 상위 업무명 (JOIN 결과)

    
    // VO 변환 메서드
    public GanttTaskVO toGanttVO() {
        GanttTaskVO task = new GanttTaskVO();

        task.setTaskId(this.taskNo); // ID 설정
        task.setTaskNo(this.taskNo);
        task.setPrjctNo(this.prjctNo);
        task.setTaskNm(this.taskNm);
        task.setTaskCn(this.taskCn);
        task.setPriort(this.priort);
        task.setTaskGrad(this.taskGrad);
        task.setTaskSttus(this.taskSttus);
        task.setProgrsrt(this.progrsrt);
        task.setUpperTaskNo(this.upperTaskNo);
        task.setChargerEmpNm(this.chargerEmpNm);
        task.setChargerEmpno(this.chargerEmpno);
        task.setAtchFileNo(this.atchFileNo);
        task.setTaskDaycnt(this.taskDaycnt);
        task.setTaskBeginDt(this.taskBeginDt);
        task.setTaskEndDt(this.taskEndDt);

        return task;
    }

    
    public KanbanTaskVO toKanbanVO() {
        KanbanTaskVO vo = new KanbanTaskVO();
        // 필드 복사
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