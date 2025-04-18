package kr.or.ddit.sevenfs.config;

import jakarta.servlet.DispatcherType;
import jakarta.servlet.Filter;
import kr.or.ddit.sevenfs.config.jwt.JwtTokenProvider;
import kr.or.ddit.sevenfs.filter.JwtAuthenticationFilter;
import kr.or.ddit.sevenfs.service.auth.impl.EmpDetailImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.CorsUtils;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;


import javax.sql.DataSource;
import java.util.Arrays;
import java.util.List;

@Configuration
public class SecurityConfig {

    // 0. 스프링시큐리티의 사용자정보를 담은 객체 DI
    @Autowired
    EmpDetailImpl userDetailService;
    @Autowired
    private DataSource dataSource;
    @Autowired
    JwtTokenProvider jwtTokenProvider;

    // 1. 스프링 시큐리티 기능 비활성화
    /**
     * 스프링 시큐리티의 모든 기능을 사용하지 않게 설정하는 코드.
     * 즉, 인증, 인가 서비스를 모든 곳에 적용하지는 않음 일반적으로 정적
     * 리소스(이미지, HTML 파일)에 설정함.
     * 정적 리소스만 스프링 시큐리티 사용을 비활성화 하는 데 static 하위 경로에 있는 리소스를
     * 대상으로 ignoring() 메서드를 사용함
     */
//    @Bean
//    public WebSecurityCustomizer configure() {
//        return (web) -> web.ignoring()
//                .requestMatchers("/assets/**", "/images/**", "/layout/**", "/ws/**", "/upload/**");
//    }

    /**
     * 서버가 재시작 되어도 로그인 유지를 위힘
     */
    @Bean
    public PersistentTokenRepository persistentTokenRepository() {
        JdbcTokenRepositoryImpl tokenRepository = new JdbcTokenRepositoryImpl();
        tokenRepository.setDataSource(dataSource);
        // 처음 한 번만 실행 (테이블 생성)
        // tokenRepository.setCreateTableOnStartup(true);
        return tokenRepository;
    }

    /**
     * 스프링 시큐리티 내부에서 OPTIONS에는 쿠키를 담을수 없어서
     * 해당 쿠키를 담기 위해서 cors관련을 OPTIONS에 쿠키를 담을 수 있게 열어준다
     */
    @Bean
    CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration corsConfiguration = new CorsConfiguration();
        corsConfiguration.setAllowedOrigins(Arrays.asList("http://localhost:3000"));
        corsConfiguration.setAllowedHeaders(List.of("*"));
        corsConfiguration.setAllowedMethods(Arrays.asList("GET", "POST", "DELETE", "PUT", "PATCH"));
        corsConfiguration.setAllowCredentials(true);
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", corsConfiguration);
        return source;
    }

    // ** 2. 특정 HTTP 요청에 대한 웹 기반 보안 구성
    /**
     * 이 메서드에서 인증/인가 및 로그인, 로그아웃 관련 설정을 할 수 있음
     *
     * 클라이언트 ----> 필터1 ----> 필터2 ---> 필터3 ---> 서버 클라이언트 <---- 필터1 <---- 필터2 <--- 필터3 <--- 서버
     * HTTP Basic : 시큐리티에서 제공해주는 기본 인증 방식(구식 form)
     *
     * sameOrigin : iframe 설정 X-Frame-Options 헤더는 브라우저에서 렌더링을 허용, 금지 여부를 결정하는
     * 응답헤더이다. 사용 가능한 옵션은 아래와 같다. DENY : iframe 비허용(불가) SAMEORIGIN : 동일 도메인 내에선 접근
     * 가능 ALLOW-FROM {도메인} : 특정 도메인 접근 가능
     */
    @Bean
    protected SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        return http
                .csrf(csrf -> csrf.disable())
                .cors((cors) -> cors
                        .configurationSource(corsConfigurationSource())
                )
                .headers(config -> config.frameOptions(customizer -> customizer.sameOrigin()))
                .httpBasic(hbasic -> hbasic.disable())
                .authorizeHttpRequests(authz -> authz
                        .dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.ASYNC).permitAll() // forward
                        .requestMatchers("/auth/login", "/signup", "/error",
                                "/assets/**", "/images/**", "/layout/**", "/ws/**", "/upload/**",
                                "/api/login","/api/token/invalid", "/api/token/refresh" // 여기는 비동기 로그인 관련
                        ).permitAll()
                        .requestMatchers("/api/**").authenticated() // 나머지 API는 인증 필요
                        // .requestMatchers("/ceo/**").hasRole("ROLE_ADMIN")
                        // .requestMatchers("/manager/**").hasAnyRole("ROLE_ADMIN", "ROLE_MANAGER")
                        .anyRequest().authenticated()
                )
                .formLogin(formLogin -> formLogin.loginPage("/auth/login")
                        .defaultSuccessUrl("/", false)
                        .failureHandler((request, response, e) -> {
                            response.sendRedirect("/auth/login?error=true");
                        })
                )
                .sessionManagement(session -> session.maximumSessions(1))
                .logout(logout -> logout.logoutSuccessUrl("/auth/login")
                        .invalidateHttpSession(true))
//               // 임시로 사용 - 개발 시 로그인 유지를 위해 (서버 재 시작시)
                .rememberMe(rememberMe -> rememberMe
                        .key(System.getenv("REMEMBER_ME_KEY"))
                        .rememberMeParameter("remember-me")
                        .tokenValiditySeconds(60 * 60 * 24 * 7)
                        .tokenRepository(persistentTokenRepository())
                )
                .addFilterBefore(new JwtAuthenticationFilter(jwtTokenProvider),
                        UsernamePasswordAuthenticationFilter.class)
                .build();
    }


    // 3. 인증 관리자 관련 설정(UserDetailServiceImpl)
    // 사용자 정보를 가져올 서비스를 재정의하거나, 인증 방법, 예를들어 LDAP, JDBC 기반 인증 등을 설정할 때 사용함
    /*
     * 요청URI : /login 요청파라미터 : request{username=test@test.com,password=java} 요청방식 :
     * post
     */
    @Bean
    public AuthenticationManager authenticationManager(
            HttpSecurity http,
            BCryptPasswordEncoder bCryptPasswordEncoder) throws Exception {
        // 4. 사용자 정보 서비스 설정
        /*
         * userDetailsService() : 사용자 정보를 가져올 서비스를 설정함.
         * 이때 설정하는 서비스클래스는 반드시 UserDetailsService를 상속받은 클래스여야 함.
         * passwordEncoder() : 비밀번호를 암호화하기 위한 인코더를 설정
         */

        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailService);
        authProvider.setPasswordEncoder(bCryptPasswordEncoder);

        return new ProviderManager(authProvider);
    }

    // 5. 패스워드 인코더로 사용할 빈 등록
    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
