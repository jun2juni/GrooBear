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
    @Autowired
    BCryptPasswordEncoder bCryptPasswordEncoder;

    @GetMapping("/auth/login")
    public String login() {

        return "auth/login";
    }
}
