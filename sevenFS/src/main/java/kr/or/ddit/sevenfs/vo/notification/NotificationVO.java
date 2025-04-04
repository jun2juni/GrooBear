package kr.or.ddit.sevenfs.vo.notification;

import lombok.Data;

import java.util.Date;

@Data
public class NotificationVO {
    private int ntcnSn; // 알림 순번
    private String emplNo; // 알림을 받는 사원 넘버
    private String ntcnSj; // 알림 제목
    private String ntcnCn; // 알림 내용
    private String originPath; // 기능별 NO =? /board/detail?boardNo=1
    private int fnctCtgryTy; // 기능 PK
    private Date ntcnCreatDt; // 알림 생성 일시
}
