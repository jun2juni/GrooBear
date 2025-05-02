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

/* 업무명 40% 넓이 설정 + 좌측 정렬 */
#urgentTaskTable th:nth-child(1),
#urgentTaskTable td:nth-child(1) {
  width: 40%;
  text-align: left;
  padding-left: 2%;
}

/* 나머지 컬럼 최소 너비 + nowrap */
#urgentTaskTable th:nth-child(2),
#urgentTaskTable th:nth-child(3),
#urgentTaskTable th:nth-child(4),
#urgentTaskTable th:nth-child(5) {
  width: 60px;
  white-space: nowrap;
}
.scroll-table {
  max-height: 300px;
  overflow-y: auto;
}
</style>
<meta charset="UTF-8" />
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="ie=edge" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
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
						style="position: sticky; top: 112px; z-index: 1; max-height: 80vh;">
						<!-- 출퇴근-->
						<div class="card-style mb-4"
							style="box-shadow: 1px 1px 20px 1px rgba(0, 0, 2, 0.1);">
							<c:import url="./organization/dclz/workButton.jsp" />
							<!-- 출퇴근 버튼 -->
							<div class=" text-center">
								<span class="status-btn dark-btn text-center mt-20"><%=serverDate%></span>
								<div id="clock" style="font-size: 24px; font-weight: bold;"></div>
								<div class="d-flex mb-10 mt-3 justify-content-center">
									<div class="content mr-30">
										<input type="hidden" id="inputTodWorkTime" value="${todayWorkTime}"
											id="todayWorkTime">
										<button type="button"
											id="${todayWorkTime != null ? '' : 'workStartButton'}"
											class="btn btn-outline-primary rounded-pill px-4 py-2 beginWorkBtn">🏃 출근</button>
										<p id="startTime">${todayWorkTime != null ? todayWorkTime : '출근 전'}</p>
									</div>
									<div class="content">
										<input type="hidden" value="${todayWorkEndTime}"
											id="workEndTime">
										<button type="button"
											id="${workEndButton != null ? '' : 'workEndButton'}"
											class="btn btn-outline-danger rounded-pill px-4 py-2">🚩 퇴근</button>
										<p id="endTime">${todayWorkEndTime != null ? todayWorkEndTime : '퇴근 전'}</p>
									</div>
								</div>
							</div>
						</div>
						<!-- 출퇴근 -->
						
						<!-- 출퇴근 카드 -->
					  <%-- <div class="card-style p-4 mb-4 text-center"
						   style="box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08); backdrop-filter: blur(12px); border-radius: 16px; background-color: rgba(255, 255, 255, 0.6);">
					  
						<!-- 서버 날짜 -->
						<div class="mb-2">
						  <span class="badge bg-secondary text-white px-3 py-2 fs-6 rounded-pill"><%= serverDate %></span>
						</div>
					 
						<!-- 현재 시계 -->
						<div id="clock" class="mb-4 fs-4 fw-bold text-dark"></div>
					 
						<!-- 출근 / 퇴근 버튼 -->
						<div class="d-flex justify-content-center gap-5">
						  
						  <!-- 출근 -->
						  <div>
							<input type="hidden" id="inputTodWorkTime" value="${todayWorkTime}" />
							<button type="button"
									id="${todayWorkTime != null ? '' : 'workStartButton'}"
									class="btn btn-outline-primary rounded-pill px-4 py-2 beginWorkBtn">
							  🏃 출근
							</button>
							<p id="startTime" class="mt-2 text-muted">
							  ${todayWorkTime != null ? todayWorkTime : '출근 전'}
							</p>
						  </div>
					  
						  <!-- 퇴근 -->
						  <div>
							<input type="hidden" id="workEndTime" value="${todayWorkEndTime}" />
							<button type="button"
									id="${workEndButton != null ? '' : 'workEndButton'}"
									class="btn btn-outline-danger rounded-pill px-4 py-2">
							  🚩 퇴근
							</button>
							<p id="endTime" class="mt-2 text-muted">
							  ${todayWorkEndTime != null ? todayWorkEndTime : '퇴근 전'}
							</p>
						  </div>
						</div>
					  </div> --%>


						<!-- 메일 + 일정 -->
						  <!-- 메일 + 일정 카드 -->
					  <div class="card-style mb-4 d-flex justify-content-center align-items-center p-4"
						  style="box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08); backdrop-filter: blur(12px); border-radius: 16px; background-color: rgba(255, 255, 255, 0.6);">
						  
						  <div class="d-flex justify-content-center gap-5 w-100">
							  <!-- 메일 위젯 -->
							  <div class="text-center flex-fill">
								  <a href="/mail" class="text-dark text-decoration-none">
									  <div class="fw-semibold mb-2">미확인 메일</div>
									  <div class="fw-bold text-primary">${notReadMail}건</div>
								  </a>
								  <div class="mt-3">
									  <a href="/mail/mailSend" class="btn btn-outline-primary rounded-pill">
										  <i class="lni lni-envelope me-1 align-middle mb-1"></i> 메일쓰기
									  </a>
								  </div>
							  </div>
					  
							  <!-- 일정 위젯 -->
							  <div class="text-center flex-fill">
								  <a href="/myCalendar" class="text-dark text-decoration-none">
									  <div class="fw-semibold mb-2">오늘 일정</div>
									  <div class="fw-bold text-success">${todayCalendarCnt}건</div>
								  </a>
								  <div class="mt-3">
									 <a href="/myCalendar?openModal=true" class="btn btn-outline-success rounded-pill">
									  <i class="lni lni-calendar me-1 align-middle mb-1"></i> 일정등록
									</a>
								  </div>
							  </div>
						  </div>
					  </div>
					  
						<!-- 알림 -->
					  <div class="card-style p-4 mb-4"
						   style="box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08); backdrop-filter: blur(12px); border-radius: 16px; background-color: rgba(255, 255, 255, 0.6);">
					  
						<!-- 헤더: 커뮤니티 제목 -->
						<div class="mb-4">
						  <a href="/comunity/comunityClubList" class="text-decoration-none">
							<span style="font-size: 1.4rem;">👨‍👦‍👦</span>
							<span class="fw-bold text-dark ms-2">커뮤니티</span>
						  </a>
						</div>
					 
						<!-- 버튼 목록 -->
						<div class="d-flex flex-column gap-3">
						  <button type="button" class="btn btn-outline-primary w-100 rounded-pill py-2"
								  data-bs-toggle="modal" data-bs-target="#emojiModal">
							😊 이모지 등록하기
						  </button>
					  
						  <button type="button" class="btn btn-outline-secondary w-100 rounded-pill py-2"
								  data-bs-toggle="modal" data-bs-target="#100Modal">
							💬 T.T-MI 등록하기
						  </button>
					  
						  <button type="button" class="btn btn-outline-success w-100 rounded-pill py-2"
								  data-bs-toggle="modal" data-bs-target="#todayModal">
							✍️ 오늘의 한 줄 등록하기
						  </button>
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
								<div class="d-flex justify-content-between align-items-center mb-3">
									  <h6 class="mb-0 fw-bold">진행중인 프로젝트 (마감 임박 업무)</h6>
									  <a href="/project/tab?tab=list" class="text-sm fw-bolder" style="color: #4a6cf7;">
									    더보기 
									    <span class="material-symbols-outlined align-middle">chevron_right</span>
									  </a>
									</div>
									 <div class="card-body scroll-table">
								    <table class="table table-bordered text-center hover-highlight" id="urgentTaskTable">
								      <thead class="table-light">
								        <tr>
								          <th>[프로젝트명] 업무명</th>
								          <th>등급</th>
								          <th>중요도</th>
								          <th>진행률</th>
								          <th>종료일</th>
								        </tr>
								      </thead>
										<tbody>
								        <c:forEach var="t" items="${urgentTasks}">
								          <tr>
								            <td class="text-start ps-2">[${t.prjctNm}] ${t.taskNm}</td>
								            <td><span class="badge grade-${t.taskGrad}">${t.taskGrad}</span></td>
								            <td><span class="badge priort-${t.priort}">${commonCodes['PRIORT'][t.priort]}</span></td>
								            <td>${t.progrsrt != null ? t.progrsrt : 0}%</td>
								            <td><fmt:formatDate value="${t.taskEndDt}" pattern="yyyy-MM-dd"/></td>
								          </tr>
								        </c:forEach>
								      </tbody>
								    </table>
								  </div>
								</div>

										
								
								</div>
							</div>
							<!-- 프로젝트 -->

							<input type="hidden" class="currentPage"
								value="${articlePage.currentPage}">
							<div class="row" style="max-height: 95%;">
								<!-- 게시판 시작 -->
								<div id="mainBbs" class="col-lg-6">
									<div class="card-style mb-30" style="height: 100%;">
									
										<div class="d-flex justify-content-between">
											<h6 class="mb-30">전사게시판 최근글</h6>
											<a id="bbsMoreBtn" href="#" class="text-sm fw-bolder" style="color: #4a6cf7;">더보기 
												<span class="material-symbols-outlined" style="vertical-align: middle;">chevron_right</span>
											</a>
										</div>
										
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
																	<i class="bi bi-pin-angle-fill" style="color: red;"></i>
																</c:if>
																<a href="/bbs/bbsDetail?bbsSn=${bbsNoticeList.bbsSn}"
																	class="text-black text-bold text-sm">
																	${bbsNoticeList.bbscttSj} </a>
															</div>
															<div class="d-flex justify-content-between">
																<c:set var="date" value="${bbsNoticeList.bbscttCreatDt.substring(0,10)}"></c:set>
																<c:set var="time" value="${bbsNoticeList.bbscttCreatDt.substring(10)}"></c:set>
																<span class="text-sm text-gray">${bbsNoticeList.emplNm}</span>
																<span class="text-sm text-gray">${date}&nbsp;&nbsp;&nbsp;${time}</span>
															</div>
														</div>
														<hr />
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
								<div id="mainCal" class="col-lg-6" >
									<div class="card-style mb-30" style="padding-top: 20px; height: 100%;">
										<jsp:include page="schedule/scheduleMainHome.jsp"></jsp:include>
									</div>
								</div>
								<!-- 캘린더 -->
							</div>

						</div>
					</div>
					<form action="/comunity/insertTTMI" method="post">
				<div class="modal fade" id="100Modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h1 class="modal-title fs-5" id="exampleModalLabel">T.T-MI 입력</h1>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        <div class="input-style-1">
		                  <label><h4>가장 좋아하는 과일을 말해주세요!</h4></label> <!--백문백답 들어가는 곳   -->
		                  <textarea placeholder="답변을 입력해주세요" name="ttmiContent" rows="5" data-listener-added_0bb1bb59="true"></textarea>
		                </div>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				        <button type="submit" class="btn btn-primary">답변 저장하기</button>
				      </div>	
				    </div>
				  </div>
				</div>
			</form>
       		 <!-- 백문백답모달 끝  -->
			 <!-- 오늘의 한 줄 모달 시작  -->
			 <form id="todayForm" action="/comunity/insertToday" method="post">
				<div class="modal fade" id="todayModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h1 class="modal-title fs-5" id="exampleModalLabel">T.T-MI 입력</h1>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        <div class="input-style-1">
		                  <label><h4>😼오늘의 기분을 말해주세요!😻</h4></label> 
		                  <textarea name="bbscttCn" placeholder="답변을 입력해주세요" rows="5" data-listener-added_0bb1bb5="true"></textarea>
		                </div>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				        <button type="submit" class="btn btn-primary">답변 저장하기</button>
				      </div>	
				    </div>
				  </div>
				</div>     
			</form>
       		 <!-- 오늘의 한 줄 모달 끝  -->
			 <!-- 오늘의 이모지 모달 시작  -->
			 <form action="/comunity/insertEmoji" method="post">
				<div class="modal fade" id="emojiModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h1 class="modal-title fs-5" id="exampleModalLabel">이모지 선택</h1>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
						<div class="emoji-picker my-3">
						  <!-- 이모지 버튼이 여기에 동적으로 들어갈 예정 -->
						</div>				      
				        <div class="input-style-1">
		                  <label><h4>👍오늘의 기분을 이모지로 말해주세요!👎(최대 3개)</h4></label> <!--이모지 들어가는 곳   -->
		                  <textarea readonly="readonly"  id="emojiTextArea" name="emoji" placeholder="이모지를 입력해주세요" rows="5" data-listener-added_0bb1bb5="true"></textarea>
		                </div>
				      </div>
				      <div class="modal-footer">
				        <button type="button" id="emojiResetBtn" class="btn btn-outline-danger btn-sm mt-2">선택 초기화</button>
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				        <button type="submit" class="btn btn-primary">오늘의 이모지 저장하기</button>
				      </div>	
				    </div>
				  </div> 
				</div>     
			</form>
				</div> <!-- containerflud 끝 -->
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
// 메인페이지 로딩시 공지사항 경로로 기본값 세팅
$('#bbsMoreBtn').attr('href', '/bbs/bbsList?bbsCtgryNo=1');

