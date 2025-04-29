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
		<form id="atrz_dr_form" action="/atrz/insertAtrzLine" method="post" enctype="multipart/form-data">
			<div class="container-fluid">
				<!-- 여기서 작업 시작 -->
				<!-- <p>${attachFileVOList}</p> -->
				<div class="row">
					<div class="col-sm-12 mb-3 mb-sm-0">
						<!-- 결재요청 | 임시저장 | 결재선지정 | 취소  -->
						<div class="col card-body" id="approvalBtn">
							<!-- 새로운 버튼 -->
							<div class="tool_bar">
								
								<sec:authentication property="principal.empVO" var="emp" />
								<!-- <p>${emp.emplNo}?????</p> -->
								<div class="critical d-flex gap-2 mb-3">
									<!--[AtrzLineVO(atrzDocNo=H_20250414_00025, atrzLnSn=1, sanctnerEmpno=20250004, sanctnerClsfCode=02
										, contdEmpno=null, contdClsfCode=null, dcrbManEmpno=null, dcrbManClsfCode=null, atrzTy=N
										, sanctnProgrsSttusCode=00, dcrbAuthorYn=0, contdAuthorYn=null, sanctnOpinion=null
										, eltsgnImage=null, sanctnConfmDt=null, atrzLineList=null, sanctnerClsfNm=대리, sanctnerEmpNm=길준희
										, befSanctnerEmpno=null, befSanctnProgrsSttusCode=null, aftSanctnerEmpno=null
										, aftSanctnProgrsSttusCode=null, maxAtrzLnSn=0)]-->
										<!-- 기안자일때만 보이게 하기 -->
										<c:forEach var="atrzLineVO" items="${atrzVO.atrzLineVOList}">
											<!-- <p>curAtrzLnSn : 여기야${curAtrzLnSn} / ${atrzLineVO.atrzLnSn}</p> -->
											<c:if test="${atrzLineVO.sanctnerEmpno == emp.emplNo
															&& atrzLineVO.atrzTy eq 1
															&& atrzLineVO.atrzLnSn == curAtrzLnSn && atrzVO.atrzSttusCode eq '00'}">
												<button id="atrzAppBtnTo" type="button" 
													class="btn btn-outline-primary d-flex align-items-center gap-1 atrzAppBtn btnFontSt" 
													data-all-app-check="<c:if test='${lastAtrzLnSn==atrzLineVO.atrzLnSn}'>Y</c:if>" 
													data-bs-toggle="modal" data-bs-target="#atrzApprovalModal"
													style="padding: 0.4rem 1rem; font-size: 0.95rem;">
													<span class="material-symbols-outlined fs-5">inventory</span> 결재
												</button>
												<a id="atrzComBtnTo" type="button"
													class="btn btn-outline-danger d-flex align-items-center gap-1 btnFontSt"
													data-bs-toggle="modal" data-bs-target="#atrzCompanModal"
													style="padding: 0.4rem 1rem; font-size: 0.95rem;"> 
													<span class="material-symbols-outlined fs-5 atrzComBtn">undo</span> 반려
												</a>
											</c:if>
										</c:forEach>
										<c:if test="${emp.emplNo==atrzVO.drafterEmpno && atrzVO.atrzSttusCode eq '20'}">
											<a id="atrzComOption" type="button"
												class="btn btn-outline-danger d-flex align-items-center gap-1"
												style="padding: 0.4rem 1rem; font-size: 0.95rem;"
												data-bs-toggle="modal" data-bs-target="#atrzComOptionModal"> 
												<span class="material-symbols-outlined fs-5 atrzComBtn">playlist_remove</span> 반려사유
											</a>
											<a id="atrzAppReturnTo" type="button" 
													class="btn btn-outline-success d-flex align-items-center gap-1 atrzAppReturnBtn" 
													href="/atrz/selectForm/selectDocumentReturn?atrzDocNo=${atrzVO.atrzDocNo}"
													style="padding: 0.4rem 1rem; font-size: 0.95rem;">
												<span class="material-symbols-outlined fs-5">edit_square</span>재기안
											</a>
										</c:if>
										<!-- <p>${atrzVO}</p> -->
										<c:if test="${atrzVO.drafterEmpno == emp.emplNo  && atrzVO.atrzSttusCode!=10 && atrzVO.atrzSttusCode!=20 && atrzVO.atrzSttusCode!=30}">
											<a id="atrzCancelBtnTo" type="button" class="btn btn-outline-danger d-flex align-items-center gap-1 atrzCancelBtn"
											style="padding: 0.4rem 1rem; font-size: 0.95rem;"> 
											<span class="material-symbols-outlined fs-5 atrzComBtn">keyboard_return</span> 기안취소
										</a>
										</c:if>
										<a type="button" 
										class="btn btn-outline-secondary d-flex align-items-center gap-1"
										style="padding: 0.4rem 1rem; font-size: 0.95rem;"
										href="/atrz/approval?tab=1"> 
										<span class="material-symbols-outlined fs-5">format_list_bulleted</span> 목록
									</a>
								</div>
							</div>

							<!-- 새로운 버튼 -->
						</div>
						<!-- 모달창 인포트 -->
						<c:import url="../documentForm/atrzAppCompModal.jsp" />
							<div class="card">
								<div class="card-body">
									<!-- 여기다가 작성해주세요(준희) -->
									<!-- 기능 시작 -->
									<!-- 전자결재 양식 수정도 가능 시작 -->
									<!-- <p>${atrzVO}</p> -->
									<div id="s_eap_content_box_left" class="s_scroll">
										<div class="s_div_container s_scroll">
											<div style="text-align: center; font-size: 2em; font-weight: bold; padding: 20px;">기안서</div>
											<div style="float: left; width: 230px; margin: 0 30px;">
												<table border="1" id="s_eap_draft_info" class="text-center">
													<tr>
														<!-- 기안자 정보가져오기 -->
														<!-- <p>${atrzVO}</p> -->
														<!-- <p>${employeeVO}</p> -->
														<th>기안자</th>
														<td>${atrzVO.drafterEmpnm}</td>
													</tr>
													<tr>
														<th>기안부서</th>
														<td>${atrzVO.deptCodeNm}</td>
													</tr>
													<tr>
														<!-- 기안일 출력을 위한 것 -->
														<jsp:useBean id="now" class="java.util.Date" />
														<fmt:formatDate value="${atrzVO.atrzDrftDt}" pattern="yyyy-MM-dd HH:mm:ss" var="today" />
														<th>기안일</th>
														<td>
															<c:out value="${today}"/>
														</td>
													</tr>
													<tr>
														<th>문서번호</th>
														<td id="s_dfNo" name="atrzDocNo">${atrzVO.atrzDocNo}</td>
													</tr>
												</table>
											</div>

											<div style="float: left; width: 130px; margin-right: 10px;">
												<table border="1" id="s_eap_draft">
													<tr>
														<th rowspan="2">신청</th>
														<td>${atrzVO.clsfCodeNm}</td>
													</tr>
													<tr>
														<td>${atrzVO.drafterEmpnm}</td>
													</tr>
												</table>
											</div>

											<!-- <p>${atrzVO.atrzLineVOList}</p> -->
											<div style="float: right; margin-right: 20px;" id="s_eap_draft_app">
												<table border="1" class="s_eap_draft_app">
													<tbody>
														<!-- 결재자: atrzTy = 'N' -->
														<tr>
															<th rowspan="3">결재</th>
															<c:forEach var="atrzLineVO" items="${atrzVO.atrzLineVOList}">
																<c:if test="${atrzLineVO.atrzTy eq '1'}">
																	<!-- <p>${atrzLineVO}</p> -->
																	<td>${atrzLineVO.sanctnerClsfNm}</td>
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
																		<input type="hidden" name="atrzLnSn" value="${atrzLineVO.atrzLnSn}" />
																		<input type="hidden" name="sanctnerEmpno" value="${atrzLineVO.sanctnerEmpno}" />
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
																					<fmt:formatDate value="${atrzLineVO.sanctnConfmDt}" pattern="yyyy-MM-dd HH:mm:ss" />
																				</span>
																			</c:when>
																			<c:when test="${atrzLineVO.sanctnProgrsSttusCode eq '30'}">
																				<span style="display: block; width: 100%; height: 1px; background-color: gray; transform: rotate(-15deg); margin: 10px auto;"></span>
																			</c:when>
																			<c:otherwise>
																				<span style="color: black;">
																					<fmt:formatDate value="${atrzLineVO.sanctnConfmDt}" pattern="yyyy-MM-dd HH:mm:ss" />
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
															<tr>
																<th rowspan="2">참조</th>
																<c:forEach var="atrzLineVO" items="${atrzVO.atrzLineVOList}">
																	<c:if test="${atrzLineVO.atrzTy eq '0'}">
																		<td>${atrzLineVO.sanctnerClsfNm}</td>
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
													style="display: inline-block; width: 90%; margin-left: 5px;" disabled
													id="s_sp_tt" name="atrzSj">
											</div>

											<div style="border: 1px solid lightgray; margin: 10px;"></div>
											<div style="margin: 0 10px;">

												<div style="padding: 10px 0;">
													<div class="s_frm_title mb-2"><b>상세 내용</b></div>
													<textarea class="form-control" disabled
														style="resize: none; height: 150px;" id="s_sp_co" name="atrzCn" 
														required="required" rows="2" cols="20" wrap="hard">${atrzVO.atrzCn}</textarea>
												</div>

												<%--첨부파일 구성하기--%>
												<div class="mb-3">
													<div class="s_frm_title mb-2"> 미리보기</div>
													<c:if test="${not empty attachFileVOList}">
														<div class="d-flex flex-wrap gap-3 mt-2">
														<c:forEach var="attachFileVO" items="${attachFileVOList}">
															<c:set var="ext" value="${fn:toLowerCase(fn:substringAfter(attachFileVO.fileNm, '.'))}" />
															<c:choose>
																<%-- 이미지 파일일 경우 썸네일로 출력 --%>
																<c:when test="${ext == 'jpg' || ext == 'jpeg' || ext == 'png' || ext == 'gif' || ext == 'bmp'}">
																	<div class="border rounded p-3 bg-light d-inline-flex flex-column align-items-center" style="max-width: 450px;">
																	<!-- <a class="attachment-item" href="/download?fileName=${attachFileVO.fileStrePath}"> -->
																		<img src="/upload/${attachFileVO.fileStrePath}" 
																			alt="${attachFileVO.fileNm}" 
																			style="max-width: 300px; max-height: 300px; object-fit: cover;" />
																	<!-- </a> -->
																	<div class="mt-2 text-truncate w-100 text-center" style="max-width: 180px;" title="${attachFileVO.fileNm}">
																		${attachFileVO.fileNm}
																	</div>
																	</div>
																</c:when>
															<%-- 그 외 파일은 아이콘으로 출력 --%>
															<c:otherwise>
																<div class="border p-2 rounded bg-light">
																	<a class="attachment-item" href="/download?fileName=${attachFileVO.fileStrePath}">
																	<i class="far fa-attachFileVO-pdf attachment-icon"></i>
																	<span class="attachment-name">${attachFileVO.fileNm} (${attachFileVO.fileViewSize})</span>
																	</a>
																</div>
															</c:otherwise>
															</c:choose>
														</c:forEach>
														</div>
													</c:if>
													
													<c:if test="${empty attachFileVOList}">
														<p class="text-muted">첨부파일이 없습니다.</p>
													</c:if>
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
								<div class="critical d-flex gap-2 mb-3 mt-3">
									<c:forEach var="atrzLineVO" items="${atrzVO.atrzLineVOList}">
										<c:if test="${atrzLineVO.sanctnerEmpno == emp.emplNo
														&& atrzLineVO.atrzTy eq '1'
														&& atrzLineVO.atrzLnSn == curAtrzLnSn && atrzVO.atrzSttusCode eq '00'}">
											<button id="atrzAppBtnBo" type="button" 
												class="btn btn-outline-primary d-flex align-items-center gap-1 atrzAppBtn" 
												data-all-app-check="<c:if test='${lastAtrzLnSn==atrzLineVO.atrzLnSn}'>Y</c:if>"
												data-bs-toggle="modal" data-bs-target="#atrzApprovalModal"
												style="padding: 0.4rem 1rem; font-size: 0.95rem;">
												<span class="material-symbols-outlined fs-5">inventory</span>결재
											</button>
											<a id="atrzComBtnBo" type="button"
												class="btn btn-outline-danger d-flex align-items-center gap-1"
												data-bs-toggle="modal" data-bs-target="#atrzCompanModal"
												style="padding: 0.4rem 1rem; font-size: 0.95rem;"> 
												<span class="material-symbols-outlined fs-5 atrzComBtn">undo</span> 반려
											</a>
										</c:if>
									</c:forEach>
									<c:if test="${emp.emplNo==atrzLineVO.sanctnerEmpno && atrzVO.atrzSttusCode eq '20'}">
										<a id="atrzComOption" type="button"
											class="btn btn-outline-danger d-flex align-items-center gap-1 btnFontSt"
											style="padding: 0.4rem 1rem; font-size: 0.95rem;"
											data-bs-toggle="modal" data-bs-target="#atrzComOptionModal"> 
											<span class="material-symbols-outlined fs-5 atrzComBtn">playlist_remove</span> 반려사유
										</a>
										<a id="atrzAppReturnTo" type="button" href="/atrz/selectForm/selectDocumentReturn?atrzDocNo=${atrzVO.atrzDocNo}"
												class="btn btn-outline-success d-flex align-items-center gap-1 atrzAppReturnBtn" 
												style="padding: 0.4rem 1rem; font-size: 0.95rem;">
											<span class="material-symbols-outlined fs-5">edit_square</span>재기안
										</a>
									</c:if>
									<!-- <p>${atrzVO}</p> -->
									<c:if test="${atrzVO.drafterEmpno == emp.emplNo  && atrzVO.atrzSttusCode!=10 && atrzVO.atrzSttusCode!=20}">
										<a id="atrzCancelBtnBo" type="button" 
										class="btn btn-outline-danger d-flex align-items-center gap-1 atrzCancelBtn"
										style="padding: 0.4rem 1rem; font-size: 0.95rem;"> 
										<span class="material-symbols-outlined fs-5 atrzComBtn">keyboard_return</span> 기안취소
									</a>
									</c:if>
									<a type="button" 
										class="btn btn-outline-secondary d-flex align-items-center gap-1"
										style="padding: 0.4rem 1rem; font-size: 0.95rem;"
										href="/atrz/approval?tab=1"> 
										<span class="material-symbols-outlined fs-5">format_list_bulleted</span> 목록
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
document.addEventListener("DOMContentLoaded", ()=>{

//결재하기 버튼을 눌러서 업데이트 진행하기 
$("#atrzDetailappBtn").on("click", function() {
	const atrzDocNo = $("#atrzDocNo").val(); // 문서 번호 가져오기
    const approvalMessage = $("#approvalMessage").val(); // 결재 의견 가져오기
    const authorStatus = $("#authorStatus").is(":checked"); // 전결 여부 가져오기

    // 서버로 전송할 데이터 구성
    const approvalData = {
        "atrzDocNo": atrzDocNo,
        "atrzLineVOList[0].sanctnOpinion": approvalMessage,
        "authorStatus": authorStatus,
        "sanctnProgrsSttusCode": "10", // 결재 상태를 "승인"으로 설정
    };
	/*
	{
		"atrzDocNo": "H_20250411_00003",
		"approvalMessage": "승인합니다.",
		"authorStatus": false,
		"approvalStatus": "10"
	}
	*/
	console.log("approvalData : ", approvalData);

    // AJAX 요청
    $.ajax({
        url: "/atrz/selectForm/atrzDetailAppUpdate", // 서버의 결재 상태 업데이트 API
        type: "POST",
        data: approvalData,
		dataType: "text",
        success: function (response) {
			if (response == "success") {
				swal({
					title: "결재 완료",
					text: "결재가 성공적으로 처리되었습니다.",
					icon: "success",
					button: "확인",
				}).then(() => {
					// 결재 완료 후 페이지를 새로고침하거나 목록 페이지로 이동
					window.location.href = "/atrz/home";
				});
			}
        },
        error: function (error) {
            swal({
                title: "결재 실패",
                text: "결재 처리 중 오류가 발생했습니다. 다시 시도해주세요.",
                icon: "error",
                button: "확인",
            });
        },
    });
	
});

$("#atrzDetailComBtn").on("click", function () {
	const atrzDocNo = $("#atrzDocNo").val(); // 문서 번호 가져오기
	const companionMessage = $("#companionMessage").val(); // 반려 의견 가져오기
	
	// 반려 의견이 비어있는지 확인
	if (!companionMessage.trim()) {
			swal({
				title: "반려시 반려의견은 필수입니다.",
				icon: "warning",
				button: "확인",
			});
			return; // 의견이 없으면 함수 종료
		}

		// 서버로 전송할 데이터 구성
		const companionData = {
			"atrzDocNo": atrzDocNo,
			"atrzLineVOList[0].sanctnOpinion": companionMessage,
			"sanctnProgrsSttusCode": "20", // 결재 상태를 "반려"로 설정
		};
		console.log("companionData : ", companionData);

		// AJAX 요청
		$.ajax({
			url: "/atrz/selectForm/atrzDetilCompUpdate", // 결재 반려 시
			type: "POST",
			data: companionData,
			dataType: "text",
			success: function (response) {
				if (response == "success") {
					swal({
						title: "반려 완료",
						text: "반려가 성공적으로 처리되었습니다.",
						icon: "success",
						button: "확인",
					}).then(() => {
						// 반려 완료 후 페이지를 새로고침하거나 목록 페이지로 이동
						window.location.href = "/atrz/home";
					});
				}
			},
			error: function (error) {
				swal({
					title: "반려 실패",
					text: "반려 처리 중 오류가 발생했습니다. 다시 시도해주세요.",
					icon: "error",
					button: "확인",
				});
			},
		});
	});

	//기안취소버튼을 누르면  atrzCancelBtnTo
	$(".atrzCancelBtn").on("click",function(){
		const atrzDocNo = $("#s_dfNo").text(); // 문서 번호 가져오기

		//정말로 결재 기안취소하시겠습니까 ?
		swal({
			title: "기안취소",
			text: "정말로 기안취소하시겠습니까?",
			icon: "warning",
			buttons: {
				cancel: {
					text: "아니오",
					value: null,
					visible: true,
					closeModal: true
				},
				confirm: {
					text: "네",
					value: true,
					closeModal: true
				}
			}
		}).then((willDelete) => {
			if (willDelete) {
				// 서버로 전송할 데이터 구성
				const cancelData = {
					"drafterEmpno": "${empVO.emplNo}", // 기안자 사원번호
					"atrzDocNo": atrzDocNo,
					"sanctnProgrsSttusCode": "30", // 결재 상태를 "기안취소"로 설정
				};
				console.log("cancelData : ", cancelData);

				// AJAX 요청
				$.ajax({
					url: "/atrz/selectForm/atrzCancelUpdate", // 서버의 기안취소 API
					type: "POST",
					data: cancelData,
					dataType: "text",
					success: function (response) {
						if (response == "success") {
							swal({
								title: "기안취소 완료",
								text: "기안취소가 성공적으로 처리되었습니다.",
								icon: "success",
								button: "확인",
							}).then(() => {
								// 기안취소 완료 후 페이지를 새로고침하거나 목록 페이지로 이동
								window.location.href = "/atrz/home";
							});
						}
					},
					error: function (error) {
						swal({
							title: "기안취소 실패",
							text: "기안취소 처리 중 오류가 발생했습니다. 다시 시도해주세요.",
							icon: "error",
							button: "확인",
						});
					},
				});
			}
		});
	});//기안취소버튼을 누르면  atrzCancelBtnTo

	//결재버튼 클릭 시 마지막 결재자일 경우 전결체크박스를 사라지게 처리함
	$(".atrzAppBtn").on("click", function() {
		const allAppCheck = $(this).data("all-app-check");
		if (allAppCheck == "Y") {
			$("#authorStatus").parent().parent().hide(); // 전결 체크박스 숨기기
		} else {
			$("#authorStatus").parent().parent().show(); // 전결 체크박스 보이기
		}
	});

});//end DOMContentLoaded
</script>
</body>

</html>
