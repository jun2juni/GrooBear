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

/* 공제금액 스타일 */
#salTable{
    margin: 0 10px;
    margin-left: 30px;
    margin-right: 30px;
}
.salEnd{
    padding-right: 60px;
}

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
		<form id="atrz_sa_form" action="/atrz/insertAtrzLine" method="post" enctype="multipart/form-data">
			<div class="container-fluid">
				<!-- 여기서 작업 시작 -->
				<div class="row">
					<div class="col-sm-12 mb-3 mb-sm-0">
						<!-- 목록으로  -->
						<div class="col card-body" id="approvalBtn">
							<!-- 새로운 버튼 -->
							<div class="tool_bar">
								<div class="critical d-flex gap-2 mb-3">
                                    <a type="button" class="btn btn-outline-secondary d-flex align-items-center gap-1"
										href="/atrz/home"> 
                                    <span class="material-symbols-outlined fs-5">format_list_bulleted</span>목록으로
									</a>
								</div>
							</div>

							<!-- 새로운 버튼 -->
						</div>
						<!-- 모달창 인포트 -->
						<c:import url="../documentForm/approvalLineModal.jsp" />
							<div class="card">
								<div class="card-body">
									<div id="s_eap_content_box_left" class="s_scroll">
										<div class="s_div_container s_scroll">
											<div
												style="text-align: center; font-size: 2em; font-weight: bold; padding: 20px;">급여명세서</div>

											<div style="float: left; width: 230px; margin: 0 30px;">
												<table border="1" id="s_eap_draft_info" class="text-center">
													<tr>
														<!-- 기안자 정보가져오기 -->
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


											<div style="float: right; margin-right: 20px;" id="s_eap_draft_app">
												<table border="1" class="s_eap_draft_app" hidden>
													<tbody>
														<tr>
															<th rowspan="3">결재</th>
															<c:forEach var="atrzLineVO" items="${atrzVO.atrzLineVOList}">
																<c:if test="${atrzLineVO.atrzTy eq '1'}">
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

												
														
													</tbody>
												</table>
											</div>
											<!-- <p>${atrzVO}</p> -->
											<div id="salaryDetail">
												<div style="padding: 50px 10px 20px; clear: both;">
													<div class="row salary-header text-center">
														<div class="col-6">지급 항목</div>
														<div class="col-6">공제 항목</div>
													</div>
												</div>

												<div style="border: 1px solid lightgray; margin: 10px;"></div>
												
												<div id="salTable">
													<div class="row" >
														<!-- 지급 항목 -->
														<div class="col-md-6" >
															<table class="table table-bordered">
															<tbody>
																<tr>
																	<th scope="row" class="text-center align-middle" style="width: 40%;">기본급</th>
																	<fmt:formatNumber value="${atrzVO.salaryVO.baseSalary}" pattern="#,###원" var="baseSalary" />
																	<td class="text-end salEnd" id="baseSalary" style="padding-right: 20px;">${baseSalary}</td>
																</tr>
																<tr>
																	<th scope="row" class="text-center align-middle" style="width: 40%;">식대</th>
																	<fmt:formatNumber value="${atrzVO.salaryVO.mealAllowance}" pattern="#,###원" var="mealAllowance" />
																	<td class="text-end salEnd" id="mealAllowance" style="padding-right: 20px;" >${mealAllowance}</td>
																</tr>
																<tr>
																	<th scope="row" class="bg-light text-center align-middle">총 지급액</th>
																	<fmt:formatNumber value="${atrzVO.salaryVO.totalDed}" pattern="#,###원" var="totalDed" />
																	<td class="bg-light text-end fw-bold" id="totalDed" style="padding-right: 20px;">${totalDed}</td>
																</tr>
																<tr>
																	<th scope="row" class="bg-light text-center align-middle">실 지급액</th>
																	<fmt:formatNumber value="${atrzVO.salaryVO.netPay}" pattern="#,###원" var="netPay" />
																	<td class="bg-light text-end fw-bold" id="netPay" style="padding-right: 20px;">${netPay}</td>
																</tr>
															</tbody>
															</table>
														</div>
													
														<!-- 공제 항목 -->
														<div class="col-md-6">
															<table class="table table-bordered">
															<tbody>
																<tr>
																	<th scope="row" class="text-center align-middle" style="width: 40%;">소득세</th>
																	<fmt:formatNumber value="${atrzVO.salaryVO.incomeTax}" pattern="#,###원" var="incomeTax" />
																	<td class="text-end salEnd" id="incomeTax" style="padding-right: 20px;" >${incomeTax}</td>
																</tr>
																<tr>
																	<th scope="row" class="text-center align-middle">지방소득세</th>
																	<fmt:formatNumber value="100000" pattern="#,###" var="mealAllowance" />
																	<fmt:formatNumber value="${atrzVO.salaryVO.localTax}" pattern="#,###원" var="localTax" />
																	<td class="text-end salEnd" id="localTax" style="padding-right: 20px;" >${localTax}</td>
																</tr>
																<tr>
																	<th scope="row" class="text-center align-middle">국민연금</th>
																	<fmt:formatNumber value="${atrzVO.salaryVO.pension}" pattern="#,###원" var="pension" />
																	<td class="text-end salEnd" id="pension" style="padding-right: 20px;" >${pension}</td>
																</tr>
																<tr>
																	<th scope="row" class="text-center align-middle">건강보험</th>
																	<fmt:formatNumber value="${atrzVO.salaryVO.healthIns}" pattern="#,###원" var="healthIns" />
																	<td class="text-end salEnd" id="healthIns" style="padding-right: 20px;" >${healthIns}</td>
																</tr>
																<tr>
																	<th scope="row" class="text-center align-middle">장기요양보험</th>
																	<fmt:formatNumber value="${atrzVO.salaryVO.careIns}" pattern="#,###원" var="careIns" />
																	<td class="text-end salEnd" id="careIns" style="padding-right: 20px;" >${careIns}</td>
																</tr>
																<tr>
																	<th scope="row" class="text-center align-middle">고용보험</th>
																	<fmt:formatNumber value="${atrzVO.salaryVO.employmentIns}" pattern="#,###원" var="employmentIns" />
																	<td class="text-end salEnd" id="employmentIns" style="padding-right: 20px;" >${employmentIns}</td>
																</tr>
																<tr>
																	<th scope="row" class="text-center align-middle bg-light">총 공제액</th>
																	<fmt:formatNumber value="${atrzVO.salaryVO.totalPay}" pattern="#,###원" var="totalPay" />
																	<td class="bg-light text-end fw-bold" id="totalPay" style="padding-right: 20px;">${totalPay}</td>
																</tr>
															</tbody>
															</table>
														</div>
													</div>
												</div>
											</div> 
										</div>
									</div>
								</div>
							</div>
							<!-- 상하 버튼 추가 -->
							<div class="tool_bar">
								<div class="critical d-flex gap-2 mt-3">
									</a> 
                                    <a type="button" class="btn btn-outline-secondary d-flex align-items-center gap-1" href="/atrz/home"> 
                                    <span class="material-symbols-outlined fs-5">format_list_bulleted</span> 목록으로
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
function parseNumber(str) {
  return Number(str.replace(/[^0-9]/g, '')) || 0;
}

