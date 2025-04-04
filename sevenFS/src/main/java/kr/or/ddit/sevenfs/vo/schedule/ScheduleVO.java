package kr.or.ddit.sevenfs.vo.schedule;

import java.util.Date;
import java.util.List;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ScheduleVO {
	// front의 요청과 이름이 다르다면 front에서 처리하자
	// vo
	
	// pk
	private int schdulNo;
	// 작성자
	private String emplNo;
	
	// 라벨 넘버	// 프론트에서 작성 //완
	private int lblNo;
	
	////////////////////////////////////////////////////
		
	// 일정 유형 0:개인공개 1:전체공개	// 프론트에서 작성 // 완
	private String schdulTy;
	
	// 제목	// 프론트에서 작성 //완
	private String schdulSj; 
	
	// 내용	// 프론트에서 작성 //완
	private String schdulCn;
	
	// 시작날짜	// 프론트에서 작성 //완
	private Date schdulBeginDt;
	
	// 종료 날짜	// 프론트에서 작성 //완
	private Date schdulEndDt;
	
	// 장소	// 프론트에서 작성
	private String schdulPlace;
	
	////////////////////////////////////////////////////
	
	// 부서번호
	private String deptCode;
	
	private List<ScheduleLabelVO> labelList;
	
}
