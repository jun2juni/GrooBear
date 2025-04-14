package kr.or.ddit.sevenfs.filter;

import java.io.IOException;
import java.util.Arrays;
import java.util.Map;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

import kr.or.ddit.sevenfs.config.jwt.JwtTokenProvider;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtTokenProvider tokenProvider;

    public JwtAuthenticationFilter(JwtTokenProvider tokenProvider) {
        this.tokenProvider = tokenProvider;
    }

    private final static String HEADER_AUTHORIZATION = "Authorization";
    private final static String TOKEN_PREFIX = "Bearer ";

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {

        String requestURI = request.getRequestURI();

        // `/api`로 시작하는 요청만 필터 실행
        if (!requestURI.startsWith("/api") || requestURI.contains("/api/login")
                || requestURI.contains("/api/token/refresh") || requestURI.contains("/api/token/logout")
        ) {
            filterChain.doFilter(request, response);
            return;
        }

        Cookie[] cookies = request.getCookies();
        String accessToken = getAccessToken(cookies);

        log.debug("requestURI: {}", requestURI);
        log.debug("Access token: {}", accessToken);
        log.debug("tokenProvider.validateToken(accessToken): {}", tokenProvider.validateToken(accessToken));

        if (accessToken.equals("")) {
            // 여기서 토큰 벨리데이션에 걸린 경우 뒤로 되돌리기
            // 리프레시 토큰을 가지고 새로 발급 받기
            // 리프레시 토큰도 사용 불가능 한경우 다시 로그인
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access token is missing");
            return;
        }

        if (!tokenProvider.validateToken(accessToken)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid or expired token");
            return;
        }

        log.debug("토큰 사용 가능");
        // 로그인 검증
        Authentication authentication = tokenProvider.getAuthentication(accessToken);
        SecurityContextHolder.getContext().setAuthentication(authentication);

        // 엑서스 토큰이 없는 경우는 올수가 없음
        filterChain.doFilter(request, response);
    }

    private String getAccessToken(Cookie[] cookies) {
        if (cookies == null) return "";
        return Arrays.stream(cookies)
                .filter(cookie -> "accessToken".equals(cookie.getName()))
                .map(Cookie::getValue)
                .findFirst()
                .orElse("");
    }
}
