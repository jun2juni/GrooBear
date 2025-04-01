package kr.or.ddit.sevenfs.filter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Slf4j
public class AuthFilter extends OncePerRequestFilter {

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain)
            throws ServletException, IOException {

        String uri = request.getRequestURI();

        // 화이트리스트 URL은 필터 건너뛰기
        if (isWhitelisted(uri)) {
            filterChain.doFilter(request, response);
            return;
        }

        HttpSession session = request.getSession(false);
        EmployeeVO empVO = (session != null) ? (EmployeeVO) session.getAttribute("empVO") : null;

        if (empVO == null) {
            log.debug("로그인되지 않음! {} -> /login 리다이렉트", uri);

            // 세션이 없으면 새로 생성
            if (session == null) {
                session = request.getSession(true);
            }

            session.setAttribute("redirectAfterLogin", uri);
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 이전에 보던 페이지로 이동 하는 기능
        String redirectAfterLogin = (String) session.getAttribute("redirectAfterLogin");
        log.debug("redirectAfterLogin {}", redirectAfterLogin);
        if (redirectAfterLogin != null) {
            session.removeAttribute("redirectAfterLogin");
            response.sendRedirect(request.getContextPath() + redirectAfterLogin);
            return;
        }

        filterChain.doFilter(request, response);
    }

    private boolean isWhitelisted(String uri) {
        return uri.startsWith("/assets/") || uri.startsWith("/upload/")
                || uri.equals("/favicon.ico") || uri.startsWith("/error")
                || uri.equals("/login") || uri.equals("/auth/login");
    }
}
