<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="메인" />
<c:set var="copyLight" scope="application" value="7FS" />

<!-- 디지털 시계 -->
<%
java.util.Date now = new java.util.Date();
java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("HH:mm:ss");
java.text.SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
dateFormat.applyPattern("yyyy년 MM월 dd일");
String serverTime = sdf.format(now);
String serverDate = dateFormat.format(now);
%>
<!DOCTYPE html>
<html lang="en">
<head>

<style>
.badge {
	display: inline-block;
	padding: 0.35em 0.65em;
	font-size: 0.85em;
	font-weight: 600;
	line-height: 1;
	color: black;
	text-align: center;
	white-space: nowrap;
	vertical-align: baseline;
	border-radius: 0.375rem;
}

.grade-A {
	background-color: #99ccff;
	color: #004085;
} /* 더 진한 하늘색 */
.grade-B {
	background-color: #a3d9a5;
	color: #155724;
} /* 더 진한 연두색 */
.grade-C {
	background-color: #ffe08a;
	color: #856404;
} /* 더 진한 노란색 */
.grade-D {
	background-color: #ffcc80;
	color: #8a6d3b;
} /* 더 진한 오렌지 */
.grade-E {
	background-color: #d6d6d6;
	color: #333;
} /* 더 진한 회색 */
.priort-00 {
	background-color: #c8cbcf;
	color: #0c5460;
} /* 진한 회색 텍스트 */
.priort-01 {
	background-color: #9fd4db;
	color: #0c5460;
} /* 진한 청록 텍스트 */
.priort-02 {
	background-color: #ffdf7e;
	color: #0c5460;
} /* 더 어두운 갈색 텍스트 */
.priort-03 {
	background-color: #f1aeb5;
	color: #0c5460;
} /* 더 짙은 빨강 계열 텍스트 */
.nav-link.active {
	background-color: #d8bfd8;
	font-weight: bold;
	color: #d8bfd8; /* 부트스트랩 기본 primary 색 */
	box-shadow: inset 0 -3px 0 #ffc0cb;
	transition: all 0.3s ease;
}

.nav-link {
	color: #ffb6c1;
}

.nav-link:hover {
	background-color: #ffb6c1;
	color: #ffb6c1;
}

#notice-tab {
	color: #696969;
}

#cummunity-tab {
	color: #696969;
}

