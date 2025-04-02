<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="메인" />

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
 	<meta name="viewport"
		  content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"/>
	<meta http-equiv="X-UA-Compatible" content="ie=edge" />
	<title>${title}</title>
  <%@ include file="../layout/prestyle.jsp" %>
</head>
<body>
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
											<table border="1" id="s_eap_draft_info">
												<tr>
													<th>기안자</th>
													<td>${eap.emp_name }</td>
												</tr>
												<tr>
													<th>기안부서</th>
													<td>${eap.dept_name }</td>
												</tr>
												<tr>
													<th>기안일</th>
													<td>${eap.eap_draft_date }</td>
												</tr>
												<tr>
													<th>문서번호</th>
													<td id="s_dfNo">${resultDoc.df_no }</td>
												</tr>
											</table>
										</div>

										<div style="float: left; width: 130px; margin-right: 10px;">
											<table border="1" id="s_eap_draft">
												<tr>
													<th rowspan="2">신청</th>
													<td>${eap.job_title }</td>
												</tr>
												<tr>
													<td>${eap.emp_name }</td>
												</tr>
											</table>
										</div>

										<c:forEach items="${info }" var="i">
											<div style="float: left; width: 130px; margin-right: 5px;">
												<table border="1" class="s_eap_draft_app">
													<tr>
														<th rowspan="3">승인</th>
														<td>${i.job_title }</td>
													</tr>
													<tr>
														<td>${i.emp_name }</td>
													</tr>
													<tr>
														<td><c:if test="${empty i.df_no }">
																<img
																	src="https://media.discordapp.net/attachments/692994434526085184/988792844099678208/stamp_6.png"
																	style="width: 50px;">
															</c:if></td>
													</tr>
												</table>
											</div>
										</c:forEach>

										<div id="s_eap_final">
											<div>

												<div style="padding: 50px 10px 20px; clear: both;">
													<div
														style="display: inline-block; font-size: 1.2em; font-weight: bold;">제목
														:</div>
													<input type="text" class="form-control"
														style="display: inline-block; width: 583px; margin-left: 5px;"
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
													</div>

													<div style="padding: 10px 0;">
														<div class="s_frm_title">3. 기타</div>
														<div>문의사항은 BAB ${eap.emp_name }(${eap.emp_phone })에게
															연락바랍니다. 끝.</div>
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
// 전자결재 홈 클릭
function eapHome() {
	$("#menu_eap").get(0).click();
}

// 결재선 지정 시 결재상태에 따라 글씨색 변경
for(var i = 0; i < 3; i++) {
	if($(".s_span_fw").eq(i).text() == '결재') {
		$(".s_span_fw").eq(i).css('color', 'rgb(5, 131, 242)');
	} else if($(".s_span_fw").eq(i).text() == '대기') {
		$(".s_span_fw").eq(i).css('color', 'gray');
	} else if($(".s_span_fw").eq(i).text() == '반려') {
		$(".s_span_fw").eq(i).css('color', 'green');
	}
}

