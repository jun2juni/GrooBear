package kr.or.ddit.sevenfs.controller;

import jakarta.servlet.http.HttpSession;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Slf4j
@Controller
public class AuthController {
//    @Autowired
//    private AuthService authService;
    @Autowired
    BCryptPasswordEncoder bCryptPasswordEncoder;

    @GetMapping("/auth/login")
    public String login() {

        return "auth/login";
    }

//    @PostMapping("/auth/login")
//    public String login(String username, String password,
//                        Model model, HttpSession session,
//                        RedirectAttributes redirectAttributes) {
//        // 로그인 실패한 경우
////        EmployeeVO empVO = authService.login(username, password);
//        if (empVO == null) {
//            redirectAttributes.addFlashAttribute("message", "로그인에 실패했습니다.\n다시 시도해주세요.");
//            redirectAttributes.addFlashAttribute("username", username);
//            return "redirect:/login";
//        }
//
//        log.debug("enpVO {}", empVO);
//
//        session.setAttribute("empVO", empVO);
//        return "redirect:/";
//    }
}
