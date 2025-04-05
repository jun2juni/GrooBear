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
		<form id="atrz_ho_form" action="/atrz/appLineList" method="post" enctype="multipart/form-data">
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
										class="btn btn-outline-primary d-flex align-items-center gap-1">
										<span class="material-symbols-outlined fs-5">cancel</span> 결재요청
									</button>
									<a id="s_eap_stor" type="button"
										class="btn btn-outline-success d-flex align-items-center gap-1"
										data-bs-toggle="modal" data-bs-target="#atrzLineModal"> <span
										class="material-symbols-outlined fs-5">error</span> 임시저장
									</a> <a id="s_appLine_btn" type="button"
										class="btn btn-outline-info d-flex align-items-center gap-1"
										data-bs-toggle="modal" data-bs-target="#atrzLineModal"> <span
										class="material-symbols-outlined fs-5">error</span> 결재선 지정
									</a> <a type="button"
										class="btn btn-outline-danger d-flex align-items-center gap-1"
										href="/atrz/home"> <span
										class="material-symbols-outlined fs-5">cancel</span> 취소
									</a>
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
						<!-- 모달창 인포트 -->
						<c:import url="../documentForm/approvalLineModal.jsp" />
							<div class="card">
								<div class="card-body">
									<!-- 여기다가 작성해주세요(준희) -->
									<!-- 기능 시작 -->
									<!-- 전자결재 양식 수정도 가능 시작 -->
									
									<div id="s_eap_content_box_left" class="s_scroll">
										<div class="s_div_container s_scroll">
											<div
												style="text-align: center; font-size: 2em; font-weight: bold; padding: 20px;">연차신청서</div>

											<div style="float: left; width: 230px; margin: 0 30px;">
												<table border="1" id="s_eap_draft_info">
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
														<th>기안일</th>
														<td>SYSDATE</td>
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


											<div style="float: left; width: 800px; margin-right: 5px;"
												id=s_eap_draft_app>
												
												</div>

											<div style="padding: 50px 10px 20px; clear: both;">
												<div
													style="display: inline-block; font-size: 1.2em; font-weight: bold;">제목
													:</div>
												<input type="text" class="form-control"
													style="display: inline-block; width: 90%; margin-left: 5px;"
													id="s_ho_tt" name="atrzSj" required="required">
											</div>

											<div style="border: 1px solid lightgray; margin: 10px;"></div>
											<div style="margin: 0 10px;">

												<div style="padding: 10px 0;">
													<div class="s_frm_title">1. 종류</div>
													<div class="form-check" style="display: inline-block;">
														<input class="form-check-input" type="radio"
															name="holiCode" id="flexRadioDefault1" checked
															value="A"> <label class="form-check-label"
															for="flexRadioDefault1"> 연차 </label>
													</div>
													<div class="form-check" style="display: inline-block;">
														<input class="form-check-input" type="radio"
															name="holiCode" id="flexRadioDefault2" value="B">
														<label class="form-check-label" for="flexRadioDefault2">
															반차 </label>
													</div>
													<div class="form-check" style="display: inline-block;">
														<input class="form-check-input" type="radio"
															name="holiCode" id="flexRadioDefault3" value="C">
														<label class="form-check-label" for="flexRadioDefault3">
															병가 </label>
													</div>
													<div class="form-check" style="display: inline-block;">
														<input class="form-check-input" type="radio"
															name="holiCode" id="flexRadioDefault4" value="D">
														<label class="form-check-label" for="flexRadioDefault4">
															공가 </label>
													</div>
												</div>

												<div style="padding: 10px 0;">
													<div class="s_frm_title">2. 내용</div>
													<textarea class="form-control s_scroll"
														style="resize: none; height: 150px;" id="s_ho_co" name="atrzCn" 
														required="required" rows="2" cols="20" wrap="hard"></textarea>
												</div>

												<div style="padding: 10px 0;">
													<div class="s_frm_title">3. 신청기간</div>
													<div style="margin: 5px 0;">
														사용 가능한 휴가일수는 <span id="s_ho_use">${checkHo }</span>일 입니다.
													</div>
													<div>
														<input type="text" placeholder="신청 시작 기간을 선택해주세요"
															class="form-control s_ho_start"
															style="width: 250px; display: inline-block; cursor: context-menu;"
															id="s_ho_start" required="required" onchange="dateCnt();" name="holiStartArr">
														<input type="time" class="form-control"
															style="width: 150px; display: inline-block;"
															id="s_start_time" min="09:00:00" max="18:00:00"
															required="required" onchange="dateCnt();" name="holiStartArr"> 부터
													</div>
													<div>
														<input type="text" placeholder="신청 종료 기간을 선택해주세요"
															class="form-control s_ho_end"
															style="width: 250px; display: inline-block; cursor: context-menu; margin-top: 10px;"
															id="s_ho_end" required="required" onchange="dateCnt();" name="holiEndArr" />
														<input type="time" class="form-control"
															style="width: 150px; display: inline-block;"
															id="s_end_time" min="09:00:00" max="18:00:00"
															required="required" onchange="dateCnt();" name="holiEndArr" /> 까지
														<div style="display: inline-block;">
															(총 <span id="s_date_cal">0</span>일)
														</div>
													</div>
												</div>

												<div style="padding: 10px 0;">
													<div class="s_frm_title">파일첨부</div>
													<div id="s_file_upload">
														<input type="file" name="uploadFile" id="eap_file_path" multiple />
													</div>
													<input type="hidden" name="fileUrl" id="fileUrl">
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
										class="btn btn-outline-primary d-flex align-items-center gap-1">
										<span class="material-symbols-outlined fs-5">cancel</span> 결재요청
									</button>
									<a id="s_eap_stor" type="button"
										class="btn btn-outline-success d-flex align-items-center gap-1"
										data-bs-toggle="modal" data-bs-target="#atrzLineModal"> <span
										class="material-symbols-outlined fs-5">error</span> 임시저장
									</a> <a id="s_appLine_btn" type="button"
									
										class="btn btn-outline-info d-flex align-items-center gap-1"
										data-bs-toggle="modal" data-bs-target="#atrzLineModal"> <span
										class="material-symbols-outlined fs-5">error</span> 결재선 지정
									</a> <a type="button"
										class="btn btn-outline-danger d-flex align-items-center gap-1"
										href="/atrz/home"> <span
										class="material-symbols-outlined fs-5">cancel</span> 취소
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
// 결재요청 클릭 시
$("#s_eap_app").click(function() {
	var eap_title = $('#s_ho_tt').val();
	var eap_content = $('#s_ho_co').val();
	// textarea에 \r \n같은 문자를 <br>로 바꿔주기
	eap_content = eap_content.replace(/(?:\r\n|\r|\n)/g,'<br/>');
	var ho_code = $('input[type=radio]:checked').val();
	var ho_start = $('#s_ho_start').val() + " " + $('#s_start_time').val();
	var ho_end = $('#s_ho_end').val() + " " + $('#s_end_time').val();
	var ho_use_count = $('#s_date_cal').text();
	
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
                  closeOnEsc: false
              });
		$("#s_end_time").val('');
	}
	
	// 제목, 내용이 비어있을 때
	if(eap_title == "" || eap_content == "") {
		swal({
                  title: "제목 또는 내용이 비어있습니다.",
                  text: "다시 확인해주세요.",
                  icon: "error",
                  closeOnClickOutside: false,
                  closeOnEsc: false
              });
		return;
	}
	
	// 신청한 휴가일수가 0일때 alert
	if(ho_use_count == 0) {
		swal({
                  title: "신청한 휴가일수가 0일입니다",
                  text: "날짜와 시간을 다시 선택해주세요",
                  icon: "error",
                  closeOnClickOutside: false,
                  closeOnEsc: false
              });
		return;
	}
	
	var s_ho_use = $("#s_ho_use").text();
	
	// 사용 가능한 휴가일수보다 신청한 휴가일수가 더 많을 때 alert
	// ex) s_ho_use(사용 가능한 휴가일수) = 14.5 / ho_use_count(신청한 휴가 일수) = 1
	if(parseFloat(ho_use_count) > parseFloat(s_ho_use)) {
		swal({
				title: "사용 가능한 휴가일수보다 신청한 휴가일수가 더 많습니다.",
				text: "날짜와 시간을 다시 선택해주세요",
				icon: "error",
				closeOnClickOutside: false,
				closeOnEsc: false
			});
		return;
	}
});
// <!-- 결재선지정하는 관련 스크립트 끝 -->


