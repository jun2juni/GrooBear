<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="title" />
<c:set var="copyLight" scope="application" value="by 길준희" />
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport"
		content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
  <meta http-equiv="X-UA-Compatible" content="ie=edge" />
  <title>${title}</title>
  <%@ include file="../layout/prestyle.jsp" %>
</head>
<style>
    .homeContainer {
        margin-left: 0px;
        margin-right: 0px;
        margin-bottom: 8px;

    }

    .wdBtn {
        --bs-btn-padding-y: .40rem;
        --bs-btn-padding-x: 4rem;
        --bs-btn-font-size: 1rem;
        background-color: #00bfff;
        color: white;
        border-radius: 0 0 5px 5px;
        width: 100%;
        height: 60px;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .actBtn {
        width: 60px;
        height: 20px;
        font-size: 0.8em;
        padding: 0;
        border: 0;
        text-align: center;
    }

    .atrzContSc {
        border: 1px solid lightgray;
        border-radius: 10px;
        /* height: 300px; */
        margin-top: 10px;
        margin-left: 10px;
        margin-right: 10px;
        padding: 10px;
        padding-bottom: 10px;
    }

    .atrzTabCont {
        border: 1px solid lightgray;
        border-radius: 10px;
        margin-top: 10px;
        margin-left: 10px;
        margin-right: 10px;
        margin-bottom: 60px;

    }

    .docList {
        margin-bottom: 0px;
    }

    .homeFr {
        width: 180px;
        padding-left: 10px;
        display: block;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;

    }

    .listCont {
        width: 450px;
        display: block;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;

    }

    .newAtrzDocBtn {
        padding: 0.5rem 1rem;
        font-size: 0.875rem;
    }

    .emptyList {
        padding: 50px 0;
        font-size: 1.2rem;
        color: gray;
    }

</style>
<body>
<%@ include file="../layout/sidebar.jsp" %>
<main class="main-wrapper">
  <%@ include file="../layout/header.jsp" %>
  <section class="section">
	<div class="container-fluid">
	  <!-- 여기서 작업 시작 -->
	  <div class="col-sm-13" id="divCard">
		<div class="card">
		  <div class="card-body">
			<!-- <p>${atrzVOList}</p> -->
			<!-- 메뉴바 시작 -->
			<div class="d-flex justify-content-between align-items-center">
			  <div id="atrNavBar">
				<ul class="nav nav-pills" id="myTab" role="tablist">
				  <li class="nav-item" role="presentation">
					<!-- <h4 style="margin-left: 10px; color: rgb(54, 92, 245);">전자결재</h4> -->
					<button id="s_eap_btn" class="main-btn active-btn rounded-full btn-hover newAtrzDocBtn"
							data-bs-toggle="modal" data-bs-target="#newAtrzDocModal">
					  새 결재 진행
					</button>
				  </li>
				</ul>
			  </div>
			</div>
		  </div>
		  
		  <!-- 메뉴바 끝 -->
		  <!-- 컨텐츠1 시작 -->
		  <div class="tab-content" id="myTabContent">
			<div style="margin-left: 30px;margin-top: 25px;margin-right: 30px;margin-bottom: 5px;"
			
					class="tab-pane fade show active" id="contact1-tab-pane"
				 role="tabpanel" aria-labelledby="contact1-tab" tabindex="0">
			  <!-- <p>${myEmpInfo}</p> -->
			  <div class="d-flex justify-content-between ms-2 me-2">
				<h4 class="mb-10">결재대기문서</h4>
				<a href="/atrz/document" class="text-sm fw-bolder" style="color: #4a6cf7;">
				  더보기 <span class="material-symbols-outlined" style="vertical-align: middle;">chevron_right</span>
				</a>
			  </div>
			  <div class="atrzTabCont">
				<div class="" style="margin-top: 0px; overflow-x: auto;">
				  <div class="container mt-2 homeContainer" style="padding-left: 20px; padding-top: 10px; padding-bottom: 10px;">
					<c:choose>
					  <c:when test="${empty homeAtrzApprovalList}">
						<div class="text-center emptyList">
						  결재할 문서가 없습니다.
						</div>
					  </c:when>
					  <c:otherwise>
						<div class="d-flex gap-3 flex-nowrap">
						  <input type="hidden" name="emplNo" value="${myEmpInfo.emplNo}">
						  <c:forEach var="atrzVO" items="${homeAtrzApprovalList}">
							<div class="">
							  <div class="card" style="height: 250px; width: 300px; margin-right: 10px;">
								<div class="card-header pt-3" style="height: 50px;">
								  <div class="row g-0 text-center">
									<c:choose>
									  <c:when test="${atrzVO.atrzSttusCode == '00' }">
										<span class="status-btn close-btn actBtn col-sm-6 col-md-4"
											  style="background-color: #fbf5b1; color: #dd9e5f;">진행중</span>
									  </c:when>
									  <c:when test="${atrzVO.atrzSttusCode == '10' }">
										<span class="status-btn active-btn actBtn col-sm-6 col-md-4">완료</span>
									  </c:when>
									  <c:when test="${atrzVO.atrzSttusCode == '20' }">
										<span class="status-btn close-btn actBtn col-sm-6 col-md-4">반려</span>
									  </c:when>
									  <c:when test="${atrzVO.atrzSttusCode == '30' }">
										<span class="status-btn success-btn actBtn col-sm-6 col-md-4">회수</span>
									  </c:when>
									  <c:otherwise>
										<span class="status-btn info-btn actBtn actBtn col-sm-6 col-md-4"
											  style="background-color: pink; color: #ed268a;">취소</span>
									  </c:otherwise>
									</c:choose>
									<a href="/atrz/selectForm/atrzDetail?atrzDocNo=${atrzVO.atrzDocNo}"
									   class="col-6 col-md-8">
									  <h5 class="homeFr">${atrzVO.atrzSj}</h5>
									</a>
								  </div>
								</div>
								<div class="card-body d-flex flex-column justify-content-center" style="height: 150px;">
								  <div class="card-text mb-2">
								  	<span style="width: 80px">기안자</span> ${atrzVO.drafterEmpnm}[${atrzVO.deptCodeNm}]</div>
								  <div class="card-text mb-2">
								  	<span style="width: 80px">기안일시</span>
									<fmt:formatDate value="${atrzVO.atrzDrftDt}" pattern="yyyy-MM-dd" var="onlyDate" />
									<fmt:formatDate value="${atrzVO.atrzDrftDt}" pattern="HH:mm:ss" var="onlyTime" />
									<b>${onlyDate}</b> ${onlyTime}</div>
								  <div class="card-text mb-2">
								  	<span style="width: 80px">결재양식</span>
									<c:choose>
									  <c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'H')}">연차신청서</c:when>
									  <c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'S')}">지출결의서</c:when>
									  <c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'D')}">기안서</c:when>
									  <c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'A')}">급여명세서</c:when>
									  <c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'B')}">급여계좌변경신청서</c:when>
									  <c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'C')}">재직증명서</c:when>
									  <c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'R')}">퇴직증명서</c:when>
									  <c:otherwise>알 수 없는 문서유형</c:otherwise>
									</c:choose>
								  </div>
								</div>
								<div class="col text-center">
								  <a href="/atrz/selectForm/atrzDetail?atrzDocNo=${atrzVO.atrzDocNo}"
									 class="main-btn secondary-btn-outline btn-hover"
									 style="width: 100%; border: none; border-top: 1px solid lightgray;">결재하기</a>
								</div>
							  </div>
							</div>
						  </c:forEach>
						</div>
					  </c:otherwise>
					</c:choose>
				  </div>
				</div>
			  </div>
			  
			  <div class="d-flex justify-content-between ms-2 me-2">
				<h4 class="mb-10">기안진행문서</h4>
				<a href="/atrz/document" class="text-sm fw-bolder" style="color: #4a6cf7;">
				  더보기 <span class="material-symbols-outlined" style="vertical-align: middle;">chevron_right</span>
				</a>
			  </div>
			  <div class="atrzTabCont">
				<div class="col-lg-12">
				  <div class="card-style mb-30 docList">
					<c:choose>
					  <c:when test="${empty atrzMinSubmitList}">
						<div class="text-center emptyList">
						  진행중인 문서가 없습니다.
						</div>
					  </c:when>
					  <c:otherwise>
						<div class="table-wrapper table-responsive">
						  <table class="table striped-table">
							<thead>
							<tr>
							  <th>
								<h6 class="fw-bolder" style="text-align: center;">기안일시</h6>
							  </th>
							  <th>
								<h6 class="fw-bolder">양식유형</h6>
							  </th>
							  <th></th>
							  <th>
								<h6 class="fw-bolder">제목</h6>
							  </th>
							  <th>
								<h6 class="fw-bolder" style="text-align: center;">진행부서</h6>
							  </th>
							  <th>
								<h6 class="fw-bolder" style="text-align: center;">진행자</h6>
							  </th>
							  <th>
								<h6 class="fw-bolder">결재상태</h6>
							  </th>
							</tr>
							</thead>
							<c:forEach var="atrzVO" items="${atrzMinSubmitList}">
							  <tbody>
							  <!-- <p>${atrzMinSubmitList}</p> -->
							  <tr>
								<td>
								  <p class="fw-bolder" style="text-align: center;">
									<fmt:formatDate value="${atrzVO.atrzDrftDt}" pattern="yyyy-MM-dd" var="onlyDate" />
									<fmt:formatDate value="${atrzVO.atrzDrftDt}" pattern="HH:mm:ss" var="onlyTime" />
									  ${onlyDate} ${onlyTime}</p>
								</td>
								<td>
								  <p>
									<c:choose>
									  <c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'H')}">연차신청서</c:when>
									  <c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'S')}">지출결의서</c:when>
									  <c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'B')}">급여계좌변경신청서</c:when>
									  <c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'A')}">급여명세서</c:when>
									  <c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'D')}">기안서</c:when>
									  <c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'C')}">재직증명서</c:when>
									  <c:otherwise>퇴사신청서</c:otherwise>
									</c:choose>
								  </p>
								</td>
								<td style="text-align: right;">
								  <c:choose>
									<c:when test="${not empty atrzVO.atchFileNo and atrzVO.atchFileNo != 0}">
																				<span class="material-symbols-outlined"
																					  style="font-size: 14px;">
																					attach_file
																				</span>
									</c:when>
									<c:otherwise>
																				<span class="material-symbols-outlined"
																					  style="font-size: 14px; visibility: hidden;">
																					attach_file
																				</span>
									</c:otherwise>
								  </c:choose>
								</td>
								<td>
								  <a href="/atrz/selectForm/atrzDetail?atrzDocNo=${atrzVO.atrzDocNo}"
									 class="text-sm fw-bolder listCont" style="display: flex; align-items: center;">
									  ${atrzVO.atrzSj}
								  </a>
								</td>
								<td>
								  <p style="text-align: center;">${atrzVO.deptCodeNm}</p>
								</td>
								<td>
								  <p style="text-align: center;">${atrzVO.drafterEmpnm}</p>
								</td>
								
								<td>
								  <h6 class="text-sm">
									<p>
									  <c:choose>
										<c:when test="${atrzVO.atrzSttusCode == '00' }">
										  <span class="status-btn close-btn actBtn col-sm-6 col-md-4"
												style="background-color: #fbf5b1; color: #d68c41;">진행중</span>
										</c:when>
										<c:when test="${atrzVO.atrzSttusCode == '10' }">
										  <span class="status-btn active-btn actBtn col-sm-6 col-md-4">완료</span>
										</c:when>
										<c:when test="${atrzVO.atrzSttusCode == '20' }">
										  <span class="status-btn close-btn actBtn col-sm-6 col-md-4">반려</span>
										</c:when>
										<c:when test="${atrzVO.atrzSttusCode == '30' }">
										  <span class="status-btn success-btn actBtn col-sm-6 col-md-4">회수</span>
										</c:when>
										<c:when test="${atrzVO.atrzSttusCode == '40' }">
										  <span class="status-btn info-btn actBtn actBtn col-sm-6 col-md-4"
												style="background-color: pink; color: #ed268a;">취소</span>
										</c:when>
										<c:otherwise>
										  <span class="status-btn info-btn actBtn actBtn col-sm-6 col-md-4"
												style="color: #20b2aa  ;">임시저장</span>
										</c:otherwise>
									  </c:choose>
									</p>
								  </h6>
								</td>
							  </tr>
							  </tbody>
							</c:forEach>
						  </table>
						</div>
					  </c:otherwise>
					</c:choose>
				  </div>
				</div>
			  </div>
			  
			  
			  <div class="d-flex justify-content-between ms-2 me-2">
				<h4 class="mb-10">결재완료문서</h4>
				<a href="/atrz/complete" class="text-sm fw-bolder" style="color: #4a6cf7;">
				  더보기 <span class="material-symbols-outlined" style="vertical-align: middle;">chevron_right</span>
				</a>
			  </div>
			  <div class="atrzTabCont">
				<div class="col-lg-12">
				  <div class="card-style mb-30 docList">
					<c:choose>
					  <c:when test="${empty atrzMinCompltedList}">
						<div class="text-center emptyList">
						  완료된 문서가 없습니다.
						</div>
					  </c:when>
					  <c:otherwise>
						<div class="table-wrapper table-responsive">
						  <table class="table striped-table">
							<thead>
							<tr>
							  <th>
								<h6 class="fw-bolder" style="text-align: center;">완료일시</h6>
							  </th>
							  <th>
								<h6 class="fw-bolder">양식유형</h6>
							  </th>
							  <th></th>
							  <th>
								<h6 class="fw-bolder">제목</h6>
							  </th>
							  <th>
								<h6 class="fw-bolder" style="text-align: center;">기안부서</h6>
							  </th>
							  <th>
								<h6 class="fw-bolder" style="text-align: center;">기안자</h6>
							  </th>
							  <th>
								<h6 class="fw-bolder">결재상태</h6>
							  </th>
							</tr>
							</thead>
							<c:forEach var="atrzVO" items="${atrzMinCompltedList}">
							  <tbody>
							  <tr>
								<td>
								  <p class="fw-bolder" style="text-align: center;">
									<fmt:formatDate value="${atrzVO.atrzComptDt}" pattern="yyyy-MM-dd" var="onlyDate" />
									<fmt:formatDate value="${atrzVO.atrzComptDt}" pattern="HH:mm:ss" var="onlyTime" />
									  ${onlyDate} ${onlyTime}
								  </p>
								</td>
								<td>
								  <p>
									<c:choose>
									  <c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'H')}">연차신청서</c:when>
									  <c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'S')}">지출결의서</c:when>
									  <c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'B')}">급여계좌변경신청서</c:when>
									  <c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'A')}">급여명세서</c:when>
									  <c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'D')}">기안서</c:when>
									  <c:when test="${fn:startsWith(atrzVO.atrzDocNo, 'C')}">재직증명서</c:when>
									  <c:otherwise>퇴사신청서</c:otherwise>
									</c:choose>
								  </p>
								</td>
								<td style="text-align: right;">
								  <c:choose>
									<c:when test="${not empty atrzVO.atchFileNo and atrzVO.atchFileNo != 0}">
																				<span class="material-symbols-outlined"
																					  style="font-size: 14px;">
																					attach_file
																				</span>
									</c:when>
									<c:otherwise>
																				<span class="material-symbols-outlined"
																					  style="font-size: 14px; visibility: hidden;">
																					attach_file
																				</span>
									</c:otherwise>
								  </c:choose>
								</td>
								<td style="text-align:left;">
								  <a href="/atrz/selectForm/atrzDetail?atrzDocNo=${atrzVO.atrzDocNo}"
									 class="text-sm fw-bolder listCont" style="display: flex; align-items: center;">
									  ${atrzVO.atrzSj}
								  </a>
								</td>
								<td>
								  <p style="text-align: center;">${atrzVO.deptCodeNm}</p>
								</td>
								<td>
								  <p style="text-align: center;">${atrzVO.drafterEmpnm}</p>
								</td>
								<td>
								  <h6 class="text-sm">
									<p>
									  <c:choose>
										<c:when test="${atrzVO.atrzSttusCode == '00' }">
										  <span class="status-btn close-btn actBtn col-sm-6 col-md-4"
												style="background-color: #fbf5b1; color: #d68c41;">진행중</span>
										</c:when>
										<c:when test="${atrzVO.atrzSttusCode == '10' }">
										  <span class="status-btn active-btn actBtn col-sm-6 col-md-4">완료</span>
										</c:when>
										<c:when test="${atrzVO.atrzSttusCode == '20' }">
										  <span class="status-btn close-btn actBtn col-sm-6 col-md-4">반려</span>
										</c:when>
										<c:when test="${atrzVO.atrzSttusCode == '30' }">
										  <span class="status-btn success-btn actBtn col-sm-6 col-md-4">회수</span>
										</c:when>
										<c:when test="${atrzVO.atrzSttusCode == '40' }">
										  <span class="status-btn info-btn actBtn actBtn col-sm-6 col-md-4"
												style="background-color: pink; color: #ed268a;">취소</span>
										</c:when>
										<c:otherwise>
										  <span class="status-btn info-btn actBtn actBtn col-sm-6 col-md-4">임시저장</span>
										</c:otherwise>
									  </c:choose>
									</p>
								  </h6>
								</td>
							  </tr>
							  </tbody>
							</c:forEach>
						  </table>
						</div>
					  </c:otherwise>
					</c:choose>
				  </div>
				</div>
			  </div>
			</div>
			<!-- 컨텐츠1 끝 -->
		  </div>
		</div>
	  </div>
	  <!-- 여기서 작업 끝 -->
	
	</div>
  </section>
  <%@ include file="../layout/footer.jsp" %>
</main>
<%@ include file="../layout/prescript.jsp" %>
<!-- j쿼리 사용시 여기 이후에 작성하기 -->
<c:import url="./newAtrzDocModal.jsp" />
<!--기간입력 선택시 활성화 시키는 스크립트-->
<script>
//   document.getElementById("duration").addEventListener("change", function() {
//     var durationPeriod = document.getElementById("durationPeriod");
//     if(this.value == "period") {
//       durationPeriod.classList.remove("d-none");
//       durationPeriod.classList.add("d-flex");
//     } else {
//       durationPeriod.classList.remove("d-flex");
//       durationPeriod.classList.add("d-none");
//     }
//   })
</script>
</body>
</html>
