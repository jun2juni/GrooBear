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
</head>
<style>
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


/* 제목, 내용 글씨 크기 */
.s_frm_title {
	font-size: 1em;
	font-weight: bold;
	padding: 5px 0;
}
/* 버튼 작게만들기 */
.approvalBtn {
	color: white;
	--bs-btn-padding-y: .25rem;
	--bs-btn-padding-x: .5rem;
	--bs-btn-font-size: .75rem;
}
/* 버튼 공간 마진 */
#approvalBtn {
	margin: 10px;
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
<%@ include file="../layout/prestyle.jsp" %>

<body>
<sec:authentication property="principal.empVO" var="empVO" />
<%@ include file="../layout/sidebar.jsp" %>
<main class="main-wrapper">
<%@ include file="../layout/header.jsp" %>
	<section class="section">
		<form id="atrz_dr_form" action="/atrz/insertAtrzLine" method="post" enctype="multipart/form-data">
		<div class="container-fluid">
			<!-- 여기서 작업 시작 -->
			<div class="row">
				<div class="col-sm-12 mb-3 mb-sm-0">
					<!-- 결재요청 | 임시저장 | 결재선지정 | 취소  -->
					<div class="col card-body" id="approvalBtn">
					<div class="tool_bar">
						<div class="critical d-flex gap-2 mb-3">
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
							<a type="button" id="cancelButtonTo"
							class="btn btn-outline-danger d-flex align-items-center gap-1 atrzLineCancelBtn"
							style="padding: 0.4rem 1rem; font-size: 0.95rem;"> 
							<span class="material-symbols-outlined fs-5">cancel</span> 취소
							</a>
							<!-- 자동 입력 버튼 -->
							<div style="margin-left: auto;">
								<button type="button" class="btn btn-outline-warning d-flex align-items-center gap-1" onclick="fillDefaultValues()">자동입력</button>
							</div>
						</div>
					</div>
					<!-- 새로운 버튼 -->
					</div>
			<!-- 모달창 인포트 -->
			<c:import url="../documentForm/approvalLineModal.jsp" />
					<div class="card">
						<div class="card-body">
							<div class="s_div_container s_scroll">
								<div style="text-align: center; font-size: 2em; font-weight: bold; padding: 20px;">기안서</div>
									<div style="float: left; width: 230px; margin: 0 30px;">
										<table border="1" id="s_eap_draft_info" class="text-center">
											<tr>
												<!-- 기안자 정보가져오기 -->
<%-- 											<p>${empVO}</p>  --%>
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


								<div id="s_eap_draft_app" style="float: right; margin-right: 10px;">
								</div>
								<div id="s_eap_final">
									<div>
										<div style="padding: 50px 10px 20px; clear: both;">
											<div
												style="display: inline-block; font-size: 1.2em; font-weight: bold;">제목
												:</div>
											<input type="text" class="form-control" value="" placeholder="제목을 입력해주세요"
												style="display: inline-block; width: 90%; margin-left: 5px;"
												id="s_dr_tt" name="atrzSj">
										</div>
										<div style="border: 1px solid lightgray; margin: 10px;"></div>
										<div style="margin: 0 10px;">
											<div style="padding: 10px 0;">
												<div class="s_frm_title mb-2"><b>상세 내용</b></div>
												<textarea class="form-control"
													style="resize: none; height: 150px;" id="s_dr_co" name="atrzCn"
													required="required" rows="2" cols="20" wrap="hard" placeholder="상세내용을 입력해주세요"></textarea>
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
							</div>
						</div>
					</div>
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
							<a type="button" id="cancelButtonBo"
							class="btn btn-outline-danger d-flex align-items-center gap-1 atrzLineCancelBtn"
							style="padding: 0.4rem 1rem; font-size: 0.95rem;"> 
							<span class="material-symbols-outlined fs-5">cancel</span> 취소
							</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		</form>
	</div>
