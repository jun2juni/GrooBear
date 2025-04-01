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
	<title>${title}</title>
  <%@ include file="../layout/prestyle.jsp" %>
</head>
<style>
.wdBtn {
	--bs-btn-padding-y: .25rem;
	--bs-btn-padding-x: 4rem;
	--bs-btn-font-size: .75rem;
	background-color: pink;
	color: white;
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
	height: 300px;
	margin-top: 10px;
	margin-bottom: 10px;
	margin-left: 10px;
	margin-right: 10px;
	padding: 20px;
	padding-bottom: 50px;
}

.atrzTabCont {
	border: 1px solid lightgray;
	border-radius: 10px;
	margin-top: 10px;
	margin-left: 10px;
	margin-right: 10px;
	margin-bottom: 10px;
}

#contact1-tab-pane {
	padding-bottom: 10px;;
}

#critical {
	padding-left: 4px;
}
</style>
<body>
<%@ include file="../layout/sidebar.jsp" %>
<main class="main-wrapper">
  <%@ include file="../layout/header.jsp" %>
	<section class="section">
		<div class="container-fluid">
			<!-- 여기서 작업시작 -->
		 		<!-- 여기서 작업 시작 -->
				<div class="col-sm-13" id="divCard">
					<div class="card">
						<div class="card-body">
							<div class="d-flex justify-content-between align-items-center">
								<div id="atrNavBar">
									<ul class="nav nav-pills" id="myTab" role="tablist">
										<li class="nav-item" role="presentation">
											<button class="nav-link active" id="contact1-tab"
												data-bs-toggle="tab" data-bs-target="#contact1-tab-pane"
												type="button" role="tab" aria-controls="contact1-tab-pane"
												aria-selected="true">결재대기문서</button>
										</li>
										<li class="nav-item" role="presentation">
											<button class="nav-link" id="contact2-tab"
												data-bs-toggle="tab" data-bs-target="#contact2-tab-pane"
												type="button" role="tab" aria-controls="contact2-tab-pane"
												aria-selected="false">참조대기문서</button>
										</li>
										<li class="nav-item" role="presentation">
											<button class="nav-link" id="contact3-tab"
												data-bs-toggle="tab" data-bs-target="#contact3-tab-pane"
												type="button" role="tab" aria-controls="contact3-tab-pane"
												aria-selected="false">결재예정문서</button>
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
											style="width: 100px;"> ~ <input id="toDate"
											class="form-control" type="text" style="width: 100px;">
									</div>
									<!--기간입력 선택시 활성화 시키는 스크립트-->
									<script>
									document.getElementById("duration").addEventListener("change",function(){
										var durationPeriod = document.getElementById("durationPeriod");
										if(this.value == "period"){
											durationPeriod.classList.remove("d-none");
											durationPeriod.classList.add("d-flex");
										}else{
											durationPeriod.classList.remove("d-flex");
											durationPeriod.classList.add("d-none");
											
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
											<input id="keyword" class="form-control border-0" type="text"
												placeholder="검색"> <span
												class="material-symbols-outlined">search</span>
										</div>
									</section>
								</div>
							</div>
						</div>
						<!-- <p>결재하기</p> -->
						<!-- <p>${atrzVOList}</p> -->
						<!-- 메뉴바 시작 -->
					<!-- 메뉴바 끝 -->
					<!-- 새결재 진행 모달import -->
					<c:import url="newAtrzDocModal.jsp" />
					<!-- 컨텐츠1 시작 -->

					<div class="tab-content" id="myTabContent">

						<!--일괄결재모달 시작-->
						<!-- Modal -->
						<div class="modal fade" id="allApproval" tabindex="-1"
							aria-labelledby="exampleModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-body">
										<form>
											<div class="mt-1 mb-3">
												<h4 class="form-label">정말로 일괄 결재하시겠습니까?</h4>
											</div>
											<div class="mb-3">
												<textarea class="form-control" id="message-text"
													style="height: 200px" placeholder="의견을 작성해주세요"></textarea>
											</div>
										</form>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-primary">확인</button>
										<button type="button" class="btn btn-secondary"
											data-bs-dismiss="modal">취소</button>
									</div>
								</div>
							</div>
						</div>
						<!--일괄결재모달 끝-->



						<div class="tab-pane fade show active" id="contact1-tab-pane"
							role="tabpanel" aria-labelledby="contact1-tab" tabindex="0">
							<div id="critical">
								<a class="btn" data-bs-toggle="modal"
									data-bs-target="#allApproval"> <span
									class="material-symbols-outlined">data_check</span> <span
									class="txt">일괄결재</span>
								</a>
							</div>

							<div class="atrzTabCont">
								<!-- <div class="container mt-4"> -->
								<div class="row">
									<div class="col-lg-12">
										<div class="card-style">
											<h6 class="mb-10">결재대기문서</h6>
											<div class="table-wrapper table-responsive">
												<table class="table striped-table">
													<thead>
														<tr>
															<!-- select박스 -->
															<th></th>
															<th class="text-center">
																<h6 class="fw-bolder">기안일</h6>
															</th>
															<th class="text-center">
																<h6 class="fw-bolder">제목</h6>
															</th>
															<th class="text-center">
																<h6 class="fw-bolder">기안부서</h6>
															</th>
															<th class="text-center">
																<h6 class="fw-bolder">기안자</h6>
															</th>
															<th class="text-center">
																<h6 class="fw-bolder">첨부</h6>
															</th>
															<th class="text-center">
																<h6 class="fw-bolder">결재상태</h6>
															</th>
														</tr>
													</thead>
													<c:forEach var="atrzVO" items="${atrzVOList}">
														<tbody>
															<tr>
																<td class="text-center"
																	style="padding-top: 10px; padding-bottom: 10px;">
																	<div class="check-input-primary">
																		<input class="form-check-input" type="checkbox"
																			id="checkbox-1">
																	</div>
																</td>
																<td class="text-center" style="padding-top: 0px;">
																	<!--글씨체 두껍게 b태그 사용하기-->
																	<p class="text-sm fw-bolder">${fn:substring(atrzVO.atrzDocNo, 2, 12)}</p>
																</td>
																<td class="text-center" style="padding-top: 0px;">
																	<a href="#" class="fw-bolder">${atrzVO.atrzSj}</a>
																</td>
																<td class="text-center" style="padding-top: 0px;">
																	<p class="fw-bolder">인사부</p>
																</td>
																<td class="text-center" style="padding-top: 0px;">
																	<p class="fw-bolder">김은대</p>
																</td>
																<td class="text-center" style="padding-top: 0px;">
																	<p>
																		<span class="material-symbols-outlined">
																			attach_file </span>
																	</p>
																</td>
																<td class="text-center" style="padding-top: 0px;">
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
																</td>
															</tr>
														</tbody>
													</c:forEach>
												</table>
											</div>
										</div>
									</div>
								</div>
								<!-- </div> -->
								<!--기안진행 문서 끝-->
								<!-- 기안 완료 문서 시작 -->
							</div>
						</div>
					</div>
					<!-- 컨텐츠1 끝 -->

					<!-- 컨텐츠2(결재대기문서) 시작 -->
					<div class="tab-content" id="myTabContent">
						<div class="tab-pane fade" id="contact2-tab-pane" role="tabpanel"
							aria-labelledby="contact2-tab" tabindex="0">
							<div class="atrzTabCont">
								<!--참조대기문서 시작-->
								<div class="row">
									<div class="col-lg-12">
										<div class="card-style">
											<h6 class="mb-10">참조대기문서</h6>
											<div class="table-wrapper table-responsive">
												<table class="table striped-table">
													<thead>
														<tr>
															<th class="text-center">
																<h6 class="fw-bolder">기안일</h6>
															</th>
															<th class="text-center">
																<h6 class="fw-bolder">제목</h6>
															</th>
															<th class="text-center">
																<h6 class="fw-bolder">기안부서</h6>
															</th>
															<th class="text-center">
																<h6 class="fw-bolder">기안자</h6>
															</th>
															<th class="text-center">
																<h6 class="fw-bolder">첨부파일</h6>
															</th>
															<th class="text-center">
																<h6 class="fw-bolder">결재상태</h6>
															</th>
														</tr>
													</thead>
													<c:forEach var="atrzVO" items="${atrzVOList}">
														<tbody>
															<tr>
																<td class="text-center"
																	style="padding-top: 10px; padding-bottom: 10px;">
																	<p class="text-sm fw-bolder">${fn:substring(atrzVO.atrzDocNo, 2, 12)}</p>
																</td>
																<td class="text-center" style="padding-top: 0px;">
																	<a href="#" class="text-sm fw-bolder">${atrzVO.atrzSj}</a>
																</td>
																<td class="text-center" style="padding-top: 0px;">
																	<p class="text-sm fw-bolder">기안부서</p>
																</td>
																<td class="text-center" style="padding-top: 0px;">
																	<p class="text-sm fw-bolder">기안자</p>
																</td>
																<td class="text-center" style="padding-top: 0px;">
																	<p class="text-sm fw-bolder">
																		<span class="material-symbols-outlined">
																			attach_file </span>
																	</p>
																</td>
																<td class="text-center" style="padding-top: 0px;">
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
								<!--참조대기문서 끝-->
							</div>
						</div>
					</div>
					<!-- 컨텐츠2 끝 -->
					<!-- 컨텐츠3(결재예정문서) 시작 -->
					<div class="tab-content" id="myTabContent">
						<div class="tab-pane fade" id="contact3-tab-pane" role="tabpanel"
							aria-labelledby="contact3-tab" tabindex="0">
							<div class="atrzTabCont">
								<!--결재예정문서 시작-->
								<div class="row">
									<div class="col-lg-12">
										<div class="card-style">
											<h6 class="mb-10">결재예정문서</h6>
											<div class="table-wrapper table-responsive">
												<table class="table striped-table">
													<thead>
														<tr>
															<th class="text-center">
																<h6 class="fw-bolder">기안일</h6>
															</th>
															<th class="text-center">
																<h6 class="fw-bolder">결재양식</h6>
															</th>
															<th class="text-center">
																<h6 class="fw-bolder">제목</h6>
															</th>
															<th class="text-center">
																<h6 class="fw-bolder">기안자</h6>
															</th>
															<th class="text-center">
																<h6 class="fw-bolder">첨부파일</h6>
															</th>
														</tr>
													</thead>
													<c:forEach var="atrzVO" items="${atrzVOList}">
														<tbody>
															<tr>
																<td class="text-center"
																	style="padding-top: 10px; padding-bottom: 10px;">
																	<p class="text-sm fw-bolder">${fn:substring(atrzVO.atrzDocNo, 2, 12)}</p>
																</td>
																<td class="text-center" style="padding-top: 0px;">
																	<p class="text-sm fw-bolder">결재양식</p>
																</td>
																<td class="text-center" style="padding-top: 0px;">
																	<a href="#" class="text-sm fw-bolder">${atrzVO.atrzSj}</a>
																</td>
																<td class="text-center" style="padding-top: 0px;">
																	<p class="text-sm fw-bolder">기안자</p>
																</td>
																<td class="text-center" style="padding-top: 0px;">
																	<p class="text-sm fw-bolder">
																		<span class="material-symbols-outlined">
																			attach_file </span>
																	</p>
																</td>
															</tr>
														</tbody>
													</c:forEach>
												</table>
											</div>
										</div>
									</div>
								</div>
								<!--결재예정문서 끝-->
							</div>
						</div>
					</div>
					<!-- 컨텐츠3(결재예정문서) 끝 -->
				</div>
			</div>
			<!-- 여기서 작업 끝 -->
			<!-- 여기서 작업끝 -->
		</div>
	</section>
  <%@ include file="../layout/footer.jsp" %>
</main>
<%@ include file="../layout/prescript.jsp" %>
<!-- jquery 사용시 여기 이후 작성하기 -->
<c:import url="./newAtrzDocModal.jsp" />
</body>
</html>
