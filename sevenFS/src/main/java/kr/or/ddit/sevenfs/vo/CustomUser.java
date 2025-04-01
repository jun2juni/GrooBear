package kr.or.ddit.sevenfs.vo;

import kr.or.ddit.sevenfs.vo.organization.EmployeeVO;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Getter
public class CustomUser extends User {
    private EmployeeVO empVO;

    public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
        super(username, password, authorities);
    }

    //생성자.return memberVO == null?null:new CustomUser(memberVO);
    public CustomUser(EmployeeVO empVO) {
        //사용자가 정의한 (select한) MemberVO 타입의 객체 memberVO를
        //스프링 시큐리티에서 제공해주고 있는 UsersDetails 타입으로 변환
        //회원정보를 보내줄테니 이제부터 프링이 너가 관리해줘
        super(empVO.getEmplNo(), empVO.getPassword(),
                empVO.getAuthorities().stream()
                        .map(auth ->
                                new SimpleGrantedAuthority(auth.getAuthority()))
                        .collect(Collectors.toList())
        );

        this.empVO = empVO;
    }

}
