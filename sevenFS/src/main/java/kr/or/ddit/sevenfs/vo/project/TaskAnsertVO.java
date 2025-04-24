package kr.or.ddit.sevenfs.vo.project;

import java.util.Date;

import lombok.Data;

@Data
public class TaskAnsertVO {
	private int taskNo; // 업무 번호
	private int taskAnswerSn; // 업무 답변 번호
	private String answerCn; // 업무 답변 내용
	private Date answerCreatDt; // 업무 답변 생성 일시
	private Date answerUpdtDt; // 업무 답변 수정 일시
	private String answerWritngEmpno; // 업무 답변 작성 사원 번호
	private int parentAnswerNo; // 대댓글이면 부모 댓글 번호
	private int answerDepth;   // 댓글 깊이 (0: 댓글, 1: 대댓글)
	private String answerWritngEmpNm; // 업무 답변 작성 사원 이름
}
