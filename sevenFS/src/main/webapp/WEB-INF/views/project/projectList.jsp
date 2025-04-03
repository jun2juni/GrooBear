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
<meta
name="viewport"
content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"
/>
<meta http-equiv="X-UA-Compatible" content="ie=edge" />
<title>${title}</title>
</head>
<body>
<main class="main-wrapper">

<section class="section">
<div class="container-fluid">
    <!-- 검색 폼 추가 -->
    <div class="row mb-4">
        <div class="col-6">
            <div class="card-style">
                <form id="searchForm" method="get" action="/project/projectList">
                    <div class="input-group">
                        <input type="text" name="keyword" value="${param.keyword}" class="form-control" placeholder="검색어를 입력하세요">
                        <button type="submit" class="btn btn-primary">검색</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-12">
            <div class="card-style">
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th scope="col" id="proNm">프로젝트 명</th>
                        <th scope="col">카테고리</th>
                        <th scope="col">책임자</th>
                        <th scope="col">상태</th>
                        <th scope="col">등급</th>
                        <th scope="col">시작일</th>
                        <th scope="col">종료일</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="project" items="${projectList}">
                    <tr>
                        <td>${project.prjctNm}</td>
                        <td>${project.ctgryNm}</td>
                        <td>${project.prtcpntNm}</td>
                        <td>${project.prjctSttusNm}</td>
                        <td>${project.prjctGrad}</td>
                        <td>${project.prjctBeginDateFormatted}</td>
						<td>${project.prjctEndDateFormatted}</td>
                    </tr>
                    </c:forEach>
                    </tbody>
                </table>

				<!-- 페이지 네비게이션 -->
				<div class="row mb-4">
				    <div class="col-12">
				        <div class="card-style">
				            <div style="display: flex; justify-content: center;">
				                <page-navi
				                    url="/project/projectList?keyword=${param.keyword}"
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
    </div>
</div>
</section>
</main>
</body>
</html>