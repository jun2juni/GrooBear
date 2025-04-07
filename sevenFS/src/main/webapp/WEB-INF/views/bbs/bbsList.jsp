	<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="메인" />

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
 	<meta name="viewport"
		  content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"/>
	<meta http-equiv="X-UA-Compatible" content="ie=edge" />
	<title>게시판</title>
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
	padding: 15px 0; /* 상하 15px, 좌우 0px */
}


</style>
</head>
<body>
<%@ include file="../layout/sidebar.jsp" %>
<main class="main-wrapper">
  <%@ include file="../layout/header.jsp" %>
	<section class="section">
      <div class="container-fluid">
        <div class="card-style mb-4">
          <div class="d-flex justify-content-between align-items-center mb-3">
            <h3 class="text-dark">게시판</h3>
            <!-- 움직이는 태두리 없이 hover 효과만 적용 -->
            <a href="/bbs/bbsInsert" class="btn btn-outline-primary">게시글 추가</a>
          </div>
          <!-- (나머지 게시판 및 테이블 내용) -->
          <nav class="navbar navbar-light">
            <div class="container-fluid" style="padding-left:0px;">
              <form action="/bbs/bbsList" method="get" class="d-flex">
              	<input type="hidden" name="bbsCtgryNo" value="1">
                <!-- 카테고리 선택 드롭다운 -->
                <select name="category" class="form-select me-2">
				  <option value="bbscttSj"
				    <c:if test="${selectedCategory == 'bbscttSj'}">selected</c:if>
				  >제목</option>
				
				  <option value="bbscttCn"
				    <c:if test="${selectedCategory == 'bbscttCn'}">selected</c:if>
				  >내용</option>
				</select>


                
                <!-- 검색어 입력 필드 -->
                <input type="text" name="searchKeyword" value="${SearchKeyword}" class="form-control me-2" placeholder="검색어 입력">
                
                <!-- 검색 버튼 -->
                <button style="white-space: nowrap;" type="submit" class="btn btn-outline-primary">검색</button>
              </form>
            </div>
          </nav>

          <div class="table-responsive">
            <table class="table table-hover align-middle text-center" style="table-layout: fixed; width: 100%;">
              <thead class="table-light">
                <tr>
                  <th style="width: 10%;">게시글 번호</th>
                  <th style="width: 60%; text-align: left;">제목</th>
                  <th style="width: 10%;">작성자</th>
                  <th style="width: 10%;">작성일</th>
                  <th style="width: 10%;">조회수</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="bbsVO" items="${bbsList}">
                  <tr onClick="location.href='/bbs/bbsDetail?bbsSn=${bbsVO.bbsSn}'" style="cursor:pointer;">
                    <td>${bbsVO.bbsSn}</td>
                    <td style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis; text-align: left;">
                    	<c:if test="${bbsVO.upendFixingYn == 'Y'}">
					        <span style="color: red; font-weight: bold;">[공지]</span>
					    </c:if>
                    	${bbsVO.bbscttSj}
                    	<c:choose>
                        <c:when test="${not empty bbsVO.files and bbsVO.files.size() > 0}">
                          	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-archive-fill" viewBox="0 0 16 16">
						  		<path d="M12.643 15C13.979 15 15 13.845 15 12.5V5H1v7.5C1 13.845 2.021 15 3.357 15zM5.5 7h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1 0-1M.8 1a.8.8 0 0 0-.8.8V3a.8.8 0 0 0 .8.8h14.4A.8.8 0 0 0 16 3V1.8a.8.8 0 0 0-.8-.8z"/>
							</svg>
                        </c:when>
                      </c:choose>
                    </td>
                    <td style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${myEmpInfo.emplNm}</td>
                    <td>${fn:substring(bbsVO.bbscttCreatDt, 0, 10)}</td>
                    <td>
                      ${bbsVO.rdcnt}
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
<%@ include file="../layout/prescript.jsp" %>
</body>
</html>