#menu-tab {
	color: #696969;
}
</style>
<meta charset="UTF-8" />
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="ie=edge" />
<title>${title}</title>
<%@ include file="./layout/prestyle.jsp"%>
</head>
<body>
	<%@ include file="./layout/sidebar.jsp"%>
	<main class="main-wrapper">
		<%@ include file="./layout/header.jsp"%>
		<section class="section">
			<div class="container-fluid">
				<div class="row">
					<div class="col-md-3"
						style="position: sticky; top: 100px; z-index: 1; max-height: 80vh;">
						<!-- 출퇴근-->
						<div class="card-style mb-3"
							style="box-shadow: 1px 1px 20px 1px rgba(0, 0, 2, 0.1);">
							<c:import url="./organization/dclz/workButton.jsp" />
							<!-- 출퇴근 버튼 -->
							<div class="">
								<div class=" text-center">
									<span class="status-btn dark-btn text-center mt-30"><%=serverDate%></span>
									<div id="clock" style="font-size: 24px; font-weight: bold;"></div>
									<div class="d-flex mb-30 mt-3 justify-content-center">
										<div class="content mr-30">
											<input type="hidden" id="inputTodWorkTime" value="${todayWorkTime}"
												id="todayWorkTime">
											<button type="button"
												id="${todayWorkTime != null ? '' : 'workStartButton'}"
												class="btn-sm main-btn primary-btn-light rounded-full btn-hover">출근</button>
											<p id="startTime">${todayWorkTime != null ? todayWorkTime : '출근 전'}</p>
										</div>
										<div class="content">
											<input type="hidden" value="${todayWorkEndTime}"
												id="workEndTime">
											<button type="button"
												id="${workEndButton != null ? '' : 'workEndButton'}"
												class="btn-sm main-btn danger-btn-light rounded-full btn-hover">퇴근</button>
											<p id="endTime">${todayWorkEndTime != null ? todayWorkEndTime : '퇴근 전'}</p>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- 출퇴근 -->

						<!-- 메일 + 일정 -->
						<div class="card-style mb-3 d-flex flex justify-content-center"
							style="box-shadow: 1px 1px 20px 1px rgba(0, 0, 2, 0.1); backdrop-filter: blur(15px);">
							<div class="d-flex justify-content-center">
								<!-- 메일 위젯 -->
								<div class="text-center mr-15">
									<p class="text-sm">
										미확인 <span class="text-xl text-bold text-dark ml-2">0</span>건
									</p>
									<div class="rounded-4"
										style="background-color: rgb(230, 230, 250, 0.5); display: inline-block;">
										<a href="/mail/mailSend"
											class="btn-sm main-btn square-btn btn-hover text-dark"
											style="padding: 8px;"> <i class="lni lni-envelope"></i>
											메일쓰기
										</a>
									</div>
									<!-- <div class="d-flex flex-column text-center"> -->
									<!-- </div> -->
								</div>
								<!-- 메일 위젯 -->
								<!-- 일정 위젯 -->
								<div class="text-center">
									<a href="/myCalendar" class="text-sm text-dark">오늘 일정 <span
										class="text-xl text-bold text-dark ml-2">${todayCalendarCnt}</span>건
									</a>
									<div class="rounded-4"
										style="background-color: rgb(230, 230, 250, 0.5); display: inline-block;">
										<a href="/myCalendar?openModal=true"
											class="btn-sm main-btn square-btn btn-hover mr-10 text-dark"
											style="padding: 8px;"> <i class="lni lni-calendar"></i>
											일정등록
										</a>
									</div>
									<!-- <div class="d-flex flex-column text-center"> -->
									<!-- </div> -->
								</div>
								<!-- 일정 위젯 -->
							</div>
							<!-- 메일 + 일정 -->
						</div>

						<!-- 알림 -->
						<div
							style="box-shadow: 1px 1px 20px 1px rgba(0, 0, 2, 0.1); backdrop-filter: blur(15px);">
							<div class="card-style mb-3	">
								<div class="row mb-4">
									<div class="text-bold">
										💌 <span class="text-dark text-bold ml-3">최근 알림</span>
									</div>
								</div>
								<div class=" ">
									<div class="mb-4">
										<a href="#0" class="d-flex flex-column"> <span
											class="text-black text-sm"> 게시판 알림 </span> <span
											class="text-sm text-gray"> 2025.04.15. 01:33 </span>
										</a>
									</div>
									<hr />
									<div class="mb-4">
										<a href="#0" class="d-flex flex-column"> <span
											class="text-black text-sm"> 공지 알림 </span> <span
											class="text-sm text-gray"> 2025.04.15. 01:33 </span>
										</a>
									</div>
									<hr />
									<div class="mb-4">
										<a href="#0" class="d-flex flex-column"> <span
											class="text-black text-sm"> '모바일 쿠폰 서비스 임직원을 위한 맞춤형 쿠폰
												발송, ONE-STOP으로 해결! </span> <span class="text-sm text-gray">2025.04.15.
												01:33</span>
										</a>
									</div>
								</div>
							</div>
						</div>
						<!-- 알림 -->
						<!-- todo list -->
						<!--  <div class="card-style mb-3" style="box-shadow: 1px 1px 20px 1px rgba(0,0,2,0.1);">
	  	  	일정 목록
	  	  </div> -->
						<!-- todo list-->
					</div>

					<div class="col-md-9">
						<!-- 전자결재 -->
						<div class="row">
							<div class="col-3">
								<div class="icon-card mb-30">
									<div class="icon orange">
										<i class="lni lni-more"></i>
									</div>
									<div class="content">
										<h6>결재 대기중</h6>
										<h4>
											<a href="/atrz/home" style="margin-top: 20px;"
												class="text-bold mb-10"> ${atrzApprovalCnt != null ? atrzApprovalCnt : '0'}<span
												class="text-sm">건</span></a>
										</h4>
										<p class="text-sm text-success"></p>
									</div>
								</div>
								<!-- End Icon Cart -->
							</div>
							<!-- End Col -->
							<div class="col-3">
								<div class="icon-card mb-30">
									<div class="icon purple">
										<i class="lni lni-spinner"></i>
									</div>
									<div class="content">
										<h6>결재 진행중</h6>
										<h4>
											<a href="/atrz/home" style="margin-top: 20px;"
												class="text-bold mb-10"> ${atrzSubmitCnt != null ? atrzSubmitCnt : '0'}<span
												class="text-sm">건</span></a>
										</h4>
										<p class="text-sm text-success"></p>
									</div>
								</div>
								<!-- End Icon Cart -->
							</div>
							<!-- End Col -->
							<!--  </div> -->
							<!-- End Col -->
							<!--  <div class="row"> -->
							<div class="col-3">
								<div class="icon-card mb-30">

									<div class="icon success">
										<i class="lni lni-checkmark-circle"></i>
									</div>
									<div class="content">
										<h6>결재 완료</h6>
										<h4>
											<a href="/atrz/home" style="margin-top: 20px;"
												class="text-bold mb-10"> ${atrzCompletedCnt != null ? atrzCompletedCnt : '0'}<span
												class="text-sm">건</span></a>
										</h4>
										<p class="text-sm text-success"></p>
									</div>
								</div>
								<!-- End Icon Cart -->
							</div>
							<div class="col-3">
								<div class="icon-card">
									<div class="icon orange"
										style="background-color: #ffe4e1; color: red;">
										<i class="lni lni-cross-circle"></i>
									</div>
									<div class="content">
										<h6>결재 반려</h6>
										<h4>
											<!-- 반려 목록 페이지로 이동시키기 -->
											<a href="/atrz/companion" style="margin-top: 20px;"
												class="text-bold mb-10"> ${atrzRejectedCnt != null ? atrzRejectedCnt : '0'}<span
												class="text-sm">건</span></a>
										</h4>
										<p class="text-sm text-danger"></p>
									</div>
								</div>
								<!-- End Icon Cart -->
							</div>
							<!-- End Col -->
							<!--    </div> -->
							<!-- 전자결재 -->

							<!-- 프로젝트 -->
							<div class="col-lg-12">
								<div class="card-style mb-30">
									<h6 class="mb-10">진행중인 프로젝트 업무</h6>
									<div class="card-body scroll-table"
										style="max-height: 350px; overflow-y: auto;">
										<table
											class="table table-bordered text-center hover-highlight"
											id="urgentTaskTable">
											<thead class="table-light">
												<tr>
													<th>업무명</th>
													<th>등급</th>
													<th>중요도</th>
													<th>종료일</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="t" items="${urgentTasks}">
													<tr>
														<td class="text-start ps-2">${t.taskNm}</td>
														<td><span class="badge grade-${t.taskGrad}">${t.taskGrad}</span></td>
														<td><span class="badge priort-${t.priort}">${commonCodes['PRIORT'][t.priort]}</span></td>
														<td><fmt:formatDate value="${t.taskEndDt}"
																pattern="yyyy-MM-dd" /></td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
								</div>
							</div>
							<!-- 프로젝트 -->

							<input type="hidden" class="currentPage"
								value="${articlePage.currentPage}">
							<div class="row" style="max-height: 100%;">
								<!-- 게시판 시작 -->
								<div id="mainBbs" class="col-lg-6">
									<div class="card-style mb-30">
										<h6 class="mb-30">전사게시판 최근글</h6>
										<ul class="nav nav-tabs" id="myTab" role="tablist">
											<!-- 공지사항 -->
											<%--bbsCtgryNo --%>
											<li class="nav-item" role="presentation"
												data-bbs-ctgry-no="1">
												<button type="submit" class="nav-link active"
													id="notice-tab" data-bs-toggle="tab"
													data-bs-target="#notice" type="button" role="tab"
													aria-controls="notice" aria-selected="true">공지사항</button>
											</li>

											<!-- 커뮤니티 -->
											<li class="nav-item" role="presentation"
												data-bbs-ctgry-no="2">
												<button class="nav-link" id="cummunity-tab"
													data-bs-toggle="tab" data-bs-target="#cummunity"
													type="button" role="tab" aria-controls="cummunity"
													aria-selected="false">커뮤니티</button>
											</li>
											<!-- 식단표 -->
											<li class="nav-item" role="presentation"
												data-bbs-ctgry-no="3">
												<button class="nav-link" id="menu-tab" data-bs-toggle="tab"
													data-bs-target="#menu" type="button" role="tab"
													aria-controls="menu" aria-selected="false">오늘의 식단표</button>
											</li>
										</ul>
										<div class="tab-content" id="myTabContent">
											<div class="tab-pane fade show active mt-20" id="notice"
												role="tabpanel" aria-labelledby="notice-tab">
												<div class="bbsDiv">
													<c:forEach var="bbsNoticeList" items="${noticeList}">
														<div class="mb-4">
															<div>
																<c:if test="${bbsNoticeList.upendFixingYn == 'Y'}">
																	<span class="" style="color: red;"> <svg
																			xmlns="http://www.w3.org/2000/svg" width="16"
																			height="16" fill="currentColor"
																			class="bi bi-pin-angle-fill" viewBox="0 0 16 16">
											  <path
																				d="M9.828.722a.5.5 0 0 1 .354.146l4.95 4.95a.5.5 0 0 1 0 .707c-.48.48-1.072.588-1.503.588-.177 0-.335-.018-.46-.039l-3.134 3.134a6 6 0 0 1 .16 1.013c.046.702-.032 1.687-.72 2.375a.5.5 0 0 1-.707 0l-2.829-2.828-3.182 3.182c-.195.195-1.219.902-1.414.707s.512-1.22.707-1.414l3.182-3.182-2.828-2.829a.5.5 0 0 1 0-.707c.688-.688 1.673-.767 2.375-.72a6 6 0 0 1 1.013.16l3.134-3.133a3 3 0 0 1-.04-.461c0-.43.108-1.022.589-1.503a.5.5 0 0 1 .353-.146" />
											</svg>
																	</span>
																</c:if>
																<a href="/bbs/bbsDetail?bbsSn=${bbsNoticeList.bbsSn}"
																	class="text-black text-bold text-sm">
																	${bbsNoticeList.bbscttSj} </a>
															</div>
															<span class="text-sm text-gray">
																${bbsNoticeList.emplNm} ${bbsNoticeList.bbscttCreatDt} </span>
														</div>
														<hr />

														<%-- <div class="text-dark text-bold mb-3">
								  <c:if test="${bbsNoticeList.upendFixingYn == 'Y'}">
									  <span style="color: red; font-weight: bold;">[고정]</span>
								  </c:if>
								   <a href="/bbs/bbsDetail?bbsSn=${bbsNoticeList.bbsSn}" class="text-dark">
									  ${bbsNoticeList.bbscttSj}</a>
								  <p class="text-sm">${bbsNoticeList.bbscttUpdtDt} ${bbsNoticeList.emplNm}</p>
							   </div> --%>
													</c:forEach>
												</div>
											</div>
											<div class="tab-pane fade mt-20" id="cummunity"
												role="tabpanel" aria-labelledby="cummunity-tab">
												<div class="bbsDiv"></div>
											</div>
											<div class="tab-pane fade mt-20" id="menu" role="tabpanel"
												aria-labelledby="menu-tab">
												<div class="bbsDiv"></div>
											</div>

											<!-- 공지사항 페이지네이션 -->
											<nav aria-label="Page navigation example">
												<ul class="pagination d-flex justify-content-center">
													<li class="page-item">
														<button class="page-link prevBtn">
															<span aria-hidden="true"><</span>
														</button>
													</li>
													<li class="page-item">
														<button class="page-link nextPage">
															<span aria-hidden="true">></span>
														</button>
													</li>
												</ul>
											</nav>
											<!-- 공지사항 페이지네이션 -->
										</div>
									</div>
								</div>
								<!-- 게시판 끝 -->

								<!-- 캘린더 -->
								<div id="mainBbs" class="col-lg-6">
									<div class="card-style mb-30">
										<div class=" calendar-card">
											<div id="calendar-mini"
												class="fc fc-media-screen fc-direction-ltr fc-theme-standard">
												<div class="fc-header-toolbar fc-toolbar ">
													<div class="fc-toolbar-chunk">
														<h2 class="fc-toolbar-title" id="fc-dom-1">April 2025</h2>
													</div>
													<div class="fc-toolbar-chunk"></div>
													<div class="fc-toolbar-chunk">
														<button type="button" title="This month" disabled=""
															aria-pressed="false"
															class="fc-today-button fc-button fc-button-primary">today</button>
														<div class="fc-button-group">
															<button type="button" title="Previous month"
																aria-pressed="false"
																class="fc-prev-button fc-button fc-button-primary">
																<span class="fc-icon fc-icon-chevron-left"></span>
															</button>
															<button type="button" title="Next month"
																aria-pressed="false"
																class="fc-next-button fc-button fc-button-primary">
																<span class="fc-icon fc-icon-chevron-right"></span>
															</button>
														</div>
													</div>
												</div>
												<div aria-labelledby="fc-dom-1"
													class="fc-view-harness fc-view-harness-active"
													style="height: 274.815px;">
													<div class="fc-dayGridMonth-view fc-view fc-daygrid">
														<table role="grid"
															class="fc-scrollgrid  fc-scrollgrid-liquid">
															<thead role="rowgroup">
																<tr role="presentation"
																	class="fc-scrollgrid-section fc-scrollgrid-section-header ">
																	<th role="presentation"><div
																			class="fc-scroller-harness">
																			<div class="fc-scroller"
																				style="overflow: hidden scroll;">
																				<table role="presentation" class="fc-col-header "
																					style="width: 356px;">
																					<colgroup></colgroup>
																					<thead role="presentation">
																						<tr role="row">
																							<th role="columnheader"
																								class="fc-col-header-cell fc-day fc-day-sun"><div
																									class="fc-scrollgrid-sync-inner">
																									<a aria-label="Sunday"
																										class="fc-col-header-cell-cushion">Sun</a>
																								</div></th>
																							<th role="columnheader"
																								class="fc-col-header-cell fc-day fc-day-mon"><div
																									class="fc-scrollgrid-sync-inner">
																									<a aria-label="Monday"
																										class="fc-col-header-cell-cushion">Mon</a>
																								</div></th>
																							<th role="columnheader"
																								class="fc-col-header-cell fc-day fc-day-tue"><div
																									class="fc-scrollgrid-sync-inner">
																									<a aria-label="Tuesday"
																										class="fc-col-header-cell-cushion">Tue</a>
																								</div></th>
																							<th role="columnheader"
																								class="fc-col-header-cell fc-day fc-day-wed"><div
																									class="fc-scrollgrid-sync-inner">
																									<a aria-label="Wednesday"
																										class="fc-col-header-cell-cushion">Wed</a>
																								</div></th>
																							<th role="columnheader"
																								class="fc-col-header-cell fc-day fc-day-thu"><div
																									class="fc-scrollgrid-sync-inner">
																									<a aria-label="Thursday"
																										class="fc-col-header-cell-cushion">Thu</a>
																								</div></th>
																							<th role="columnheader"
																								class="fc-col-header-cell fc-day fc-day-fri"><div
																									class="fc-scrollgrid-sync-inner">
																									<a aria-label="Friday"
																										class="fc-col-header-cell-cushion">Fri</a>
																								</div></th>
																							<th role="columnheader"
																								class="fc-col-header-cell fc-day fc-day-sat"><div
																									class="fc-scrollgrid-sync-inner">
																									<a aria-label="Saturday"
																										class="fc-col-header-cell-cushion">Sat</a>
																								</div></th>
																						</tr>
																					</thead>
																				</table>
																			</div>
																		</div></th>
																</tr>
															</thead>
															<tbody role="rowgroup">
																<tr role="presentation"
																	class="fc-scrollgrid-section fc-scrollgrid-section-body  fc-scrollgrid-section-liquid">
																	<td role="presentation"><div
																			class="fc-scroller-harness fc-scroller-harness-liquid">
																			<div class="fc-scroller fc-scroller-liquid-absolute"
																				style="overflow: hidden scroll;">
																				<div
																					class="fc-daygrid-body fc-daygrid-body-unbalanced "
																					style="width: 355px;">
																					<table role="presentation"
																						class="fc-scrollgrid-sync-table"
																						style="width: 355px; height: 356px;">
																						<colgroup></colgroup>
																						<tbody role="presentation">
																							<tr role="row">
																								<td aria-labelledby="fc-dom-2" role="gridcell"
																									data-date="2025-03-30"
																									class="fc-day fc-day-sun fc-day-past fc-day-other fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="March 30, 2025" id="fc-dom-2"
																												class="fc-daygrid-day-number">30</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-4" role="gridcell"
																									data-date="2025-03-31"
																									class="fc-day fc-day-mon fc-day-past fc-day-other fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="March 31, 2025" id="fc-dom-4"
																												class="fc-daygrid-day-number">31</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-6" role="gridcell"
																									data-date="2025-04-01"
																									class="fc-day fc-day-tue fc-day-past fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="April 1, 2025" id="fc-dom-6"
																												class="fc-daygrid-day-number">1</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-8" role="gridcell"
																									data-date="2025-04-02"
																									class="fc-day fc-day-wed fc-day-past fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="April 2, 2025" id="fc-dom-8"
																												class="fc-daygrid-day-number">2</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-10" role="gridcell"
																									data-date="2025-04-03"
																									class="fc-day fc-day-thu fc-day-past fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="April 3, 2025" id="fc-dom-10"
																												class="fc-daygrid-day-number">3</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-12" role="gridcell"
																									data-date="2025-04-04"
																									class="fc-day fc-day-fri fc-day-past fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="April 4, 2025" id="fc-dom-12"
																												class="fc-daygrid-day-number">4</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-14" role="gridcell"
																									data-date="2025-04-05"
																									class="fc-day fc-day-sat fc-day-past fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="April 5, 2025" id="fc-dom-14"
																												class="fc-daygrid-day-number">5</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																							</tr>
																							<tr role="row">
																								<td aria-labelledby="fc-dom-16" role="gridcell"
																									data-date="2025-04-06"
																									class="fc-day fc-day-sun fc-day-past fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="April 6, 2025" id="fc-dom-16"
																												class="fc-daygrid-day-number">6</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-18" role="gridcell"
																									data-date="2025-04-07"
																									class="fc-day fc-day-mon fc-day-past fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="April 7, 2025" id="fc-dom-18"
																												class="fc-daygrid-day-number">7</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-20" role="gridcell"
																									data-date="2025-04-08"
																									class="fc-day fc-day-tue fc-day-past fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="April 8, 2025" id="fc-dom-20"
																												class="fc-daygrid-day-number">8</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-22" role="gridcell"
																									data-date="2025-04-09"
																									class="fc-day fc-day-wed fc-day-past fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="April 9, 2025" id="fc-dom-22"
																												class="fc-daygrid-day-number">9</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-24" role="gridcell"
																									data-date="2025-04-10"
																									class="fc-day fc-day-thu fc-day-past fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="April 10, 2025" id="fc-dom-24"
																												class="fc-daygrid-day-number">10</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-26" role="gridcell"
																									data-date="2025-04-11"
																									class="fc-day fc-day-fri fc-day-past fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="April 11, 2025" id="fc-dom-26"
																												class="fc-daygrid-day-number">11</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-28" role="gridcell"
																									data-date="2025-04-12"
																									class="fc-day fc-day-sat fc-day-past fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="April 12, 2025" id="fc-dom-28"
																												class="fc-daygrid-day-number">12</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																							</tr>
																							<tr role="row">
																								<td aria-labelledby="fc-dom-30" role="gridcell"
																									data-date="2025-04-13"
																									class="fc-day fc-day-sun fc-day-past fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="April 13, 2025" id="fc-dom-30"
																												class="fc-daygrid-day-number">13</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-32" role="gridcell"
																									data-date="2025-04-14"
																									class="fc-day fc-day-mon fc-day-past fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="April 14, 2025" id="fc-dom-32"
																												class="fc-daygrid-day-number">14</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-34" role="gridcell"
																									data-date="2025-04-15"
																									class="fc-day fc-day-tue fc-day-past fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="April 15, 2025" id="fc-dom-34"
																												class="fc-daygrid-day-number">15</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-36" role="gridcell"
																									data-date="2025-04-16"
																									class="fc-day fc-day-wed fc-day-past fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="April 16, 2025" id="fc-dom-36"
																												class="fc-daygrid-day-number">16</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-38" role="gridcell"
																									data-date="2025-04-17"
																									class="fc-day fc-day-thu fc-day-today fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="April 17, 2025" id="fc-dom-38"
																												class="fc-daygrid-day-number">17</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-40" role="gridcell"
																									data-date="2025-04-18"
																									class="fc-day fc-day-fri fc-day-future fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="April 18, 2025" id="fc-dom-40"
																												class="fc-daygrid-day-number">18</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-42" role="gridcell"
																									data-date="2025-04-19"
																									class="fc-day fc-day-sat fc-day-future fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="April 19, 2025" id="fc-dom-42"
																												class="fc-daygrid-day-number">19</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																							</tr>
																							<tr role="row">
																								<td aria-labelledby="fc-dom-44" role="gridcell"
																									data-date="2025-04-20"
																									class="fc-day fc-day-sun fc-day-future fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="April 20, 2025" id="fc-dom-44"
																												class="fc-daygrid-day-number">20</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-46" role="gridcell"
																									data-date="2025-04-21"
																									class="fc-day fc-day-mon fc-day-future fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="April 21, 2025" id="fc-dom-46"
																												class="fc-daygrid-day-number">21</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-48" role="gridcell"
																									data-date="2025-04-22"
																									class="fc-day fc-day-tue fc-day-future fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="April 22, 2025" id="fc-dom-48"
																												class="fc-daygrid-day-number">22</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-50" role="gridcell"
																									data-date="2025-04-23"
																									class="fc-day fc-day-wed fc-day-future fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="April 23, 2025" id="fc-dom-50"
																												class="fc-daygrid-day-number">23</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-52" role="gridcell"
																									data-date="2025-04-24"
																									class="fc-day fc-day-thu fc-day-future fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="April 24, 2025" id="fc-dom-52"
																												class="fc-daygrid-day-number">24</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-54" role="gridcell"
																									data-date="2025-04-25"
																									class="fc-day fc-day-fri fc-day-future fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="April 25, 2025" id="fc-dom-54"
																												class="fc-daygrid-day-number">25</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-56" role="gridcell"
																									data-date="2025-04-26"
																									class="fc-day fc-day-sat fc-day-future fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="April 26, 2025" id="fc-dom-56"
																												class="fc-daygrid-day-number">26</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																							</tr>
																							<tr role="row">
																								<td aria-labelledby="fc-dom-58" role="gridcell"
																									data-date="2025-04-27"
																									class="fc-day fc-day-sun fc-day-future fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="April 27, 2025" id="fc-dom-58"
																												class="fc-daygrid-day-number">27</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-60" role="gridcell"
																									data-date="2025-04-28"
																									class="fc-day fc-day-mon fc-day-future fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="April 28, 2025" id="fc-dom-60"
																												class="fc-daygrid-day-number">28</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-62" role="gridcell"
																									data-date="2025-04-29"
																									class="fc-day fc-day-tue fc-day-future fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="April 29, 2025" id="fc-dom-62"
																												class="fc-daygrid-day-number">29</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-64" role="gridcell"
																									data-date="2025-04-30"
																									class="fc-day fc-day-wed fc-day-future fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="April 30, 2025" id="fc-dom-64"
																												class="fc-daygrid-day-number">30</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-66" role="gridcell"
																									data-date="2025-05-01"
																									class="fc-day fc-day-thu fc-day-future fc-day-other fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="May 1, 2025" id="fc-dom-66"
																												class="fc-daygrid-day-number">1</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-68" role="gridcell"
																									data-date="2025-05-02"
																									class="fc-day fc-day-fri fc-day-future fc-day-other fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="May 2, 2025" id="fc-dom-68"
																												class="fc-daygrid-day-number">2</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-70" role="gridcell"
																									data-date="2025-05-03"
																									class="fc-day fc-day-sat fc-day-future fc-day-other fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="May 3, 2025" id="fc-dom-70"
																												class="fc-daygrid-day-number">3</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																							</tr>
																							<tr role="row">
																								<td aria-labelledby="fc-dom-72" role="gridcell"
																									data-date="2025-05-04"
																									class="fc-day fc-day-sun fc-day-future fc-day-other fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="May 4, 2025" id="fc-dom-72"
																												class="fc-daygrid-day-number">4</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-74" role="gridcell"
																									data-date="2025-05-05"
																									class="fc-day fc-day-mon fc-day-future fc-day-other fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="May 5, 2025" id="fc-dom-74"
																												class="fc-daygrid-day-number">5</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-76" role="gridcell"
																									data-date="2025-05-06"
																									class="fc-day fc-day-tue fc-day-future fc-day-other fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="May 6, 2025" id="fc-dom-76"
																												class="fc-daygrid-day-number">6</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-78" role="gridcell"
																									data-date="2025-05-07"
																									class="fc-day fc-day-wed fc-day-future fc-day-other fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="May 7, 2025" id="fc-dom-78"
																												class="fc-daygrid-day-number">7</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-80" role="gridcell"
																									data-date="2025-05-08"
																									class="fc-day fc-day-thu fc-day-future fc-day-other fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="May 8, 2025" id="fc-dom-80"
																												class="fc-daygrid-day-number">8</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-82" role="gridcell"
																									data-date="2025-05-09"
																									class="fc-day fc-day-fri fc-day-future fc-day-other fc-daygrid-day"><div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="May 9, 2025" id="fc-dom-82"
																												class="fc-daygrid-day-number">9</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div></td>
																								<td aria-labelledby="fc-dom-84" role="gridcell"
																									data-date="2025-05-10"
																									class="fc-day fc-day-sat fc-day-future fc-day-other fc-daygrid-day">
																									<div
																										class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																										<div class="fc-daygrid-day-top">
																											<a aria-label="May 10, 2025" id="fc-dom-84"
																												class="fc-daygrid-day-number">10</a>
																										</div>
																										<div class="fc-daygrid-day-events">
																											<div class="fc-daygrid-day-bottom"
																												style="margin-top: 0px;"></div>
																										</div>
																										<div class="fc-daygrid-day-bg"></div>
																									</div>
																								</td>
																							</tr>
																						</tbody>
																					</table>
																				</div>
																			</div>
																		</div></td>
																</tr>
															</tbody>
														</table>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!-- 캘린더 -->
							</div>

							<!-- 통계 -->
							<!--  <div class="col-lg-12">
              <div class="card-style mb-30">
              	통계
               </div>
             </div> -->
							<!-- 통계 -->
						</div>
					</div>


				</div>
		</section>
		<%@ include file="./layout/footer.jsp"%>
	</main>
	<%@ include file="./layout/prescript.jsp"%>

	<script type="text/javascript">
