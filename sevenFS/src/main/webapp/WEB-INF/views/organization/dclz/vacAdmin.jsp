<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="org.springframework.security.core.Authentication"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="연차 관리" />

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
 	<meta name="viewport"
		  content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"/>
	<meta http-equiv="X-UA-Compatible" content="ie=edge" />
	<title>${title}</title>
  <%@ include file="../../layout/prestyle.jsp" %>
  
<style>
.form-label{
    font-size: 14px;
    font-weight: 500;
    color: #1A2142;
    display: block;
    margin-bottom: 10px;
}
</style>   
  
</head>
<body>
<%@ include file="../../layout/sidebar.jsp" %>
<main class="main-wrapper">
  <%@ include file="../../layout/header.jsp" %>
	<section class="section">
		<div class="container-fluid">
       		<!-- Button trigger modal -->
       		<form action="/dclz/vacAdmin" method="get" id="vacAdminSearchForm">
       		<div class="col-lg-12 mb-10">
              <div class="card-style d-flex gap-3 justify-content-center">
              <div class="col-2">
              	<span class="form-label">사원이름</span>
              	<input class="form-control" type="text" value="" name="keywordName" id="searchEmplNm">
              </div>
              <div class="col-2">
              	<span class="form-label">부서명</span>
              	<input class="form-control" data-bs-toggle="modal" data-bs-target="#orgListModal" type="text" value="" name="keywordDept" id="searchDeptNm" readonly="readonly" >
              </div>
              <div class="col-3">
              	<span class="form-label">입사일자</span>
              	<input class="form-control" type="date" id="ecnyDt">
              	<input type="hidden" value="" name="keywordEcny" id="hidEncyDt">
              </div>
              <div class="col-3">
              	<span class="form-label">퇴사일자</span>
              	<input class="form-control" type="date" id="retireDt">
              	<input type="hidden" value="" name="keywordRetire" id="hidRetireDt">
              </div>
              	<button type="button" id="vacAdminSearch" class="main-btn light-btn square-btn btn-hover btn-sm mt-30" style="height:40px;">검색</button>
              </div>
   			</div>
   			</form>
			<div class="row">
            <div class="col-lg-12">
              <div class="card-style">
                <div class="table-wrapper table-responsive">
                  <table class="table">
                  <h6>전체사원 연차 관리</h6>
                  <h6>**<span class="mt-3" style="color:lightcoral">사원 이름을 클릭하시면 해당 사원의 이번달 연차 사용 현황을 조회할 수 있습니다.</span></h6>
                  <h6>**<span class="mt-3" style="color:lightcoral">추가로 지급할 성과보상 또는 근무보상 일수를 지급해주세요.</span></h6>
                  <div class="mb-10 d-flex justify-content-end col-12">
                   <div>
                   	 <a href="/dclz/vacAdmin" class="btn-sm light-btn-light btn-hover mr-10 rounded-md">전체 목록 보기</a>
                   </div>
                  <%--  <form action="/dclz/vacAdmin" method="get" id="selTypeForm">
                  	<c:set var="duplTypes" value="" />
	                <div class="input-style-1 form-group mr-10">
		     	     <select id="vacType" class="form-select w-auto" required="required">
						<option>유형 선택</option>
						<c:forEach var="vacDatas" items="${allEmplVacList}">
						<c:set var="vacType" value="${vacDatas.cmmnCodeNm}" />
							<c:if test="${not fn:contains(duplTypes, vacType)}">
								<option value="${vacType}">${vacType}</option>
								<c:set var="duplTypes" value="${duplTypes},${vacType}" />
							</c:if>	
						</c:forEach>
					 </select> 
					 <input type="hidden" id="typeKeyword" name="keyword">
				  	</div> 
		            </form> --%>
		           <%--  <form action="/dclz/vacAdmin" method="get" id="selYearForm">
                  	<c:set var="duplYears" value="" />
	                <div class="input-style-1 form-group">
		     	     <select id="vacYear" class="form-select w-auto" required="required">
						<option>년도 선택</option>
						<c:forEach var="vacDatas" items="${allEmplVacList}">
						<fmt:formatDate value="${vacDatas.dclzBeginDt}" pattern="yyyy" var="vacYear" />
							<c:if test="${not fn:contains(duplYears, vacYear)}">
								<option value="${vacYear}">${vacYear}</option>
								<c:set var="duplYears" value="${duplYears},${vacYear}" />
							</c:if>	
						</c:forEach>
					 </select> 
					 <input type="hidden" id="yearKeyword" name="keyword">
				  	</div>
				  	</form> --%>
				  	<!-- <form action="/dclz/vacAdmin" method="get" id="selSearchNm">
				  	<div class="ml-10 d-flex">
				  	    <div class="rounded mb-3" style="width : 150px;">
				            <input type="search" class="form-control rounded" placeholder="이름 입력" aria-label="Search" name="keyword" aria-describedby="search-addon" id="shName" onkeydown="scEnter(event)">
				        </div>
				        <span class="input-group-text border-0" id="search-addon" style="height:40px">
				            <i class="fas fa-search" aria-hidden="true"></i>
				        </span>
			        </div>
		            </form> -->
		            </div>
                    <thead>
		            <%-- ${allEmplVacList} --%>
                      <tr>
                        <th>
                          <h6>번호</h6>
                        </th>
                        <th>
                          <h6>사원 이름</h6>
                        </th>
                        <th>
                          <h6>부서명</h6>
                        </th>
                        <th>
                          <h6>입사일자</h6>
                        </th>
                        <th>
                          <h6>퇴사일자</h6>
                        </th>
                        <th>
                          <h6>성과 보상</h6>
                        </th>
                        <th>
                          <h6>근무 보상</h6>
                        </th>
                        <th>
                          <h6>총 연차</h6>
                        </th>
                        <th>
                          <h6>사용 연차</h6>
                        </th>
                        <th>
                          <h6>잔여 연차</h6>
                        </th>
                        <th>
                        </th>
                      </tr>
                      <!-- end table row-->
                    </thead>
                     <%-- ${allEmplVacList}  --%>
                    <tbody>
                    <c:set var="emplVacData" value="${allEmplVacList}"></c:set>
                     <c:forEach var="allVacData" items="${emplVacData}" varStatus="status">
                      <tr>
                      	<td>
                      		${allVacData.rnum}
                      	</td>
                        <td>
                          <div>
                            <div>
                              <div class="d-flex justify-content-start">
					             <button class="main-btn light-btn-outline square-btn btn-hover btn-sm vacation-modal-btn" 
					             		data-bs-toggle="modal" data-bs-target="#exampleModal" id="vacationModal" data-empl-no="${allVacData.emplNo}">
									 ${allVacData.emplNm}
								 </button>
				              </div>
                            </div>
                          </div>
                        </td>
                        <td>
                          <div>
                            <div>
                              <span>${allVacData.cmmnCodeNm}</span>
                            </div>
                          </div>
                        </td>
                        <td>
                         <%--  <fmt:formatDate var="ecnyDate" value="${allVacData.ecnyDate}" pattern="yyyy-MM-dd"/> --%>
							<c:set var="year" value="${allVacData.ecnyDate.substring(0,4)}"></c:set>
							<c:set var="month" value="${allVacData.ecnyDate.substring(4,6)}"></c:set>
							<c:set var="day" value="${allVacData.ecnyDate.substring(6,8)}"></c:set>
							${year}-${month}-${day}      
                        </td>
                        <td>
                          	<c:set var="reYear" value="${allVacData.retireDate.substring(0,4)}"></c:set>
							<c:set var="reMonth" value="${allVacData.retireDate.substring(4,6)}"></c:set>
							<c:set var="reDay" value="${allVacData.retireDate.substring(6,8)}"></c:set>
                       		 ${retireDate}
                       		 <c:choose>
                       		 	<c:when test="${allVacData.retireDate == '' || allVacData.retireDate == null}">
                       		 		재직자
                       		 	</c:when>
                       		 	<c:otherwise>
                       		 		${reYear}-${reMonth}-${reDay}  
                       		 	</c:otherwise>
                       		 </c:choose>
                        </td>
                        <td>
		                   <input class="cmpnstnYrycCnt" id="cmpnstnCnt${status.count}" type="number" step="0.5" min="0" max="25" style="width:50px;" value="0.0">개
	                  	</td>
	                  	<td> 
	                  		<input class="excessWorkYryc" id="excessWorkYryc${status.count}" type="number" step="0.5" min="0" max="25" style="width:50px;" value="0.0">개
	                  	</td>
                        <td>
                        	<input class="inputTotalCnt" id="inputTotalCnt${status.count}" type="text" readonly="readonly" value="${allVacData.totYrycDaycnt}" style="width:50px;" />개		
                        </td>
                        <td>
                          <c:choose>
		                  	<c:when test="${allVacData.yrycUseDaycnt % 1 == 0}">
			                    ${allVacData.yrycUseDaycnt.intValue()}개
		                  	</c:when>
		                  	<c:otherwise>
			                     ${allVacData.yrycUseDaycnt}개
		                  	</c:otherwise>
	                  	</c:choose>
                        </td>
                        <td>
			                <input type="text" id="yrycRemndrDaycnt${status.count}" value="${allVacData.yrycRemndrDaycnt}" readonly style="width:50px;">개
                        </td>
                      <form action="/dclz/addVacInsert" method="get" id="addVacationForm${status.count}">
                        <td>
	                         <div class="d-flex flex-column gap-1">
				                <button type="button" id="sendVacBtn${status.count}" class="main-btn primary-btn-light square-btn btn-hover btn-sm" style="width: 60px; height: 40px;">지급하기</button>
				                <button type="button" id="resetBtn${status.count}" class="main-btn danger-btn-light square-btn btn-hover btn-sm" style="width: 60px; height: 40px;">초기화</button>
                        	</div>
                        </td>
                      </tr>
                      	<input type="hidden" id="emplNo${status.count}" value="${allVacData.emplNo}" name="emplNo">
                      	<input id="hiddenCmpnstnCnt${status.count}" type="hidden" value="${allVacData.cmpnstnYryc}" name="cmpnstnYryc">
                      	<input id="hiddenexcessWork${status.count}" type="hidden" value="${allVacData.excessWorkYryc}" name="excessWorkYryc">
                      	<input id="hiddenInputTotal${status.count}" type="hidden" readonly="readonly" name="totYrycDaycnt" value="${allVacData.totYrycDaycnt}" style="width:15px;"/>
                      	<input type="hidden" id="hiddenRemndrDaycnt${status.count}" name="yrycRemndrDaycnt" value="${allVacData.yrycRemndrDaycnt}">
                      	<input type="hidden" name="currentPage" value="${articlePage.currentPage}"/>
                      </form>
                      </c:forEach>
                      <!-- end table row -->
                    </tbody>
                  </table>
                  <!-- end table -->
                  <!-- 페이지네이션 -->
                  <div>
                  <page-navi
					url="/dclz/vacAdmin?"
					current="${param.get('currentPage')}"
					show-max="10"
					total="${articlePage.totalPages}">
				  </page-navi> 
				  </div>
				  <!-- 페이지네이션 -->
                </div>
              </div>
              <!-- end card -->
            </div>
            <!-- end col -->
          </div>
          
        <!-- 연차 Modal -->
        <!-- <form id="vacationSub"> -->
		<div class="modal fade" tabindex="-1" id="exampleModal" aria-labelledby="exampleModalLabel" aria-hidden="true"> 
		  <div class="modal-dialog modal-xl">
		    <div class="modal-content">
		      <div class="modal-header" id="emplVacationModal">
		        <h5 class="modal-title" id="exampleModalLabel"></h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body" id="vacationModalBody">
		        <c:import url="./vacationAdmin.jsp"></c:import>
		        
		    </div>
		  </div>
		</div>
		 <!-- </form> -->
		</div>
		<!-- 연차 Modal -->
		
        <!-- 조직도 Modal -->
		<div class="modal fade" tabindex="-1" id="orgListModal" aria-labelledby="orgListModalLabel" aria-hidden="true"> 
		  <div class="modal-dialog modal-sm">
		    <div class="modal-content"  style="max-height: 50%;">
		      <div class="modal-header">
		        <h5 class="modal-title">👥 부서 선택</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body" id="orgListModalBody">
		        <c:import url="../orgList.jsp"></c:import>
		    </div>
		  </div>
		</div>
		</div>
		<!-- 조직도 Modal -->
	</section>
  <%@ include file="../../layout/footer.jsp" %>
