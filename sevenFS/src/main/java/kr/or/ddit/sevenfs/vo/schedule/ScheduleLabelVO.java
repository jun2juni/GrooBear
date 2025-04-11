package kr.or.ddit.sevenfs.vo.schedule;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
public class ScheduleLabelVO {
	// front의 요청과 이름이 다르다면 front에서 처리하자
	private int lblNo;
	private String lblColor;
	private String lblNm;
	private String emplNo;
	
	private String deptCode;
}
