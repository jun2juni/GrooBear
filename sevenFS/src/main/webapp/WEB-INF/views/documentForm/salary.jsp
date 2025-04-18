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
    margin-left: 0px;
    margin-right: 60px;
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
										class="btn btn-outline-primary d-flex align-items-center gap-1 s_eap_app">
										<span class="material-symbols-outlined fs-5">bookmark</span> 저장(확인)
									</button>
									</a> 
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
                                                        <!-- <p>${empVO}</p> -->
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


											<div style="float: left; margin-right: 10px;" id=s_eap_draft_app>
												
												</div>

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
                                                            <td class="text-end">
                                                                <fmt:formatNumber value="${empVO.anslry}" pattern="#,###" var="baseSalary" />
                                                                <input type="text" class="form-control text-end" id="baseSalary" name="baseSalary" value="${baseSalary}">
                                                            </td>
                                                            </tr>
                                                            <tr>
                                                            <th scope="row" class="text-center align-middle">식대</th>
                                                            <td class="text-end">
                                                                <fmt:formatNumber value="100000" pattern="#,###" var="mealAllowance" />
                                                                <input type="text" class="form-control text-end" id="mealAllowance" name="mealAllowance" value="${mealAllowance}">
                                                            </td>
                                                            </tr>
                                                            <tr>
                                                            <th scope="row" class="bg-light align-middle">총 지급액</th>
                                                            <td class="bg-light text-end fw-bold" id="totalPay">0원</td>
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
                                                                <td class="text-end salEnd" id="incomeTax" style="padding-right: 20px;">0원</td>
                                                            </tr>
                                                            <tr>
                                                                <th scope="row" class="text-center align-middle">지방소득세</th>
                                                                <fmt:formatNumber value="100000" pattern="#,###" var="mealAllowance" />
                                                                <td class="text-end salEnd" id="localTax" style="padding-right: 20px;">0원</td>
                                                            </tr>
                                                            <tr>
                                                                <th scope="row" class="text-center align-middle">국민연금</th>
                                                                <td class="text-end salEnd" id="pension" style="padding-right: 20px;">0원</td>
                                                            </tr>
                                                            <tr>
                                                                <th scope="row" class="text-center align-middle">건강보험</th>
                                                                <td class="text-end salEnd" id="healthInsurance" style="padding-right: 20px;">0원</td>
                                                            </tr>
                                                            <tr>
                                                                <th scope="row" class="text-center align-middle">장기요양보험</th>
                                                                <td class="text-end salEnd" id="longTermCare" style="padding-right: 20px;">0원</td>
                                                            </tr>
                                                            <tr>
                                                                <th scope="row" class="text-center align-middle">고용보험</th>
                                                                <td class="text-end salEnd" id="employmentInsurance" style="padding-right: 20px;">0원</td>
                                                            </tr>
                                                            <tr>
                                                                <th scope="row" class="bg-light" class="text-center align-middle">총 공제액</th>
                                                                <td class="bg-light text-end fw-bold" id="totalDeductions" style="padding-right: 20px;">0원</td>
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
							<!-- 상하 버튼 추가 -->
							<div class="tool_bar">
								<div class="critical d-flex gap-2 mt-3">
									<!--성진스 버튼-->
									<button id="s_eap_app_bottom" type="button" 
										class="btn btn-outline-primary d-flex align-items-center gap-1 s_eap_app">
										<span class="material-symbols-outlined fs-5">bookmark</span>저장(확인)
									</button>
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
//JSON Object List
let authList = [];

