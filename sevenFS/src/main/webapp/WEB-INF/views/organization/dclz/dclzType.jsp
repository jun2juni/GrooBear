<%@page import="java.util.Calendar" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="메인" />
<c:set var="copyLight" scope="application" value="by 박호산나" />

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
  <c:import url="../../layout/prestyle.jsp" />
</head>
<body>
<c:import url="../../layout/sidebar.jsp" />
<main class="main-wrapper">
  <c:import url="../../layout/header.jsp" />
  
  
  <%
	// 서버에서 현재 연도 구하기 (JSP 스크립틀릿 사용)
	int currentYear = Calendar.getInstance().get(Calendar.YEAR);
	request.setAttribute("currentYear", currentYear);
  %>
  
  <section class="section">
	<div class="container-fluid">
	  <div class="row">
		<div class="col-12">
		  <div class="row">
			<%-- <div class="text-center mb-20">
				<h4><p class="status-btn" style="color:thistle; font-size:20px; font-weight:bold; background-color: white;"> ${paramKeyword.substring(0,4)}년 근태현황 </p></h4>
			</div> --%>
			<div class="col-3">
			  <div class="icon-card mb-30">
				<div class="icon orange">
				  <i class="lni lni-user"></i>
				</div>
				<div class="content">
				  <h6 class="mb-10">근무</h6>
				  <h3 style="margin-top: 20px;" class="text-bold mb-10">${dclzCnt.work == null ? 0 : dclzCnt.work}<span class="text-gray text-sm">건</span></h3>
				  <p class="text-sm text-success">
					<span></span>
				  </p>
				</div>
			  </div>
			  <!-- End Icon Cart -->
			</div>
			<!-- End Col -->
			<div class="col-3">
			  <div class="icon-card mb-30">
				<div class="icon success">
				  <i class="lni lni-users"></i>
				</div>
				<div class="content">
				  <h6 class="mb-10">출장</h6>
				  <h3 style="margin-top: 20px;"
					  class="text-bold mb-10">${dclzCnt.businessTrip == null ? 0 : dclzCnt.businessTrip}<span class="text-gray text-sm">건</span></h3>
				  <p class="text-sm text-gray">
					<c:forEach var="dclzType" items="${empDetailDclzTypeCnt}" varStatus="status">
					  <c:choose>
						<c:when test="${dclzType.upperCmmnCode == '30' && dclzType.cnt != 0}">
						  <span>${dclzType.cmmnCodeNm} ${dclzType.cnt}&nbsp;</span>
						</c:when>
						<c:otherwise>
						</c:otherwise>
					  </c:choose>
					</c:forEach>
					<span></span>
				  </p>
				</div>
			  </div>
			  <!-- End Icon Cart -->
			</div>
			<!-- End Col -->
			<!-- </div> -->
			<!-- End Col -->
			<!-- <div class="row"> -->
			<div class="col-3">
			  <div class="icon-card mb-30">
				<div class="icon orange">
				  <i class="lni lni-smile"></i>
				</div>
				<div class="content">
				  <h6 class="mb-10">휴가</h6>
				  <h3 style="margin-top: 20px;"
					  class="text-bold mb-10">${dclzCnt.vacation == null ? 0 : dclzCnt.vacation}<span class="text-gray text-sm">건</span></h3>
				  <p class="text-sm text-gray">
					<c:forEach var="dclzType" items="${empDetailDclzTypeCnt}" varStatus="status">
					  <c:choose>
						<c:when test="${dclzType.upperCmmnCode == '20' && dclzType.cnt != 0}">
						  <span>${separator}${dclzType.cmmnCodeNm} ${dclzType.cnt}&nbsp;</span>
						</c:when>
						<c:otherwise>
						  <span> </span>
						</c:otherwise>
					  </c:choose>
					</c:forEach>
				  </p>
				</div>
			  </div>
			  <!-- End Icon Cart -->
			</div>
			<div class="col-3">
			  <div class="icon-card">
				<div class="icon primary">
				  <i class="lni lni-alarm-clock"></i>
				</div>
				<div class="content">
				  <h6 class="mb-10">기타</h6>
				  <h3 style="margin-top: 20px;" class="text-bold mb-10">${dclzCnt.bad == null ? 0 : dclzCnt.bad}<span class="text-gray text-sm">건</span></h3>
				  <p class="text-sm text-danger">
					<c:forEach var="dclzType" items="${empDetailDclzTypeCnt}" varStatus="status">
					  <c:choose>
						<c:when test="${dclzType.upperCmmnCode == '00' && dclzType.cnt != 0}">
						  <span>${separator}${dclzType.cmmnCodeNm} ${dclzType.cnt}&nbsp;</span>
						</c:when>
						<c:otherwise>
						  <span> </span>
						</c:otherwise>
					  </c:choose>
					</c:forEach>
				  </p>
				</div>
			  </div>
			  <!-- End Icon Cart -->
			</div>
			<!-- End Col -->
			<!-- </div> -->
		  </div>
		</div>
		<div class="c0l-12">
		  <div class="">
			<div class="card-style mb-30" id="divPage">
			  <div class="title d-flex flex-wrap">
				<div class=" justify-content-first" style="width: 40%">
				  <h6 class="text-medium mb-30">이번달 근무현황</h6>
				  <!-- 출퇴근만 출력? -->
				</div>
				<div class="justify-content-center">
				  <!-- 달력 페이지네이션 -->
				  <form action="/dclz/dclzType" method="get" id="keywordForm">
					<nav class="justify-content-center" aria-label="Page navigation example">
					  <ul class=" d-flex">
						<li class="page-item">
						  <button type="button" class="page-link prevBtn">
							<span aria-hidden="true"><</span>
						  </button>
						</li>
						<input type="hidden" value="${paramKeyword.substring(0,4)}" id="hiddenKeyYear" />
						<input type="hidden" value="${paramKeyword.substring(5,7)}" id="hiddenKeyword" />
						<input type="hidden" value="" id="submitKeyword" name="keyword" />
						<h4 class="ml-10 mr-10"
							id="monthDisplay">${paramKeyword.substring(0,4)}-${paramKeyword.substring(5,7)}</h4>
						<li class="page-item">
						  <button type="button" class="page-link nextPage">
							<span aria-hidden="true">></span>
						  </button>
						</li>
					  </ul>
					</nav>
				  </form>
				  <!-- 달력 페이지네이션 -->
				</div>
				<div class="input-group mb-3 ms-auto justify-content-end w-20">
				  <a href="/dclz/dclzType" class="btn-xs main-btn light-btn-light btn-hover mr-10 rounded">전체 목록 보기</a>
				  <form action="/dclz/dclzType" method="get" id="keywordSearchFome">
					<input type="search" class="form-control rounded" placeholder="년도, 근태유형 입력" aria-label="Search"
						   aria-describedby="search-addon" id="schName" name="keywordSearch"
						   onkeydown="fSchEnder(event)"/>
				  </form>
				  <span class="input-group-text" id="search-addon" onclick="fSch()">
					 <i class="fas fa-search"></i>
				  </span>
				</div>
			  </div>
			  <!-- End Title -->
			  <%-- ${empDclzList} --%>
			  <div class="table-responsive">
				<table class="table top-selling-table">
				  <thead>
				  <tr>
					<th>
					  <h6 class="text-sm text-center text-medium" style="text-center;">근무일자</h6>
					</th>
					<th>
					  <h6 class="text-sm text-medium">근태유형</h6>
					</th>
					<th class="min-width">
					  <h6 class="text-sm text-medium">업무시작</h6>
					</th>
					<th class="min-width">
					  <h6 class="text-sm text-medium">업무종료</h6>
					</th>
					<th class="min-width">
					  <h6 class="text-sm text-medium">총 근무시간</h6>
					</th>
				  </tr>
				  </thead>
				  
				  <!-- 반복문 돌리기 -->
				  <c:set var="dclzTypeList" value="${empDclzList}"></c:set>
				  <tbody id="dclzBody">
				  <c:choose>
					<c:when test="${dclzTypeList.size() == 0}">
					  <td>해당 날짜에 대한 근태현황이 없습니다.</td>
					</c:when>
					<c:otherwise>
					  <c:forEach var="dclzWork" items="${empDclzList}">
						<c:set var="year" value="${dclzWork.dclzNo.substring(0,4)}"></c:set>
						<c:set var="month" value="${dclzWork.dclzNo.substring(4,6)}"></c:set>
						<c:set var="day" value="${dclzWork.dclzNo.substring(6,8)}"></c:set>
						<tr>
						  <td>
							<div>
							  <p class="text-sm text-center">${year}-${month}-${day}</p>
							</div>
						  </td>
						  <td>
							<div>
							  <c:if test="${dclzWork.cmmnCodeNm == '지각'}">
								<h4><span class="badge rounded-pill text-white"
										  style="background-color:salmon">${dclzWork.cmmnCodeNm}</span></h4>
							  </c:if>
							  <c:if test="${dclzWork.cmmnCodeNm == '결근'}">
								<h4><span class="badge rounded-pill text-white"
										  style="background-color:salmon">${dclzWork.cmmnCodeNm}</span></h4>
							  </c:if>
							  <c:if test="${dclzWork.cmmnCodeNm == '출/퇴근'}">
								<h4><span class="badge rounded-pill text-white"
										  style="background-color:mediumSeaGreen">${dclzWork.cmmnCodeNm}</span></h4>
							  </c:if>
							  <c:if test="${dclzWork.cmmnCodeNm == '출장'}">
								<h4><span class="badge rounded-pill text-white"
										  style="background-color:lightBlue">${dclzWork.cmmnCodeNm}</span></h4>
							  </c:if>
							  <c:if test="${dclzWork.cmmnCodeNm == '외근'}">
								<h4><span class="badge rounded-pill text-white"
										  style="background-color:lightBlue">${dclzWork.cmmnCodeNm}</span></h4>
							  </c:if>
							  <c:if test="${dclzWork.cmmnCodeNm == '조퇴'}">
								<h4><span class="badge rounded-pill text-white"
										  style="background-color:thistle">${dclzWork.cmmnCodeNm}</span></h4>
							  </c:if>
							  <c:if test="${dclzWork.cmmnCodeNm == '반차'}">
								<h4><span class="badge rounded-pill text-white"
										  style="background-color:pink">${dclzWork.cmmnCodeNm}</span></h4>
							  </c:if>
							</div>
						  </td>
						  <td>
							<p class="text-sm">${dclzWork.workBeginTime}</p>
						  </td>
						  <td>
							<c:choose>
							  <c:when test="${dclzWork.workEndTime == null}">
								<p class="text-sm">미등록</p>
							  </c:when>
							  <c:otherwise>
								<p class="text-sm">${dclzWork.workEndTime}</p>
							  </c:otherwise>
							</c:choose>
						  </td>
						  <td>
							<c:choose>
							  <c:when test="${dclzWork.workHour == 0}">
								<p class="text-sm">0시간 0분</p>
							  </c:when>
							  <c:when test="${dclzWork.workEndTime == null}">
								<p class="text-sm"></p>
							  </c:when>
							  <c:otherwise>
								<p class="text-sm">${dclzWork.workHour}시간 ${dclzWork.workMinutes}분</p>
							  </c:otherwise>
							</c:choose>
						  
						  </td>
						</tr>
					  </c:forEach>
					</c:otherwise>
				  </c:choose>
				  </tbody>
				</table>
				<%--  <page-navi id="page"
				   url="/dclz/dclzType?"
				   current="${param.get("currentPage")}"
				   show-max="10"
				   total="${articlePage.endPage}"></page-navi> --%>
				<!-- End Table -->
			  </div>
			</div>
		  </div>
		  <!— End Col —>
		</div>
	  </div>
  </section>
  <c:import url="../../layout/footer.jsp" />
