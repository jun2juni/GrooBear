<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="메인" />

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"/>
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
	background: #f1f1f1;
	border-radius: 50%;
	padding-top: 10px;
	padding-bottom: 10px;
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

</style>
<title>${title}</title>
<%@ include file="../layout/prestyle.jsp" %>
</head>
<body>
<!-- 로그인한 정보 가져오기 위한 시큐리티 -->
<sec:authentication property="principal.empVO" var="empVO" />
<%@ include file="../layout/sidebar.jsp" %>
<main class="main-wrapper">
<%@ include file="../layout/header.jsp" %>
	<section class="section">
		<div class="container-fluid">
			<!-- 여기서 작업 시작 -->
			<!-- 결재요청 | 임시저장 | 결재선지정 | 취소  -->
			<div class="col card-body" id="approvalBtn">
				<!-- 새로운 버튼 -->
						<div class="tool_bar">
									<div class="critical d-flex gap-2 mb-3">
										<!--성진스 버튼-->
										<a id="s_eap_app" type="button" class="btn btn-outline-primary d-flex align-items-center gap-1">
											<span class="material-symbols-outlined fs-5">cancel</span> 
											결재요청</a>
										<a id="s_eap_stor" type="button" class="btn btn-outline-success d-flex align-items-center gap-1"
										data-bs-toggle="modal" data-bs-target="#atrzLineModal">
											<span class="material-symbols-outlined fs-5">error</span> 
												임시저장</a>
										<a id="s_appLine_btn" type="button" class="btn btn-outline-info d-flex align-items-center gap-1"
										data-bs-toggle="modal" data-bs-target="#atrzLineModal">
											<span class="material-symbols-outlined fs-5">error</span> 
												결재선 지정</a>
										<a type="button" class="btn btn-outline-danger d-flex align-items-center gap-1" href="/atrz/home">
											<span class="material-symbols-outlined fs-5">cancel</span> 
											취소</a>
<!-- 										<a type="button" class="btn btn-outline-secondary d-flex align-items-center gap-1" href="/atrz/approval"> -->
<!-- 											<span class="material-symbols-outlined fs-5">reorder</span>  -->
<!-- 											목록으로</a> -->

<!-- 										<a id="act_draft_withdrawal" class="btn d-flex align-items-center gap-1" data-role="button"> -->
<!-- 											<span class="material-symbols-outlined fs-5">cancel</span>  -->
<!-- 											<span class="txt">상신취소</span> -->
<!-- 										</a> -->
<!-- 										<a id="act_edit_apprflow" class="btn d-flex align-items-center gap-1" data-role="button"> -->
<!-- 											<span class="material-symbols-outlined fs-5">error</span>  -->
<!-- 											<span class="txt">결재선 정보</span> -->
<!-- 										</a> -->
<!-- 										<a id="act_edit_apprflow" class="btn d-flex align-items-center gap-1" data-role="button"> -->
<!-- 											<span class="material-symbols-outlined fs-5">reorder</span>  -->
<!-- 											<span class="txt">목록</span> -->
<!-- 										</a> -->
									</div>
								</div>
						
						<!-- 새로운 버튼 -->
			</div>
			<div class="row">
					<div class="col-sm-12 mb-3 mb-sm-0">
						<div class="card">
							<div class="card-body">
								<!-- 여기다가 작성해주세요(준희) -->
								<!-- 기능 시작 -->
								<!-- 전자결재 양식 수정도 가능 시작 -->
								<div id="s_eap_content_box_left" class="s_scroll">
									<div class="s_div_container s_scroll">
										<div
											style="text-align: center; font-size: 2em; font-weight: bold; padding: 20px;">지출결의서</div>

										<div style="float: left; width: 230px; margin: 0 30px;">
											<table border="1" id="s_eap_draft_info" class="text-center">
												<tr>
