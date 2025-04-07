package kr.or.ddit.sevenfs.service.notification;

import kr.or.ddit.sevenfs.vo.notification.NotificationVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;

import java.util.List;

public interface NotificationService {
    // 알림 목록
    public List<NotificationVO> notificationList(int currentPage, EmployeeVO employeeVO);

    // 알림 추가 - 알림 추가되면 알림도 같이 보내기
    public int insertNotification(NotificationVO notificationVO, List<EmployeeVO> employeeVOList);

    // 알림 삭제
    public int deleteNotification(NotificationVO notificationVO);

    // 알림 읽음 처리
    public int updateNotificationRead(String emplNo, Integer ntcnSn);

    // 읽지 않은 알림 가져오기
    public List<NotificationVO> getUnreadNotifications(EmployeeVO employeeVO);
}