// 총 일수 계산 함수
function dateCnt() {
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
				closeOnEsc: false
			});
		$("#s_end_time").val('');
	}
	
	if((0 < diffDay && diffDay < 1) && (0 < diffTime && diffTime < 8)) {
		$('#s_date_cal').text('0.5'); // 반차
	} else if(diffTime >= 1 && diffTime >= 8) {
		
		// 평일 계산할 cnt 선언
		let cnt = 0;
		while(true) {
			let tmpDate = start;
			// 시작시간이 끝나는시간보다 크면
			if(tmpDate.getTime() > end.getTime()) {
				break;
			} else { // 아니면
				let tmp = tmpDate.getDay();
				// 평일일 때 
				if(tmp != 0 && tmp != 6) {
					cnt++;
				} 
				tmpDate.setDate(start.getDate() + 1);
			}
		}
		
		// 날짜 계산
		let diff = Math.abs(end.getTime() - start.getTime());
		diff = Math.ceil(diff / (1000 * 3600 * 24));
		
		// cnt string으로 변환하여 일수 나타내기
		var cntStr = String(cnt);
		$('#s_date_cal').text(cntStr);
		
	} else {
		$('#s_date_cal').text('0');
	}
}
</script>

<script>
//JSON Object List
let authList = [];

$(document).ready(function() {
	//******* 폼 전송 *******
	$("#s_eap_app_bottom").on("click",function(){
		event.preventDefault();
// 		alert("체킁");
		console.log("전송하기 체킁 확인");
		console.log("s_eap_app_bottom->authList : ", authList);
		
		let jnForm = document.querySelector("#atrz_ho_form");
		// console.log("${empVO}" + empVO);
		
		
	

		
		let formData = new FormData();
		formData.append("atrzSj",jnForm.atrzSj.value);
		formData.append("atrzCn",jnForm.atrzCn.value);
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
				holiCode:jnForm.holiCode.value

		}
		console.log("docHoliday",docHoliday);
		
		// 가끔 VO가 depth가 깊어 복잡할 땡!, 파일과 별개로
		// BACKEND에서 @RequestPart("test")로 받아 버리장
		formData.append("atrzLineList",new Blob([JSON.stringify(atrzLineList)],{type:"application/json"}));
		formData.append("docHoliday",new Blob([JSON.stringify(docHoliday)],{type:"application/json"}));
		
		formData.append("emplNo",secEmplNo);
		formData.append("emplNm",secEmplNm);
		
		const junyError = (request, status, error) => {
       				 console.log("code: " + request.status)
        			 console.log("message: " + request.responseText)
        			 console.log("error: " + error);
            }

		$.ajax({
			url:"/atrz/atrzInsert",
			processData:false,
			contentType:false,
			type:"post",
			data: formData,
			dataType:"text",
			success : function(result){
				console.log("체킁:",result);
				if(result=="쭈니성공"){
					//location.href = "컨트롤러주소";  //  .href 브라우져 성능 향상을 위해서 캐쉬가 적용 될 수도 있고, 안 될 수도 있어
					location.replace("/atrz/home")
				}
			},
			error: junyError
		})
		
		//<form
		//여기서 for문을돌려서 하나씩 담아줘야한다.
		/*
		let str ="";
		$.each(authList, function(i,emp){
			str +=`
				<input type="hidden" name="documHolidayVO.atrzLineVOList[${i}].atrzLnSn" value="\${emp.atrzLnSn}" /><br>
				<input type="hidden" name="documHolidayVO.atrzLineVOList[${i}].sanctnerEmpno" value="\${emp.auth}" /><br>
				<input type="hidden" name="documHolidayVO.atrzLineVOList[${i}].atrzTy" value="\${emp.emplNo}" /><br>
				<input type="hidden" name="documHolidayVO.atrzLineVOList[${i}].dcrbAuthorYn" value="\${emp.flex}" /><br>
			`;
		})
		
		// console.log("str : "+str);
		$("#atrz_ho_form").append(str);
		*/
		
		
		//폼제출
		//$("#atrz_ho_form").submit();	

	});
	
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
		
		
		//JSON Object
		let data = {};
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
				"auth":$(this).val(),
				"flex":dcrbAuthorYn,
				"atrzLnSn":(idx+1)
			};
			
			authList.push(data);
		});	
		
		//*******
		/*
		[
		    {
		        "emplNo": "20250008",
		        "auth": "0",
		        "flex": true
		    },
		    {
		        "emplNo": "20250010",
		        "auth": "1",
		        "flex": false
		    }
		]
		*/
		console.log("순번권한전결여부authList : ", authList);
		
