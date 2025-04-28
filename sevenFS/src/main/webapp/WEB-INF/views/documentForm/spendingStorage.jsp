<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="메인" />

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="ie=edge" />
<style type="text/css">
#s_eap_draft_info tr th {
	width: 100px;
}

#s_eap_draft_info tr th, #s_eap_draft_info tr td,
#s_eap_draft tr th, #s_eap_draft tr td,
.s_eap_draft_app tr th, .s_eap_draft_app tr td
 {
	padding: 5px;
	border: 1px solid;
	font-size: .9em;
	font-weight: bold;
}
#s_eap_draft_info tr th,
#s_eap_draft tr th,
.s_eap_draft_app tr th {
	background-color: gainsboro;
	text-align: center;
	
}
	#s_eap_draft td, .s_eap_draft_app td {
	width: 100px;
	text-align: center;
}
/* sweetalert스타일 */
/*모달창  */
.swal-modal {
	background-color: white;
	border: 3px solid white;
}
/*ok버튼  */
.swal-button--danger {
	background-color: #0583F2;
	color: white;
}
/*cancel버튼  */
.swal-button--cancel {
	background-color: red;
	color: white;
}
/*ok버튼  */
.swal-button--confirm {
	background-color: #0583F2;
	color: white;
}
/*아이콘 테두리  */
.swal-icon--info {
	border-color: #0583F2;
}
/*아이콘 i 윗부분  */
.swal-icon--info:after {
	background-color: #0583F2;
}
/*아이콘 i 아랫부분  */
.swal-icon--info:before {
	background-color: #0583F2;
}
/*타이틀  */
.swal-title {
	font-size: 20px;
	color: black;
}
/*텍스트  */
.swal-text {
	color: black;
}
/* datepicker css */
.ui-widget-header {
	border: 0px solid #dddddd;
	background: #fff;
}

.ui-datepicker-calendar>thead>tr>th {
	font-size: 14px !important;
}

.ui-datepicker .ui-datepicker-header {
	position: relative;
	padding: 10px 0;
}

.ui-state-default, .ui-widget-content .ui-state-default,
	.ui-widget-header .ui-state-default, .ui-button, html .ui-button.ui-state-disabled:hover,
	html .ui-button.ui-state-disabled:active {
	border: 0px solid #c5c5c5;
	background-color: transparent;
	font-weight: normal;
	color: #454545;
	text-align: center;
}

.ui-datepicker .ui-datepicker-title {
	margin: 0 0em;
	line-height: 16px;
	text-align: center;
	font-size: 14px;
	padding: 0px;
	font-weight: bold;
}

.ui-datepicker {
	display: none;
	background-color: #fff;
	border-radius: 4px;
	margin-top: 10px;
	margin-left: 0px;
	margin-right: 0px;
	padding: 20px;
	padding-bottom: 10px;
	width: 300px;
	box-shadow: 10px 10px 40px rgba(0, 0, 0, 0.1);
	padding-top: 10px;
	
}

.ui-widget.ui-widget-content {
	border: 1px solid #eee;
}

#datepicker:focus>.ui-datepicker {
	display: block;
}

.ui-datepicker-prev, .ui-datepicker-next {
	cursor: pointer;
}

.ui-datepicker-next {
	float: right;
}

.ui-state-disabled {
	cursor: auto;
	color: hsla(0, 0%, 80%, 1);
}

.ui-datepicker-title {
	text-align: center;
	padding: 10px;
	font-weight: 100;
	font-size: 20px;
}

.ui-datepicker-calendar {
	width: 100%;
}

.ui-datepicker-calendar>thead>tr>th {
	padding: 5px;
	font-size: 20px;
	font-weight: 400;
}

.ui-datepicker-calendar>tbody>tr>td>a {
	color: #000;
	font-size: 12px !important;
	font-weight: bold !important;
	text-decoration: none;
}

.ui-datepicker-calendar>tbody>tr>.ui-state-disabled:hover {
	cursor: auto;
	background-color: #fff;
}

.ui-datepicker-calendar>tbody>tr>td {
	border-radius: 100%;
	width: 44px;
	height: 30px;
	cursor: pointer;
	padding: 5px;
	font-weight: 100;
	text-align: center;
	font-size: 12px;
}

.ui-datepicker-calendar>tbody>tr>td:hover {
	background-color: transparent;
	opacity: 0.6;
}

.ui-state-hover, .ui-widget-content .ui-state-hover, .ui-widget-header .ui-state-hover,
	.ui-state-focus, .ui-widget-content .ui-state-focus, .ui-widget-header .ui-state-focus,
	.ui-button:hover, .ui-button:focus {
	border: 0px solid #cccccc;
	background-color: transparent;
	font-weight: normal;
	color: #2b2b2b;
}

.ui-widget-header .ui-icon {
	background-image: url('https://media.discordapp.net/attachments/692994434526085184/995979886768439306/btns.png');
}

.ui-icon-circle-triangle-e {
	background-position: -20px 0px;
	background-size: 36px;
}

.ui-icon-circle-triangle-w {
	background-position: -0px -0px;
	background-size: 36px;
}

.ui-datepicker-calendar>tbody>tr>td:first-child a {
	color: red !important;
}

.ui-datepicker-calendar>tbody>tr>td:last-child a {
	color: #0099ff !important;
}

.ui-datepicker-calendar>thead>tr>th:first-child {
	color: red !important;
}

.ui-datepicker-calendar>thead>tr>th:last-child {
	color: #0099ff !important;
}

.ui-state-highlight, .ui-widget-content .ui-state-highlight,
.ui-widget-header .ui-state-highlight {
	border: 0px;
	background: rgb(255, 192, 203);
	border-radius: 50%;
	padding-top: 10px;
	padding-bottom: 10px;
	width: 30px;
}

.inp {
	padding: 10px 10px;
	background-color: #f1f1f1;
	border-radius: 4px;
	border: 0px;
}

.inp:focus {
	outline: none;
	background-color: #eee;
}

select.ui-datepicker-month {
	border-radius: 5px;
	padding: 5px;
	width: 80px !important;
}

select.ui-datepicker-year {
	border-radius: 5px;
	padding: 5px;
	margin-left: 10px !important;
	width: 80px !important;
}

.ui-datepicker .ui-datepicker-prev, .ui-datepicker .ui-datepicker-next {
	top: 9px !important;
}
/* 달력이전다음버튼 변경하는 클래스 */
/* input, select에 여백 주기 */
.s_default_tbody_cl td > .form-control,
.s_default_tbody_cl th > .form-control,
.s_default_tbody_cl td > .form-select {
margin-bottom: 8px !important;
}