function numberWithCommas(num) {
  return num.toLocaleString() + '원';
}

document.getElementById("baseSalary").addEventListener("input", calculate);
document.getElementById("mealAllowance").addEventListener("input", calculate);

function calculate() {
    const baseSalary = parseNumber(document.getElementById("baseSalary").value);
    const mealAllowance = parseNumber(document.getElementById("mealAllowance").value);
    const totalPay = baseSalary + mealAllowance;

    // 4대 보험 계산
    const pension = Math.floor(baseSalary * 0.045);
    const healthInsurance = Math.floor(baseSalary * 0.03545);
    const longTermCare = Math.floor(healthInsurance * 0.1281);
    const employmentInsurance = Math.floor(baseSalary * 0.009);

    // 소득세 간이계산 (월 200만원 초과 시 누진세 적용 예시)
    let incomeTax = 0;
    if (baseSalary > 2000000) {
    incomeTax = Math.floor((baseSalary - 2000000) * 0.06);
    }
    const localTax = Math.floor(incomeTax * 0.1);

    const totalDeductions = incomeTax + localTax + pension + healthInsurance + longTermCare + employmentInsurance;

  // 화면 반영
    document.getElementById("totalPay").innerText = numberWithCommas(totalPay);
    document.getElementById("incomeTax").innerText = numberWithCommas(incomeTax);
    document.getElementById("localTax").innerText = numberWithCommas(localTax);
    document.getElementById("pension").innerText = numberWithCommas(pension);
    document.getElementById("healthInsurance").innerText = numberWithCommas(healthInsurance);
    document.getElementById("longTermCare").innerText = numberWithCommas(longTermCare);
    document.getElementById("employmentInsurance").innerText = numberWithCommas(employmentInsurance);
    document.getElementById("totalDeductions").innerText = numberWithCommas(totalDeductions);
}

