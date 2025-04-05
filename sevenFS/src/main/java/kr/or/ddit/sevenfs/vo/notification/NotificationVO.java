package kr.or.ddit.sevenfs.vo.notification;

import kr.or.ddit.sevenfs.utils.CommonCode;
import kr.or.ddit.sevenfs.vo.chat.ChatVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class NotificationVO {
    private int totalCount;
    private int rNum;
    private int ntcnSn; // 알림 순번
    private String emplNo; // 알림을 받는 사원 넘버
    private String ntcnSj; // 알림 제목
    private String ntcnCn; // 알림 내용
    private String originPath; // 기능별 NO =? /board/detail?boardNo=1
    private Date ntcnCreatDt; // 알림 생성 일시
    private String ntcnReadYn; // 알림 읽음 여부

    private String skillCode; // 기능 PK
    private String skillLabel;
    private String notificationIcon;
    private String notificationColor;

    private String type = "NOTIFICATION";

    private List<EmployeeVO> employeeVOList;

    public void setSkillCode(String skillCode) {
        this.skillCode = skillCode;
        this.skillLabel = CommonCode.SkillEnum.BOARD.getLabelByCode(skillCode);

        switch (skillCode) {
            case "00": {
                this.notificationIcon = CommonCode.SkillEnum.PROJECT.getIcon();
                this.notificationColor = "bg-primary";
                break;
            }
            case "01": {
                this.notificationIcon = CommonCode.SkillEnum.BOARD.getIcon();
                this.notificationColor = "bg-secondary";
                break;
            }
            case "02": {
                this.notificationIcon = CommonCode.SkillEnum.E_APPROVAL.getIcon();
                this.notificationColor = "bg-success";
                break;
            }
            case "03": {
                this.notificationIcon = CommonCode.SkillEnum.DOCUMENTS.getIcon();
                this.notificationColor = "bg-danger";
                break;
            }
            case "04": {
                this.notificationIcon = CommonCode.SkillEnum.SCHEDULE.getIcon();
                this.notificationColor = "bg-warning";
                break;
            }
            case "05": {
                this.notificationIcon = CommonCode.SkillEnum.EMAIL.getIcon();
                this.notificationColor = "bg-info";
                break;
            }
            case "06": {
                this.notificationIcon = CommonCode.SkillEnum.MESSENGER.getIcon();
                this.notificationColor = "bg-dark-subtle";
                break;
            }
            case "07": {
                this.notificationIcon = CommonCode.SkillEnum.NOTIFICATIONS.getIcon();
                this.notificationColor = "bg-dark";
                break;
            }
        }
    }
}