/* 셀 내부 여백 주기 */
.s_default_tbody_cl td,
.s_default_tbody_cl th {
padding: 10px !important;
}
.s_sp_date {
	text-align: center;
}



</style>
<title>${title}</title>
<%@ include file="../layout/prestyle.jsp"%>
</head>
<body>
	<sec:authentication property="principal.empVO" var="empVO" />
	<%@ include file="../layout/sidebar.jsp"%>
	<main class="main-wrapper">
		<%@ include file="../layout/header.jsp"%>
		<section class="section">
		<form id="atrz_sp_form" action="/atrz/insertAtrzLine" method="post" enctype="multipart/form-data">
			<div class="container-fluid">
				<!-- 여기서 작업 시작 -->
				<!-- <p>${attachFileVOList}</p> -->
				<div class="row">
					<div class="col-sm-12 mb-3 mb-sm-0">
						<!-- 결재요청 | 임시저장 | 결재선지정 | 취소  -->
						<div class="col card-body" id="approvalBtn">
							<!-- 새로운 버튼 -->
							<div class="tool_bar">
								
								<div class="critical d-flex gap-2 mb-3">
									<!--성진스 버튼-->
									<button id="s_eap_app_top" type="button" 
										class="btn btn-outline-primary d-flex align-items-center gap-1 s_eap_app"
										style="padding: 0.4rem 1rem; font-size: 0.95rem;">
										<span class="material-symbols-outlined fs-5">upload</span> 결재요청
									</button>
									<a id="s_eap_storTo" type="button" 
										class="btn btn-outline-success d-flex align-items-center gap-1 s_eap_stor"
										style="padding: 0.4rem 1rem; font-size: 0.95rem;"> 
										<span class="material-symbols-outlined fs-5">downloading</span> 임시저장
									</a> <a id="s_appLine_btn" type="button"
										class="btn btn-outline-info d-flex align-items-center gap-1"
										data-bs-toggle="modal" data-bs-target="#atrzLineModal"
										style="padding: 0.4rem 1rem; font-size: 0.95rem;"> 
										<span class="material-symbols-outlined fs-5">error</span> 결재선 지정
									</a> 
									<a type="button" class="btn btn-outline-danger d-flex align-items-center gap-1"
										href="/atrz/home" style="padding: 0.4rem 1rem; font-size: 0.95rem;"> 
										<span class="material-symbols-outlined fs-5">cancel</span> 취소
									</a>
								</div>
							</div>

							<!-- 새로운 버튼 -->
						</div>
						<!-- 모달창 인포트 -->
						<c:import url="../documentForm/approvalLineModal.jsp" />
							<div class="card">
								<div class="card-body">
									<!-- 여기다가 작성해주세요(준희) -->
									<!-- 기능 시작 -->
									<!-- 전자결재 양식 수정도 가능 시작 -->
									<p>${atrzVO}</p>
									<div id="s_eap_content_box_left" class="s_scroll">
										<div class="s_div_container s_scroll">
											<div style="text-align: center; font-size: 2em; font-weight: bold; padding: 20px;">지출결의서</div>
											<div style="float: left; width: 230px; margin: 0 30px;">
												<table border="1" id="s_eap_draft_info" class="text-center">
													<tr>
														<!-- 기안자 정보가져오기 -->
