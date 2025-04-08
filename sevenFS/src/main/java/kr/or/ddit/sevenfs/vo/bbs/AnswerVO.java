package kr.or.ddit.sevenfs.vo.bbs;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class AnswerVO {
	private int answerNo; // 댓글 번호
    private int bbsSn; // 게시판 번호
    private int bbsCtgryNo; // 게시판 카테고리 번호
    private String emplNo; // 사원번호
    private String answerCn; // 댓글 내용
    private LocalDateTime answerCreatDt; // 댓글 생성 일시
}