$(function(){
	$('.beginWorkBtn').on('click' , function(){
		if($('#startTime').val() != null){
			swal({
				icon : 'warning',
				text : '이미 출근 처리되었습니다.',
				buttons : {
					confirm : {
						text : '확인',
						value : true,
						closeModal : true
					}
				}
			})
			.then(() => {
				$('#workStartButton').prop('disabled', true);
			})
		}
	})
	
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


	// 탭에 따라 더보기 링크 바꾸기
	let notice = '/bbs/bbsList?bbsCtgryNo=1';
	let community = '/bbs/bbsList?bbsCtgryNo=2';
	let menu = '/bbs/bbsList?bbsCtgryNo=3';

	$('#notice-tab').on('click', function(){
		$('#bbsMoreBtn').attr('href', notice);
	})
	$('#cummunity-tab').on('click', function(){
		$('#bbsMoreBtn').attr('href', community);
	})
	$('#menu-tab').on('click', function(){
		$('#bbsMoreBtn').attr('href', menu);
	})



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
          const isFixed = item.upendFixingYn === 'Y' ? '<i class="bi bi-pin-angle-fill" style="color: red;"></i>' : '';
          const newData = `
		        	  <div class="mb-4">
			              <div>
			              	\${isFixed}
			              	<a href="/bbs/bbsDetail?bbsSn=\${item.bbsSn}" class="text-black text-bold text-sm">
			              		\${item.bbscttSj}
			              	</a>
			              </div>
			              <div class="d-flex justify-content-between">
							<span class="text-sm text-gray">\${item.emplNm}</span>
							<span class="text-sm text-gray">\${item.bbscttCreatDt.substring(0,10)}&nbsp;&nbsp;&nbsp;\${item.bbscttCreatDt.substring(10)} </span>
						  </div>
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
			const isFixed = item.upendFixingYn === 'Y' ? '<i class="bi bi-pin-angle-fill" style="color: red;"></i>' : '';
			const newData = `
				<div class="mb-4">
	              <div>
	              	\${isFixed}
	              	<a href="/bbs/bbsDetail?bbsSn=\${item.bbsSn}" class="text-black text-bold text-sm">
	              		\${item.bbscttSj}
	              	</a>
	              </div>
	              <div class="d-flex justify-content-between">
					<span class="text-sm text-gray">\${item.emplNm}</span>
					<span class="text-sm text-gray">\${item.bbscttCreatDt.substring(0,10)}&nbsp;&nbsp;&nbsp;\${item.bbscttCreatDt.substring(10)} </span>
				  </div>
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
			const isFixed = item.upendFixingYn === 'Y' ? '<i class="bi bi-pin-angle-fill" style="color: red;"></i>' : '';
			const newData = `
				<div class="mb-4">
		              <div>
		              	\${isFixed}
			              	<a href="/bbs/bbsDetail?bbsSn=\${item.bbsSn}" class="text-black text-bold text-sm">
			              		\${item.bbscttSj}
			              	</a>
		              </div>
		              <div class="d-flex justify-content-between">
						<span class="text-sm text-gray">\${item.emplNm}</span>
						<span class="text-sm text-gray">\${item.bbscttCreatDt.substring(0,10)}&nbsp;&nbsp;&nbsp;\${item.bbscttCreatDt.substring(10)} </span>
					  </div>
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