<%-- 													<p>${empVO}</p>  --%>
														<th>기안자</th>
														<td>${empVO.emplNm}</td>
													</tr>
													<tr>
														<th>기안부서</th>
														<td>${empVO.deptNm}</td>
													</tr>
													<tr>
														<!-- 기안일 출력을 위한 것 -->
														<jsp:useBean id="now" class="java.util.Date" />
														<fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm:ss" var="today" />
														<th>기안일</th>
														<td>
															<c:out value="${today}"/>
														</td>
													</tr>
													<tr>
														<th>문서번호</th>
														<td id="s_dfNo">${atrzVO.atrzDocNo}</td>
													</tr>
												</table>
											</div>

											<div style="float: left; width: 130px; margin-right: 10px;">
												<table border="1" id="s_eap_draft">
													<tr>
														<th rowspan="2">신청</th>
														<td>${empVO.clsfCodeNm}</td>
													</tr>
													<tr>
														<td>${empVO.emplNm}</td>
													</tr>
												</table>
											</div>


											<div style="float: right; margin-right: 20px;" id="s_eap_draft_app">
												<table border="1" class="s_eap_draft_app">
													<tbody>
														<!-- 결재자: atrzTy = 'N' -->
														<tr id="trAtrzLine" class="trAtrzLine">
															<th rowspan="3">결재</th>
															<c:forEach var="atrzLineVO" items="${atrzVO.atrzLineVOList}">
																<c:if test="${atrzLineVO.atrzTy eq '1'}">
																	<!-- <p>${atrzLineVO}</p> -->
																	<td data-atrz-ln-sn="${atrzLineVO.atrzLnSn}" data-sanctner-empno="${atrzLineVO.sanctnerEmpno}"
																		data-atrz-ty="${atrzLineVO.atrzTy}" data-dcrb-author-yn="${atrzLineVO.dcrbAuthorYn}"
																		data-sanctner-clsf-code="${atrzLineVO.sanctnerClsfCode}">${atrzLineVO.sanctnerClsfNm}</td>
																</c:if>
															</c:forEach>
														</tr>
														<tr>
															<c:forEach var="atrzLineVO" items="${atrzVO.atrzLineVOList}">
																<c:if test="${atrzLineVO.atrzTy eq '1'}">
																	<td style="text-align: center;">
																		<c:choose>
																			<c:when test="${atrzLineVO.sanctnProgrsSttusCode eq '10'}">
																				<img src="/assets/images/atrz/afterRe.png" style="width: 50px; display: block; margin: 0 auto;">
																			</c:when>
																			<c:when test="${atrzLineVO.sanctnProgrsSttusCode eq '20'}">
																				<img src="/assets/images/atrz/return.png" style="width: 50px; display: block; margin: 0 auto;">
																			</c:when>
																			<c:when test="${atrzLineVO.sanctnProgrsSttusCode eq '30'}">
																				<img src="/assets/images/atrz/cancel.png" style="width: 50px; display: block; margin: 0 auto;">
																			</c:when>
																			<c:otherwise>
																				<img src="/assets/images/atrz/before.png" style="width: 50px; display: block; margin: 0 auto;">
																			</c:otherwise>
																		</c:choose>
																		<span style="display: block; margin-top: 5px;">${atrzLineVO.sanctnerEmpNm}</span>
																		<input type="hidden" name="atrzLnSn" id="s_dfNo" value="${atrzLineVO.atrzLnSn}" />
																		<input type="hidden" name="sanctnerEmpno" value="${atrzLineVO.sanctnerEmpno}" />
																		<input type="hidden" name="atrzDocNo" value="${atrzLineVO.atrzDocNo}" />
																	</td>
																</c:if>
															</c:forEach>
														</tr>
														<tr style="height: 30px;">
															<c:forEach var="atrzLineVO" items="${atrzVO.atrzLineVOList}">
																<c:if test="${atrzLineVO.atrzTy eq '1'}">
																	<td style="font-size: 0.8em;">
																		<c:choose>
																			<c:when test="${atrzLineVO.sanctnProgrsSttusCode eq '20'}">
																				<span style="color: red;">
																					<fmt:formatDate value="${atrzLineVO.sanctnConfmDt}" pattern="yyyy-MM-dd" />
																				</span>
																			</c:when>
																			<c:when test="${atrzLineVO.sanctnProgrsSttusCode eq '30'}">
																				<span style="display: block; width: 100%; height: 1px; background-color: gray; transform: rotate(-15deg); margin: 10px auto;"></span>
																			</c:when>
																			<c:otherwise>
																				<span style="color: black;">
																					<fmt:formatDate value="${atrzLineVO.sanctnConfmDt}" pattern="yyyy-MM-dd" />
																				</span>
																			</c:otherwise>
																		</c:choose>
																	</td>
																</c:if>
															</c:forEach>
														</tr>

												
														<!-- 참조자: atrzTy = 'Y' -->
														<c:set var="hasReference" value="false" />
														<c:forEach var="atrzLineVO" items="${atrzVO.atrzLineVOList}">
															<c:if test="${atrzLineVO.atrzTy eq '0'}">
																<c:set var="hasReference" value="true" />
															</c:if>
														</c:forEach>
												
														<c:if test="${hasReference eq true}">
															<tr class="trAtrzLine">
																<th rowspan="2">참조</th>
																<c:forEach var="atrzLineVO" items="${atrzVO.atrzLineVOList}">
																	<c:if test="${atrzLineVO.atrzTy eq '0'}">
																		<td data-atrz-ln-sn="${atrzLineVO.atrzLnSn}" data-sanctner-empno="${atrzLineVO.sanctnerEmpno}"
																		data-atrz-ty="${atrzLineVO.atrzTy}" data-dcrb-author-yn="${atrzLineVO.dcrbAuthorYn}"
																		data-sanctner-clsf-code="${atrzLineVO.sanctnerClsfCode}">${atrzLineVO.sanctnerClsfNm}</td>
																	</c:if>
																</c:forEach>
															</tr>
															<tr>
																<c:forEach var="atrzLineVO" items="${atrzVO.atrzLineVOList}">
																	<c:if test="${atrzLineVO.atrzTy eq '0'}">
																		<td>
																			${atrzLineVO.sanctnerEmpNm}
																			<input type="hidden" name="atrzLnSn" value="${atrzLineVO.atrzLnSn}" />
																			<input type="hidden" name="sanctnerEmpno" value="${atrzLineVO.sanctnerEmpno}" />
																		</td>
																	</c:if>
																</c:forEach>
															</tr>
														</c:if>
													</tbody>
												</table>
											</div>

											<div style="padding: 50px 10px 20px; clear: both;">
												<div style="display: inline-block; font-size: 1.2em; font-weight: bold;">제목
													:</div>
												<input type="text" class="form-control" value="${atrzVO.atrzSj}" 
													style="display: inline-block; width: 90%; margin-left: 5px;" 
													id="s_sp_tt" name="atrzSj">
											</div>

											<div style="border: 1px solid lightgray; margin: 10px;"></div>
											<div style="margin: 0 10px;">

												<div style="padding: 10px 0;">
													<div class="s_frm_title mb-2"><b>지출 내용</b></div>
													<textarea class="form-control"
														style="resize: none; height: 150px;" id="s_sp_co" name="atrzCn" 
														required="required" rows="2" cols="20" wrap="hard">${atrzVO.atrzCn}</textarea>
												</div>

												<div style="padding: 10px 0;">
													<div class="s_frm_title"><b>지출 내역</b></div>
													<table class="table" style="text-align: center;">
														<thead>
															<tr>
																<th scope="col" style="width: 130px;">날짜</th>
																<th scope="col" style="width: 300px;">내역</th>
																<th scope="col" style="width: 70px;">수량</th>
																<th scope="col" style="width: 150px;">금액</th>
																<th scope="col" style="width: 130px;">결제수단</th>
															</tr>
														</thead>
														<tbody id="s_default_tbody" class="s_default_tbody_cl">
															<tr>
																<th scope="row">
																	<input type="text" class="form-control s_sp_date " id="s_sp_date" onkeyup="checkDateFormat(this)"
																	name="expenseDate" value="${atrzVO.spendingVO.expenseDate}"
																	style="cursor: context-menu;" >
																</th>
																<td>
																	<input type="text" placeholder="지출내역을 작성해주세요" value="${atrzVO.spendingVO.itemDescription}"
																	class="form-control s_sp_detail" name="itemDescription" >
																</td>
																<td>
																	<input type="text" id="sp_count" value="${atrzVO.spendingVO.itemQuantity}"
																	class="form-control s_sp_count" name="itemQuantity" 
																	onblur="total()" placeholder="수량입력" onkeyup="commas(this)">
																</td>
																	<!-- oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" -->
																<td>
																	<input type="text" placeholder="금액입력" value="${atrzVO.spendingVO.itemAmount}"
																	class="form-control s_sp_amount" id="sp_amount" 
																	name="itemAmount" onkeyup="commas(this)" onblur="total()">
																</td>
																<td>
																	<select class="form-select s_select" aria-label="Default select example" >
																		<option value="C" <c:if test="${atrzVO.spendingVO.paymentMethod eq 'C'}">checked</c:if>>신용카드</option>
																		<option value="A" <c:if test="${atrzVO.spendingVO.paymentMethod eq 'A'}">checked</c:if>>가상계좌</option>
																</select></td>
															</tr>

														</tbody>
														<tfoot>
															<tr>
																<th colspan="3">합계</th>
																<td colspan="2">\ <span id="s_total_price"></span>
																	(VAT포함)
																</td>
															</tr>
														</tfoot>
													</table>
													<!-- <button type="button" id="s_add_sp_detail" class="btn btn-success" onclick="addTr()">내역 추가</button> -->
												</div>
												<%--첨부파일 구성하기--%>
												<div class="mb-3">
													<form action="/fileUpload" method="post" enctype="multipart/form-data">
														<file-upload
																label="첨부파일"
																name="uploadFile"
																max-files="1"
																contextPath="${pageContext.request.contextPath }"
																uploaded-file="${attachFileVOList}"
																atch-file-no="${atrzVO.atchFileNo}"
														></file-upload>
													</form>
												</div>
											</div>
											</div>
										</div>
									</div>
									
									<!-- 전자결재 양식 수정도 가능 끝 -->
									<!-- 기능 끝 -->
									<!-- 여기다가 작성해주세요(준희) -->
								</div>
							</div>
							<!-- 상하 버튼 추가 -->
							<div class="tool_bar">
								<div class="critical d-flex gap-2 mt-3">
									<!--성진스 버튼-->
									<button id="s_eap_app_bottom" type="button" 
										class="btn btn-outline-primary d-flex align-items-center gap-1 s_eap_app"
										style="padding: 0.4rem 1rem; font-size: 0.95rem;">
										<span class="material-symbols-outlined fs-5">upload</span> 결재요청
									</button>
									<a id="s_eap_storBo" type="button" 
										class="btn btn-outline-success d-flex align-items-center gap-1 s_eap_stor"
										style="padding: 0.4rem 1rem; font-size: 0.95rem;"> 
										<span class="material-symbols-outlined fs-5">downloading</span> 임시저장
									</a> 
									<a id="s_appLine_btn" type="button"
										class="btn btn-outline-info d-flex align-items-center gap-1"
										data-bs-toggle="modal" data-bs-target="#atrzLineModal"
										style="padding: 0.4rem 1rem; font-size: 0.95rem;"> 
										<span class="material-symbols-outlined fs-5">error</span> 결재선 지정
									</a> 
									<a type="button" class="btn btn-outline-danger d-flex align-items-center gap-1"
										href="/atrz/home" style="padding: 0.4rem 1rem; font-size: 0.95rem;"> 
										<span class="material-symbols-outlined fs-5">cancel</span> 취소
									</a>
								</div>
							</div>
						<!-- 상하 버튼 추가 -->
						</form>
					</div>
				</div>
				<!-- 여기서 작업 끝 -->
			</div>
		</form>
		</section>
		<%@ include file="../layout/footer.jsp"%>
	</main>
	<%@ include file="../layout/prescript.jsp"%>
	<!-- 제이쿼리사용시 여기다 인포트 -->



