package kr.or.ddit.sevenfs.config.jwt;

import io.jsonwebtoken.*;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.sevenfs.vo.CustomUser;
import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseCookie;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Component;

import java.util.Collections;
import java.util.Date;
import java.util.Set;

@Slf4j
@Component
public class JwtTokenProvider {

    @Value("${remember-me.key}")
    private String jwtSecret;
    private final long accessTokenValidity = 1000 * 60 * 30; // 30분
    private final long refreshTokenValidity = 1000 * 60 * 60 * 24 * 7; // 7일

    //토큰 테스트 용
//    private final long accessTokenValidity = 1000 * 10; // 30분
//    private final long refreshTokenValidity = 1000 * 30; // 7일

//    private final long refreshTokenValidity = 1000 * 10; // 리프레쉬 토큰

    // Access Token 생성
    public String generateToken(CustomUser userPrincipal) {
        EmployeeVO empVO = userPrincipal.getEmpVO();

        return Jwts.builder()
                .setSubject(empVO.getUsername())
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + accessTokenValidity))
                .signWith(SignatureAlgorithm.HS256, jwtSecret)
                .compact();
    }

    // Refresh Token 생성
    public String generateRefreshToken(CustomUser userPrincipal) {
        EmployeeVO empVO = userPrincipal.getEmpVO();

        return Jwts.builder()
                .setSubject(empVO.getUsername())
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + refreshTokenValidity))
                .signWith(SignatureAlgorithm.HS256, jwtSecret)
                .compact();
    }

    public boolean validateToken(String token) {
        try {
            Jwts.parser().setSigningKey(jwtSecret).parseClaimsJws(token);
            return true;
        } catch (SignatureException | MalformedJwtException | ExpiredJwtException |
                 UnsupportedJwtException | IllegalArgumentException e) {
            return false;
        }
    }

    // React 서버인 node.js서버(프론트엔드) -> Spring 서버인 내장 tomcat의 스프링시큐리티로 이관(백엔드)
    public Authentication getAuthentication(String token) {
        Claims claims = getUserNameFromJwt(token);
        Set<SimpleGrantedAuthority> authorities = Collections.singleton(new SimpleGrantedAuthority("ROLE_MEMBER"));

        return new UsernamePasswordAuthenticationToken(
                new org.springframework.security.core.userdetails.User(claims.getSubject(), "", authorities), token,
                authorities);
    }

    /*5. 클레임 조회 및 처리
       private String issuer;
       private String secretKey;
       매개변수 token = iss=chemusic@naver.com,sub=chemusic@naver.com,iat=2025/03/10T10:47:13...;
       리턴타입 claims{
          "iss":"chemusic@naver.com",
          "sub":"chemusic@naver.com",
          "iat":"2025/03/10T10:47:13",
          ..
       }
    */
    public Claims getUserNameFromJwt(String token) {
        Claims claims = Jwts.parser()
                .setSigningKey(jwtSecret)
                .parseClaimsJws(token)
                .getBody();

        return claims;
    }

    public ResponseCookie createCookie(String key, String value, long maxAge) {
        return ResponseCookie.from(key, value)
                .httpOnly(true)
                .secure(true) // HTTPS에서만 전송 (개발 환경에서는 false로 설정 가능)
                .path("/")
                .maxAge(maxAge)
                .sameSite("Strict")
                .build();
    }

    public void removeCookie(String key, HttpServletResponse response) {
        Cookie cookie = new Cookie(key, null);
        cookie.setMaxAge(0); // 쿠키 만료
        cookie.setHttpOnly(true);
        cookie.setPath("/"); // 모든 경로에서 삭제되도록 설정

        response.addCookie(cookie);

    }
}