</main>
<%@ include file="../../layout/prescript.jsp" %>
<script type="text/javascript">

/* $('#addVacationForm').on('submit', function(e){
	e.preventDefault();
}) */

/* let selectEmpl = null;
	
function clickEmp(data){
	//console.log("data : " , data);
	//console.log("사원번호 : " , data.node.id);
	fetch('/emplDetailData?emplNo=' + data.node.id,{
		method : 'get',
		headers : {
	        "Content-Type": "application/json"
	    }
	 })
	 .then(resp => resp.json())
	 .then(res => {
		 console.log('fetch결과 : ' ,res);
		 selectEmpl = res;
	  }) 
}

// 검색한 사원의 사원번호 가져오기


let searchEmpl = null;
// 이름 검색하고 엔터 눌렀을시
function fSchEnder(e) {
   if (e.code === "Enter") {
	
	 $('#jstree').jstree(true).search($("#schName").val());   
	
	 
	 
   	/* fetch('/emplDetailData?emplNo=' + ,{
   		method : 'get',
   		headers : {
   	        "Content-Type": "application/json"
   	    }
   	 })
   	 .then(resp => resp.json())
   	 .then(res => {
   		 searchEmpl = res.empDetail;
   		 console.log('fetch결과 : ' ,searchEmpl);
   		 let emplNm = searchEmpl.emplNm;
		 let emplPos = searchEmpl.posNm;
		 let deptNm = searchEmpl.deptNm;
		 $('#username').val(emplNm+' '+emplPos);
		 $('#emplDep').val(deptNm);
   	 
   	 })  
   }
}   */