<script>
	//제목 너무 길게 입력하면 입력초과 스왈
	document.getElementById('s_sp_tt').addEventListener('input', function (event) {
			const maxLength = 60; // 최대 길이 설정
			const inputField = this;
			const inputValue = inputField.value;
	
			// 입력값이 최대 길이를 초과할 경우
			if (inputValue.length > maxLength) {
				swal({
					title: "입력 초과",
					text: "제목은 최대 60자까지 입력 가능합니다.",
					icon: "warning",
					button: "확인"
				}).then(() => {
					// 초과된 부분을 잘라내기
					inputField.value = inputValue.substring(0, maxLength);
				});
	
				// 입력 처리를 중단
				event.preventDefault();
				return;
			}
		});
	//내역추가
	function addTr() {
		$(".s_default_tbody_cl").append(
			'<tr>'
				+ '<th scope="row"><input type="date" class="form-control s_sp_date" id="s_sp_date" name="sp_date"></th>'
				+ '<td><input type="text" class="form-control s_sp_detail" name="sp_detail"></td>'
				+ '<td><input type="number" id="sp_count" class="form-control s_sp_count" name="sp_count" onblur="total()"></td>'
				+ '<td><input type="text" class="form-control s_sp_amount" id="sp_amount" name="sp_amount" onkeyup="commas(this)" onblur="total()"></td>'
				+ '<td>'
				+ '<select class="form-select s_select" aria-label="Default select example">'
					+ '<option value="C">신용카드</option>'
					+ '<option value="A">가상계좌</option>'
				+ '</select>'
				+ '</td>'
			+ '</tr>'	
		);
	}
	
	
	
	
	
	
	// 합계 구하기
	function total() {
		var spCnt = 0;
		var spAmount = 0;
		var total = 0;
		var sum = 0;
		// const number;
		for(var i = 0; i < $('.s_sp_count').length; i++) {
			spCnt = $(".s_sp_count").eq(i).val();
			spAmount = $(".s_sp_amount").eq(i).val();
			
			spAmount = spAmount.replace(/,/g, "");
			total = Number(spCnt * spAmount);
			
			sum += total;
		}
		
		$("#s_total_price").text(sum);
		
		var total1 = $("#s_total_price").text();
		var total2 = total1.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		$('#s_total_price').text(total2);
	};
	
	function commas(t) {
	
	// 콤마 빼고 
	var x = t.value;			
	x = x.replace(/,/gi, '');
	
	// 숫자 정규식 확인
	var regexp = /^[0-9]*$/;
	if(!regexp.test(x)){ 
		$(t).val(""); 
		swal({
				title: "숫자만 입력 가능합니다.",
				text: "",
				icon: "error",
				closeOnClickOutside: false,
				closeOnEsc: false
			});
	} else {
		x = x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");			
		$(t).val(x);			
	}
	}
	
	//날짜 정규식 확인
		function checkDateFormat(t) {
		var x = t.value.trim();
	
		// 날짜 정규식 (YYYY-MM-DD)
		var regexp = /^[0-9\-]*$/;
	
		if (!regexp.test(x)) {
			$(t).val(""); // 잘못된 입력 제거
	
			swal({
			title: "숫자와 '-'만 입력 가능합니다.",
			text: "날짜는 YYYY-MM-DD 형식으로 입력해주세요.",
			icon: "error",
			closeOnClickOutside: false,
			closeOnEsc: false
			});
			return;
		}
	
		// 입력이 10자리 되었을 때 형식까지 검사
		if (x.length === 10 && !/^\d{4}-\d{2}-\d{2}$/.test(x)) {
			$(t).val("");
	
			swal({
			title: "날짜 형식 오류",
			text: "날짜는 YYYY-MM-DD 형식으로 입력해주세요.",
			icon: "error",
			closeOnClickOutside: false,
			closeOnEsc: false
			});
		}
		}
	</script>
	<script>
	
	//JSON Object List
	let authList = [];
	$(document).ready(function() {
		//******* 폼 전송 *******
		$(".s_eap_app").on("click",function(){
			event.preventDefault();
			//보고 가져온것 시작
			var sp_date = "";
			var sp_detail = "";
			var sp_count = 0;
			var sp_amount = 0;
			var sp_pay_code = "";
			
			// 제목, 내용이 비어있을 때
			if($('#s_sp_tt').val() == "" || $('#s_sp_co').val() == "") {
				swal({
						title: "제목 또는 내용이 비어있습니다.",
						text: "다시 확인해주세요.",
						icon: "error",
						closeOnClickOutside: false,
						closeOnEsc: false
					});
				return;
			}
			
			// 지출 내역이 비어있을 때
			if($('.s_sp_date').val() == "" || $('.s_sp_detail').val() == "" || $('.s_sp_count').val() == "" || $('.s_sp_amount').val() == "") {
				swal({
						title: "지출 내역을 다시 확인하여 입력해주세요.",
						text: "",
						icon: "error",
						closeOnClickOutside: false,
						closeOnEsc: false
					});
				return;
			}
			
			// 지출 날짜가 'YYYY-MM-DD'형태로 입력이 되지 않았을 때
			if($('.s_sp_date').val().length != 10) {
				swal({
						title: "날짜를 'YYYY-MM-DD'형태로 입력해주세요.",
						text: "",
						icon: "error",
						closeOnClickOutside: false,
						closeOnEsc: false
					});
				return;
			}
			
			var eap_content = $('#s_sp_co').val();
	
			
			// textarea에 \r \n같은 문자를 <br>로 바꿔주기
			eap_content = eap_content.replace(/(?:\r\n|\r|\n)/g,'<br/>');
			
			
			//보고 가져온것 끝
			
			let jnForm = document.querySelector("#atrz_sp_form");
			// console.log("${empVO}" + empVO);
			let formData = new FormData();
			formData.append("docFormNm","S");
			formData.append("docFormNo",2);
			formData.append("atrzSj",jnForm.atrzSj.value);
			formData.append("atrzCn",jnForm.atrzCn.value);
      
      		document.querySelectorAll("input[name='removeFileId']").forEach(element => {
				formData.append("removeFileId", element.value);
			});
   
			if(jnForm.uploadFile.files.length){
				for(let i=0; i< jnForm.uploadFile.files.length; i++)
				formData.append("uploadFile",jnForm.uploadFile.files[i]);
			}
	
			let atrzLineList = [];
			for(let i=0; i< authList.length; i++){
				let auth = authList[i];
				let atrzLine = {
					atrzLnSn: auth.atrzLnSn ,
					sanctnerEmpno: auth.emplNo,
					atrzTy: auth.auth,
					dcrbAuthorYn: auth.flex,
					sanctnerClsfCode: auth.clsfCode,
				}
				atrzLineList.push(atrzLine);			
			}
			console.log("atrzLineList",atrzLineList);
	
			let docSpending = {
					expenseDate: $('.s_sp_date').val(),
					itemDescription: $('.s_sp_detail').val(),
					itemQuantity: $('.s_sp_count').val(),
					itemAmount: $('.s_sp_amount').val(),
					paymentMethod: $('.s_select').val()
				};
	
			formData.append("docSpending",new Blob([JSON.stringify(docSpending)],{type:"application/json"}));
	
	
			formData.append("atrzLineList",new Blob([JSON.stringify(atrzLineList)],{type:"application/json"}));
	
			formData.append("emplNo",secEmplNo);
			formData.append("emplNm",secEmplNm);
			formData.append("atrzDocNo",$("#s_dfNo").text());
	
			console.log("전송하기 체킁 확인");
			console.log("s_eap_app_bottom->formData : ", formData);
		
			const junyError = (request, status, error) => {
						console.log("code: " + request.status)
						console.log("message: " + request.responseText)
						console.log("error: " + error);
				}
	
			$.ajax({
				url:"/atrz/atrzSpendingInsert",
				processData:false,
				contentType:false,
				type:"post",
				data: formData,
				dataType:"text",
				success : function(result){
					console.log("체킁:",result);
					if(result=="쭈니성공"){
						//location.href = "컨트롤러주소";  //  .href 브라우져 성능 향상을 위해서 캐쉬가 적용 될 수도 있고, 안 될 수도 있어
						swal({
							title: "결재요청이 완료되었습니다.",
							text: "",
							icon: "success",
							closeOnClickOutside: false,
							closeOnEsc: false,
							button: "확인"
						}).then(() => {
							location.replace("/atrz/home")
						});
					}
				},
				error: junyError
			})
		});
	
	
	
	
		
	
		//임시저장 클릭시 
		$(".s_eap_stor").on("click",function(){
			event.preventDefault();
			// alert("체킁");
			console.log("전송하기 체킁 확인");
			console.log("s_eap_app_bottom->authList : ", authList);
			
			// 제목, 내용이 비어있을 때
			if($('#s_sp_tt').val() == "" || $('#s_sp_co').val() == "") {
				swal({
						title: "제목 또는 내용이 비어있습니다.",
						text: "다시 확인해주세요.",
						icon: "error",
						closeOnClickOutside: false,
						closeOnEsc: false
					});
				return;
			}
			
			// 지출 내역이 비어있을 때
			if($('.s_sp_date').val() == "" || $('.s_sp_detail').val() == "" || $('.s_sp_count').val() == "" || $('.s_sp_amount').val() == "") {
				swal({
						title: "지출 내역을 다시 확인하여 입력해주세요.",
						text: "",
						icon: "error",
						closeOnClickOutside: false,
						closeOnEsc: false
					});
				return;
			}
			
			// 지출 날짜가 'YYYY-MM-DD'형태로 입력이 되지 않았을 때
			if($('.s_sp_date').val().length != 10) {
				swal({
						title: "날짜를 'YYYY-MM-DD'형태로 입력해주세요.",
						text: "",
						icon: "error",
						closeOnClickOutside: false,
						closeOnEsc: false
					});
				return;
			}
			
			var eap_content = $('#s_sp_co').val();
	
			
			// textarea에 \r \n같은 문자를 <br>로 바꿔주기
			eap_content = eap_content.replace(/(?:\r\n|\r|\n)/g,'<br/>');
	
			//formData로 담아주기 위한것
			let jnForm = document.querySelector("#atrz_sp_form");
	
			let formData = new FormData();
			formData.append("docFormNm","S");
			formData.append("docFormNo",2);
			formData.append("atrzSj",jnForm.atrzSj.value);
			formData.append("atrzCn",jnForm.atrzCn.value);
   
			document.querySelectorAll("input[name='removeFileId']").forEach(element => {
				formData.append("removeFileId", element.value);
			});
   
   
			if(jnForm.uploadFile.files.length){
				for(let i=0; i< jnForm.uploadFile.files.length; i++)
				formData.append("uploadFile",jnForm.uploadFile.files[i]);
			}
	
	
			let atrzLineList = [];
				$(".trAtrzLine").children("td").each(function(idx, atrzLine){
				let atrzLine2 = {
					atrzLnSn: $(this).data("atrzLnSn"),
					sanctnerEmpno: $(this).data("sanctnerEmpno"),
					atrzTy: $(this).data("atrzTy"),
					dcrbAuthorYn: $(this).data("dcrbAuthorYn"),
					sanctnerClsfCode:$(this).data("sanctnerClsfCode")
				}
				atrzLineList.push(atrzLine2);	

				formData.append("atrzLineVOList["+idx+"].atrzLnSn",atrzLine2.atrzLnSn);
				formData.append("atrzLineVOList["+idx+"].sanctnerEmpno",atrzLine2.sanctnerEmpno);
				formData.append("atrzLineVOList["+idx+"].atrzTy",atrzLine2.atrzTy);
				formData.append("atrzLineVOList["+idx+"].dcrbAuthorYn",atrzLine2.dcrbAuthorYn);
				formData.append("atrzLineVOList["+idx+"].sanctnerClsfCode",atrzLine2.sanctnerClsfCode);
			});

		document.querySelectorAll("input[name='removeFileId']").forEach(element => {
			formData.append("removeFileId", element.value);
		});

			console.log("atrzLineList",atrzLineList);
	
			let docSpending = {
					expenseDate: $('.s_sp_date').val(),
					itemDescription: $('.s_sp_detail').val(),
					itemQuantity: $('.s_sp_count').val(),
					itemAmount: $('.s_sp_amount').val(),
					paymentMethod: $('.s_select').val()
				};

			console.log("docSpending",docSpending);
			
			formData.append("atrzLineList",new Blob([JSON.stringify(atrzLineList)],{type:"application/json"}));
			formData.append("docSpending",new Blob([JSON.stringify(docSpending)],{type:"application/json"}));
	
			formData.append("emplNo",secEmplNo);
			formData.append("emplNm",secEmplNm);
			formData.append("atrzDocNo",$("#s_dfNo").text());
	
			console.log("전송하기 체킁 확인");
			console.log("s_eap_app_bottom->formData : ", formData);
		
			const junyError = (request, status, error) => {
						console.log("code(ajaxError): " + request.status)
						console.log("message(ajaxError): " + request.responseText)
						console.log("error(ajaxError): " + error);
			}
	
			//지출결의서 임시저장 시작
			$.ajax({
				url:"/atrz/atrzSpendingStorage",
				processData:false,
				contentType:false,
				type:"post",
				data: formData,
				dataType:"text",
				success : function(result){
					console.log("체킁:",result);
					if(result=="임시저장성공"){
						swal({
							title: "임시저장이 완료되었습니다.",
							text: "",
							icon: "success",
							closeOnClickOutside: false,
							closeOnEsc: false,
							button: "확인"
						}).then(() => {
							// location.replace("/atrz/document");
						});
						// alert("왔다");
					}
				},
				error: junyError
			})
			//지출결의서 임시저장 끝
		})
	
	
	
		
		//버튼눌렀을때 작동되게 하기 위해서 변수에 담아준다.
		let emplNo = null;  //선택된 사원 번호 저장
	// 	let secEMPL = '\${customUser.userName}';
	
		let secEmplNo = '${empVO.emplNo}';
		let secEmplNm = '${empVO.emplNm}';
	
		console.log("secEmplNo번호 : ",secEmplNo);
		console.log("secEmplNm이름 : ",secEmplNm);
		
	// 	여기 중호쌤이랑 같이했던거 해보기
		$(document).on("click",".jstree-anchor",function(){
			let idStr = $(this).prop("id");//20250008_anchor
	// 		console.log("개똥이->idStr : ",idStr);
			emplNo = idStr.split("_")[0];//20250008
			console.log("결재선지정->emplNo : ",emplNo);
			
		});//end jstree-anchor
		
		let selectedType = "sign";  // 기본은 결재
	
		$(document).on("click", "#add_appLine", function(){
			selectedType = "sign";  // 결재선
			addAppLine();
		});
	
		$(document).on("click", "#add_attLine", function(){
			selectedType = "ref";  // 참조자
			addAppLine();
		});
	
	
		function addAppLine() {
			console.log("appAppLine->emplNo : ", emplNo);
	
			if(!emplNo){
				swal({ text: "선택한 사원이 없습니다.", icon: "error",	button: "확인" });
			return;
			}
			if(secEmplNo == emplNo){
				swal({ text: "본인은 결재선 리스트에 추가할 수 없습니다.", icon: "error",button: "확인" });
			return;
			}
			for(let i = 0; i< $('.s_td_no').length; i++){
				if($('.s_td_no').eq(i).text() == emplNo){
					swal({ text: "이미 추가된 사원입니다.", icon: "error", button: "확인" });
					return;
				}
			}
	
			//기안자 정보담기
			$.ajax({
				url:"/atrz/insertAtrzEmp",
				data:{"emplNo":emplNo},
				type:"post",
				dataType:"json",
				success:function(result){
					let noLen = $(".clsPo").length;
	
					let selectHtml = `
						<select class="form-select selAuth" aria-label="Default select example">
							<option value="1" \${selectedType == "sign" ? "selected" : ""}>결재</option>
							<option value="0" \${selectedType == "ref" ? "selected" : ""}>참조</option>
						</select>
					`;
	
					// 참조일 때는 checkbox 없이 처리
					let checkboxHtml = "";
					if (selectedType == "sign") {
						checkboxHtml = `
							<input class="form-check-input flexCheckDefault" type="checkbox" value="Y" />
						`;
					}
	
					let strA = `
						<tr class="clsTr" id="row_\${emplNo}" name="emplNm">
							<th>\${noLen+1}</th>
							<th style="display: none;" hidden class="s_td_no">\${result.emplNo}</th>
							<th class="s_td_name">\${result.emplNm}</th>
							<th>\${result.deptNm}</th>
							<th class="clsPo">\${result.posNm}</th>
							<input type="hidden" name="emplNo" class="emplNo" value="\${result.emplNo}"/>
							<input type="hidden" name="clsfCode" class="clsfCode" value="\${result.clsfCode}"/>
							log.info("결재선지정->result : ",result);
							<th hidden>\${selectHtml}</th>
							<th>\${checkboxHtml}</th>
						</tr>
					`;
	
					let strB = `
						<tr class="clsTr" id="row_\${emplNo}" name="emplNm">
							<th></th>
							<th style="display: none;" hidden class="s_td_no">\${result.emplNo}</th>
							<th class="s_td_name">\${result.emplNm}</th>
							<th>\${result.deptNm}</th>
							<th>\${result.posNm}</th>
							<input type="hidden" name="emplNo" class="emplNo" value="\${result.emplNo}"/>
							<input type="hidden" name="clsfCode" class="clsfCode" value="\${result.clsfCode}"/>
							log.info("결재선지정->result : ",result);
							<th hidden>\${selectHtml}</th>
							<th>\${checkboxHtml}</th>
						</tr>
					`;
	
					// ✅ 타입에 따라 위치 다르게 append
					if(selectedType === "sign"){
						$(".s_appLine_tbody_new").append(strA);  // 위쪽 결재선
					}else{
						$(".s_appLine_tbody_ref").append(strB);  // 아래쪽 참조자
					}
				}
			});
		
		}//end addAppLine()
		
		//결재자 리스트 삭제
		$(document).on("click", "#remo_appLine",function(){
			let lastRow = $(".s_appLine_tbody_new .clsTr");   //가장마지막에 추가된 tr
			//삭제대상확인 
			
			if(lastRow.length > 0){
				lastRow.last().remove(); 
				reindexApprovalLines();
					// lastRow.remove();
					// console.log("삭제후 남은 행의갯수 : ",$(".s_appLine_tbody_new .clsTr").length);
					// lastRow.children().last().remove();
				}else{
					swal({
						title: "",
						text: "삭제할 결재자가 없습니다.",
						icon: "error",
						closeOnClickOutside: false,
						closeOnEsc: false,
						button: "확인"
					});
						return;
				}
			});
	
			// 우선 버튼을 누르면 정말로 기안을 취소하시겠습니까라고 알려준다.
			
	$(".atrzLineCancelBtn").on("click", function(event) {
		event.preventDefault();
		swal({
			title: "작성중인 기안을 취소하시겠습니까?",
			text: "취소 후에는 기안이 삭제됩니다.",
			icon: "warning",
			buttons: {
				cancel: "아니요",
				confirm: {
					text: "예",
					value: true,
					className: "atrzLineCancelBtn"
				}
			},
			dangerMode: true,
		}).then((willDelete) => {
			if (willDelete) {
				// 취소 요청을 처리하는 fetch 호출
				fetch('/atrz/deleteAtrzWriting', 
				{
					method: 'POST',
					headers: {
						'Content-Type': 'application/json'
					},
					body: JSON.stringify({ atrzDocNo: $("#s_dfNo").text() }) // 문서 번호를 전송
				})
				.then(res => res.text())  // 👈 여기!
				.then(result => {
				if(result === "success") {
					swal("취소 완료!", "", "success");
						location.replace("/atrz/home")
				} else {
					swal("삭제 실패", "관리자에게 문의하세요", "error");
				}
				});
						}
					});
				});
				//뒤로가기 진행시 기안취소되게 만들기
				let hasDoc = !!$("#s_dfNo").text(); // 문서번호 존재 시만 동작
				let isCanceled = false;
	
				// history state push (현재 상태 저장)
				if (hasDoc) {
					history.pushState(null, document.title, location.href);
				}
	
				window.addEventListener('popstate', function (event) {
					if (hasDoc && !isCanceled) {
					event.preventDefault(); // 뒤로가기 중지
					swal({
						title: "기안을 취소하시겠습니까?",
						text: "지정된 결재선이 삭제됩니다.",
						icon: "warning",
						buttons: ["취소", "확인"],
						dangerMode: true
					}).then((willDelete) => {
						if (willDelete) {
						fetch('/atrz/deleteAtrzWriting', {
							method: 'POST',
							headers: { 'Content-Type': 'application/json' },
							body: JSON.stringify({ atrzDocNo: $("#s_dfNo").text() })
						})
						.then(res => res.text())
						.then(result => {
							if (result === "success") {
							isCanceled = true;
							swal("기안이 취소되었습니다!", "", "success")
								.then(() => {
								history.back(); // 진짜 뒤로가기
								});
							} else {
							swal("기안 취소 실패", "다시 시도해주세요", "error");
							history.pushState(null, document.title, location.href); // 다시 뒤로 못 가게 복원
							}
						});
						} else {
						// 뒤로가기 막기 위해 다시 앞으로 push
						history.pushState(null, document.title, location.href);
						}
					});
					}
				});
	
	
		//전체테이블 순번 다시 매기기
		function reindexApprovalLines() {
			$(".clsTr").each(function(index) {
				$(this).find("th").first().text(index + 1);
			});
		}
	
		//참조자 리스트 삭제
		$(document).on("click", "#remo_attLine", function() {
		let refRows = $(".s_appLine_tbody_ref .clsTr");
	
		if (refRows.length > 0) {
			// 마지막 참조자 삭제
			refRows.last().remove();
			// 순번 다시 매기기
			reindexApprovalLines();
		} else {
			swal({
				title: "",
				text: "삭제할 참조자가 없습니다.",
				icon: "error",
				closeOnClickOutside: false,
				closeOnEsc: false
			});
		}
	});
	
		//결재선지정에서 확인버튼 눌렀을때
		$("#s_add_appLine_list").click(function(){
			if($(".s_appLine_tbody_new .clsTr").length==0){
				swal({
					title: "결재선이 지정되어있지 않습니다.",
					text: "결재할 사원을 추가해주세요!",
					icon: "error",
					closeOnClickOutside: false,
					closeOnEsc: false,
					button: "확인"
				});
				return;
			}
			var appLineArr = [];
			
			//1)
			let formData = new FormData();
			
			//I. 결재자 정보
			for(let i= 0; i<$(".s_td_no").length; i++){
				let sTdNo = $(".s_td_no").eq(i).text();
				console.log("sTdNo : ",sTdNo);
				
				appLineArr.push($(".s_td_no").eq(i).text());
				console.log("appLineArr : ",appLineArr);
				//위의 코드까지는 찍힘
				
				//2) 결재자 번호 입력
				formData.append("emplNoArr",sTdNo);
			}
			var obj = {"emplNo" : appLineArr};
			
			
			//JSON Object
			let data = {};
			//여기서 배열을 초기화준다면 결재선을 다시 들어가게 한다.
			//결재선이 중복으로 들어가게 안되도록 만들어준다.
			authList = [];
			//II. 권한 정보(.selAuth)
			$(".selAuth").each(function(idx,auth){
				//전결여부 기본 N
				let dcrbAuthorYn = "N";
				
				if($(this).parent().next().children().eq(0).is(":checked")){//true
					dcrbAuthorYn = "Y";
				}else{
					dcrbAuthorYn = "N";
				}
				
				data = {
					"emplNo":$(this).parent().parent().children("th").eq(1).html(),
					"clsfCode": $(this).parent().parent().find(".clsfCode").val(),
					"auth":$(this).val(),
					"flex":dcrbAuthorYn,
					"atrzLnSn":(idx+1),
					"atrzDocNo": $("#s_dfNo").text()
				};
				
				//결재선 목록
				authList.push(data);			
				formData.append("atrzLineVOList["+idx+"].atrzDocNo",data.atrzDocNo); //결재문서번호 입력
				formData.append("atrzLineVOList["+idx+"].sanctnerEmpno",data.emplNo);
				formData.append("atrzLineVOList["+idx+"].sanctnerClsfCode",data.clsfCode);
				formData.append("atrzLineVOList["+idx+"].atrzTy",data.auth);//Y / N 결재자 / 참조자
				formData.append("atrzLineVOList["+idx+"].dcrbAuthorYn",data.flex);//  1 / 0 전결여부
				formData.append("atrzLineVOList["+idx+"].atrzLnSn",data.atrzLnSn);
			});	
			
			console.log("순번권한전결여부authList : ", authList);
			formData.append("docFormNm","S");
			formData.append("docFormNo",2);
	
			console.log("obj.emplNo : ",obj.emplNo);
			//asnyc를 써서 
			$.ajax({
				url:"/atrz/insertAtrzLine",
				processData:false,
				contentType:false,
				type:"post",
				data: formData,
				dataType:"json",
				success : function(atrzVO){
					swal({
						title: "결재선 지정이 완료되었습니다.",
						text: "",
						icon: "success",
						closeOnClickOutside: false,
						closeOnEsc: false,
						button: "확인"
					});
					$(".btn-close").trigger('click');
					console.log("atrzVO : ", atrzVO);
	
					//문서번호 채우기
					$("#s_dfNo").html(atrzVO.atrzDocNo);
	
					let result = atrzVO.emplDetailList;
	
					//result : List<EmployeeVO>
					console.log("result : ", result);
	
					let tableHtml = `<table border="1" class="s_eap_draft_app"><tbody>`;
	
					// authList를 기반으로 분리
					const approvalList = [];
					const referenceList = [];
	
					$.each(authList, function(i, authItem) {
						const matched = result.find(emp => emp.emplNo === authItem.emplNo);
						if (matched) {
							matched.flex = authItem.flex; // flex 정보도 보존
							if (authItem.auth === "1") {
								approvalList.push(matched);
							} else if (authItem.auth === "0") {
								referenceList.push(matched);
							}
						}
					});
					//길준희 여기부터 시작
					// 가. 결재파트 시작
					if (approvalList.length > 0) {
						tableHtml += `<tr><th rowspan="2">결재</th>`;
						$.each(approvalList, function(i, employeeVO){
							$("#atrz_sp_form").append(`<input type="hidden" name="empNoList" value="\${employeeVO.emplNo}"/>`);
							tableHtml += `<td>\${employeeVO.clsfCodeNm}</td>`;
						});
						tableHtml += `</tr><tr>`;
						$.each(approvalList, function(i, employeeVO){
							tableHtml += `<td><img src="/assets/images/atrz/before.png"
								style="width: 50px;">
								<span style="display: block; margin-top: 5px; name="sanctnerEmpno">\${employeeVO.emplNm}</span></td>`;				
							});
						tableHtml += `</tr>`;
					}
	
					// 나. 참조파트 시작
					if (referenceList.length > 0) {
						tableHtml += `<tr><th rowspan="2">참조</th>`;
						$.each(referenceList, function(i, employeeVO){
							$("#atrz_sp_form").append(`<input type="hidden" name="empAttNoList" value="\${employeeVO.emplNo}"/>`);
							tableHtml += `<td>\${employeeVO.clsfCodeNm}</td>`;
						});
	
						tableHtml += `</tr><tr>`;
						$.each(referenceList, function(i, employeeVO){
							tableHtml += `<td name="sanctnerEmpno">\${employeeVO.emplNm}</td>`;
						});
	
						tableHtml += `</tr>`;
					}
	
					tableHtml += `</tbody></table>`;
	
					$("#s_eap_draft_app").html(tableHtml);
				}//end success
		});//ajax
		//여기서 결재선에 담긴 애들을 다 하나씩 담아서 post로
	})
	
	
		// 합계 구하기
		function total() {
			var spCnt = 0;
			var spAmount = 0;
			var total = 0;
			var sum = 0;
			// const number;
			for(var i = 0; i < $('.s_sp_count').length; i++) {
				spCnt = $(".s_sp_count").eq(i).val();
				spAmount = $(".s_sp_amount").eq(i).val();
				
				spAmount = spAmount.replace(/,/g, "");
				total = Number(spCnt * spAmount);
				
				sum += total;
			}
			
			$("#s_total_price").text(sum);
			
			var total1 = $("#s_total_price").text();
			var total2 = total1.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			$('#s_total_price').text(total2);
		};
	
	
	
	
		// datepicker위젯
		$("#s_sp_date").datepicker({
			timepicker: true,
			changeMonth: true,
			changeYear: true,
			controlType: 'select',
			timeFormat: 'HH:mm',
			dateFormat: 'yy-mm-dd',
			yearRange: '1930:2025',
			dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			monthNamesShort: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'],
			monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			beforeShow: function() {
				setTimeout(function(){
					$('.ui-datepicker').css('z-index', 99999999999999);
				}, 0);
			}
		});
	});
	</script>
</body>

</html>