// 		let flexList = [];
		
		//III. 전결여부(.flexCheckDefault)
// 		$(".flexCheckDefault").each(function(idx,flex){
// 			console.log("flex : ", $(this).is(":checked"));
			
// 			if($(this).is(":checked")){
// 				flexList.push("Y");
// 			}else{
// 				flexList.push("N");
// 			}
			
// 		});
		

		/*
		["20250008","20250010"]
		*/
		console.log("obj.emplNo : ",obj.emplNo);
		//이게 굳이 필요있나 싶음
		//결재선 리스트에 있는 사원번호를 가져와 결재선 jsp에 이름 부서 직책 찍기

//asnyc를 써서 
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

		let tableHtml = `<table border="1" class="s_eap_draft_app"><tbody>`;

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
				tableHtml += `<td name="sanctnerEmpno">\${employeeVO.emplNm}</td>`;
			});

			tableHtml += `</tr><tr>`;
			$.each(approvalList, function(i, employeeVO){
				tableHtml += `<td><img
					src="/assets/images/atrz/beforGR.png"
					style="width: 50px;"></td>`;
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
		}
	});//ajax
	//여기서 결재선에 담긴 애들을 다 하나씩 담아서 post로
})


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
			
			// 시작 날짜와 끝나는 날짜 비교하여 끝나는 날짜보다 시작하는 날짜가 앞이면 경고창으로 안내
			if(date1 < date2 == true) {
				swal({
					title: "신청 시작 기간을 다시 선택해주세요.",
					text: "",
					icon: "error",
					closeOnClickOutside: false,
					closeOnEsc: false
				});
				$("#s_ho_start").val("");
			}
			dateCnt();
			},
			beforeShow: function() {
				setTimeout(function(){
					$('.ui-datepicker').css('z-index', 99999999999999);
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
            
              	// 시작 날짜와 끝나는 날짜 비교하여 시작하는 날짜보다 끝나는 날짜가 앞이면 경고창으로 안내
			if(date1 > date2 == true) {
				swal({
					title: "신청 종료 기간을 다시 선택해주세요.",
					text: "",
					icon: "error",
					closeOnClickOutside: false,
					closeOnEsc: false
				});
				$("#s_ho_end").val("");
			}
			dateCnt();
			},
			beforeShow: function() {
				setTimeout(function(){
					$('.ui-datepicker').css('z-index', 99999999999999);
				}, 0);
			}
	});
});

function disableAllTheseDays2(date) {
		var day = date.getDay();
		return [(day != 0 && day != 6)];
	// 0=일, 6=토 => 안나오게 할 것 
    }
</script>
	<!-- 주니가 입력한 스크립트 끝 -->
	<p></p>
	<p>
		<sec:authentication property="principal.Username" />
	</p>

</body>

</html>