// input 이벤트 연결
document.getElementById("baseSalary").addEventListener("input", calculate);
document.getElementById("mealAllowance").addEventListener("input", calculate);

// 🔥 함수 직접 호출로 초기 계산
calculate();
</script>

<script>
$(".s_eap_app").on("click",function(){
	event.preventDefault();

	let jnForm = document.querySelector("#atrz_sa_form");
	const formData = new FormData();

	//기안자 정보
	let secEmplNo = '${empVO.emplNo}';
	let secEmplNm = '${empVO.emplNm}';

	//결재자 정보
	let atrzLineList = [];

	//전자결재 정보
	formData.append("docFormNm","A");
	formData.append("docFormNo",6);
	formData.append("atrzSj","제목");
	formData.append("atrzCn","내용");
	formData.append("atrzCn","내용");

	let atrzLine = {
		atrzLnSn: 1,
		sanctnerEmpno: '${empVO.emplNo}',
		atrzTy: '1',
		dcrbAuthorYn: 'N',
		sanctnerClsfCode: '${empVO.clsfCode}',
		sanctnProgrsSttusCode : '10',
		sanctnConfmDt: new Date().toISOString().slice(0, 10),
	}
	atrzLineList.push(atrzLine);			
	console.log("atrzLineList",atrzLineList);

	let docSalary = {
		"baseSalary" : $('#baseSalary').val().replace(/[^0-9]/g, ''), 					//기본급
		"mealAllowance": $('#mealAllowance').val().replace(/[^0-9]/g, ''),  				//식대
		"incomeTax": $('#incomeTax').text().replace(/[^0-9]/g, ''),				//소득세 
		"localTax": $('#localTax').text().replace(/[^0-9]/g, ''),						//지방소득세
		"pension": $('#pension').text().replace(/[^0-9]/g, ''),							//국민연금
		"healthInsurance": $('#healthInsurance').text().replace(/[^0-9]/g, ''),			//고용보험
		"longTermCare": $('#longTermCare').text().replace(/[^0-9]/g, ''),				//건강보험료
		"employmentInsurance": $('#employmentInsurance').text().replace(/[^0-9]/g, ''),	//장기요양보험
		"totalDeductions": $('#totalDeductions').text().replace(/[^0-9]/g, ''),			//지급일 지급달
		"totalPay": $('#totalPay').text().replace(/[^0-9]/g, '')
		};

	formData.append("docSalary",new Blob([JSON.stringify(docSalary)],{type:"application/json"}));
	formData.append("atrzLineList",new Blob([JSON.stringify(atrzLineList)],{type:"application/json"}));
		
	formData.append("emplNo",secEmplNo);
	formData.append("emplNm",secEmplNm);

	console.log("전송하기 체킁 확인");
	console.log("s_eap_app_bottom->formData : ", formData);
	formData.forEach((value, key) => {
	console.log("체킁",key, value);
	});
	const junyError = (request, status, error) => {
				console.log("code: " + request.status)
				console.log("message: " + request.responseText)
				console.log("error: " + error);
		}
	//기안자 정보담기
	$.ajax({
	url:"/atrz/insertAtrzEmp",
	data:'${empVO.emplNo}',
	type:"post",
	dataType:"json",
	success:function(result){
		console.log("기안자 정보",result);
	}
});

	//결재자 정보 담기
	$.ajax({
		url:"/atrz/insertAtrzLine",
		processData:false,
		contentType:false,
		type:"post",
		data: formData,
		dataType:"json",
		success : function(atrzVO){
			console.log("atrzVO : ", atrzVO);

		}//end success
	});//ajax


	//지출결의서 등록
	$.ajax({
	url:"/atrz/atrzSalaryInsert",
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
})



</script>
</body>

</html>
