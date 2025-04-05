package kr.or.ddit.sevenfs.service.notification.impl;

import kr.or.ddit.sevenfs.mapper.notification.NotificationMapper;
import kr.or.ddit.sevenfs.service.notification.NotificationService;
import kr.or.ddit.sevenfs.vo.notification.NotificationVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public class NotificationServiceImpl implements NotificationService {
    @Autowired
    private NotificationMapper notificationMapper;
    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    @Override
    public List<NotificationVO> notificationList(int currentPage, EmployeeVO employeeVO) {
        List<NotificationVO> notificationVOList = notificationMapper.notificationList(currentPage, employeeVO);
        // 목록 온 경우 읽음 처리
        updateNotificationAllRead(employeeVO.getEmplNo());
        return notificationVOList;
    }

    /**
     *
     * @param notificationVO - 알림 내용
     * @param employeeVOList - 알림 보내야하는 사원 목록
     * @return
     */
    @Override
    public int insertNotification(NotificationVO notificationVO, List<EmployeeVO> employeeVOList) {
        notificationVO.setEmployeeVOList(employeeVOList);
        int i = notificationMapper.insertNotification(notificationVO);

        for (EmployeeVO employeeVO : employeeVOList) {
            messagingTemplate.convertAndSend("/sub/alert/room/" + employeeVO.getEmplNo(), notificationVO);
        }

        return i;
    }

    @Override
    public int deleteNotification(NotificationVO notificationVO) {
        return notificationMapper.deleteNotification(notificationVO);
    }

    @Override
    public int updateNotificationAllRead(String emplNo) {
        return notificationMapper.updateNotificationAllRead(emplNo);
    }


    @Override
    public List<NotificationVO> getUnreadNotifications(EmployeeVO employeeVO) {
        return  notificationMapper.getUnreadNotifications(employeeVO);
    }
}
