package kr.or.ddit.sevenfs.service.notification;

import com.fasterxml.jackson.databind.annotation.JsonAppend;
import kr.or.ddit.sevenfs.vo.notification.NotificationVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class NotificationServiceTest {

    @Autowired
    private NotificationService notificationService;

    @Test
    void sendNotification() {
        NotificationVO notificationVO = new NotificationVO();
        notificationVO.setNtcnSj("[게시판 알림] 알림 제목입니다~~~~~~");
        notificationVO.setNtcnCn("[게시판 알림] 이 알림은 미국에서 시작해서 1997에서 시작한다 7FS 화이팅");
        notificationVO.setOriginPath("/chat/list");
        notificationVO.setSkillCode("01");

        List<EmployeeVO> employeeVOList = new ArrayList<>();
//        String[] emplNo = {"20250000", "20250001", "20250002", "20250003"};
        String[] emplNo = {"20250001"};
        for (int i = 0; i < emplNo.length; i++) {
            EmployeeVO employeeVO = new EmployeeVO();
            employeeVO.setEmplNo(emplNo[i]);
            employeeVOList.add(employeeVO);
        }

        this.notificationService.insertNotification(notificationVO, employeeVOList);
    }
}