<%-- 												<p>${empVO}</p> --%>
													<th>기안자</th>
													<td>${empVO.emplNm}</td>
												</tr>
												<tr>
													<th>기안부서</th>
													<td>${empVO.deptNm}</td>
												</tr>
												<tr>
													<jsp:useBean id="now" class="java.util.Date" />
													<fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm:ss" var="today" />
													<th>기안일</th>
													<td>
														<c:out value="${today}"/>
													</td>
												</tr>
												<tr>
													<th>문서번호</th>
													<td id="s_dfNo">${resultDoc.df_no}</td>
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

										<div style="float: left; width: 800px; margin-right: 5px;"	id="s_eap_draft_app" class="s_div">
										</div>
										<div id="s_eap_final">
											<div>
												<div style="padding: 50px 10px 20px; clear: both;">
													<div
														style="display: inline-block; font-size: 1.2em; font-weight: bold;">제목
														:</div>
													<input type="text" class="form-control"
														style="display: inline-block; width: 90%; margin-left: 5px;"
														id="s_sp_tt">
												</div>

												<div style="border: 1px solid lightgray; margin: 10px;"></div>
												<div style="margin: 0 10px;">

													<div style="padding: 10px 0;">
														<div class="s_frm_title">1. 지출 내용</div>
														<textarea class="form-control"
															style="resize: none; height: 150px;" id="s_sp_co"
															required="required" rows="2" cols="20" wrap="hard"></textarea>
													</div>
													<div style="padding: 10px 0;">
														<div class="s_frm_title">2. 지출 내역</div>
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
																	<th scope="row"><input type="text"
																		class="form-control s_sp_date" id="s_sp_date"
																		name="sp_date" placeholder="날짜 선택"
																		style="cursor: context-menu;"></th>
																	<td><input type="text"
																		class="form-control s_sp_detail" name="sp_detail"></td>
																	<td><input type="text" id="sp_count"
																		class="form-control s_sp_count" name="sp_count"
																		onblur="total()"
																		oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"></td>
																	<td><input type="text"
																		class="form-control s_sp_amount" id="sp_amount"
																		name="sp_amount" onkeyup="commas(this)"
																		onblur="total()"></td>
																	<td><select class="form-select s_select"
																		aria-label="Default select example">
																			<option value="C">신용카드</option>
																			<option value="A">가상계좌</option>
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
														<!-- <button id="s_add_sp_detail" class="btn btn-success" onclick="addTr()">내역 추가</button> -->
													</div>

													<div style="padding: 10px 0;">
														<div class="s_frm_title">파일첨부</div>
														<!-- <input type="file" class="form-control"> -->
														<div id="s_file_upload">
															<input type="file" id="eap_file_path" />
														</div>
														<input type="hidden" name="fileUrl" id="fileUrl">
													</div>
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
										<button id="s_eap_app" type="submit" class="btn btn-outline-primary d-flex align-items-center gap-1">
											<span class="material-symbols-outlined fs-5">cancel</span> 
											결재요청</button>
										<a id="s_eap_stor" type="button" class="btn btn-outline-success d-flex align-items-center gap-1"
										data-bs-toggle="modal" data-bs-target="#atrzLineModal">
											<span class="material-symbols-outlined fs-5">error</span> 
												임시저장</a>
										<a id="s_appLine_btn" type="button" class="btn btn-outline-info d-flex align-items-center gap-1"
										data-bs-toggle="modal" data-bs-target="#atrzLineModal">
											<span class="material-symbols-outlined fs-5">error</span> 
												결재선 지정</a>
										<a type="button" class="btn btn-outline-danger d-flex align-items-center gap-1" href="/atrz/home">
											<span class="material-symbols-outlined fs-5">cancel</span> 
											취소</a>
<!-- 										<a type="button" class="btn btn-outline-secondary d-flex align-items-center gap-1" href="/atrz/approval"> -->
<!-- 											<span class="material-symbols-outlined fs-5">reorder</span>  -->
<!-- 											목록으로</a> -->

<!-- 										<a id="act_draft_withdrawal" class="btn d-flex align-items-center gap-1" data-role="button"> -->
<!-- 											<span class="material-symbols-outlined fs-5">cancel</span>  -->
<!-- 											<span class="txt">상신취소</span> -->
<!-- 										</a> -->
<!-- 										<a id="act_edit_apprflow" class="btn d-flex align-items-center gap-1" data-role="button"> -->
<!-- 											<span class="material-symbols-outlined fs-5">error</span>  -->
<!-- 											<span class="txt">결재선 정보</span> -->
<!-- 										</a> -->
<!-- 										<a id="act_edit_apprflow" class="btn d-flex align-items-center gap-1" data-role="button"> -->
<!-- 											<span class="material-symbols-outlined fs-5">reorder</span>  -->
<!-- 											<span class="txt">목록</span> -->
<!-- 										</a> -->
									</div>
								</div>
							<!-- 상하 버튼 추가 -->
					</div>
				</div>
			
			<!-- 여기서 작업 끝 -->
		</div>
	</section>
  <%@ include file="../layout/footer.jsp" %>
