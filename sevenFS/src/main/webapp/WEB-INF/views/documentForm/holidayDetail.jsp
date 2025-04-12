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
		<form id="atrz_ho_form" action="/atrz/appLineList" method="post" enctype="multipart/form-data">
			<div class="container-fluid">
				<!-- 여기서 작업 시작 -->
				<!-- <p>${atrzVO}</p> -->
				<!-- <p>${sanEmplVOList}</p> -->
				<div class="row">
					<div class="col-sm-12 mb-3 mb-sm-0">
						<!-- 결재요청 | 임시저장 | 결재선지정 | 취소  -->
						<div class="col card-body" id="approvalBtn">
							<!-- 새로운 버튼 -->
							<div class="tool_bar">
								<div class="critical d-flex gap-2 mb-3">
									<button id="atrzAppBtnTo" type="button" 
										class="btn btn-outline-success d-flex align-items-center gap-1 atrzAppBtn" 
										data-bs-toggle="modal" data-bs-target="#atrzApprovalModal">
										<span class="material-symbols-outlined fs-5">note_alt</span> 결재
									</button>
									<a id="atrzComBtnTo" type="button"
										class="btn btn-outline-danger d-flex align-items-center gap-1"
										data-bs-toggle="modal" data-bs-target="#atrzCompanModal"> <span
										class="material-symbols-outlined fs-5 atrzComBtn">keyboard_return</span> 반려
									</a> 
									<a type="button"
										class="btn btn-outline-secondary d-flex align-items-center gap-1"
										href="/atrz/approval"> <span
										class="material-symbols-outlined fs-5">format_list_bulleted</span> 목록으로
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
											<div
												style="text-align: center; font-size: 2em; font-weight: bold; padding: 20px;">연차신청서</div>

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
																<c:if test="${atrzLineVO.atrzTy eq 'N'}">
																	<!-- <p>${atrzLineVO}</p> -->
																	<td>${atrzLineVO.sanctnerClsfNm}</td>
																</c:if>
															</c:forEach>
														</tr>
														<tr>
															<c:forEach var="atrzLineVO" items="${atrzVO.atrzLineVOList}">
																<c:if test="${atrzLineVO.atrzTy eq 'N'}">
																	<td>
																		${atrzLineVO.sanctnerEmpNm}
																		<input type="hidden" name="atrzLnSn" value="${atrzLineVO.atrzLnSn}" />
																		<input type="hidden" name="sanctnerEmpno" value="${atrzLineVO.sanctnerEmpno}" />
																	</td>
																</c:if>
															</c:forEach>
														</tr>
														<tr>
															<c:forEach var="atrzLineVO" items="${atrzVO.atrzLineVOList}">
																<c:if test="${atrzLineVO.atrzTy eq 'N'}">
																	<td>
																		<c:choose>
																			<c:when test="${atrzLineVO.sanctnProgrsSttusCode eq '10'}">
																				<img src="/assets/images/atrz/afterRe.png" style="width: 50px;">
																			</c:when>
																			<c:otherwise>
																				<img src="/assets/images/atrz/beforGR.png" style="width: 50px;">
																			</c:otherwise>
																		</c:choose>
																	</td>
																</c:if>
															</c:forEach>
														</tr>
												
														<!-- 참조자: atrzTy = 'Y' -->
														<c:set var="hasReference" value="false" />
														<c:forEach var="atrzLineVO" items="${atrzVO.atrzLineVOList}">
															<c:if test="${atrzLineVO.atrzTy eq 'Y'}">
																<c:set var="hasReference" value="true" />
															</c:if>
														</c:forEach>
												
														<c:if test="${hasReference eq true}">
															<tr>
																<th rowspan="2">참조</th>
																<c:forEach var="atrzLineVO" items="${atrzVO.atrzLineVOList}">
																	<c:if test="${atrzLineVO.atrzTy eq 'Y'}">
																		<td>${atrzLineVO.sanctnerClsfNm}</td>
																	</c:if>
																</c:forEach>
															</tr>
															<tr>
																<c:forEach var="atrzLineVO" items="${atrzVO.atrzLineVOList}">
																	<c:if test="${atrzLineVO.atrzTy eq 'Y'}">
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
												<!--여기에 결재선이 보여야하는데-->

											<div style="padding: 50px 10px 20px; clear: both;">
												<div
													style="display: inline-block; font-size: 1.2em; font-weight: bold;">제목
													:</div>
												<input type="text" class="form-control" value="${atrzVO.atrzSj}" 
													style="display: inline-block; width: 90%; margin-left: 5px;"
													id="s_ho_tt" name="atrzSj" disabled>
											</div>

											<div style="border: 1px solid lightgray; margin: 10px;"></div>
											<div style="margin: 0 10px;">
												
												<div class="row align-items-start" style="padding: 10px 0;">
													<div class="col-auto">
														<div class="s_frm_title mb-2"><b>유형</b></div>
														<div class="form-check mr-5" style="display: inline-block;">
															<input class="form-check-input" type="radio" name="holiCode" disabled id="flexRadioDefault2"  value="20" <c:if test="${atrzVO.holidayVO.holiCode eq '20'}">checked</c:if>>
															<label class="form-check-label" for="flexRadioDefault2">오전반차</label>
														</div>
														<div class="form-check mr-5" style="display: inline-block;">
															<input class="form-check-input" type="radio" name="holiCode" disabled id="flexRadioDefault2"  value="21" <c:if test="${atrzVO.holidayVO.holiCode eq '21'}">checked</c:if>>
															<label class="form-check-label" for="flexRadioDefault2">오후반차</label>
														</div>
														<div class="form-check mr-5" style="display: inline-block;">
															<input class="form-check-input" type="radio"
																name="holiCode" id="flexRadioDefault1" disabled
																value="22" <c:if test="${atrzVO.holidayVO.holiCode eq '22'}">checked</c:if>> 
																<label class="form-check-label"	for="flexRadioDefault1">연차</label>
														</div>
														<div class="form-check mr-5" style="display: inline-block;">
															<input class="form-check-input" type="radio" name="holiCode" disabled id="flexRadioDefault4" value="23" <c:if test="${atrzVO.holidayVO.holiCode eq '23'}">checked</c:if>>
															<label class="form-check-label" for="flexRadioDefault4">공가</label>
														</div>
														<div class="form-check mr-5" style="display: inline-block;">
															<input class="form-check-input" type="radio" name="holiCode" disabled id="flexRadioDefault3" value="24" <c:if test="${atrzVO.holidayVO.holiCode eq '24'}">checked</c:if>>
															<label class="form-check-label" for="flexRadioDefault3">병가</label>
														</div>
													</div>
													
													<!--연차기간 선택 시작-->
													<div class="col ms-4">
														<div class="s_frm_title mb-2"><b>신청기간</b></div>
														<!-- <div style="margin: 5px 0;">
															사용 가능한 휴가일수는 <span id="s_ho_use">${checkHo }</span>일 입니다.
														</div> -->
														<div>
															<!-- <p>${atrzVO.holidayVO}</p> -->
															<fmt:formatDate value="${atrzVO.holidayVO.holiStart}" pattern="yyyy-MM-dd" var="onlyStDate" />
															<fmt:formatDate value="${atrzVO.holidayVO.holiStart}" pattern="HH:mm:ss" var="onlyStTime" />
															<input type="text" placeholder="신청 시작 기간을 선택해주세요"

																class="form-control s_ho_start d-inline-block"
																style="width: 250px; cursor: context-menu;" value="${onlyStDate}" disabled
																id="s_ho_start" >
															<input type="time" class="form-control d-inline-block"
																style="width: 150px; display: none;"
																id="s_start_time" value=${onlyStTime}
																disabled > 부터
														</div>
														<div>
															<fmt:formatDate value="${atrzVO.holidayVO.holiEnd}" pattern="yyyy-MM-dd" var="onlyEnDate" />
															<fmt:formatDate value="${atrzVO.holidayVO.holiEnd}" pattern="HH:mm:ss" var="onlyEnTime" />
															<input type="text" placeholder="신청 종료 기간을 선택해주세요"
																class="form-control s_ho_end d-inline-block mt-2"
																style="width: 250px; cursor: context-menu;" value="${onlyEnDate}" disabled
																id="s_ho_end" />
															<input type="time" class="form-control d-inline-block"
																style="width: 150px; display: none;"
																id="s_end_time" value="${onlyEnTime}" disabled  /> 까지
															<!-- <div class="d-inline-block" >
																(총 <span id="s_date_cal">0</span>일)
															</div> -->
														</div>
													</div>	
													<!--연차기간 선택 끝-->

												</div>

												<div style="padding: 10px 0;">
													<div class="s_frm_title mb-2"> 내용</div>
													<textarea class="form-control s_scroll"
														style="resize: none; height: 150px;" id="s_ho_co" name="atrzCn" 
														disabled rows="2" cols="20" wrap="hard">${atrzVO.atrzCn}</textarea>
												</div>

												

												<div style="padding: 10px 0;">
													<div class="s_frm_title">파일첨부</div>
													<div id="s_file_upload">
														<input type="file" name="uploadFile" id="eap_file_path" multiple  disabled/>
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
								<div class="critical d-flex gap-2 mb-3 mt-3">
									<button id="atrzAppBtnBo" type="button" 
										class="btn btn-outline-success d-flex align-items-center gap-1 atrzAppBtn" 
										data-bs-toggle="modal" data-bs-target="#atrzApprovalModal">
										<span class="material-symbols-outlined fs-5">note_alt</span> 결재
									</button>
									<a id="atrzComBtnBo" type="button"
										class="btn btn-outline-danger d-flex align-items-center gap-1"
										data-bs-toggle="modal" data-bs-target="#atrzCompanModal"> <span
										class="material-symbols-outlined fs-5 atrzComBtn">keyboard_return</span> 반려
									</a> 
									<a type="button"
										class="btn btn-outline-secondary d-flex align-items-center gap-1"
										href="/atrz/approval"> <span
										class="material-symbols-outlined fs-5">format_list_bulleted</span> 목록으로
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
        url: "/atrz/selectForm/atrzDetailUpdate", // 서버의 결재 상태 업데이트 API
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

$("#atrzDetailComBtn").on("click",function(){
	const atrzDocNo = $("#atrzDocNo").val(); // 문서 번호 가져오기
	const companionMessage = $("#companionMessage").val(); // 반려 의견 가져오기

	// 서버로 전송할 데이터 구성
	const companionData = {
		"atrzDocNo": atrzDocNo,
		"atrzLineVOList[0].sanctnOpinion": companionMessage,
		"sanctnProgrsSttusCode": "20", // 결재 상태를 "반려"로 설정
	};
	console.log("companionData : ", companionData);
	
})



</script>
</body>

</html>
