<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="title" />

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
 	<meta name="viewport"
		  content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"/>
	<meta http-equiv="X-UA-Compatible" content="ie=edge" />
	<title>${title}</title>
  <%@ include file="../layout/prestyle.jsp" %>
</head>
<style>
.homeContainer{
	margin-left: 0px;
	margin-right: 0px;
	margin-bottom: 8px;
							
}
.wdBtn {
	--bs-btn-padding-y: .40rem;
	--bs-btn-padding-x: 4rem;
	--bs-btn-font-size: 1rem;
	background-color: #00bfff ;
	color: white;
	border-radius: 0 0 5px 5px;
	width: 100%;
}

.actBtn {
	width: 50px;
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
	margin-bottom: 10px;
	
}

.docList {
	margin-bottom: 0px;
}
.homeFr{
	width: 180px;
	padding-left: 10px;
	display: block;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	
}
.listCont{
    width: 450px;
    display: block;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	
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
										<button class="nav-link active" id="contact1-tab"
											data-bs-toggle="tab" data-bs-target="#contact1-tab-pane"
											type="button" role="tab" aria-controls="contact1-tab-pane"
											aria-selected="true">전자결재</button>
									</li>
								</ul>
							</div>

							<!-- 오른쪽: 검색창 -->
							<div class="table_search d-flex align-items-center gap-2">
								<button id="s_eap_btn" class="btn btn-primary"
									data-bs-toggle="modal" data-bs-target="#newAtrzDocModal">
									새 결재 진행</button>
								<select id="duration" class="form-select w-auto">
									<option value="all">전체기간</option>
									<option value="1">1개월</option>
									<option value="6">6개월</option>
									<option value="12">1년</option>
									<option value="period">기간입력</option>
								</select>
								<div id="durationPeriod"
									class="search_option d-none align-items-center">
									<input id="fromDate" class="form-control" type="text"
										style="width: 150px;"> ~ <input id="toDate"
										class="form-control" type="text" style="width: 150px;">
								</div>
								<!--기간입력 선택시 활성화 시키는 스크립트-->
								<script>
									document
											.getElementById("duration")
											.addEventListener(
													"change",
													function() {
														var durationPeriod = document
																.getElementById("durationPeriod");
														if (this.value == "period") {
															durationPeriod.classList
																	.remove("d-none");
															durationPeriod.classList
																	.add("d-flex");
														} else {
															durationPeriod.classList
																	.remove("d-flex");
															durationPeriod.classList
																	.add("d-none");
														}
													})
								</script>
								<!-- 검색 유형 선택 -->
								<select id="searchtype" class="form-select w-auto">
									<option value="title">제목</option>
									<option value="drafterName">기안자</option>
									<option value="drafterDeptName">기안부서</option>
									<option value="formName">결재양식</option>
									<option value="activityUserName">결재선</option>
								</select>
								<section class="search2">
									<div
										class="search_wrap d-flex align-items-center border rounded px-2">
										<!--focus되면 "search_focus" multi class로 추가해주세요.-->
										<input id="keyword" class="form-control border-0"
											type="text" placeholder="검색"> <span
											class="material-symbols-outlined">search</span>
									</div>
								</section>
							</div>

						</div>
					</div>



					<!-- 메뉴바 끝 -->
					<!-- 컨텐츠1 시작 -->
					<div class="tab-content" id="myTabContent">
						<div class="tab-pane fade show active" id="contact1-tab-pane"
							role="tabpanel" aria-labelledby="contact1-tab" tabindex="0">
										<!-- <p>${myEmpInfo}</p> -->
							<div class="atrzTabCont" style="margin-top: 0px; overflow-x: auto;">
								<div class="container mt-2 homeContainer">
									<div class="row flex-nowrap">
										<!-- <p>atrzLineVOList</p> -->
										<!-- <p>atrzVOList : ${atrzVOList}</p> -->
										<!-- <p>atrzApprovalList : ${atrzApprovalList}</p> -->
										<!-- <p>atrzApprovalList[0] : ${atrzApprovalList[0]}</p> -->
										<!-- <p>atrzSubmitList : ${atrzSubmitList}</p> -->
										<!-- <p>atrzCompletedList : ${atrzCompletedList}</p> -->
										
										<input type="hidden" name="emplNo" value="${myEmpInfo.emplNo}">
										<c:forEach var="atrzVO" items="${atrzApprovalList}" begin="0" end="9">
											<div class="col-sm-3">
												<div class="card" >
													<div class="card-header" style="height: 36px;">
														<div class="row g-0 text-center">
															<!-- 진행 반려 완료 회수 취소 -->
															<!--결재상태코드에 따른 조건 시작-->
															<c:choose>
																<c:when test="${atrzVO.atrzSttusCode == '00' }">
																	<span
																		class="status-btn close-btn actBtn col-sm-6 col-md-4"
																		style="background-color: #fbf5b1; color: #d68c41;">진행중</span>
																</c:when>
																<c:when test="${atrzVO.atrzSttusCode == '10' }">
																	<span
																		class="status-btn close-btn actBtn col-sm-6 col-md-4">반려</span>
																</c:when>
																<c:when test="${atrzVO.atrzSttusCode == '20' }">
																	<span
																		class="status-btn active-btn actBtn col-sm-6 col-md-4">완료</span>
																</c:when>
																<c:when test="${atrzVO.atrzSttusCode == '30' }">
																	<span
																		class="status-btn success-btn actBtn col-sm-6 col-md-4">회수</span>
																</c:when>
																<c:otherwise>
																	<span
																		class="status-btn info-btn actBtn actBtn col-sm-6 col-md-4"
																		style="background-color: pink; color: #ed268a;">취소</span>
																</c:otherwise>
															</c:choose>
															<!--결재상태코드에 따른 조건 끝-->
															<!-- <p>${documHolidayVO}</p> -->
															<a href="/atrz/selectForm/holidayDetail?atrzDocNo=${atrzVO.atrzDocNo}" class="col-6 col-md-8">
																<h5 class="homeFr">${atrzVO.atrzSj}</h5>
															</a>
														</div>
													</div>
													<div class="card-body">
														<!-- <p>${atrzVO}</p> -->
														<p class="card-text">기안자&nbsp;&nbsp; :&nbsp;&nbsp;  ${atrzVO.drafterEmpnm}
																					&nbsp;&nbsp;[${atrzVO.deptCodeNm}]</p>
														<p class="card-text">기안일시&nbsp;&nbsp; :&nbsp;&nbsp; 
															<fmt:formatDate value="${atrzVO.atrzDrftDt}" pattern="yyyy-MM-dd" var="onlyDate" />
															<fmt:formatDate value="${atrzVO.atrzDrftDt}" pattern="HH:mm:ss" var="onlyTime" />
															<b>${onlyDate}</b>&nbsp;&nbsp;&nbsp;&nbsp; ${onlyTime}</p>
														</div>
														<div class="col text-center">
															<a href="/atrz/selectForm/holidayDetail?atrzDocNo=${atrzVO.atrzDocNo}" class="btn btn-default wdBtn">결재하기</a>
														</div>
												</div>
											</div>
										</c:forEach>
									</div>
								</div>
								<!--추가-->
								<!-- </div> -->
								<!--완료문서 문서 끝-->
							</div>
							<div class="atrzTabCont">
								<div class="col-lg-12">
									<div class="card-style mb-30 docList">
										<div style="display: flex; justify-content: space-between; align-items: center;" class="mb-10">
											<h6 class="mb-10">기안진행문서</h6>
											<a href="/atrz/approval" class="text-sm fw-bolder" style="color: #4a6cf7;">
												더보기 <span class="material-symbols-outlined" style="vertical-align: middle;">chevron_right</span>
											</a>
										</div>
										<!-- <p>atrzSubmitList[0] : ${atrzSubmitList[0]}</p> -->
										<div class="table-wrapper table-responsive">
											<table class="table striped-table">
												<thead>
													<!-- <p>${atrzSubmitList}</p> -->
													<tr>
														<th>
															<h6 class="fw-bolder" style="text-align: center;">기안일시</h6>
														</th>
														<th>
															<h6 class="fw-bolder" style="text-align: center;">양식유형</h6>
														</th>
														<th>
															<h6 class="fw-bolder" style="padding-left: 120px;">제목</h6>
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
												<!-- <p>${atrzVOList}</p> -->
												<c:forEach var="atrzVO" items="${atrzSubmitList}">
													<tbody>
														<tr>
															<td style="padding-top: 10px; padding-bottom: 10px;" >
																<p class="text-sm" style="text-align: center;">
																	<fmt:formatDate value="${atrzVO.atrzDrftDt}" pattern="yyyy-MM-dd" var="onlyDate" />
																	<fmt:formatDate value="${atrzVO.atrzDrftDt}" pattern="HH:mm:ss" var="onlyTime" />
																	<b>${onlyDate}</b>&nbsp;&nbsp;&nbsp;&nbsp; ${onlyTime}</p>
															</td>
															<td style="padding-top: 0px;">
																<p class="fw-bolder" style="text-align: center;">
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
															<td style="text-align: left; padding-top: 0px;">
																<a href="#" class="text-sm fw-bolder listCont" style="display: flex; align-items: center;">
																<c:choose>
																	<c:when test="${not empty atrzVO.atchFileNo and atrzVO.atchFileNo != 0}">
																		<span class="material-symbols-outlined" style="margin-right: 5px;">
																		attach_file
																		</span>
																	</c:when>
																	<c:otherwise>
																		<!-- 빈 span으로 공간 확보 -->
																		<span class="material-symbols-outlined" style="margin-right: 5px; visibility: hidden;">
																		attach_file
																		</span>
																	</c:otherwise>
																</c:choose>
																${atrzVO.atrzSj}
																</a>
															</td>
															<td style="padding-top: 0px;">
																<p class="fw-bolder" style="text-align: center;">${atrzVO.deptCodeNm}</p>
															</td>
															<td style="padding-top: 0px;" >
																<p class="fw-bolder" style="text-align: center;">${atrzVO.drafterEmpnm}</p>
															</td>
															
															<td  style="padding-top: 0px;">
																<h6 class="text-sm">
																	<p>
																		<c:choose>
																			<c:when test="${atrzVO.atrzSttusCode == '00' }">
																				<span
																					class="status-btn close-btn actBtn col-sm-6 col-md-4"
																					style="background-color: #fbf5b1; color: #d68c41;">진행중</span>
																			</c:when>
																			<c:when test="${atrzVO.atrzSttusCode == '10' }">
																				<span
																					class="status-btn close-btn actBtn col-sm-6 col-md-4">반려</span>
																			</c:when>
																			<c:when test="${atrzVO.atrzSttusCode == '20' }">
																				<span
																					class="status-btn active-btn actBtn col-sm-6 col-md-4">완료</span>
																			</c:when>
																			<c:when test="${atrzVO.atrzSttusCode == '30' }">
																				<span
																					class="status-btn success-btn actBtn col-sm-6 col-md-4">회수</span>
																			</c:when>
																			<c:otherwise>
																				<span
																					class="status-btn info-btn actBtn actBtn col-sm-6 col-md-4"
																					style="background-color: pink; color: #ed268a;">취소</span>
																			</c:otherwise>
																		</c:choose>
																	</p>
																</h6>
															</td>
														</tr>
													</tbody>
												</c:forEach>
											</table>
											<!-- end table -->
										</div>
									</div>
									<!-- end card -->
								</div>


							</div>
							<div class="atrzTabCont">
								<div class="col-lg-12">
									<div class="card-style mb-30 docList">
										<div style="display: flex; justify-content: space-between; align-items: center;" class="mb-10">
										<h6 class="mb-10">완료문서</h6>
										<a href="/atrz/document" class="text-sm fw-bolder" style="color: #4a6cf7;">
											더보기 <span class="material-symbols-outlined" style="vertical-align: middle;">chevron_right</span>
										</a>
										</div>
											<div class="table-wrapper table-responsive">
												<table class="table striped-table">
													<thead>
														<!-- <p>${atrzVO}</p> -->
														<!-- <p>${atrzVOList}</p> -->
														<tr>
															<th >
																<h6 class="fw-bolder" style="text-align: center;">기안일시</h6>
															</th>
															<th>
																<h6 class="fw-bolder" style="text-align: center;">완료일시</h6>
															</th>
															<th>
																<h6 class="fw-bolder" style="padding-left: 120px;">제목</h6>
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
													<c:forEach var="atrzVO" items="${atrzCompletedList}">
														<tbody>
															<tr>
																<td style="padding-top: 10px; padding-bottom: 10px;" >
																	<p class="text-sm" style="text-align: center;">
																		<fmt:formatDate value="${atrzVO.atrzDrftDt}" pattern="yyyy-MM-dd" var="onlyDate" />
																		<fmt:formatDate value="${atrzVO.atrzDrftDt}" pattern="HH:mm:ss" var="onlyTime" />
																		<b>${onlyDate}</b>&nbsp;&nbsp;&nbsp;&nbsp; ${onlyTime}</p>
																</td>
																<td style="padding-top: 10px; padding-bottom: 10px;" >
																	<p class="text-sm" style="text-align: center;">
																		<fmt:formatDate value="${atrzVO.atrzComptDt}" pattern="yyyy-MM-dd" var="onlyDate" />
																		<fmt:formatDate value="${atrzVO.atrzComptDt}" pattern="HH:mm:ss" var="onlyTime" />
																		<b>${onlyDate}</b>&nbsp;&nbsp;&nbsp;&nbsp; ${onlyTime}</p>
																</td>
																<td style="text-align: left; padding-top: 0px;">
																	<a href="#" class="text-sm fw-bolder listCont" style="display: flex; align-items: center;">
																	<c:choose>
																		<c:when test="${not empty atrzVO.atchFileNo and atrzVO.atchFileNo != 0}">
																			<span class="material-symbols-outlined" style="margin-right: 5px;">
																			attach_file
																			</span>
																		</c:when>
																		<c:otherwise>
																			<!-- 빈 span으로 공간 확보 -->
																			<span class="material-symbols-outlined" style="margin-right: 5px; visibility: hidden;">
																			attach_file
																			</span>
																		</c:otherwise>
																	</c:choose>
																	${atrzVO.atrzSj}
																	</a>
																</td>
																<td style="padding-top: 0px;">
																	<p class="fw-bolder" style="text-align: center;">${atrzVO.deptCodeNm}</p>
																</td>
																<td style="padding-top: 0px;" >
																	<p class="fw-bolder" style="text-align: center;">${atrzVO.drafterEmpnm}</p>
																</td>
																
																<td  style="padding-top: 0px;">
																	<h6 class="text-sm">
																		<p>
																			<c:choose>
																				<c:when test="${atrzVO.atrzSttusCode == '00' }">
																					<span
																						class="status-btn close-btn actBtn col-sm-6 col-md-4"
																						style="background-color: #fbf5b1; color: #d68c41;">진행중</span>
																				</c:when>
																				<c:when test="${atrzVO.atrzSttusCode == '10' }">
																					<span
																						class="status-btn close-btn actBtn col-sm-6 col-md-4">반려</span>
																				</c:when>
																				<c:when test="${atrzVO.atrzSttusCode == '20' }">
																					<span
																						class="status-btn active-btn actBtn col-sm-6 col-md-4">완료</span>
																				</c:when>
																				<c:when test="${atrzVO.atrzSttusCode == '30' }">
																					<span
																						class="status-btn success-btn actBtn col-sm-6 col-md-4">회수</span>
																				</c:when>
																				<c:otherwise>
																					<span
																						class="status-btn info-btn actBtn actBtn col-sm-6 col-md-4"
																						style="background-color: pink; color: #ed268a;">취소</span>
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
</body>
</html>