</section>
<%@ include file="../layout/footer.jsp" %>
</main>
<%@ include file="../layout/prescript.jsp" %>
<script>
//자동입력 버튼클릭시
function fillDefaultValues() {
	// 내용
	document.getElementById('s_dr_tt').value = '신규 프로젝트 “[스마트 업무지원 시스템 구축]” 추진 기안';
	// 상세내용
	document.getElementById('s_dr_co').value = "아래와 같이 신규 프로젝트를 추진하고자 하오니 검토 및 승인 부탁드립니다.\n\n\
	1. 기안 목적\n\
	본 기안서는 스마트 업무지원 시스템 구축 프로젝트의 추진을 위한 사전 승인 요청입니다. 본 프로젝트는 업무 효율성 향상과 내부 프로세스 자동화를 목표로 합니다.\n\n\
	2. 프로젝트 개요\n\
	- 프로젝트명: 스마트 업무지원 시스템 구축\n\
	- 추진 배경: 내부 문서관리 및 협업 시스템의 노후화로 인한 업무 비효율 발생\n\
	- 목표: 사용자 친화적이고 확장 가능한 업무지원 플랫폼 개발\n\n\
	3. 주요 일정\n\
	- 기획/요구사항 정의: 2025.05.01 ~ 2025.05.15\n\
	- 시스템 설계 및 개발: 2025.05.16 ~ 2025.07.15\n\
	- 테스트 및 운영 반영: 2025.07.16 ~ 2025.07.31\n\n\
	4. 필요 인력 및 역할\n\
	- PM: 1명 (내부)\n\
	- 개발자: 2명 (내부 1, 외부 1)\n\
	- 디자이너 및 QA: 1명 (외부)\n\n\
	5. 예산 계획\n\
	- 총 예산: 약 2,000만원\n\
	- 외부 인력 투입 비용, 테스트 장비 임차비 등 포함\n\n\
	6. 기대 효과\n\
	- 전사 업무 프로세스 표준화\n\
	- 문서 처리 속도 향상 및 이력 추적 용이\n\
	- 사용자 중심의 UI/UX로 직원 만족도 향상\n\n\
	7. 기타\n\
	- 보안 및 개인정보 관련 고려사항은 별도 검토 예정\n\
	- 외주 인력 계약은 별도 기안으로 진행 예정";
    };


//제목 너무 길게 입력하면 입력초과 스왈
document.getElementById('s_dr_tt').addEventListener('input', function (event) {
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


//JSON Object List
let authList = [];
$(document).ready(function() {
	//******* 폼 전송 *******
	$(".s_eap_app").on("click",function(){
		event.preventDefault();

		// 제목, 내용이 비어있을 때
		if($('#s_dr_tt').val() == "" || $('#s_sp_co').val() == "") {
			swal({
					title: "제목 또는 내용이 비어있습니다.",
					text: "다시 확인해주세요.",
					icon: "error",
					closeOnClickOutside: false,
					closeOnEsc: false
				});
			return;
		}
		
		
		var eap_content = $('#s_sp_co').val();

		
		//보고 가져온것 끝
		
		let jnForm = document.querySelector("#atrz_dr_form");
		
		let formData = new FormData();
		formData.append("docFormNm","D");
		formData.append("docFormNo",3);
		formData.append("atrzSj",jnForm.atrzSj.value);
		formData.append("atrzCn",jnForm.atrzCn.value);

		if(jnForm.uploadFile.files.length){
			for(let i=0; i< jnForm.uploadFile.files.length; i++)
			formData.append("uploadFile",jnForm.uploadFile.files[i]);
		}
  
  
		document.querySelectorAll("input[name='removeFileId']").forEach(element => {
			formData.append("removeFileId", element.value);
		});

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
			url:"/atrz/atrzDraftInsert",
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
						location.replace("/atrz/document?tab=1")
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

		// 제목, 내용이 비어있을 때
		if($('#s_dr_tt').val() == "" || $('#s_sp_co').val() == "") {
			swal({
					title: "제목 또는 내용이 비어있습니다.",
					text: "다시 확인해주세요.",
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
		let jnForm = document.querySelector("#atrz_dr_form");

		let formData = new FormData();
		formData.append("docFormNm","D");
		formData.append("docFormNo",3);
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

		formData.append("atrzLineList",new Blob([JSON.stringify(atrzLineList)],{type:"application/json"}));

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

		//기안서 임시저장 시작
		$.ajax({
			url:"/atrz/atrzDraftStorage",
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
				"atrzDocNo": $("#s_dfNo").text(),
				"sanctnProgrsSttusCode":'00'
			};
			
			//결재선 목록
			authList.push(data);			
			formData.append("atrzLineVOList["+idx+"].atrzDocNo",data.atrzDocNo); //결재문서번호 입력
			formData.append("atrzLineVOList["+idx+"].sanctnerEmpno",data.emplNo);
			formData.append("atrzLineVOList["+idx+"].sanctnerClsfCode",data.clsfCode);
			formData.append("atrzLineVOList["+idx+"].atrzTy",data.auth);//Y / N 결재자 / 참조자
			formData.append("atrzLineVOList["+idx+"].dcrbAuthorYn",data.flex);//  1 / 0 전결여부
			formData.append("atrzLineVOList["+idx+"].atrzLnSn",data.atrzLnSn); //결재진행순서
			formData.append("atrzLineVOList["+idx+"].sanctnProgrsSttusCode",data.sanctnProgrsSttusCode); //결재진행상태코드
		});	
		
		console.log("순번권한전결여부authList : ", authList);
		formData.append("docFormNm","D");
		formData.append("docFormNo",3);

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

	
});
</script>
</body>
</html>