</main>
<c:import url="../../layout/prescript.jsp" />

<script type="text/javascript">

  function fSchEnder(e) {
    if(e.code === "Enter") {
      const keywordSearch = $('#keywordSearch').val();
      console.log('dkdkdk : ', keywordSearch);
    }
  }

  $(function() {


    // 버튼 클릭 이벤트
    function updateDateDisplay() {
      const year = $('#hiddenKeyYear').val();
      const month = $('#hiddenKeyword').val();
      const formattedMonth = String(month).padStart(2, '0');
      document.getElementById('monthDisplay').textContent = year + '-' + formattedMonth;

      const newDate = $('#monthDisplay').text();
      console.log(" ddddddd ", newDate);

      $('#submitKeyword').val(newDate);
      console.log('보낼키워드 : ', $('#submitKeyword').val());
      $('#keywordForm').submit();
    }

    // --- 이전버튼
    document.querySelector('.prevBtn').addEventListener('click', () => {
      let hiddenKeyword = Number($('#hiddenKeyword').val());
      hiddenKeyword -= 1;

      if(hiddenKeyword === 0) {
        const prevYear = Number($('#hiddenKeyYear').val()) - 1;
        $('#hiddenKeyYear').val(prevYear);
        hiddenKeyword = 12;
      }
      $('#hiddenKeyword').val(hiddenKeyword);
      updateDateDisplay();

    });

    // --- 다음버튼
    document.querySelector('.nextPage').addEventListener('click', () => {
      let hiddenKeyword = Number($('#hiddenKeyword').val());
      //let monthNum = Number(hiddenKeyword);
      hiddenKeyword += 1;

      if(hiddenKeyword === 13) {
        const nextYear = Number($('#hiddenKeyYear').val()) + 1;
        $('#hiddenKeyYear').val(nextYear);
        hiddenKeyword = 1;
      }
      $('#hiddenKeyword').val(hiddenKeyword);
      updateDateDisplay();
    });
  }) // end fn


</script>

</body>
</html>