</script>

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
        var deptCnt = 1;
        var arr = [];
        // 결재선에서 '->' 클릭 시
		$("#s_add_appLine").click(function() {
			var empNo = $(".jstree-clicked").text().slice(-8, $(".jstree-clicked").text().length-1);
			var text = $(".jstree-clicked").text();
            var name = $('.jstree-clicked').text().substr(0,3);
            var job = $('.jstree-clicked').text().substr(4,2); // 부사장 '부사'로 되어 수정
            var result = $('.jstree-clicked').text().substr(4,2).match("^부사") // 부사로 시작하지 않으면 null 리턴
            if(result != null) {
            	job = $('.jstree-clicked').text().substr(4,3);
            }
            
            var deptText = $('.jstree-clicked').parent().parent().parent().text().substr(0,3);
            // 임원 부서가 '임원이'로 되어 수정
            if($('.jstree-clicked').parent().parent().parent().text().substr(0,3).length <= 3) {
         	    deptText = $('.jstree-clicked').parent().parent().parent().text().substr(0,2);
         	}
           var deptName = $(".jstree-clicked").text();
             
             
           for(var i = 0; i < $('.s_td_name').length; i++) {
        	   if($(".s_td_name").eq(i).text() == name) {
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
			for(var i = 0; i < $('.s_td_deptName').length; i++) {
				if($('.s_td_deptName').eq(i).text() == deptName) {
					swal({
	                       title: "",
	                       text: "참조처에 이미 선택되어 있습니다.",
	                       icon: "error",
	                       closeOnClickOutside: false,
	                       closeOnEsc: false
	                   });
					return;
				}
			}
			
// 			// 본인을 결재선 리스트에 추가할 때 alert
<%-- 			var checkEmpName = "<%=empName%>"; --%>
// 			if(name == checkEmpName) {
// 				swal({
//                     title: "",
//                     text: "본인은 결재선 리스트에 추가할 수 없습니다.",
//                     icon: "error",
//                     closeOnClickOutside: false,
//                     closeOnEsc: false
//                 });
// 				return;
// 			}
			
			// 결재선 리스트 추가
             if($('.jstree-clicked').text().length > 3) {
              if($(".s_appLine_tbody_cl tr").length < 3) {
            	  arr.push({"name":name,"deptText":deptText,"job":job,"empNo":empNo})
	              fn_arr(arr);
              } else {
            	  swal({
                      title: "",
                      text: "결재선은 최대 3명까지 추가가 가능합니다.",
                      icon: "error",
                      closeOnClickOutside: false,
                      closeOnEsc: false
                  });
              }
             } else if($('.jstree-clicked').text().length <= 3) {
            	// 참조처 리스트 추가
          	   if ($(".s_appDept_tbody_cl tr").length < 2) {
           	  $('.s_appDept_tbody_cl').append(
           			'<tr>'
           			+ '<td>' + deptCnt + '</td>'
           			+ '<td class="s_td_deptName">' + deptName + '</td>'
           			+ '</tr>'
           	  );
           	  	deptCnt++;
          	   } else {
          		 swal({
                     title: "",
                     text: "참조처는 최대 2개 부서까지 추가가 가능합니다.",
                     icon: "error",
                     closeOnClickOutside: false,
                     closeOnEsc: false
                 });
          	   }
             }
			
		});
        
        // 직책 순으로 정렬하는 함수
		function fn_arr(arr){
        	var cnt = 1;
        	var aprvList ="";
        	$(".s_appLine_tbody_cl").empty();
        	var jobArr = ['사원','대리','과장','차장','부장','이사','부사장','사장'];
			var numArr = [];
			var nArr = arr.slice();
			
			for(var i = 0; i < nArr.length; i++) { // 부장, 차장, 대리 순이라면
				numArr.push(jobArr.indexOf(nArr[i].job)); // 4,3,1이 들어감
			}
			
			numArr.sort();  // 1,3,4
			for(var i=0; i<numArr.length; i++){
				for(var j=0; j<arr.length; j++){
					if(nArr[j].job==jobArr[numArr[i]]){
						aprvList += '<tr>'
  	               				 + '<td>' + cnt + '</td>'
  	               				 + '<td class="s_td_name">' + nArr[j].name + '</td>'
  	               			 	 + '<td>' + nArr[j].deptText + '</td>'
  	               			     + '<td class="s_td_job">' + nArr[j].job + '</td>'
  	               			     + '</tr>'
  	               				 + '<input type="hidden" name="emp_no" class="emp_no" value="' + nArr[j].empNo + '">'
  	               				 cnt++;
  	               				 // 직급이 같을 때 for문 여러번 도는 것 막기
  	               				 nArr.splice(j,1);
  	               				 break;
					}	
				}
			}
			$(".s_appLine_tbody_cl").append(aprvList);
        }
        
        function fn_remove(arr) {
        	arr.splice(0); // arr 모두 삭제
        	$(".s_appLine_tbody_cl").children().remove(); // 테이블에 생성된 자식들 모두 삭제
        }
		
        // 결재선 쪽 <- 눌렀을 때
		$("#s_remove_appLine").click(function() {
			fn_remove(arr);
		});
		
		// 참조처 쪽 <- 눌렀을 때
		$("#s_remove_appDept").click(function() {
			$(".s_appDept_tbody_cl").children().last().remove();
			if(deptCnt == 1) {
				return;
			}
			deptCnt--;
		});
		
		// 모달에서 확인 클릭 시 
		$("#s_add_appLine_list").click(function() {
			
			if($(".s_td_name").length == 0) {
				swal({
                    title: "결재선이 지정되어있지 않습니다.",
                    text: "결재할 사원을 추가해주세요!",
                    icon: "error",
                    closeOnClickOutside: false,
                    closeOnEsc: false
                });
				return;
			}
			
			var empNoArr = [];
			for(var i = 0; i < $(".emp_no").length; i++) {
				empNoArr.push($(".emp_no").eq(i).val());
			}
			
		var obj = {"emp_no" : empNoArr};

			// 결재선 리스트에 있는 사원 번호를 가져와 결재선jsp에 이름, 부서, 직책 띄우기(ajax)
			$.ajax({
				url : "<%=request.getContextPath()%>/organ/applinelistsp"
		, type: "post"
		, data: obj
		, success: function(result) {
			$(".btn-close").trigger('click');
			$("#s_eap_content_box").html(result);
		}
	});
	
	var arr = [];
	for(var i = 0; i < $('.s_td_name').length; i++) {
		var tdName = $('.s_td_name').eq(i).text();
		arr.push(tdName);
	}
	var str1 = arr[0];
	var str2 = arr[1];
	var str3 = arr[2];
	
	if(str1 == undefined) {
		swal({
                  title: "",
                  text: "결재선에 1명 이상 선택해주세요.",
                  icon: "error",
                  closeOnClickOutside: false,
                  closeOnEsc: false
              });
	}
	if(str2 == undefined) {
		str2 = null;
	} 
	if(str3 == undefined) {
		str3 = null;
	} 
	// str1 => eap_first_ap에 저장
	// str2 => eap_mid_ap에 저장
	// str3 => eap_final_ap에 저장
	
	var arrDept = [];
	for(var i = 0; i < $('.s_td_deptName').length; i++) {
		var tdDeptName = $('.s_td_deptName').eq(i).text();
		arrDept.push(tdDeptName);
	}
	var deptStr1 = arrDept[0];
	var deptStr2 = arrDept[1];
	
	if(deptStr1 == undefined) {
		deptStr1 = null;
	}
	if(deptStr2 == undefined) {
		deptStr2 = null;
	}
	
	// deptStr1 => eap_first_dept에 저장
	// deptStr2 => eap_final_dept에 저장
	
	// ajax에 보낼 obj
	var dataObj = {
			"eap_first_ap" : str1,
			"eap_mid_ap" : str2,
			"eap_final_ap" : str3,
			"eap_first_dept" : deptStr1,
			"eap_final_dept" : deptStr2,
			"df_no" : $("#s_dfNo").text(),
	}
	
	$.ajax({
		url : "<%=request.getContextPath()%>/eap/updateappsp"
			, type: "post"
			, data: dataObj
			, success: function(result) {
				if(result.includes('실패')) {
					swal({
	                    title: "",
	                    text: result,
	                    icon: "error",
	                    closeOnClickOutside: false,
	                    closeOnEsc: false
	                });
				} else {
					swal({
	                    title: "",
	                    text: result,
	                    icon: "success",
	                    closeOnClickOutside: false,
	                    closeOnEsc: false
	                });
				}
			}
	});
});
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

<script>
// datepicker위젯
$(document).ready(function() {
	$("#s_sp_date").datepicker({
		timepicker: true,
		changeMonth: true,
           changeYear: true,
           controlType: 'select',
           timeFormat: 'HH:mm',
           dateFormat: 'yy-mm-dd',
           yearRange: '1930:2024',
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
<!-- 스크립트 입력 -->
</body>
</html>