</main>
<%@ include file="../layout/prescript.jsp" %>
<!--결재선지정 버튼 모달 시작-->
<c:import url="../documentForm/approvalLineModal.jsp" />
<!-- 스크립트 입력 -->
<script>
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
</script>

<script>
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

</script>


<script>
// 결재 요청 클릭 시
$("#s_eap_app").click(function() {
	var sp_date = "";
	var sp_detail = "";
	var sp_count = 0;
	var sp_amount = 0;
	var sp_pay_code = "";
	var df_no = "";
	var dataArr = [];
	
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
	
	dataObj = {
			"sp_date" : $('.s_sp_date').val(),
			"sp_detail" : $('.s_sp_detail').val(),
			"sp_count" : $('.s_sp_count').val(),
			"sp_amount" : $('.s_sp_amount').val(),
			"sp_pay_code" : $('.s_select').val(),
			"df_no" : $('#s_dfNo').text(),
			"eap_title" : $('#s_sp_tt').val(),
			"eap_content" : eap_content,
			"eap_file_path": $("#fileUrl").val(),
	}
	
	
	// 결재요청 클릭 시 DB다녀올 ajax
	$.ajax({
		url : "<%=request.getContextPath()%>/eap/insertsp"
		, type : "post"
		, data : dataObj
		, success : function(result) {
			if(result.includes('다시')) {
				swal({
                    title: "",
                    text: result,
                    icon: "error",
                    closeOnClickOutside: false,
                    closeOnEsc: false
                })
                .then((ok) => {
					$("#menu_eap").get(0).click();
            	})
			} else {
				swal({
                    title: "",
                    text: result,
                    icon: "success",
                    closeOnClickOutside: false,
                    closeOnEsc: false
                })
                .then((ok) => {
					$("#menu_eap").get(0).click();
            	})
			}
		}
	});
});


</script>

<script>
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
</script>
<script>
// 제목 입력 시
$('#s_sp_tt').keyup(function() {
	// 결재선 지정이 안되어 있다면
	if($('div').hasClass('s_div') == false) {
		swal({
				title: "",
				text: "결재선 지정을 먼저 해주세요",
				icon: "error",
				closeOnClickOutside: false,
				closeOnEsc: false
			});
		// 입력한 내용 지우기
		$('#s_sp_tt').val("");
	}
});

// 내용 입력 시
$('#s_sp_co').keyup(function() {
	// 결재선 지정이 안되어 있다면
	if($('div').hasClass('s_div') == false) {
		swal({
				title: "",
				text: "결재선 지정을 먼저 해주세요",
				icon: "error",
				closeOnClickOutside: false,
				closeOnEsc: false
			});
		// 입력한 내용 지우기
		$('#s_sp_co').val("");
	}
});

// 지출날짜 입력 시
$(".s_sp_date").change(function() {
	if($('div').hasClass('s_div') == false) {
		swal({
				title: "",
				text: "결재선 지정을 먼저 해주세요",
				icon: "error",
				closeOnClickOutside: false,
				closeOnEsc: false
			});
		// 입력한 내용 지우기
		$('.s_sp_date').val("");
	}
});

// 지출내역 입력 시
$(".s_sp_detail").keyup(function() {
	// 결재선 지정이 안되어 있다면
	if($('div').hasClass('s_div') == false) {
		swal({
				title: "",
				text: "결재선 지정을 먼저 해주세요",
				icon: "error",
				closeOnClickOutside: false,
				closeOnEsc: false
			});
		// 입력한 내용 지우기
		$('.s_sp_detail').val("");
	}
})

// 수량 입력 시
$(".s_sp_count").keyup(function() {
	// 결재선 지정이 안되어 있다면
	if($('div').hasClass('s_div') == false) {
		swal({
				title: "",
				text: "결재선 지정을 먼저 해주세요",
				icon: "error",
				closeOnClickOutside: false,
				closeOnEsc: false
			});
		// 입력한 내용 지우기
		$('.s_sp_count').val("");
	}
})

