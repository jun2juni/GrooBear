<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="메인" />

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
 	<meta name="viewport"
		  content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"/>
	<meta http-equiv="X-UA-Compatible" content="ie=edge" />
	<title>${title}</title>
  <%@ include file="../../layout/prestyle.jsp" %>
</head>
<body>
<%@ include file="../../layout/sidebar.jsp" %>
<main class="main-wrapper">
  <%@ include file="../../layout/header.jsp" %>
	<section class="section">
		<div class="container-fluid">
			<%-- ${emplVacation} --%>
			<div class="row">			
				<div class="col-2">
	              <div class="icon-card mb-30">
	                <div class="content mx-auto">
	                  <div>
	                  	<h3><span class="status-btn success-btn">직급???</span></h3>
	                  </div>
	                  <div>
	                    <p class="text-dark text-center">${emplVacation.emplNm}</p>
	                  </div>
	                </div>
	              </div>
	              <!-- End Icon Cart -->
	            </div>
				<div class="col-3">
	              <div class="icon-card mb-30">
	                <div class="content mx-auto">
	                  <div>
	                  	<h3><span class="status-btn success-btn">총 연차 수</span></h3>
	                  </div>
	                  <div>
	                    <p class="text-center"> ${emplVacation.totYrycDaycnt} </p>
	                  </div>
	                </div>
	              </div>
	              <!-- End Icon Cart -->
	            </div>
				<div class="col-3">
	              <div class="icon-card mb-30">
	                <div class="content mx-auto">
	                  <div>
	                  	<h3><span class="status-btn success-btn">사용 연차 수</span></h3>
	                  </div>
	                  <div>
	                    <p class="text-center">${emplVacation.yrycUseDaycnt}</p>
	                  </div>
	                </div>
	              </div>
	              <!-- End Icon Cart -->
	            </div>
				<div class="col-3">
	              <div class="icon-card mb-30">
	                <div class="content mx-auto">
	                  <div>
	                  	<h3><span class="status-btn success-btn">잔여 연차 수</span></h3>
	                  </div>
	                  <div>
	                    <p class="text-center">보상</p>
	                  </div>
	                </div>
	              </div>
	              <!-- End Icon Cart -->
	            </div>
			</div>
			<div class="row">
          <div class="col-lg-12">
            <div class="card-style clients-table-card mb-30">
              <div class="title d-flex justify-content-between align-items-center">
                <h6 class="mb-10">연차 사용 내역</h6>
                <!-- select box 넣기  -->
              </div>
              <div class="table-wrapper table-responsive">
                <table class="table clients-table">
                  <thead>
                    <tr>
                      <th>
                        <h6></h6>
                      </th>
                      <th>
                        <h6>연차 유형</h6>
                      </th>
                      <th>
                        <h6>사용 기간</h6>
                      </th>
                      <th>
                        <h6>내용</h6>
                      </th>
                      <th>
                        <h6>상태</h6>
                      </th>
                    </tr>
                    <!-- end table row-->
                  </thead>
                  <tbody>
                    <tr>
                      <td>
                        <div>
                        </div>
                      </td>
                      <td class="min-width">
                        <span class="status-btn active-btn">반차</span>
                      </td>
                      <td class="min-width">
                        <p><a href="#0">날짜입력</a></p>
                      </td>
                      <td class="min-width">
                        <p>개인사유</p>
                      </td>
                      <td>
                      	<h5><span class="badge bg-success">사용완료</span></h5>
                      </td>
                    </tr>
                    <!-- end table row -->
                  </tbody>
                </table>
                <!-- end table -->
              </div>
            </div>
            <!-- end card -->
          </div>
          <!-- end col -->
        </div>
			
		</div>
	</section>
  <%@ include file="../../layout/footer.jsp" %>
</main>
<%@ include file="../../layout/prescript.jsp" %>
</body>
</html>
