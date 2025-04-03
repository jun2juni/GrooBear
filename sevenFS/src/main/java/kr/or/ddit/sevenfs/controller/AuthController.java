package kr.or.ddit.sevenfs.controller;

import io.jsonwebtoken.Claims;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.sevenfs.config.jwt.JwtTokenProvider;
import kr.or.ddit.sevenfs.service.auth.impl.EmpDetailImpl;
import kr.or.ddit.sevenfs.service.organization.OrganizationService;
import kr.or.ddit.sevenfs.vo.CommonCodeVO;
import kr.or.ddit.sevenfs.vo.CustomUser;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseCookie;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
public class AuthController {
    @Autowired
    private EmpDetailImpl userDetailService;
    @Autowired
    BCryptPasswordEncoder bCryptPasswordEncoder;
    @Autowired
    private AuthenticationManager authenticationManager;
    @Autowired
    private JwtTokenProvider jwtTokenProvider;
    @Autowired
    private OrganizationService orgService;

    @GetMapping("/auth/login")
    public String login() {
        return "auth/login";
    }

    @ResponseBody
    @PostMapping("/api/login")
    public ResponseEntity<?> apiLogin(EmployeeVO reqEmployeeVO, HttpServletResponse response) {
        try {
            log.debug("employeeVO: {}", reqEmployeeVO);
            String password = reqEmployeeVO.getPassword();

            // 로그인 인증을 처리하는 spring security 객체
            authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(reqEmployeeVO.getEmplNo(), password));

            CustomUser user = (CustomUser) this.userDetailService.loadUserByUsername(reqEmployeeVO.getEmplNo());
            EmployeeVO employeeVO = user.getEmpVO();


            boolean matches = this.bCryptPasswordEncoder.matches(password, employeeVO.getPassword());

            log.debug(" {}", matches);
            // 비밀번호가 맞으면 로그인 성공
            if (matches) {
                String generateToken = jwtTokenProvider.generateToken(user);
                String refreshToken = jwtTokenProvider.generateRefreshToken(user);

                // 쿠키에 엑세스, 리프레쉬 토큰 생성
                ResponseCookie accessTokenCookie = jwtTokenProvider.createCookie("accessToken", generateToken, 60 * 30); // 30분 유자
                response.addHeader("Set-Cookie", accessTokenCookie.toString());

                ResponseCookie refreshTokenCookie = jwtTokenProvider.createCookie("refreshToken", refreshToken, 7 * 24 * 60 * 6); // 7일 유지
                response.addHeader("Set-Cookie", refreshTokenCookie.toString());


                return ResponseEntity.ok(
                    Map.of(
                        "user", employeeVO
                    )
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return ResponseEntity.badRequest().body("로그인 실패");
    }

    @ResponseBody
    @PostMapping("/api/token/refresh")
    public ResponseEntity<?> tokenRefresh(@CookieValue(value = "refreshToken", required = false) String refreshToken, HttpServletResponse response) {
        log.debug("refreshToken: {}", refreshToken);

        if (jwtTokenProvider.validateToken(refreshToken)) {
            Claims clasims = jwtTokenProvider.getUserNameFromJwt(refreshToken);
            String username = clasims.getSubject();
            CustomUser userDetails = (CustomUser) userDetailService.loadUserByUsername(username);

            // 새 액세스 토큰 발급
            String newAccessToken = jwtTokenProvider.generateToken(userDetails); // 엑서스 토큰 발급
            // 쿠키에 엑세스 토큰 생성
            ResponseCookie accessTokenCookie = jwtTokenProvider.createCookie("accessToken", newAccessToken, 60 * 30); // 30분 유자
            response.addHeader("Set-Cookie", accessTokenCookie.toString());

            return ResponseEntity.ok(Map.of("accessToken", newAccessToken));
        } else {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body("Invalid refresh token");
        }
    }

    @ResponseBody
    @PostMapping("/api/token/invalid")
    public ResponseEntity<?> tokenInvalid(@CookieValue(value = "accessToken", required = false) String accessToken) {

        log.debug("accessToken: {}", accessToken);
        Claims userNameFromJwt = this.jwtTokenProvider.getUserNameFromJwt(accessToken);
        String emplNo = userNameFromJwt.getSubject();

        CustomUser user = (CustomUser) this.userDetailService.loadUserByUsername(emplNo);
        EmployeeVO employeeVO = user.getEmpVO();

        return  ResponseEntity.ok(Map.of(
                "user", employeeVO
        ));
    }

    @ResponseBody
    @PostMapping("/api/token/logout")
    public ResponseEntity<?> tokenLogout(HttpServletResponse response) {
        this.jwtTokenProvider.removeCookie("accessToken", response);
        this.jwtTokenProvider.removeCookie("refreshToken", response);

        return ResponseEntity.ok(
                Map.of("message", "success")
        );
    }

    @ResponseBody
    @GetMapping("/api/empList")
    public Map<String, Object> test(
            @CookieValue String refreshToken,
            @CookieValue String accessToken) {

        Map<String, Object> map = new HashMap<>();
        List<CommonCodeVO> commonCodeVOS = this.orgService.depList();
        map.put("commonCodeVOS", commonCodeVOS);

        log.debug("refreshToken: {}", refreshToken);
        log.debug("accessToken: {}", accessToken);

        return map;
    }


}
