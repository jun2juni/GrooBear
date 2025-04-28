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
/* .ui-icon ui-icon-circle-triangle-e{ */
	
/* } */



</style>
<title>${title}</title>
<%@ include file="../layout/prestyle.jsp"%>
</head>
<body>
	<sec:authentication property="principal.empVO" var="empVO" />
	<%-- <p> ${empVO.emplNm} ${empVO.emplNo}</p> --%>
	<%@ include file="../layout/sidebar.jsp"%>
	<main class="main-wrapper">
		<%@ include file="../layout/header.jsp"%>
		<section class="section">
		<form id="atrz_ho_form" action="/atrz/insertAtrzLine" method="post" enctype="multipart/form-data">
			<div class="container-fluid">
				<!-- 여기서 작업 시작 -->
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
									<a id="s_eap_storTo" type="button" class="btn btn-outline-success d-flex align-items-center gap-1 s_eap_stor"
										style="padding: 0.4rem 1rem; font-size: 0.95rem;"> 
										<span class="material-symbols-outlined fs-5">downloading</span> 임시저장
									</a> 
									<a id="s_appLine_btn" type="button"
										class="btn btn-outline-info d-flex align-items-center gap-1"
										data-bs-toggle="modal" data-bs-target="#atrzLineModal"
										style="padding: 0.4rem 1rem; font-size: 0.95rem;"> 
										<span class="material-symbols-outlined fs-5">error</span> 결재선 지정
									</a> 
									<a type="button" id="cancelButton"
										class="btn btn-outline-danger d-flex align-items-center gap-1 atrzLineCancelBtn"
										style="padding: 0.4rem 1rem; font-size: 0.95rem;"> 
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
									
									<div id="s_eap_content_box_left" class="s_scroll">
										<div class="s_div_container s_scroll">
											<div style="text-align: center; font-size: 2em; font-weight: bold; padding: 20px;">연차신청서</div>
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


											<div style="float: right;  margin-right: 10px;"
												id=s_eap_draft_app>
												
												</div>

											<div style="padding: 50px 10px 20px; clear: both;">
												<div
													style="display: inline-block; font-size: 1.2em; font-weight: bold;">제목
													:</div>
												<input type="text" class="form-control" placeholder="제목을 입력해주세요"
													style="display: inline-block; width: 90%; margin-left: 5px;"
													id="s_ho_tt" name="atrzSj" required="required">
											</div>

											<div style="border: 1px solid lightgray; margin: 10px;"></div>
											<div style="margin: 0 10px;">

												<div class="row align-items-start" style="padding: 10px 0;">
													<div class="col-auto">
														<div class="s_frm_title mb-2"><b>유형</b></div>
														<div class="form-check mr-5" style="display: inline-block;">
															<input class="form-check-input" type="radio" name="holiCode" id="flexRadioDefault1" value="20">
															<label class="form-check-label" for="flexRadioDefault1">오전반차</label>
														</div>
														<div class="form-check mr-5" style="display: inline-block;">
															<input class="form-check-input" type="radio" name="holiCode" id="flexRadioDefault2" value="21">
															<label class="form-check-label" for="flexRadioDefault2">오후반차</label>
														</div>
														<div class="form-check mr-5" style="display: inline-block;">
															<input class="form-check-input" type="radio" checked name="holiCode" id="flexRadioDefault3" value="22"> 
																<label class="form-check-label"	for="flexRadioDefault3">연차</label>
														</div>
														<div class="form-check mr-5" style="display: inline-block;">
															<input class="form-check-input" type="radio" name="holiCode" id="flexRadioDefault4" value="23">
															<label class="form-check-label" for="flexRadioDefault4">공가</label>
														</div>
														<div class="form-check mr-5" style="display: inline-block;">
															<input class="form-check-input" type="radio" name="holiCode" id="flexRadioDefault5" value="24">
															<label class="form-check-label" for="flexRadioDefault5">병가</label>
														</div>
													</div>
													
													<!--연차기간 선택 시작-->
													<div class="col ms-4">
														<div class="s_frm_title mb-2"><b>신청기간</b></div>
														<div>
															<%
																java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
																String today = sdf.format(new java.util.Date());
															%>
															<input type="text" class="form-control s_ho_start d-inline-block"
																style="width: 150px; cursor: context-menu;"  value="<%= today %>" 
																id="s_ho_start" required="required" onchange="dateCnt();" name="holiStartArr">
															<input type="hidden" class="form-control d-inline-block" 
																style="width: 150px; display: none;" 
																id="s_start_time" min="09:00:00" max="18:00:00" value="09:00:00"
																disabled onchange="dateCnt();" name="holiStartArr"> ~
															<input type="text" class="form-control s_ho_end d-inline-block mt-2"
																style="width: 150px; cursor: context-menu;" value="<%= today %>" 
																id="s_ho_end" required="required" onchange="dateCnt();" name="holiEndArr" />
															<input type="hidden" class="form-control d-inline-block"
																style="width: 150px; display: none;"
																id="s_end_time" min="09:00:00" max="18:00:00" value="18:00:00"
																disabled onchange="dateCnt();" name="holiEndArr" />
															<div class="d-inline-block" style="display: none !important;">
																(총 <span id="s_date_cal">0</span>일) &nbsp;&nbsp;&nbsp;
															</div>
															<div class="d-inline-block" >
																(총 <span id="s_date_calView">0</span>일) &nbsp;&nbsp;&nbsp;
															</div>
														</div>
														<div id="halfTypeArea" style="display: none; margin-top: 5px;">
															<div class="form-check d-inline-block mr-3">
																<input class="form-check-input" type="radio" name="halfType" id="halfAm" value="AM" checked>
																<label class="form-check-label" for="halfAm">오전반차</label>
															</div>
															<div class="form-check d-inline-block">
																<input class="form-check-input" type="radio" name="halfType" id="halfPm" value="PM">
																<label class="form-check-label" for="halfPm">오후반차</label>
															</div>
														</div>
														<div style="margin: 5px 0;">
															사용 가능한 휴가일수는 
															<span id="s_ho_use"><fmt:formatNumber value="${checkHo}" minFractionDigits="0" maxFractionDigits="1" /></span>일 입니다.
														</div>
													</div>	
													<!--연차기간 선택 끝-->

												</div>

												<div style="padding: 10px 0;">
													<div class="s_frm_title mb-2">내용</div>
													<textarea class="form-control s_scroll" placeholder="내용을 입력해주세요"
														style="resize: none; height: 150px;" id="s_ho_co" name="atrzCn" 
														required="required" rows="2" cols="20" wrap="hard"></textarea>
												</div>

												<form action="/fileUpload" method="post" enctype="multipart/form-data">
													
													<file-upload
															label="첨부파일"
															name="uploadFile"
															max-files="1"
															contextPath="${pageContext.request.contextPath }"
													></file-upload>
												</form>
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
									<a id="s_appLine_btn" type="button" class="btn btn-outline-info d-flex align-items-center gap-1"
										data-bs-toggle="modal" data-bs-target="#atrzLineModal"
										style="padding: 0.4rem 1rem; font-size: 0.95rem;">
										<span class="material-symbols-outlined fs-5">error</span> 결재선 지정
									</a> 
									<a type="button" href="/atrz/home"
										class="btn btn-outline-danger d-flex align-items-center gap-1 atrzLineCancelBtn"
										style="padding: 0.4rem 1rem; font-size: 0.95rem;" > 
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
//페이지 로딩시 합계계산
document.addEventListener("DOMContentLoaded",function(){
	dateCnt();
})