//디지털시계
let timeParts = '<%=serverTime%>'.split(':');
let hours = parseInt(timeParts[0]);
let minutes = parseInt(timeParts[1]);
let seconds = parseInt(timeParts[2]);

/* const todEndTime = $('#workEndTime').val();
console.log(todEndTime); */

//퇴근 찍혔는데 한번 더 눌렀을 경우
/* $('#workEndButton').on('click', function(){
	if(endTime != null && endTime != ''){
		swal({
			title: "퇴근 등록",
			text: "정말로 퇴근을 등록하시겠습니까?",
			icon: "warning",
			buttons: {
				cancel: {
					text: "취소",
					value: null,
					visible: true,
					closeModal: true
				},
				confirm: {
					text: "확인",
					value: true,
					closeModal: true
				}
			}
		})
	}
}) */
$(function(){	
	// 퇴근 한번더 누르면 swal 띄우기
	const todWoTime = $('#todayWorkTime').val();
	if(todWoTime != null && todWoTime != ''){
		$('#workStartButton').prop('disabled', true);
	}
	
	// 공지사항 눌렀을때 1전송
	$('#notice-tab').on('click', function(e){
		e.preventDefault();
		//alert('djfjhsadjhfkjsdahfkj');
		$('#noticeForm').submit();
	})
	
function updateClock() {
  seconds++;
  if (seconds >= 60) {
    seconds = 0;
    minutes++;
  }
  if (minutes >= 60) {
    minutes = 0;
    hours++;
  }
  if (hours >= 24) {
    hours = 0;
  }

  const formattedTime = 
    String(hours).padStart(2, '0') + ':' +
    String(minutes).padStart(2, '0') + ':' +
    String(seconds).padStart(2, '0');

  document.getElementById('clock').textContent = formattedTime;
}
updateClock();
setInterval(updateClock, 1000);
// ----------------------------------------------- 여기 부터는 비동기 게시판 불러오기
let categoryNo  = 1;
let bbsDiv = document.querySelector('#notice .bbsDiv');

document.querySelectorAll("#mainBbs .nav-item").forEach(dom => {
  dom.addEventListener("click", (e) => {
    	categoryNo = dom.dataset.bbsCtgryNo;
      if (categoryNo == 1) {
        bbsDiv = document.querySelector('#notice .bbsDiv');
	  }
      if (categoryNo == 2) {
        bbsDiv = document.querySelector('#cummunity .bbsDiv');
        
	  }
      if (categoryNo == 3) {
        bbsDiv = document.querySelector('#menu .bbsDiv');
        
	  }

    fetch('/main/noticeList?currentPage=' + 1 + "&bbsCtgryNo=" + categoryNo  , {
      method : 'get',
      headers : {
        "Content-Type": "application/json"
      }
    })
      .then(resp => resp.json())
      .then(res => {
        console.log('받은 결과 : ' , res);
        const noticeList = res.noticeList;
        const articlePage = res.articlePage;
        console.log('noticeList : ' , noticeList);

        console.log('tbody : ' , bbsDiv);
        bbsDiv.innerHTML = "";
        // 현재페이지
        let currentPage = articlePage.currentPage;
        // 첫번째 페이지
        let startPage = articlePage.startPage;
        // 현재페이지 바꿔주기
        $('.currentPage').val(currentPage);
        noticeList.map((item) => {
          //const newDiv = document.createElement('div');
          const isFixed = item.upendFixingYn === 'Y' ? '<span style="color: red;">[고정]</span>' : '';
          const newData = `
		        	  <div class="mb-4">
			              <div>
			              	\${isFixed}
			              	<a href="/bbs/bbsDetail?bbsSn=\${item.bbsSn}" class="text-black text-bold text-sm">
			              		\${item.bbscttSj}
			              	</a>
			              </div>
		                  <span class="text-sm text-gray">
		                 	 \${item.emplNm} \${item.bbscttCreatDt} 
		                  </span>
			           </div>
			           <hr/>
				`
          bbsDiv.innerHTML += newData;
        }) // end map

        if (currentPage <= 1) {
          $('.prevBtn').prop('disabled', true);
          $('.nextPage').prop('disabled', false);
        } else {
          $('.prevBtn').prop('disabled', false);
        }
      }) // end res
  });
})

// 공지사항 페이지네이션
// 이전 화살표 눌렀을때 비동기로 이동
$('.prevBtn').on('click', function(){
	const currentVal = $('.currentPage').val();
  	// const  = $('.currentPage').val();
	const prevPage = currentVal - 1;
	//console.log('현재페이지 : ' , currentVal-1);
	// 이전 화살표 버튼 눌렀을때 
	fetch('/main/noticeList?currentPage=' + prevPage + "&bbsCtgryNo=" + categoryNo  , {
		method : 'get',
		headers : {
			 "Content-Type": "application/json"
		}
	})
	.then(resp => resp.json())
	.then(res => {
		//console.log('받은 결과 : ' , res);
		const noticeList = res.noticeList;
		const articlePage = res.articlePage;
		//console.log('noticeList : ' , noticeList);

		bbsDiv.innerHTML = "";
		// 현재페이지
		let currentPage = articlePage.currentPage;
		// 첫번째 페이지
		let startPage = articlePage.startPage;
		// 현재페이지 바꿔주기
		$('.currentPage').val(currentPage);
		noticeList.map((item) => {
			//const newDiv = document.createElement('div');
			const isFixed = item.upendFixingYn === 'Y' ? '<span style="color: red;">[고정]</span>' : '';
			const newData = `
				<div class="mb-4">
	              <div>
	              	\${isFixed}
	              	<a href="/bbs/bbsDetail?bbsSn=\${item.bbsSn}" class="text-black text-bold text-sm">
	              		\${item.bbscttSj}
	              	</a>
	              </div>
	                <span class="text-sm text-gray">
	              		  \${item.emplNm} \${item.bbscttCreatDt} 
	                </span>
               </div>
               <hr/>
				`
			bbsDiv.innerHTML += newData;		
		}) // end map
	 
		if (currentPage <= 1) {
		    $('.prevBtn').prop('disabled', true);
          	$('.nextPage').prop('disabled', false);
		} else {
			$('.prevBtn').prop('disabled', false);
		}
	}) // end res
}) // 이전 화살표 눌렀을때 비동기로 이동 끝

// 다음 화살표 눌렀을때 비동기로 이동
$('.nextPage').on('click', function(){
	const currentVal = Number($('.currentPage').val());
	//console.log('현재페이지 : ' , currentVal);
	const nextPage = currentVal + 1 ; 
	//console.log('다음페이지 : ' , nextPage);

    fetch('/main/noticeList?currentPage=' + nextPage + "&bbsCtgryNo=" + categoryNo , {
		method : 'get',
		headers : {
			 "Content-Type": "application/json"
		}
	})
	.then(resp => resp.json())
	.then(res => {
		//console.log('받은 결과 : ' , res);
		const noticeList = res.noticeList;
		const articlePage = res.articlePage;
		//console.log('noticeList : ' , noticeList);
		
		bbsDiv.innerHTML = "";
		// 현재페이지
		let currentPage = articlePage.currentPage;
		// 마지막 페이지
		let totalPages = articlePage.totalPages;
		// 현재페이지 바꿔주기
		$('.currentPage').val(currentPage);
		
		noticeList.map((item) => {
			//const newDiv = document.createElement('div');
			const isFixed = item.upendFixingYn === 'Y' ? '<span style="color: red; font-weight: bold;">[고정]</span>' : '';
			const newData = `
				<div class="mb-4">
		              <div>
		              	\${isFixed}
			              	<a href="/bbs/bbsDetail?bbsSn=\${item.bbsSn}" class="text-black text-bold text-sm">
			              		\${item.bbscttSj}
			              	</a>
		              </div>
	                  <span class="text-sm text-gray">
	                  		\${item.emplNm} \${item.bbscttCreatDt} 
	                  </span>
	             </div>
	             <hr/>
				`
			bbsDiv.innerHTML += newData;		
		}) // end map
		if (currentPage >= totalPages) {
		    $('.nextPage').prop('disabled', true);
          $('.prevBtn').prop('disabled', false);
		}else{
			$('.nextPage').prop('disabled', false);
		}
	}) // end res
}) // 다음 화살표 눌렀을때 비동기로 이동 끝
// 공지사항 페이지네이션 끝
// ----------------------------------------------- 여기 부터는 비동기 게시판 불러오기
}) // end function

</script>

</body>
</html>