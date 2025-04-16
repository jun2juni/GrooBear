package kr.or.ddit.sevenfs.vo.organization;

import kr.or.ddit.sevenfs.utils.CommonCode;
import kr.or.ddit.sevenfs.utils.SkilAuth;
import kr.or.ddit.sevenfs.vo.auth.EmpAuthVO;
import kr.or.ddit.sevenfs.vo.chat.ChatRoomVO;
import kr.or.ddit.sevenfs.vo.notification.NotificationVO;
import kr.or.ddit.sevenfs.vo.setting.SkillAuthVO;
import lombok.Data;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.List;

// 사원 VO
@Data
public class EmployeeVO implements UserDetails {
	private int atchFileNo;
	private int anslry; // 연봉
	private String telno;
	private String retireDate; // 퇴사일자
	private String proflPhotoUrl;
	private String postNo;
	private String password;
	private String partclrMatter; // 특이사항
	private String genderCode;
	private String genderCodeNm;
	private String enabled;
	private String emplSttusCode;
	private String emplNo;
	private String emplNm;
	private String email;
	private String elctrnSignImageUrl; // 직인서명 이미지
	private String ecnyDate;
	private String detailAdres;
	private String deptCode;//부서코드
	private String deptCodeNm;//부서코드명
	private String contdEmpno; // 부재시 대결자
	private String clsfCode; // 직급코드
	private String clsfCodeNm; // 직급코드명
	private String brthdy;
	private String bankNm;
	private String adres;
	private String acnutno; // 계좌번호
	
	private String upperCmmnCode; // 상위부서코드

	private String deptNm; // 부서명
	private String posNm;  // 직급명

	private List<EmpAuthVO> empAuthVOList;

	// 읽지 않은 알림 목록
	private List<NotificationVO> notificationVOList;

	// 채팅창 목록 (읽지 않은 채팅 방들 만)
	private List<ChatRoomVO> chatRoomVOList;

	// 권한 정보 허성진
	private List<SkillAuthVO> skillAuth;
	
	// 성별코드에 맞는 성별 반환
	public void setGenderCode(String genderCode) {
		this.genderCode = genderCode;
		this.genderCodeNm = CommonCode.GenderEnum.FEMALE.getLabelByCode(genderCode);
	}

	// 직급코드에 맞는 직급명 반환
	public void setClsfCode(String clsfCode) {
		this.clsfCode = clsfCode;
		this.clsfCodeNm = CommonCode.PositionEnum.INTERN.getLabelByCode(clsfCode);
	}
	
	// 스프링 시큐리티 용 ----------------------------------
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return List.of();
	}

	@Override
	public String getUsername() {
		return this.emplNo;
	}

	//사용자의 패스워드 반환
//	@Override
//	public String getPassword() {
//		return password;
//	}

	@Override
	public boolean isAccountNonExpired() {
		return UserDetails.super.isAccountNonExpired();
	}

	@Override
	public boolean isAccountNonLocked() {
		return UserDetails.super.isAccountNonLocked();
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return UserDetails.super.isCredentialsNonExpired();
	}

	@Override
	public boolean isEnabled() {
		return UserDetails.super.isEnabled();
	}
}
