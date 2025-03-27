package kr.or.ddit.sevenfs.filter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Slf4j
public class AuthFilter extends OncePerRequestFilter {

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {

        String uri = request.getRequestURI();

        // 화이트리스트 URL은 필터 건너뛰기
        if (isWhitelisted(uri)) {
            filterChain.doFilter(request, response);
            return;
        }

        log.debug("로그인 필터 실행: " + uri);

        filterChain.doFilter(request, response);
    }

    private boolean isWhitelisted(String uri) {
        return uri.startsWith("/assets/") || uri.startsWith("/upload/")
                || uri.equals("/favicon.ico") || uri.startsWith("/error");
    }
}
