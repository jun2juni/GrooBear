package kr.or.ddit.sevenfs.controller.notification;

import kr.or.ddit.sevenfs.service.notification.NotificationService;
import kr.or.ddit.sevenfs.vo.CustomUser;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/notification")
public class NotificationController {
    @Autowired
    private NotificationService notificationService;

    @GetMapping("/list")
    public String list(@AuthenticationPrincipal CustomUser user) {
        EmployeeVO empVO = user.getEmpVO();



        return "notification/list";
    }
}
