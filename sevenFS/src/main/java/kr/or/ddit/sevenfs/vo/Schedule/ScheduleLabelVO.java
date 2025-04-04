package kr.or.ddit.sevenfs.vo.schedule;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ScheduleLabelVO {
	// front의 요청과 이름이 다르다면 front에서 처리하자
	private int lblNo;
	private String lblColor;
	private String lblNm;
	private String emplNo;
}