// 부서명 클릭했을때 조직도 띄우기
$('#searchDeptNm').on('click', function () {
  const deptModal = $('#orgListModal');
  $('#allBtn').hide();
  deptModal.show();
});

function clickDept(data){
	  console.log(data.node.text);
	  const deptNm = data.node.text;
	  $('#searchDeptNm').val(deptNm);
	  $('#orgListModal .btn-close').trigger('click');
}

function clickEmp(){
	swal('부서만 선택할 수 있습니다.')
}


// 사원 이름 눌렀을때
$('.vacation-modal-btn').on('click', function(){
	const emplNo = $(this).data('empl-no');
	console.log(emplNo);
	
	 fetch('/dclz/vacationAdmin?targetEmplNo='+emplNo , {
		method : 'get',
	   	headers : {
	   		 "Content-Type": "application/json"
	   	 }
		 })
		.then(resp => resp.text())
		.then(res => {
			$('#vacationModalBody').html(res);
			$('#exampleModal').show();
			//console.log('res : ' , res);
			
			$('#moreViewEmplVacation').on('click', function(){
				location.href = '/dclz/vacation?emplNo='+emplNo;
			})
	}) 
})

$(function(){	
	
	//------- 성과보상
	let previousValue = 0;
	$('.cmpnstnYrycCnt').on('focus', function() {
		//$(this).data('prev', parseFloat($(this).val()) || 0);
		previousValue = parseFloat($(this).val());
		//console.log('previousValue' , previousValue);
	});
	 $('.cmpnstnYrycCnt').on('input', function(){
			const id = $(this).attr('id');
			let value = $(this).val();
			//console.log('id ' , id);
			//console.log('value ' , value);
			
			const idx = id.match(/\d+/)[0];
			const inputTotalId = $('#inputTotalCnt'+idx);
			const yrycRemndrDaycnt = $('#yrycRemndrDaycnt'+idx).val();
			console.log($('#inputTotalCnt'+idx).val());
			
			const currentValue = parseFloat($(this).val());
			const diff = currentValue - previousValue;
			console.log('diff' , diff);
			
			let sumTotal = 0;
			let sumRemain = 0;
			let cmpnstn = 0;
			//let excessWork = 0;
			// 성과보상만큼 총 연차일수도 계산해주기
			if (diff === 0.5) {
				let totalId = $('#inputTotalCnt'+idx);
				let remainId = $('#yrycRemndrDaycnt'+idx);
				let cmpnstnCnt = $('#hiddenCmpnstnCnt'+idx);
				//let excessWorkCnt = $('#hiddenexcessWork'+idx);
				
				let total = totalId.val();
				let remain = remainId.val();
				let cmpstn = cmpnstnCnt.val();
				//let excessWork = excessWorkCnt.val();
				//console.log('성과일수 : ' , cmpstn);
				
				sumTotal =  Number(total) + diff;
				sumRemain = Number(remain) + diff;
				// 기존 성과보상 + 추가 성과보상
				sumCmpnstn =  Number(cmpstn) + diff;
				// 기존 근무보상 + 추가 근무보상
				//sumExcessWork = Number(excessWork) + diff;
				//console.log('더한 근무보상 : ' , sumExcessWork);
				console.log('더한 성과보상 : ' , sumCmpnstn);
				// 보내줘야할 성과, 초과 보상일수
				$('#hiddenCmpnstnCnt'+idx).val(sumCmpnstn);
				//$('#hiddenexcessWork'+idx).val(sumExcessWork);
				
				console.log('sumCmpnstn : ',sumCmpnstn);
				$('#inputTotalCnt'+idx).val(sumTotal);
				$('#yrycRemndrDaycnt'+idx).val(sumRemain);
				$('#hiddenInputTotal'+idx).val(sumTotal);
				$('#hiddenRemndrDaycnt'+idx).val(sumRemain);
				//$('#hiddenCmpnstnCnt'+idx).val(diff);
				//$('#hiddenexcessWork'+idx).val(value);
				console.log('hiddenCmpnstnCnt : ' , $('#hiddenCmpnstnCnt'+idx).val())
				
				//console.log(id + ':' + value);
			} else if (diff === -0.5) {
				let totalId = $('#inputTotalCnt'+idx);
				let remainId = $('#yrycRemndrDaycnt'+idx);
				total = totalId.val();
				remain = remainId.val();
				sumTotal = Number(total)+(diff) ;
				sumRemain = Number(remain) + diff;
				//console.log(sumTotal);
				$('#inputTotalCnt'+idx).val(sumTotal);
				$('#yrycRemndrDaycnt'+idx).val(sumRemain);
				$('#hiddenCmpnstnCnt'+idx).val(diff);
				$('#hiddenInputTotal'+idx).val(sumTotal);
				$('#hiddenRemndrDaycnt'+idx).val(sumRemain);
				//$('#hiddenexcessWork'+idx).val(value);
				console.log('hiddenCmpnstnCnt : ' , $('#hiddenCmpnstnCnt'+idx).val())
			} 
			previousValue = currentValue;
		})
		//------- 성과보상
			
		//------- 근무보상
		 let previousVal = 0;
		$('.excessWorkYryc').on('focus', function() {
			previousVal = parseFloat($(this).val());
			//console.log('previousVal' , previousVal);
		});
		$('.excessWorkYryc').on('input', function(){
			const workId = $(this).attr('id');
			const workVal = $(this).val();
			console.log('workId ' , workId);
			console.log('workVal ' , workVal);
			
			const currentVal = parseFloat($(this).val());
			const diffVal = currentVal - previousVal;
			console.log('diffVal' , diffVal);
			
			const index = workId.match(/\d+/)[0];
			const inputTotalId = $('#inputTotalCnt'+index);
			const yrycRemndrDaycnt = $('#yrycRemndrDaycnt'+index).val();
			console.log($('#inputTotalCnt'+index).val());
			
			let sumTotal = 0;
			let sumRemain = 0;
			let excessWork = 0;
			// 성과보상만큼 총 연차일수도 계산해주기
			if (diffVal === 0.5) {
				let totalId = $('#inputTotalCnt'+index);
				let remainId = $('#yrycRemndrDaycnt'+index);
				let excessWorkCnt = $('#hiddenexcessWork'+index);
				
				let total = totalId.val();
				let remain = remainId.val();
				let excessWork = excessWorkCnt.val();
				//console.log('근무잃수 : ' , excessWork);
				
				sumTotal =  Number(total) + diffVal;
				sumRemain = Number(remain) + diffVal;
				// 기존 성과보상 + 추가 성과보상
				// 기존 근무보상 + 추가 근무보상
				sumExcessWork = Number(excessWork) + diffVal;
				console.log('더한 근무보상 : ' , sumExcessWork);
				// 보내줘야할 초과 보상일수
				$('#hiddenexcessWork'+index).val(sumExcessWork);
				
				$('#inputTotalCnt'+index).val(sumTotal);
				$('#yrycRemndrDaycnt'+index).val(sumRemain);
				$('#hiddenInputTotal'+index).val(sumTotal);
				$('#hiddenRemndrDaycnt'+index).val(sumRemain);
				//console.log('hiddenCmpnstnCnt : ' , $('#hiddenCmpnstnCnt'+idx).val())
				
				//console.log(id + ':' + value);
			} else if (diffVal === -0.5) {
				let totalId = $('#inputTotalCnt'+index);
				let remainId = $('#yrycRemndrDaycnt'+index);
				total = totalId.val();
				remain = remainId.val();
				sumTotal = Number(total)+(diffVal) ;
				sumRemain = Number(remain) + diffVal;
				//console.log(sumTotal);
				$('#inputTotalCnt'+index).val(sumTotal);
				$('#yrycRemndrDaycnt'+index).val(sumRemain);
				$('#hiddenexcessWork'+index).val(value);
				$('#hiddenInputTotal'+index).val(sumTotal);
				$('#hiddenRemndrDaycnt'+index).val(sumRemain);
				//console.log('hiddenCmpnstnCnt : ' , $('#hiddenCmpnstnCnt'+idx).val())
			} 
			previousVal = currentVal;
		})
	//——— 근무보상
	$('.excessWorkYryc, .cmpnstnYrycCnt').on('input', function(){
		const id = $(this).attr('id');
		const idx = id.match(/\d+/)[0];
		
		let hiddenInputTotal = $('#hiddenInputTotal'+idx).val();
		let hiddenRemndrDaycnt = $('#hiddenRemndrDaycnt'+idx).val();
		let hiddenCmpnstnCnt = $('#hiddenCmpnstnCnt'+id).val();
					
		
		if($('#inputTotalCnt'+idx).val() >= 25){
			swal('연차는 최대 25일까지 지급할 수 있습니다.');
			$('#inputTotalCnt'+idx).val(hiddenInputTotal);
			console.log('inputTotalCnt : ', hiddenInputTotal);
			$('.cmpnstnYrycCnt').val('0.0');
			$('.excessWorkYryc').val('0.0');
		}
		
		if($('#yrycRemndrDaycnt'+idx).val() >= 25){
			swal('잔여 연차가 25일을 초과합니다.');
			$('#yrycRemndrDaycnt'+idx).val(hiddenRemndrDaycnt);
			$('.cmpnstnYrycCnt').val('0.0');
			$('.excessWorkYryc').val('0.0');
		}
		
		
		
		// 초기화 버튼 눌렀을때
		$('#resetBtn'+idx).on('click', function(){
			swal({
	            title: "정말 초기화 하시겠습니까?",
	            icon: "warning",
	            confirmButtonColor : '#d33',
	            buttons: {
	            	cancle : {
	            		text : '취소',
	            		value : false
	            	},
	            	confirm : {
	            		text : '확인',
	            		value : true
	            	}
	            },
	            dangerMode: true
	          })
			.then((wilDelete) => {
				if(wilDelete){
					$('#yrycRemndrDaycnt'+idx).val(hiddenRemndrDaycnt);
					$('#inputTotalCnt'+idx).val(hiddenInputTotal);
					$('.cmpnstnYrycCnt').val('0.0');
					$('.excessWorkYryc').val('0.0');
				}
			})
		})
		
		// 지급하기 버튼 눌렀을때
		$('#sendVacBtn'+idx).on('click', function(){
			swal({
	            title: "연차를 지급하시겠습니까?",
	            icon: "warning",
	            confirmButtonColor : '#d33',
	            buttons: {
	            	cancle : {
	            		text : '취소',
	            		value : false
	            	},
	            	confirm : {
	            		text : '확인',
	            		value : true
	            	}
	            },
	            dangerMode: true
	          })
			.then((wilDelete) => {
				if(wilDelete){
					const empNo = $('#emplNo'+idx).val();
					//console.log(empNo);
					$('#emplNo'+idx).val(empNo);
					console.log('성과연차 : ' , $('#hiddenCmpnstnCnt'+idx).val());
					console.log('근무연차 : ' , $('#hiddenexcessWork'+idx).val());
					console.log('총 연차 : ' , $('#hiddenInputTotal'+idx).val());
					console.log('잔여 연차 : ' , $('#hiddenRemndrDaycnt'+idx).val());
					$('#addVacationForm'+idx).submit();
				}
			})
		})
	})
	
	$('#ecnyDt').on('change', function(){
		let ecnyDt = $('#ecnyDt').val();
		let ecnyReplace = ecnyDt.replaceAll('-', '');
		console.log('선택 입사일자 : ' , ecnyReplace);
		$('#hidEncyDt').val(ecnyReplace);
	})
	
	$('#retireDt').on('change', function(){
		let retireDt = $('#retireDt').val();
		let retireReplace = retireDt.replaceAll('-', '');
		console.log('선택한 퇴사일자 : ' , retireReplace);
		$('#hidRetireDt').val(retireReplace);
	})
	
	// 검색 눌렀을시
	$('#vacAdminSearch').on('click', function(){
		// 사원이름 검색
		//let searchEmplNm = $('#searchEmplNm').val();
		//console.log('검색한 사원명 : ' , searchEmplNm);
		$('#vacAdminSearchForm').submit();
	})
	

	
	// 기본연차 선택시
	/* $('#basicVacRadio').on('change', function(){
		if($(this).val() == 'basic'){
			$('#basicVacSelect').prop('disabled', false);
			$('#addVacSelect').prop('disabled', true).val('없음');
		}
	}) */
	
	// 추가연차 선택시
	/* $('#addVacRadio').on('change', function(){
		if($(this).val() === 'add'){
			$('#addVacSelect').prop('disabled', false);
			$('#basicVacSelect').prop('disabled', true).val('없음');
		}
	})
		
	 // 추가화살표 눌렀을때
	 $('#add_empl').on('click', function(){
		 let emplData = selectEmpl.empDetail;
		 //console.log('선택한 사원 정보 : ' , emplData);
		 let emplNm = emplData.emplNm;
		 let emplPos = emplData.posNm;
		 let deptNm = emplData.deptNm;
		 $('#username').val(emplNm+' '+emplPos);
		 $('#emplDep').val(deptNm);
	 }) */
	 
	 // 삭제화살표 눌렀을때
	/*  $('#remo_empl').on('click', function(){
		 $('#username').val('');
		 $('#emplDep').val('');
	 })
	
	 // 연차 지급 확인버튼 눌렀을때 경고창
	 $('#empBtn').on('click', function(){
		 let empData = selectEmpl.empDetail;
		 //console.log('사원 : ',empData.emplNo);
		 
		 //let emplData = $('#username');
		 //console.log(emplData.val());
		 const usernameVal = $('#username').val();
		 if(usernameVal == null || usernameVal == ''){
			 swal('사원을 선택해주세요.');
		 }
		 
		// 지급 최대 연차일수 제한
		if($('#addVacCnt').val() > 25){
			swal('연차 일수는 최대 25일까지만 부여할 수 있습니다.')
			.then(() => {
				$('#addVacCnt').val(25).focus();
			})
		} */
		
		// 연차 종류 선택 안했을시 경고창
		/* const selected = $('input[name="vacType"]:checked').val();
		if(selected){
			swal('연차 유형을 선택해주세요.');
			return;
		}
				
		 // 기본연차
		 const basicVac = $('#basicVac').val();
		//성과보상, 근무보상
		 const addVacType = $('#addVac').val();
		 let vacCnt = $('#addVacCnt').val();
		 const emplNo = empData.emplNo;
		 //console.log('addVacType : ', addVacType);
		 //console.log('vacCnt : ', vacCnt);

		 // 기본 조정연차
		 let mdatYryc = 0;
		 // 성과보상
		 let cmpnstnYryc = 0;
		 // 근무보상
		 let excessWorkYryc = 0;

		 if(addVacType === '성과보상'){
			 cmpnstnYryc = vacCnt;
		 }else if(addVacType === '근무보상'){
			 excessWorkYryc = vacCnt;
		 }else if(basicVac === '기본지급'){
			 mdatYryc = vacCnt;
		 } */
	 	 //console.log('dfjkld : ' , cmpnstnYryc);
	 	 //console.log('zzzz : ' , excessWorkYryc);
	 	 //console.log('기본연차일수 : ' , mdatYryc);
	 	 
	 	 // 연차 update 해줄 데이터 보내기
	 	 /* fetch('/dclz/addVacInsert',{
	 		 method : 'post',
	 		 headers : {
	 			"Content-Type": "application/json"
	 		 },
	 		 body : JSON.stringify({
	 			 emplNo : emplNo,
	 			 cmpnstnYryc : cmpnstnYryc,
	 			 excessWorkYryc : excessWorkYryc,
	 			 yrycMdatDaycnt : mdatYryc
	 		 })
	 	 }) // end fetch
	 	 .then(resp => resp.text())
	 	 .then(res => {
	 		 swal('연차 지급이 완료되었습니다.')
	 		 .then((value)=>{
	 			 $('#exampleModal').modal('hide');
	 		 })
	 		 
	 		 //console.log('연차 추가하고 받은 결과 : ' , res);
	 	 }) 
	 })
	 
	 // 유형 selectBox 선택시
	/*  $('#vacType').on('change', function(){
		 const vacType = $('#vacType').val();
		 console.log('선택한 유형 : ' , vacType);
		 // 선택한 유형 보내주기
		 const typeKeyword = $('#typeKeyword').val(vacType);
		 //console.log("바꿔준 input 값 : " , typeKeyword.val());
		 $('#selTypeForm').submit();
	 })
	 // 년도 선택시
	 $('#vacYear').on('change', function(){
		 const vacYear = $('#vacYear').val();
		 console.log('선택날짜 : ' , vacYear);
		 // 선택 날짜 보내주기
		 const yearKeyword = $('#yearKeyword').val(vacYear);
		 $('#selYearForm').submit();
	 }) */
}) // end fn
	
	
</script>

</body>
</html>
