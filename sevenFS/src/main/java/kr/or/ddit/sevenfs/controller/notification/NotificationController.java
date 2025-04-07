package kr.or.ddit.sevenfs.controller.notification;

import kr.or.ddit.sevenfs.service.notification.NotificationService;
import kr.or.ddit.sevenfs.utils.ArticlePage;
import kr.or.ddit.sevenfs.vo.CustomUser;
import kr.or.ddit.sevenfs.vo.notification.NotificationVO;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequestMapping("/notification")
public class NotificationController {
    @Autowired
    private NotificationService notificationService;

    @GetMapping("/list")
    public String list(@AuthenticationPrincipal CustomUser user,
                       Model model,
                       @RequestParam(defaultValue = "1") int currentPage
    ) {
        EmployeeVO empVO = user.getEmpVO();

        List<NotificationVO> notificationVOList = this.notificationService.notificationList(currentPage, empVO);
        int totalCount = !notificationVOList.isEmpty() ? notificationVOList.getFirst().getTotalCount() : 0;
        ArticlePage<NotificationVO> articlePage = new ArticlePage<>(totalCount, currentPage, 10);


        model.addAttribute("notificationVOList", notificationVOList);
        model.addAttribute("articlePage", articlePage);
        return "notification/list";
    }

    @ResponseBody
    @PostMapping("/delete")
    public Map<String, Object> delete(@RequestBody NotificationVO notificationVO) {
        Map<String, Object> resultMap = new HashMap<>();
        log.debug("notificationVO: {}", notificationVO);
        int i = this.notificationService.deleteNotification(notificationVO);


        resultMap.put("result", i == 1 ? "success" : "fail");

        return resultMap;
    }

    @ResponseBody
    @PostMapping("/readNotification")
    public String readNotification(@AuthenticationPrincipal CustomUser user,
                                                int ntcnSn) {
        EmployeeVO empVO = user.getEmpVO();
        int i = notificationService.updateNotificationRead(empVO.getEmplNo(), ntcnSn);

        return i > 0 ? "success" : "fail";
    }

    @ResponseBody
    @GetMapping("/insertTest")
    public String insertTest() {

        NotificationVO notificationVO = new NotificationVO();
        notificationVO.setNtcnSj("[게시판 알림] 알림 제목입니다22222");
        notificationVO.setNtcnCn("[게시판 알림] 이 알림은 미국에서 시작해서 1997에서 시작한다 7FS 화이팅");
        notificationVO.setOriginPath("/chat/list");
        notificationVO.setSkillCode("02");

        List<EmployeeVO> employeeVOList = new ArrayList<>();
//        String[] emplNo = {"20250000", "20250001", "20250002", "20250003"};
        String[] emplNo = {"20250001"};
        for (int i = 0; i < emplNo.length; i++) {
            EmployeeVO employeeVO = new EmployeeVO();
            employeeVO.setEmplNo(emplNo[i]);
            employeeVOList.add(employeeVO);
        }

        this.notificationService.insertNotification(notificationVO, employeeVOList);

        return "success";
    }
}
