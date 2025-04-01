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
	<c:import url="../layout/prestyle.jsp" />
</head>
<body>
<c:import url="../layout/sidebar.jsp" />
<main class="main-wrapper">
	<c:import url="../layout/header.jsp" />
	
	<section class="section">
		<div class="container-fluid">
		<div class="row">
        <div class="col-12">
          <div class="card-style">
            <table class="table table-hover">
              <thead>
              <tr>
                <th scope="col">프로젝트 명</th>
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
                  <td>${project.prjctBeginDate}</td>
                  <td>${project.prjctEndDate}</td>
                </tr>
              </c:forEach>
              </tbody>
            </table>
          </div>
        </div>
      </div>
			
		</div>
	</section>
	<c:import url="../layout/footer.jsp" />
</main>
<c:import url="../layout/prescript.jsp" />
</body>
</html>
