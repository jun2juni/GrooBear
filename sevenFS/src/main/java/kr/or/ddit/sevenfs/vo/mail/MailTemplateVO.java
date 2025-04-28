package kr.or.ddit.sevenfs.vo.mail;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MailTemplateVO {
	
	// 기본키
	private int emailAtmcCmpltNo;
	
	// 사원번호
	private String emplNo;

	// 템플릿 제목
	private String formSj;
	
	// 템플릿 내용
	private String formCn;
	
	// 사용횟수 ( 많이 사용한 템플릿을 먼저 보여주기 위함 )
	private int raisngUseCo;
}
