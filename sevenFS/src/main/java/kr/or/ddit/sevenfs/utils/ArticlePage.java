package kr.or.ddit.sevenfs.utils;

import java.util.HashMap;
import java.util.List;
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
	private int blockSize = 10;
	// 블록의 시작 페이지 번호
	private int startPage;
	// 블록의 종료 페이지 번호
	private int endPage;
	// 검색어
	// private String keyword = "";
	// 요청URL
	private String url = "";
	// select 결과 데이터
	private List<T> content;
	// 페이징 처리
	private String pagingArea = "";
	// pagination 구성 할때, page 번호의 url에 ?search=test와 같이 구성하기 위한 파라미터들
	private Map<String, Object> pageMap = new HashMap<String, Object>();
	// 검색 조건 vo로 처리하기 위해서 추가
	private T searchVo;

	public ArticlePage(int total, int currentPage, int size) {
		// size : 한 화면에 보여질 목록의 행 수
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
			if (total % size > 0) {
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
	
	//오버로딩
	//전자결재 동기 전용
	public ArticlePage(int total, int currentPage, int size, List<T> content, Map<String,Object> map) {
		// size : 한 화면에 보여질 목록의 행 수
		this.total = total;
		this.currentPage = currentPage;
		this.content = content;//***
		
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
			if (total % size > 0) {
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
			
			String duration = "";
			String tab = "";
			String keyword = "";
			String searchType = "";
			
			//Map<String,object> keyword
			if(map!=null && map.get("duration")!=null) {
				duration = map.get("duration").toString();
			}
			if(map!=null && map.get("tab")!=null) {
				tab = map.get("tab").toString();
			}
			if(map!=null && map.get("keyword")!=null) {
				tab = map.get("keyword").toString();
			}
			if(map!=null && map.get("searchType")!=null) {
				tab = map.get("searchType").toString();
			}
			
			
			
			//***** 페이징 블록 처리 시작 *****
		      this.pagingArea += "<page-navi url='#' current='1' show-max='5' total='1'>";
		      this.pagingArea += "<ul class='pagination w-fit mx-auto'>";
		      this.pagingArea += "<li class='page-item'><a href='/atrz/approval?currentPage=1&tab="+tab+"&keyword="+keyword+"&searchType="+searchType+"&duration="+duration+"' class='page-link' data-page='1'>«</a></li>";
		      
		      String strHide = "";
		      if(this.startPage < 6) {
		         strHide = "style='display:none;'";
		      }
		      this.pagingArea += "<li class='page-item' "+strHide+">";
		      this.pagingArea += "<a href='/atrz/approval?currentPage="+(this.startPage-5)+"&tab="+tab+"&keyword="+keyword+"&searchType="+searchType+"&duration="+duration+"' class='page-link' data-page='1'>&lt;</a></li>";
		      
		      String str = "";      
		      for(int pNo=this.startPage;pNo<=this.endPage;pNo++) {
		         if(this.currentPage != pNo) {
		            str = "";
		         }else {
		        	 str = "active";
		         }
		         this.pagingArea += "<li class='page-item "+str+"'><a href='/atrz/approval?currentPage="+pNo
		               +"&tab="+tab+"&duration="+duration+"' class='page-link' data-page='1'>"+pNo+"</a></li>";
		      }//end for
		      
		      String strEHide = "";
		      if(this.endPage >= this.totalPages) {
		         strEHide = "style='display:none;'";
		      }
		      this.pagingArea += "<li class='page-item' "+strEHide+">";
		      this.pagingArea += "<a href='/atrz/approval?currentPage="+(this.startPage+5)+"&tab="+tab+"&keyword="+keyword+"&searchType="+searchType+"&duration="+duration+"' class='page-link' data-page='1'>&gt;</a>";
		      this.pagingArea += "</li>";
		      this.pagingArea += "<li class='page-item'>";
		      this.pagingArea += "<a href='/atrz/approval?currentPage="+this.totalPages+"&tab="+tab+"&keyword="+keyword+"&searchType="+searchType+"&duration="+duration+"' class='page-link'>»</a>";
		      this.pagingArea += "</li></ul></page-navi>";
		      //***** 페이징 블록 처리 끝 *****
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
