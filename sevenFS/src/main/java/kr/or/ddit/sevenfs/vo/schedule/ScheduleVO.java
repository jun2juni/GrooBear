package kr.or.ddit.sevenfs.vo.schedule;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
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
		
		// 일정 유형 0:개인공개 1:부서공개 2:전체공개	// 프론트에서 작성 // 완
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
		
		// 1대다관계가 아니기 때문에 주석처리함.
//		private List<ScheduleLabelVO> labelList;
}
