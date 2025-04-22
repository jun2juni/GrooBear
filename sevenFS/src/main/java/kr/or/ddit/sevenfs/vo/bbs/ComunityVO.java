package kr.or.ddit.sevenfs.vo.bbs;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ComunityVO {
	private int bbsSn; // 게시판 순번
	private int bbsCtgryNo; // 게시판 카테고리 번호
	private String emplNo; // 사원 번호 == 사원정보
	private String bbscttSj; // 게시글 제목
	private String bbscttCn; // 게시글 내용
	private String bbscttCreatDt; // 게시글 생성 일시
	private String bbscttUpdtDt; // 게시글 수정 일시
	private int rdcnt; // 조회수
	private String bbscttUseYn; // 삭제여부
	private String upendFixingYn; // 수정여부
	private long atchFileNo; // 첨부파일 번호 == 파일번호
	
	private List<MultipartFile> files; // 파일 정보

	private String searchKeyword; // 검색 키워드
	private String orderByDate; // 오더바이데이트
	private String category;  // bbscttSj 또는 bbscttCn
	
	private String bbsCtgryNm; // 게시판 카테고리 이름
	private String emplNm;     // 작성자 이름
	private int commentCnt;    // 댓글 수
	private int likeCnt; // 좋아요 수
	private int rowNumber; // 게시글 번호
	
	private String ttmiContent;     // bbscttCn where bbs_ctgry_no = 14
	private String todayContent;    // bbscttCn where bbs_ctgry_no = 15
	private String emoji;     // bbscttCn where bbs_ctgry_no = 16
	
	//  페이징용
    private int offset;
    private int limit;

}