// 금액 입력 시
$(".s_sp_amount").keyup(function() {
	// 결재선 지정이 안되어 있다면
	if($('div').hasClass('s_div') == false) {
		swal({
				title: "",
				text: "결재선 지정을 먼저 해주세요",
				icon: "error",
				closeOnClickOutside: false,
				closeOnEsc: false
			});
		// 입력한 내용 지우기
		$('.s_sp_amount').val("");
	}
})
</script>

<!-- 결재선 지정스크립트 -->
<script>
$(document).ready(function() {
	let emplNo = null;  //선택된 사원 번호 저장
	
	let secEmplNo = '${empVO.emplNo}';
	let secEmplNm = '${empVO.emplNm}';
	
	console.log("secEmplNo번호 : ",secEmplNo);
	console.log("secEmplNm이름 : ",secEmplNm);
	
	$(document).on("click",".jstree-anchor",function(){
	let idStr = $(this).prop("id");//20250008_anchor
	// 		console.log("개똥이->idStr : ",idStr);
	emplNo = idStr.split("_")[0];//20250008
	console.log("결재선지정->emplNo : ",emplNo);

	});//end jstree-anchor
	$(document).on("click", "#add_appLine",function(){
		//사원선택안하고 화살표로 추가 했을때
		if(!emplNo){
			swal({
				title: "",
				text: "선택한 사원이 없습니다.",
				icon: "error",
				closeOnClickOutside: false,
				closeOnEsc: false
			});
			return;
		}
		
		//여기에선 본인을 선택하면 본인은 추가 안되게 만들어야함(완료)
		if(secEmplNo==emplNo){
			swal({
				title: "",
				text: "본인은 결재선 리스트에 추가할 수 없습니다.",
				icon: "error",
				closeOnClickOutside: false,
				closeOnEsc: false
			});
			return;
		}
		
		//여기서 이미 결재선 넣어준 사람은 다시 들어지 않게 해야함
		for(let i = 0; i< $('.s_td_no').length; i++){
			if($('.s_td_no').eq(i).text()== emplNo){
				swal({
					title: "",
					text: "결재선에 이미 선택되어 있습니다.",
					icon: "error",
					closeOnClickOutside: false,
					closeOnEsc: false
				});
				
				return;
			}
		}
			//여기서 전결여부는 장급만 되어야함
		$.ajax({
				url:"/atrz/appLineEmp",
				data:{"emplNo":emplNo},
				type:"post",
				dataType:"json",
				success:function(result){
					let resultObj = result;
					console.log("result : ", result);
					console.log("result.emplNm : ",result.emplNm);
					console.log("result.posNm : ",result.posNm);
					
					//중복으로는 못들어가게 만들기
					
					//NO처리하기
					let noLen = $(".clsTr").length;
					console.log("noLen : ", noLen);
					//여기서는 jsp언어는 java에서 처리 못하도록 역슬래시를 사용해서 막아야한다.
					let str = `
						<tr class="clsTr" id="row_\${emplNo}" name="emplNm">
							<th>\${noLen+1}</th>
							<th style="display: none;" class="s_td_no">\${result.emplNo}</th>
							<th class="s_td_name">\${result.emplNm}</th>
							<th>\${result.deptNm}</th>
							<th>\${result.posNm}</th>
							<input type="hidden" name="emplNo" class="emplNo" value="\${result.emplNo}"/>
							<th>
								<select class="form-select selAuth" aria-label="Default select example">
									<option value="0" selected>결재</option>
									<option value="1">참조</option>
								</select>
							</th>
							<th>
								<input class="form-check-input flexCheckDefault" type="checkbox" value="Y" />
							</th>
						</tr>
						`;
					$(".s_appLine_tbody_new").append(str);    
					
				}//end success
			});//end ajax
		
		})//결재선선택후에 결재선리스트로 가는버튼 
	
	//왼쪽버튼의 경우에는 결재선선택과는 거리가 멀기 때문에 필요없음
	//왼쪽 버튼을 눌렀을때 삭제처리되어야함
	$(document).on("click", "#remo_appLine",function(){
		let lastRow = $(".s_appLine_tbody_new .clsTr").last();   //가장마지막에 추가된 tr
		//삭제대상확인 
		// console.log("삭제대상 :", lastRow.prop("outerHTML"));
		
		if(lastRow.length > 0){
			$('tr:last-child').remove(); 
				// console.log("개똥이장군");
				// console.log("lastRow : ",lastRow);
				
				// lastRow.remove();
				// console.log("삭제후 남은 행의갯수 : ",$(".s_appLine_tbody_new .clsTr").length);
				// lastRow.children().last().remove();
			}else{
				swal({
					title: "",
					text: "삭제할 사원이 없습니다.",
					icon: "error",
					closeOnClickOutside: false,
					closeOnEsc: false
				});
					return;
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
				closeOnEsc: false
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
		
		//JSON Object List
		let authList = [];
		//JSON Object
		let data = {};
		//II. 권한 정보(.selAuth)
		$(".selAuth").each(function(idx,auth){
			data = {
				"emplNo":$(this).parent().parent().children("th").eq(1).html(),
				"auth":$(this).val(),
				"flex":$(this).parent().next().children().eq(0).is(":checked")
			};
			
			authList.push(data);
		});	
		console.log("authList : ", authList);
		

		/*
		["20250008","20250010"]
		*/
		console.log("obj.emplNo : ",obj.emplNo);
		//결재선 리스트에 있는 사원번호를 가져와 결재선 jsp에 이름 부서 직책 찍기
		$.ajax({
			url:"/atrz/appLineList",
			processData:false,
			contentType:false,
			type:"post",
			data: formData,
			dataType:"json",
			success : function(result){
		$(".btn-close").trigger('click');
		console.log("result : ", result);

		let tableHtml = `<div><table border="1" class="s_eap_draft_app"><tbody>`;

		// authList를 기반으로 분리
		const approvalList = [];
		const referenceList = [];

		$.each(authList, function(i, authItem) {
			const matched = result.find(emp => emp.emplNo === authItem.emplNo);
			if (matched) {
				matched.flex = authItem.flex; // flex 정보도 보존
				if (authItem.auth === "0") {
					approvalList.push(matched);
				} else if (authItem.auth === "1") {
					referenceList.push(matched);
				}
			}
		});

		// 가. 결재파트 시작
		if (approvalList.length > 0) {
			tableHtml += `<tr><th rowspan="3">결재</th>`;
			$.each(approvalList, function(i, employeeVO){
				$("#atrz_ho_form").append(`<input type="hidden" name="empNoList" value="\${employeeVO.emplNo}"/>`);
				tableHtml += `<td>\${employeeVO.clsfCodeNm}</td>`;
			});

			tableHtml += `</tr><tr>`;
			$.each(approvalList, function(i, employeeVO){
				tableHtml += `<td>\${employeeVO.emplNm}</td>`;
			});

			tableHtml += `</tr><tr>`;
			$.each(approvalList, function(i, employeeVO){
				tableHtml += `<td>이미지</td>`;
			});

			tableHtml += `</tr>`;
		}

		// 나. 참조파트 시작
		if (referenceList.length > 0) {
			tableHtml += `<tr><th rowspan="3">참조</th>`;
			$.each(referenceList, function(i, employeeVO){
				$("#atrz_ho_form").append(`<input type="hidden" name="empAttNoList" value="\${employeeVO.emplNo}"/>`);
				tableHtml += `<td>\${employeeVO.clsfCodeNm}</td>`;
			});

			tableHtml += `</tr><tr>`;
			$.each(referenceList, function(i, employeeVO){
				tableHtml += `<td>\${employeeVO.emplNm}</td>`;
			});

			tableHtml += `</tr><tr>`;
			$.each(referenceList, function(i, employeeVO){
				tableHtml += `<td>이미지</td>`;
			});

			tableHtml += `</tr>`;
		}

		tableHtml += `</tbody></table></div>`;

		$("#s_eap_draft_app").html(tableHtml);
		}
	});//ajax
	//여기서 결재선에 담긴 애들을 다 하나씩 담아서 post로
})

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
<!-- 로그인한 정보 가져오기 위한 시큐리티 -->
<!-- <p><sec:authentication property="principal.Username"/></p> -->

</body>
</html>