$(document).ready(function() {
	//******* 폼 전송 *******
	$(".s_eap_app").on("click",function(){
		event.preventDefault();
// 		alert("체킁");
		console.log("전송하기 체킁 확인");
		console.log("s_eap_app_bottom->authList : ", authList);
		
		let jnForm = document.querySelector("#atrz_ho_form");
		// console.log("${empVO}" + empVO);
	

		
		let formData = new FormData();

		//기안자 정보 
		formData.append("emplNo","${empVO.emplNo}");//EL 변수 ->  J/S에서 사용(큰따옴표로 묶어준다.)
		formData.append("drafterEmpno","${empVO.emplNo}");
		formData.append("emplNm","${empVO.emplNm}");
		formData.append("drafterEmpnm","${empVO.emplNm}");
		formData.append("clsfCode","${empVO.clsfCode}");
		formData.append("clsfCodeNm","${empVO.clsfCodeNm}");
		formData.append("deptCode","${empVO.deptCode}");
		formData.append("deptCodeNm","${empVO.deptNm}");

		//전자결재 정보
		formData.append("docFormNm","A");
		formData.append("docFormNo",6);
		formData.append("baseSalary", $('#baseSalary').val().replace(/[^0-9]/g, ''));   					//기본급
		formData.append("mealAllowance", $('#mealAllowance').val().replace(/[^0-9]/g, ''));  				//식대
		formData.append("incomeTax", $('#incomeTax').text().replace(/[^0-9]/g, '')); 						//소득세 
		formData.append("localTax", $('#localTax').text().replace(/[^0-9]/g, '')); 							//지방소득세
		formData.append("pension", $('#pension').text().replace(/[^0-9]/g, ''));							//국민연금
		formData.append("healthInsurance", $('#healthInsurance').text().replace(/[^0-9]/g, ''));			//고용보험
		formData.append("longTermCare", $('#longTermCare').text().replace(/[^0-9]/g, ''));					//건강보험료
		formData.append("employmentInsurance", $('#employmentInsurance').text().replace(/[^0-9]/g, ''));	//장기요양보험
		formData.append("totalDeductions", $('#totalDeductions').text().replace(/[^0-9]/g, ''));			//지급일 지급달
		// formData.append("totalPay", $('#totalPay').text().replace(/[^0-9]/g, ''));


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
		
		// 가끔 VO가 depth가 깊어 복잡할 땡!, 파일과 별개로
		// BACKEND에서 @RequestPart("test")로 받아 버리장
		formData.append("atrzLineList",new Blob([JSON.stringify(atrzLineList)],{type:"application/json"}));
		
		formData.append("emplNo",secEmplNo);
		formData.append("emplNm",secEmplNm);
		
		const junyError = (request, status, error) => {
					console.log("code: " + request.status)
					console.log("message: " + request.responseText)
					console.log("error: " + error);
            }
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
					location.replace("/atrz/home")
				}
			},
			error: junyError
		})
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

	$.ajax({
		url:"/atrz/insertAtrzEmp",
		data:{"emplNo":emplNo},
		type:"post",
		dataType:"json",
		success:function(result){
			let noLen = $(".clsTr").length;

			let selectHtml = `
				<select class="form-select selAuth" aria-label="Default select example">
					<option value="0" \${selectedType == "sign" ? "selected" : ""}>결재</option>
					<option value="1" \${selectedType == "ref" ? "selected" : ""}>참조</option>
				</select>
			`;

			// 참조일 때는 checkbox 없이 처리
			let checkboxHtml = "";
			if (selectedType == "sign") {
				checkboxHtml = `
					<input class="form-check-input flexCheckDefault" type="checkbox" value="Y" />
				`;
			}



			let str = `
					<tr class="clsTr" id="row_\${emplNo}" name="emplNm">
						<th>\${noLen+1}</th>
						<th style="display: none;" class="s_td_no">\${result.emplNo}</th>
						<th class="s_td_name">\${result.emplNm}</th>
						<th>\${result.deptNm}</th>
						<th>\${result.posNm}</th>
						<input type="hidden" name="emplNo" class="emplNo" value="\${result.emplNo}"/>
						<th hidden>\${selectHtml}</th>
						<th>\${checkboxHtml}</th>
					</tr>
				`;

			// ✅ 타입에 따라 위치 다르게 append
			if(selectedType === "sign"){
				$(".s_appLine_tbody_new").append(str);  // 위쪽 결재선
			}else{
				$(".s_appLine_tbody_ref").append(str);  // 아래쪽 참조자
			}
		}
	});//ajaxEnd 
}
	
	//왼쪽버튼의 경우에는 결재선선택과는 거리가 멀기 때문에 필요없음
	//왼쪽 버튼을 눌렀을때 삭제처리되어야함
	//결재자 리스트 삭제
	$(document).on("click", "#remo_appLine",function(){
		let lastRow = $(".s_appLine_tbody_new .clsTr");   //가장마지막에 추가된 tr
		//삭제대상확인 
		// console.log("삭제대상 :", lastRow.prop("outerHTML"));
		
		if(lastRow.length > 0){
			lastRow.last().remove(); 
			reindexApprovalLines();
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
	//전체테이블 순번 다시 매기기
	function reindexApprovalLines() {
		$(".clsTr").each(function(index) {
			$(this).find("th").first().text(index + 1);
		});
	}



	
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
		//새로운 리스트 만들어주기
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
				"auth":$(this).val(),
				"flex":dcrbAuthorYn,
				"atrzLnSn":(idx+1)
			};
			
			authList.push(data);
		});	
		
		console.log("순번권한전결여부authList : ", authList);
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
					src="/assets/images/atrz/before.png"
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
	
});




</script>
	<!-- 주니가 입력한 스크립트 끝 -->
	<p hidden>
		<sec:authentication property="principal.Username" />
	</p>

</body>

</html>
