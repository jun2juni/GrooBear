<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="커뮤니티" />
<c:set var="copyLight" scope="application" value="by 박현준" />


<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8" />
	
 	<meta name="viewport"
		  content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"/>
	<meta http-equiv="X-UA-Compatible" content="ie=edge" />
	
	<title>${bbsVO.bbsCtgryNm}</title>
	
  <%@ include file="../layout/prestyle.jsp" %>
<style>
.file-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
}

.file-table th, .file-table td {
    border: 1px solid #ddd;
    padding: 10px;
    text-align: center;
}

.file-table th {
    background-color: #f4f4f4;
    font-weight: bold;
}

.file-table tr:hover {
    background-color: #f9f9f9;
}

.file-table a {
    text-decoration: none;
    color: #007bff;
}

.file-table a:hover {
    text-decoration: underline;
}

table.table-hover.align-middle.text-center tbody tr td {
	padding: 10px 0; /* 상하 15px, 좌우 0px */
}


</style>
</head>
<c:if test="${not empty errorMessage}">
    <script>
        alert("${errorMessage}");
    </script>
</c:if>
<body>

<%@ include file="../layout/sidebar.jsp" %>
<main class="main-wrapper">
  <%@ include file="../layout/header.jsp" %>
	<section class="section">
      <div class="container-fluid">
        <div class="card-style mb-4">
          <div class="d-flex justify-content-between align-items-center mb-3">
		    <h3 class="text-dark">${bbsList[0].bbsCtgryNm}</h3>
		    <div>
		    		<!-- 관리자이면 공지사항 게시판에서 보이고 관리자가 아니면 공지사항에는 안보이지만 나머지 카테고리에선 보여야함 -->
		    	<c:if test="${myEmpInfo.emplNo == '20250000' || bbsVO.bbsCtgryNo != 1}">
				  <a href="/bbs/bbsInsert?bbsCtgryNo=${bbsVO.bbsCtgryNo}" class="btn btn-outline-primary me-2">
				    게시글 추가
				  </a>
				</c:if>
		        <c:if test="${myEmpInfo.emplNo == '20250000'}"><!-- 마동석이면 보이게 -->
			        <button type="button" id="bulkToggleBtn" class="btn btn-outline-secondary me-2">일괄삭제</button>
			        <button type="button" id="bulkDeleteBtn" class="btn btn-danger" style="display:none;">선택 삭제</button>
				</c:if>
		    </div>
		</div>

          <!-- (나머지 게시판 및 테이블 내용) -->
          <nav class="navbar navbar-light">
            <div class="container-fluid" style="padding-left:0px;">
              <form action="/bbs/bbsList" method="get" class="d-flex">
              <input type="hidden" value="${bbsVO.bbsCtgryNo}" name="bbsCtgryNo">
                <!-- 카테고리 선택 드롭다운 -->
                <select name="category" class="form-select me-2" style="width: 100px;">
				  <option value="bbscttSj"
				    <c:if test="${selectedCategory == 'bbscttSj'}">selected</c:if>
				  >제목</option>
				
				  <option value="emplNm"
				    <c:if test="${selectedCategory == 'emplNm'}">selected</c:if>
				  >작성자</option>
				</select>


                
                <!-- 검색어 입력 필드 -->
                <input type="text" name="searchKeyword" value="${SearchKeyword}" class="form-control me-2 col-auto flex-grow-1" placeholder="검색어 입력"">
                
                <!-- 검색 버튼 -->
                <button style="white-space: nowrap;" type="submit" class="btn btn-outline-primary">검색</button>
              </form>
              	
            </div>
          </nav>

          <div class="table">
            <table class="table table-hover align-middle text-center" style="table-layout: fixed; width: 100%;">
              <thead class="table-light">
                <tr>
				    <th style="width: 3%; display: none;" class="bulk-col">
				      <input type="checkbox" id="checkAll" />
				    </th>
                  <th style="width: 8%;">게시글 번호</th>
                  <th style="width: 2%;"></th>
                  <th style="width: 50%;">제목</th>
                  <th style="width: 10%;">작성자</th>
                  <th style="width: 15%;">작성일</th>
                  <th style="width: 8%;">조회수</th>
                  <th style="width: 8%;">좋아요</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="bbsVO" items="${bbsList}">
                  	<tr onClick="location.href='/bbs/bbsDetail?bbsSn=${bbsVO.bbsSn}'" style="cursor:pointer;">
                  	<td onclick="event.stopPropagation();" style="display: none;" class="bulk-col">
				      <input type="checkbox" class="bulk-check" value="${bbsVO.bbsSn}" />
				    </td>
                    <td style="border-bottom:1px solid #efefef;">${bbsVO.rowNumber}</td>
                    <td style="border-bottom:1px solid #efefef;">
                    	<c:if test="${bbsVO.upendFixingYn == 'Y'}">
					        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pin-angle-fill" viewBox="0 0 16 16" style="color:red;">
							  <path d="M9.828.722a.5.5 0 0 1 .354.146l4.95 4.95a.5.5 0 0 1 0 .707c-.48.48-1.072.588-1.503.588-.177 0-.335-.018-.46-.039l-3.134 3.134a6 6 0 0 1 .16 1.013c.046.702-.032 1.687-.72 2.375a.5.5 0 0 1-.707 0l-2.829-2.828-3.182 3.182c-.195.195-1.219.902-1.414.707s.512-1.22.707-1.414l3.182-3.182-2.828-2.829a.5.5 0 0 1 0-.707c.688-.688 1.673-.767 2.375-.72a6 6 0 0 1 1.013.16l3.134-3.133a3 3 0 0 1-.04-.461c0-.43.108-1.022.589-1.503a.5.5 0 0 1 .353-.146"/>
							</svg>
					    </c:if>
                    </td>
                    <td style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis; text-align: left;border-bottom:1px solid #efefef;">
                    	${bbsVO.bbscttSj}
                    	<c:choose>
                        <c:when test="${not empty bbsVO.files and bbsVO.files.size() > 0}">
                          	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-paperclip" viewBox="0 0 16 16">
							  <path d="M4.5 3a2.5 2.5 0 0 1 5 0v9a1.5 1.5 0 0 1-3 0V5a.5.5 0 0 1 1 0v7a.5.5 0 0 0 1 0V3a1.5 1.5 0 1 0-3 0v9a2.5 2.5 0 0 0 5 0V5a.5.5 0 0 1 1 0v7a3.5 3.5 0 1 1-7 0z"/>
							</svg>
                        </c:when>
                      </c:choose>
                      <c:if test="${bbsVO.commentCnt != null}">
					        <span style="color: red;">[${bbsVO.commentCnt}]</span>
					  </c:if>
                      
                    </td>
                    <td style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;border-bottom:1px solid #efefef;">${bbsVO.emplNm}</td>
                    <td style="border-bottom:1px solid #efefef;">${fn:substring(bbsVO.bbscttCreatDt, 0, 16)}</td>
                    <td style="border-bottom:1px solid #efefef;">
                      ${bbsVO.rdcnt}
                    </td>
                    <td style="border-bottom:1px solid #efefef;">
                      ${bbsVO.likeCnt}
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
            <div class="row mb-4">
				<div class="col-12">
					<div class="card-style">
					  <page-navi
						url="/bbs/bbsList?${articlePage.getSearchVo()}"
						current="${articlePage.getCurrentPage()}"
						show-max="5"
						total="${articlePage.getTotalPages()}"
					></page-navi>
					</div>
				</div>
			</div>
          </div>
        </div>
      </div>
    </section>
  <%@ include file="../layout/footer.jsp" %>
