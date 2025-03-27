package kr.or.ddit.sevenfs.filter;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.util.PatternMatchUtils;

import java.io.IOException;

@Slf4j
public class AuthFilter implements Filter {
    // 인증 없이 들어갈수 있는 URI
    private static final String[] whitelist = {"/", "/auth/login", "/auth/logout", "/assets/**"};

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
        log.debug("login Filter ---- ");
        // HttpServletRequest로 캐스팅
        HttpServletRequest httpRequest = (HttpServletRequest) req;
        HttpServletResponse httpResp = (HttpServletResponse) resp;
        String requestURI = httpRequest.getRequestURI();

        try {
            if (isLoginCheckPath(requestURI)) {
                HttpSession session = httpRequest.getSession(false);
                if (session == null || session.getAttribute("emp") == null) { // 로그인 안한 경우
                    httpResp.sendRedirect(httpRequest.getContextPath() + "/login");
                    return;
                }
            }

            chain.doFilter(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            log.info("인증 체크 필터 종료 {}", requestURI);
        }
    }

    // 화이트 리스트는 인증 체크 안함
    private boolean isLoginCheckPath(String requestURI) {
        return !PatternMatchUtils.simpleMatch(whitelist, requestURI);
    }
}
