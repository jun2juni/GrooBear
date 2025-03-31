package kr.or.ddit.sevenfs.vo.organization;

import lombok.Data;

// 사원 VO
@Data
public class EmployeeVO {

	private int atchFileNo;
	private int anslry; // 연봉
	private String telno;
	private String retireDate; // 퇴사일자
	private String proflPhotoUrl;
	private String postNo;
	private String password;
	private String partclrMatter; // 특이사항
	private String genderCode;
	private String enabled;
	private String emplSttusCode;
	private String emplNo;
	private String emplNm;
	private String email;
	private String elctrnSignImageUrl; // 직인서명 이미지
	private String ecnyDate;
	private String detailAdres;
	private String deptCode;
	private String contdEmpno; // 부재시 대결자
	private String clsfCode; // 직급코드
	private String brthdy;
	private String bankNm;
	private String adres;
	private String acnutno; // 계좌번호

	private String deptNm; // 부서명
	private String posNm;  // 직급명
}
