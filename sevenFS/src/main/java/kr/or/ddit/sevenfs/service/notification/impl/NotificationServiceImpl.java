package kr.or.ddit.sevenfs.service.notification.impl;

import kr.or.ddit.sevenfs.mapper.notification.NotificationMapper;
import kr.or.ddit.sevenfs.service.notification.NotificationService;
import kr.or.ddit.sevenfs.vo.notification.NotificationVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NotificationServiceImpl implements NotificationService {
    @Autowired
    private NotificationMapper notificationMapper;

    @Override
    public List<NotificationVO> notificationList(EmployeeVO employeeVO) {
        return notificationMapper.notificationList(employeeVO);
    }

    @Override
    public int insertNotification(List<NotificationVO> notificationVO, List<EmployeeVO> employeeVOList) {
        return notificationMapper.insertNotification(notificationVO, employeeVOList);
    }

    @Override
    public int deleteNotification(NotificationVO notificationVO) {
        return notificationMapper.deleteNotification(notificationVO);
    }
}