//제목 너무 길게 입력하면 입력초과 스왈
document.getElementById('s_ho_tt').addEventListener('input', function (event) {
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


// 총 일수 계산 함수
function dateCnt() {
	// 공가(23) 또는 병가(24)일 경우 총일수를 0으로 설정
	if ($("input[name='holiCode']:checked").val() === '23' || $("input[name='holiCode']:checked").val() === '24') {
		$('#s_date_cal').text('0');
		//신청종료일자를 초기화 시켜줘
		//신청종료일자를 없애고 다시 셋팅할수있게 해줘
		
		return;
	}
	// 날짜 계산
	var start = new Date($('#s_ho_start').val() + 'T' + $('#s_start_time').val());
	var end = new Date($('#s_ho_end').val() + 'T' + $('#s_end_time').val());
	// 일수 구하기
	var diffDay = (end.getTime() - start.getTime()) / (1000*60*60*24);
	// 시간 구하기(휴식시간 1시간 제외)
	var diffTime = (end.getTime() - start.getTime()) / (1000*60*60) -1;
	
	// 신청 종료시간이 시작시간보다 빠를 때
	if(start > end) {
		swal({
				title: "종료 시간이 시작 기간보다 빠를 수 없습니다!",
				text: "신청 종료 시간을 다시 선택해주세요.",
				icon: "error",
				closeOnClickOutside: false,
				closeOnEsc: false,
				button: "확인"
			});
		$("#s_end_time").val('');
	}
	
	if((0 < diffDay && diffDay < 1) && (0 < diffTime && diffTime < 8)) {
		$('#s_date_cal').text('0.5'); // 반차
		$('#s_date_calView').text('0.5'); // 반차
	} else if(diffTime >= 1 && diffTime >= 8) {
		
		// 평일 계산할 cnt 선언
		let cnt = 0;
		while(true) {
			let tmpDate = new Date(start); // Clone the start date
			// 시작시간이 끝나는시간보다 크면
			if(tmpDate.getTime() > end.getTime()) {
				break;
			} else { // 아니면
				let tmp = tmpDate.getDay();
				// 평일일 때 
				if(tmp != 0 && tmp != 6) {
					cnt++;
				} 
				start.setDate(start.getDate() + 1);
			}
		}
		
		// 날짜 계산
		let diff = Math.abs(end.getTime() - start.getTime());
		diff = Math.ceil(diff / (1000 * 3600 * 24));
		
		// cnt string으로 변환하여 일수 나타내기
		var cntStr = String(cnt);
		$('#s_date_cal').text(cntStr);
		$('#s_date_calView').text(cntStr);
		
		// 연차사용신청일을 변수에 담기
		let holidayUsageDates = {
			startDate: $('#s_ho_start').val(),
			endDate: $('#s_ho_end').val()
		};
		
	} else {
		$('#s_date_cal').text('0');
		$('#s_date_calView').text('0');
	}
}
// 오전반차 및 오후반차 선택 시 시간 설정 및 총일수 계산
$("input[name='holiCode']").on("change", function () {
	const selectedValue = $(this).val();
	if (selectedValue === "20") { // 오전반차
		$("#s_start_time").val("09:00:00").prop("disabled", true).show();
		$("#s_end_time").val("13:00:00").prop("disabled", true).show();
		$("#s_ho_end").val($("#s_ho_start").val()); // 종료일을 시작일과 동일하게 설정
		$("#s_ho_end").hide();
		$("#halfTypeArea").hide();
	} else if (selectedValue === "21") { // 오후반차
		$("#s_start_time").val("14:00:00").prop("disabled", true).show();
		$("#s_end_time").val("18:00:00").prop("disabled", true).show();
		$("#s_ho_end").val($("#s_ho_start").val()); // 종료일을 시작일과 동일하게 설정
		$("#s_ho_end").hide();
		$("#halfTypeArea").hide();
	} else {
		$("#s_start_time").val("09:00:00").prop("disabled", false).hide();
		$("#s_end_time").val("18:00:00").prop("disabled", false).hide();
		$("#halfTypeArea").hide();
	}
	dateCnt(); // 총일수 계산 호출
});

//시작날짜를 input을 클릭하면 자동으로 종료일자 셋팅값을 null로 넣어준다.
$("#s_ho_start").on("click", function() {
		$("#s_ho_end").val(null);
});
</script>

<script>
//JSON Object List
let authList = [];

$(document).ready(function() {
	//******* 폼 전송 *******
	$(".s_eap_app").on("click",function(){
		event.preventDefault();
// 		alert("체킁");
		console.log("전송하기 체킁 확인");
		console.log("s_eap_app_bottom->authList : ", authList);
		
	//유효성검사
	var eap_title = $('#s_ho_tt').val();
	var eap_content = $('#s_ho_co').val();

	// textarea에 \r \n같은 문자를 <br>로 바꿔주기
	eap_content = eap_content.replace(/(?:\r\n|\r|\n)/g,'<br/>');
	var ho_code = $("input[name='holiCode']:checked").val();
	var ho_start = $('#s_ho_start').val() + " " + $('#s_start_time').val();
	var ho_start_D = $('#s_ho_start').val();
	var ho_end = $('#s_ho_end').val() + " " + $('#s_end_time').val();
	var ho_end_D = $('#s_ho_end').val();
	var ho_use_count = $('#s_date_cal').text();
	var ho_use_countView = $('#s_date_calView').text();
	
	// 결재선 지정 여부 확인
	if ($(".s_appLine_tbody_new .clsTr").length === 0) {
		swal({
			title: "결재선이 지정되지 않았습니다.",
			text: "결재선을 지정해주세요.",
			icon: "error",
			closeOnClickOutside: false,
			closeOnEsc: false,
			button: "확인"
		});
		return;
	}

	//연차유형이 선택되지 않았을경우
	if (!$("input[name='holiCode']:checked").val()) {
		swal({
			title: "연차유형이 선택되지 않았습니다.",
			text: "연차유형을 선택해주세요.",
			icon: "error",
			closeOnClickOutside: false,
			closeOnEsc: false,
			button: "확인"
		});
		return false;
	}
	
	// 날짜 계산
	var start = new Date($('#s_ho_start').val() + 'T' + $('#s_start_time').val());
	var end = new Date($('#s_ho_end').val() + 'T' + $('#s_end_time').val());
	
	// 신청 종료시간이 시작시간보다 빠를 때
	if(start > end) {
		swal({
				title: "종료 시간이 시작 시간보다 빠를 수 없습니다!",
				text: "신청 종료 시간을 다시 선택해주세요.",
				icon: "error",
				closeOnClickOutside: false,
				closeOnEsc: false,
				button: "확인"

			});
		$("#s_end_time").val('');
	}
	//select박스가비어있을때 연차유형이 선택되지 않았습니다.라고 알림 띄어줘
	if (!$("input[name='holiCode']:checked").val()) 
		{
			swal({
				title: "연차유형이 선택되지 않았습니다.",
				text: "연차유형을 선택해주세요.",
				icon: "error",
				closeOnClickOutside: false,
				closeOnEsc: false,
				button: "확인"
			});
			return;
		}

	//신청시간과 종료일자가 비어있을때
	if(ho_start_D == "" || ho_end_D ==""){
		swal({
				title: "신청기간이 잘못되었습니다.",
				text: "다시 확인해주세요.",
				icon: "error",
				closeOnClickOutside: false,
				closeOnEsc: false,
				button: "확인"
			});
		return;
	}
	// 제목, 내용이 비어있을 때
	if(eap_title == "" || eap_content == "") {
		swal({
				title: "제목 또는 내용이 비어있습니다.",
				text: "다시 확인해주세요.",
				icon: "error",
				closeOnClickOutside: false,
				closeOnEsc: false,
				button: "확인"
			});
		return;
	}
	//라디오 버튼 23 24인경우에는 신청휴가일수가 사용가능한 휴가일수보다 많아도 기안이 작성된다.
	if(ho_code == '23' || ho_code == '24') {
		// 아무것도 안함
	} else {
		// 신청한 휴가일수가 0일때 alert
		if(ho_use_count == 0) {
			swal({
					title: "신청한 휴가일수가 0일입니다",
					text: "날짜와 시간을 다시 선택해주세요",
					icon: "error",
					closeOnClickOutside: false,
					closeOnEsc: false,
					button: "확인"
				});
			return;
		}
	}
	
	var s_ho_use = $("#s_ho_use").text();
	
	// 사용 가능한 휴가일수보다 신청한 휴가일수가 더 많을 때 alert
	// ex) s_ho_use(사용 가능한 휴가일수) = 14.5 / ho_use_count(신청한 휴가 일수) = 1
	if(parseFloat(ho_use_count) > parseFloat(s_ho_use)) {
		//공가병가 선택시 작아도 기안이 작성된다.
		if(ho_code == '23' || ho_code == '24') {
			// 아무것도 안함
		} else {
			swal({
				title: "사용 가능한 휴가일수보다 신청한 휴가일수가 더 많습니다.",
				text: "날짜와 시간을 다시 선택해주세요",
				icon: "error",
				closeOnClickOutside: false,
				closeOnEsc: false,
				button: "확인"
			});
			return;
		}
		swal({
				title: "사용 가능한 휴가일수보다 신청한 휴가일수가 더 많습니다.",
				text: "날짜와 시간을 다시 선택해주세요",
				icon: "error",
				closeOnClickOutside: false,
				closeOnEsc: false,
				button: "확인"
			});
		return;
	}
	//유효성검사

		let jnForm = document.querySelector("#atrz_ho_form");
		// console.log("${empVO}" + empVO);
		
		let formData = new FormData();
		formData.append("docFormNm","H");
		formData.append("docFormNo",1);
		formData.append("atrzSj",jnForm.atrzSj.value);
		formData.append("atrzCn",jnForm.atrzCn.value);
		
	
		formData.append("holiUseDays", $('#s_date_cal').text());  //연차사용일수
		
		document.querySelectorAll("input[name='removeFileId']").forEach(element => {
			formData.append("removeFileId", element.value);
		});

		if(jnForm.uploadFile.files.length){
			for(let i=0; i< jnForm.uploadFile.files.length; i++)
			formData.append("uploadFile",jnForm.uploadFile.files[i]);
		}
	
		/* 값 체킁
		for(let [name,value] of formData.entries()){
			console.log("주니체킁:",name,value);
		}
		*/
		
		let atrzLineList = [];
		for(let i=0; i< authList.length; i++){
			let auth = authList[i];
			let atrzLine = {
				atrzLnSn: auth.atrzLnSn ,
				sanctnerEmpno: auth.emplNo,
			    atrzTy: auth.flex,
			    dcrbAuthorYn: auth.auth
			}
			atrzLineList.push(atrzLine);			
		}
		console.log("atrzLineList",atrzLineList);

			
		let docHoliday = {
				holiStartArr:[jnForm.holiStartArr[0].value,jnForm.holiStartArr[1].value],   
				holiEndArr:[jnForm.holiEndArr[0].value,jnForm.holiEndArr[1].value],
				holiCode:jnForm.holiCode.value,
				holiUseDays: (jnForm.holiCode.value === '23' || jnForm.holiCode.value === '24') ? '0' : $('#s_date_cal').text()
		}
		console.log("docHoliday",docHoliday);
		
		// 가끔 VO가 depth가 깊어 복잡할 땡!, 파일과 별개로
		// BACKEND에서 @RequestPart("test")로 받아 버리장
		formData.append("atrzLineList",new Blob([JSON.stringify(atrzLineList)],{type:"application/json"}));
		formData.append("docHoliday",new Blob([JSON.stringify(docHoliday)],{type:"application/json"}));
		//파일업로드시 
		formData.append("emplNo",secEmplNo);
		formData.append("emplNm",secEmplNm);
		formData.append("atrzDocNo",$("#s_dfNo").text());
		
		const junyError = (request, status, error) => {
					console.log("code: " + request.status)
					console.log("message: " + request.responseText)
					console.log("error: " + error);
            }
		$.ajax({
			url:"/atrz/atrzHolidayInsert",
			processData:false,
			contentType:false,
			type:"post",
			data: formData,
			dataType:"text",
			success : function(result){
				console.log("체킁:",result);
				if(result=="쭈니성공"){
					//location.href = "컨트롤러주소";  //  .href 브라우져 성능 향상을 위해서 캐쉬가 적용 될 수도 있고, 안 될 수도 있어
					//여기서 swal을 이용해서 결재요청이 완료되었습니다. 라고 알림을 띄우고싶어
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

	//임시저장 클릭 시
	$(".s_eap_stor").on("click",function(){
		event.preventDefault();
		// alert("체킁");
		console.log("전송하기 체킁 확인");
		console.log("s_eap_app_bottom->authList : ", authList);
		

		if ($(".s_appLine_tbody_new .clsTr").length === 0) {
		swal({
			title: "결재선이 지정되지 않았습니다.",
			text: "결재선을 지정해주세요.",
			icon: "error",
			closeOnClickOutside: false,
			closeOnEsc: false,
			button: "확인"
		});
		return;
		}

		//연차유형이 선택되지 않았을경우
		if (!$("input[name='holiCode']:checked").val()) {
			swal({
				title: "연차유형이 선택되지 않았습니다.",
				text: "연차유형을 선택해주세요.",
				icon: "error",
				closeOnClickOutside: false,
				closeOnEsc: false,
				button: "확인"
			});
			return;
		}
		if ($("#s_ho_start").val() === "") {
			swal({
				title: "시작일자가 비어있습니다.",
				text: "시작일자를 선택해주세요.",
				icon: "error",
				closeOnClickOutside: false,
				closeOnEsc: false,
				button: "확인"
			});
			return;
		}
		if ($("#s_ho_end").val() === "") {
			swal({
				title: "종료일자가 비어있습니다.",
				text: "종료일자를 선택해주세요.",
				icon: "error",
				closeOnClickOutside: false,
				closeOnEsc: false,
				button: "확인"
			});
			return;
		}


		let jnForm = document.querySelector("#atrz_ho_form");
		// console.log("${empVO}" + empVO);
		
		let formData = new FormData();
		formData.append("docFormNm","H");
		formData.append("docFormNo",1);
		formData.append("atrzSj",jnForm.atrzSj.value);
		formData.append("atrzCn",jnForm.atrzCn.value);
		
		document.querySelectorAll("input[name='removeFileId']").forEach(element => {
			formData.append("removeFileId", element.value);
		});
  
		formData.append("holiUseDays", $('#s_date_cal').text());  //연차사용일수 

		if(jnForm.uploadFile.files.length){
			for(let i=0; i< jnForm.uploadFile.files.length; i++)
			formData.append("uploadFile",jnForm.uploadFile.files[i]);
		}
	
		/* 값 체킁
		for(let [name,value] of formData.entries()){
			console.log("주니체킁:",name,value);
		}
		*/
		
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

			
		let docHoliday = {
				holiStartArr:[jnForm.holiStartArr[0].value,jnForm.holiStartArr[1].value],   
				holiEndArr:[jnForm.holiEndArr[0].value,jnForm.holiEndArr[1].value],
				holiCode:jnForm.holiCode.value,
				holiUseDays: (jnForm.holiCode.value === '23' || jnForm.holiCode.value === '24') ? '0' : $('#s_date_cal').text()
		}
		console.log("docHoliday",docHoliday);
		
		// 가끔 VO가 depth가 깊어 복잡할 땡!, 파일과 별개로
		// BACKEND에서 @RequestPart("test")로 받아 버리장
		formData.append("atrzLineList",new Blob([JSON.stringify(atrzLineList)],{type:"application/json"}));
		formData.append("docHoliday",new Blob([JSON.stringify(docHoliday)],{type:"application/json"}));
		
		formData.append("emplNo",secEmplNo);
		formData.append("emplNm",secEmplNm);
		formData.append("atrzDocNo",$("#s_dfNo").text());
		
		const junyError = (request, status, error) => {
					console.log("code: " + request.status)
					console.log("message: " + request.responseText)
					console.log("error: " + error);
			}
			//길죽이 임시저장
		$.ajax({
			url:"/atrz/atrzHolidayStorage",
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
	});//임시저장 후 끝
	
	
	//버튼눌렀을때 작동되게 하기 위해서 변수에 담아준다.
	let emplNo = null;  //선택된 사원 번호 저장
	//숫자만 있는경우에는 
	//jsp안에서 자바언어 model에 담아서 보내는것은 그냥 이엘태그로 사용해도 가능하지만
	//jsp에서 선언한 변수와 jsp에서 사용했던것은 자바에서 사용하지 못하도록 역슬래시(이스케이프문자)를 사용해서 달러중괄호 를 모두 그대로담아가게 한다.
	//그리고 순서는 자바언어 -> jsp 이렇게 순서로 진행된다. 
	//숫자만 있는경우에는 작은따옴표 사이에 넣지 않아도되지만, 만약의 사태를 대비해서 그냥 작은 따옴표로 묶어서 사용하도록!!
	/*
	jsp주석은 이것이다.	
	아니면 역슬레시를 사용해서 jsp언어라는것을 말해줘야한다.
	*/
	
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

			console.log("결재선지정->result : ",result);
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
}
	
	//왼쪽버튼의 경우에는 결재선선택과는 거리가 멀기 때문에 필요없음
	//왼쪽 버튼을 눌렀을때 삭제처리되어야함
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
            closeOnEsc: false,
			button: "확인"
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
		//II. 권한 정보(.selAuth)
		authList = [];
		$(".selAuth").each(function(idx,auth){
			//전결여부 기본 N
			let dcrbAuthorYn = "N";
			
			if($(this).parent().next().children().eq(0).is(":checked")){//true
				dcrbAuthorYn = "Y";
			}else{
				dcrbAuthorYn = "N";
			}
			
			/* data -> AtrzLineVO
			emplNo -> sanctnerEmpno
			clsfCode -> sanctnerClsfCode
			auth -> atrzTy
			flex -> dcrbAuthorYn
			atrzLnSn : atrzLnSn
			*/
			data = {
				"emplNo":$(this).parent().parent().children("th").eq(1).html(),
				"clsfCode": $(this).parent().parent().find(".clsfCode").val(),
				"auth":$(this).val(),
				"flex":dcrbAuthorYn,
				"atrzLnSn":(idx+1),
				"sanctnProgrsSttusCode":'00'
			};
			//결재선 목록
			authList.push(data);			

			formData.append("atrzLineVOList["+idx+"].sanctnerEmpno",data.emplNo);
			formData.append("atrzLineVOList["+idx+"].sanctnerClsfCode",data.clsfCode);
			formData.append("atrzLineVOList["+idx+"].atrzTy",data.auth);//Y / N 결재자 / 참조자
			formData.append("atrzLineVOList["+idx+"].dcrbAuthorYn",data.flex);//  1 / 0 전결여부
			formData.append("atrzLineVOList["+idx+"].atrzLnSn",data.atrzLnSn);
			formData.append("atrzLineVOList["+idx+"].sanctnProgrsSttusCode",data.sanctnProgrsSttusCode); //결재진행상태코드
		});	
		
		//authList의 clsfCode를 가져와서 DB에 담기
		console.log("순번권한전결여부authList : ", authList);
		
		formData.append("docFormNm","H");
		formData.append("docFormNo",1);

		/*
		["20250008","20250010"]
		*/
		console.log("obj.emplNo : ",obj.emplNo);
		//이게 굳이 필요있나 싶음
		//결재선 리스트에 있는 사원번호를 가져와 결재선 jsp에 이름 부서 직책 찍기

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
						$("#atrz_ho_form").append(`<input type="hidden" name="empNoList" value="\${employeeVO.emplNo}"/>`);
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
						$("#atrz_ho_form").append(`<input type="hidden" name="empAttNoList" value="\${employeeVO.emplNo}"/>`);
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


	// datepicker위젯
	$("#s_ho_start").datepicker({
		timepicker: true,
		changeMonth: true,
		changeYear: true,
		controlType: 'select',
		timeFormat: 'HH:mm',
		dateFormat: 'yy-mm-dd',
		yearRange: '1930:2025',
		minDate: 0, // 오늘 날짜 이전 선택 불가
		dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		monthNamesShort: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'],
		monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		beforeShowDay: disableAllTheseDays2,
		onSelect: function(dateText, inst) {
			var date1 = new Date($("#s_ho_end").val()).getTime();
			var date2 = new Date(dateText).getTime();
		// 반차일 경우 종료일도 자동으로 동일하게 세팅
		if ($("input[name='holiCode']:checked").val() === 'B') {
			$("#s_ho_end").val(dateText); // 종료일에 시작일값 넣기
		}
			
		// 시작 날짜와 끝나는 날짜 비교하여 끝나는 날짜보다 시작하는 날짜가 앞이면 경고창으로 안내
		if(date1 < date2 == true) {
			swal({
				title: "신청 시작 기간을 다시 선택해주세요.",
				text: "",
				icon: "error",
				closeOnClickOutside: false,
				closeOnEsc: false,
				button: "확인"
			});
			$("#s_ho_start").val("");
			}
			dateCnt();
		},
		beforeShow: function(input, inst) {
		setTimeout(function() {
			addDatepickerTitle("시작일자 달력");
			// 위치 계산
			var offset = $(input).offset();
			var height = $(input).outerHeight();
			//위치조정변수
			var extraTopOffset = -100; 
			var extraRightOffset = 150; // 오른쪽으로 20px 이동

			$('#ui-datepicker-div').css({
				'top': (offset.top + height + extraTopOffset) + 'px',
				'left': (offset.left + extraRightOffset) + 'px',
				'z-index': 99999999999999
			});
		}, 0);
	},
	onChangeMonthYear: function(year, month, inst) {
		setTimeout(function() {
			addDatepickerTitle("시작일자 달력");
		}, 0);
	}
	});
	
	$("#s_ho_end").datepicker({
		timepicker: true,
		changeMonth: true,
		changeYear: true,
		controlType: 'select',
		timeFormat: 'HH:mm',
		dateFormat: 'yy-mm-dd',
		yearRange: '1930:2025',
		minDate: 0, // 오늘 날짜 이전 선택 불가
		dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		monthNamesShort: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'],
		monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		beforeShowDay: disableAllTheseDays2,
		onSelect: function(dateText, inst) {
				var date1 = new Date($("#s_ho_start").val()).getTime();
				var date2 = new Date(dateText).getTime();
            
		// 반차일 경우 시작일도 자동으로 동일하게 세팅
		if ($("input[name='holiCode']:checked").val() === 'B') {
			$("#s_ho_start").val(dateText); // 시작일에 종료일 값 넣기
		}		
				
				
		// 시작 날짜와 끝나는 날짜 비교하여 시작하는 날짜보다 끝나는 날짜가 앞이면 경고창으로 안내
		if(date1 > date2 == true) {
			swal({
				title: "신청 종료 기간을 다시 선택해주세요.",
				text: "",
				icon: "error",
				closeOnClickOutside: false,
				closeOnEsc: false,
				button: "확인"
			});
			$("#s_ho_end").val("");
		}
			dateCnt();
	},
	beforeShow: function(input, inst) {
		setTimeout(function() {
		//달력명 표시 
		addDatepickerTitle("종료일자 달력");
		// 위치 계산
		var offset = $(input).offset();
		var height = $(input).outerHeight();
		//위치조정변수
		var extraTopOffset = -95; 
		var extraRightOffset = 150; // 오른쪽으로 20px 이동


		$('#ui-datepicker-div').css({
			'top': (offset.top + height + extraTopOffset) + 'px',
			'left': (offset.left + extraRightOffset) + 'px',
			'z-index': 99999999999999
		});
		}, 0);
	},
	onChangeMonthYear: function(year, month, inst) {
		setTimeout(function() {
			addDatepickerTitle("종료일자 달력");
		}, 0);
	}
	});
});


function addDatepickerTitle(title) {
	$('#ui-datepicker-div .datepicker-title').remove();
	$('#ui-datepicker-div').prepend(
		'<div class="datepicker-title" style="padding:5px 10px; font-weight:bold; border-bottom:1px solid #ccc;">' + title + '</div>'
	);
}

function disableAllTheseDays2(date) {
		var day = date.getDay();
		return [(day != 0 && day != 6)];
	// 0=일, 6=토 => 안나오게 할 것 
    }
</script>
</body>

</html>