</main>
<script>
	document.addEventListener("DOMContentLoaded", () => {
	  const toggleBtn = document.getElementById("bulkToggleBtn");
	  const deleteBtn = document.getElementById("bulkDeleteBtn");
	  const checkAll = document.getElementById("checkAll");
	
	  toggleBtn.addEventListener("click", () => {
	    const bulkCols = document.querySelectorAll(".bulk-col");
	    const display = bulkCols[0].style.display === "none" || bulkCols[0].style.display === "" ? "table-cell" : "none";
	
	    bulkCols.forEach(col => col.style.display = display);
	    deleteBtn.style.display = display === "table-cell" ? "inline-block" : "none";
	  });
	
	  checkAll?.addEventListener("change", (e) => {
	    document.querySelectorAll(".bulk-check").forEach(cb => cb.checked = e.target.checked);
	  });
	
	  deleteBtn.addEventListener("click", () => {
	    const selected = Array.from(document.querySelectorAll(".bulk-check:checked")).map(cb => cb.value);
	    if (selected.length === 0) {
	      alert("삭제할 게시글을 선택해주세요.");
	      return;
	    }
	
	    if (!confirm(`${selected.length}개의 게시글을 삭제하시겠습니까?`)) return;
	
	    fetch("/bbs/bulkDelete", {
	      method: "POST",
	      headers: { "Content-Type": "application/json" },
	      body: JSON.stringify({ ids: selected })
	    })
	    .then(res => res.ok ? location.reload() : alert("삭제 실패"))
	    .catch(err => alert("에러 발생"));
	  });
	});
</script>

<%@ include file="../layout/prescript.jsp" %>
</body>
</html>
