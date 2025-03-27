package kr.or.ddit.sevenfs.utils;

import java.util.HashMap;
import java.util.Map;

import lombok.Data;

@Data
public class ArticlePage<T> {
	// 전체글 수
	private Integer total = 0;
	// 현재 페이지 번호
	private int currentPage = 1;
	// 전체 페이지수
	private int totalPages = 0;
	// 블록의 크기
	private int blockSize = 5;
	// 블록의 시작 페이지 번호
	private int startPage;
	// 블록의 종료 페이지 번호
	private int endPage;
	// 검색어
	// private String keyword = "";
	// 요청URL
	private String url = "";
	// select 결과 데이터
//	private List<T> content;
	// 페이징 처리
	private String pagingArea = "";
	// pagination 구성 할때, page 번호의 url에 ?search=test와 같이 구성하기 위한 파라미터들
	private Map<String, Object> pageMap = new HashMap<String, Object>();
	// 검색 조건 vo로 처리하기 위해서 추가
	private T searchVo;

	public ArticlePage(int total, int currentPage, int size) {
		// size : 한 화면에 보여질 목록의 행 수
		System.out.println(total + "????");
		this.total = total;
		this.currentPage = currentPage;

		// 전체글 수가 0이면?
		if (total == 0) {
			totalPages = 1;// 전체 페이지 수
			startPage = 1;// 블록 시작번호
			endPage = 1; // 블록 종료번호
		} else {// 글이 있다면
			// 전체 페이지 수 = 전체글 수 / 한 화면에 보여질 목록의 행 수
			// 3 = 31 / 10
			totalPages = total / size;
			// 나머지가 있다면, 페이지를 1 증가
			if (total / size > 0) {
				totalPages++;
			}

			// 페이지 블록 시작번호를 구하는 공식
			// 블록시작번호 = 현재페이지 / 페이지크기 * 페이지크기 + 1
			startPage = currentPage / blockSize * blockSize + 1;

			// 현재페이지 % 페이지크기 => 0일 때 보정
			if (currentPage % blockSize == 0) {
				startPage -= blockSize;
			}

			// 블록종료번호 = 시작페이지번호 + (페이지크기 - 1)
			// [1][2][3][4][5][다음]
			endPage = startPage + (blockSize - 1);

			// 종료 페이지 번호 > 전체페이지 수
			if (endPage > totalPages) {
				endPage = totalPages;
			}
		}
	}

	// 전체 글의 수가 0인가?
	public boolean hasNoArticles() {
		return this.total == 0;
	}

	// 데이터가 있나?
	public boolean hasArticles() {
		return this.total > 0;
	}

	public void setPagingArea(String pagingArea) {
		this.pagingArea = pagingArea;
	}

	// 페이징 블록을 자동화
	public String getPagingArea() {
		return this.pagingArea;
	}
}
