package kr.or.ddit.sevenfs.vo.atrz;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class DocumHolidayVO {
	private int holiActplnNo; //휴가 계획서 번호*
	private String atrzDocNo; //전자결재 문서 번호*
	private String holiCode;  //연차종류*
	private String[] holiStartArr; //연차시작시간 결합*
	private Date holiStart; //연차시작시간*
	private String[] holiEndArr;   //연차종료시작 결합*
	private Date holiEnd;   //연차종료시작*
	
	//DOCUM_HOLIDAY : ATRZ_LINE = 1 : N
	private List<AtrzLineVO> atrzLineVOList;
}
