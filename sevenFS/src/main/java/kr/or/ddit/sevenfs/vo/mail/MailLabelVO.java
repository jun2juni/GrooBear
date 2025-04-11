package kr.or.ddit.sevenfs.vo.mail;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MailLabelVO {
	
	// 기본키
	private int lblNo;
	
	// 사원 번호
	private String emplNo;
	
	// 라벨명
	private String lblNm;
}
