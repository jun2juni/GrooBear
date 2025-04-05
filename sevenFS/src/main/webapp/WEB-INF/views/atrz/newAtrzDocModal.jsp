<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!--새결재 진행-->
<div class="modal fade" id="newAtrzDocModal" tabindex="-1"
aria-labelledby="newAtrzDocModalLabel" aria-hidden="true">
<div class="modal-dialog">
	<div class="modal-content" style="width: 150%;">
		<div class="modal-header">
			<h5 class="modal-title" id="newAtrzDocModalLabel"
				style="font-weight: bold;">결재 양식 선택</h5>
			<button type="button" class="btn-close"
				data-bs-dismiss="modal" aria-label="Close"></button>
		</div>
		<div class="modal-body">
			<select id="s_document_form_select"
				name="s_document_form_select" class="form-select"F
				aria-label="Default select example">
				<option selected="selected">양식을 선택해주세요</option>
				<option id="s_holiday_form" value="s_holiday_form">연차신청서</option>
				<option id="s_spending_form" value="s_spending_form">지출결의서</option>
				<option id="s_draft_form" value="s_draft_form">기안서</option>
				<option id="s_salary_form" value="s_salary_form">급여명세서</option>
				<option id="s_account_form" value="s_account_form">급여계좌변경 신청서</option>
				<option id="s_certifi_form" value="s_certifi_form">재직증명서</option>
				<option id="s_resign_form" value="s_resign_form">퇴사신청서</option>
				<!-- 			            <option id="s_test_form" value="s_test_form">테스트</option> -->
			</select>
			<!-- 여기에 양식 미리보기라고 알려줘야됨 -->
			<p> 양식미리보기</p>
			<div id="s_document_form"
				style="margin-top: 20px; border: 1px solid lightgray; border-radius: 5px; padding: 10px;">
				양식을 선택해주세요.
			</div>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-secondary"
				data-bs-dismiss="modal" id="s_cancel_btn">취소</button>
			<button type="button" class="btn btn-primary"
				id="liveAlertBtn">확인</button>
		</div>
	</div>
</div>
</div>



<!--끝-->
<script>
	$(function(){
					$("#s_document_form_select").on("change",function(){
						let selectValue = $(this).val();   //양식선택한값 가져오기
						let url = "";
						console.log(selectValue);
						
	
						//선택한 값에 따라 url설정
						if(selectValue=="s_holiday_form"){  //연차신청서
							$("#s_document_form").load("<%=request.getContextPath()%>/atrz/selectForm/holidayForm");
							$("#s_document_form").html('');
	
						}else if(selectValue=="s_spending_form"){   //지출결의서
							$("#s_document_form").load("<%=request.getContextPath()%>/atrz/selectForm/spendingForm");
							$("#s_document_form").html('');
							
						}else if(selectValue=="s_draft_form"){  //기안서
							$("#s_document_form").load("<%=request.getContextPath()%>/atrz/selectForm/draftForm");
							$("#s_document_form").html('');
						}else if(selectValue=="s_draft_form"){  //급여명세서
							$("#s_document_form").load("<%=request.getContextPath()%>/atrz/selectForm/salaryForm");
							$("#s_document_form").html('');
						}
						else if(selectValue=="s_draft_form"){  //급여계좌변경서
							$("#s_document_form").load("<%=request.getContextPath()%>/atrz/selectForm/bankAccountForm");
							$("#s_document_form").html('');
						}
						else if(selectValue=="s_draft_form"){  //재직증명서
							$("#s_document_form").load("<%=request.getContextPath()%>/atrz/selectForm/certificationForm");
							$("#s_document_form").html('');
						}
						else if(selectValue=="s_draft_form"){  //퇴사신청서
							$("#s_document_form").load("<%=request.getContextPath()%>/atrz/selectForm/resignationForm");
							$("#s_document_form").html('');
						}else{   //양식을 선택하지않았다면
							$("#s_document_form").html("<div>양식을 선택해주세요.</div>");		
						}
					});//양식선택 end
					
					//양식선택후 확인버튼 클릭시(입력폼으로이동)
					$("#liveAlertBtn").click(function(){
						var form  = $('#s_document_form_select').val();
						if(form =="s_holiday_form"){
							//강제로 닫기 버튼 클릭
							$(".btn-close").trigger("click");
						}else if(form ==s_spending_form){
							//강제로 닫기 버튼 클릭
							$(".btn-close").trigger("click");
						}else{
							$("s_document_form").html('<div class="alert alert-danger d-flex align-items-center" role="alert">'
			        				  + '<i class="bi bi-exclamation-triangle-fill"></i>'
			        				  + '<div style="margin-left: 5px;">'
			        				    + '양식을 선택해주세요.'
			        				  + '</div>'
			        				+ '</div>')
						}
						
						//결재양식선택에 있는 option의 text를 form변수에 담아줌
						var form  = $("#s_document_form_select option:selected").text();
						//연차신청서
						console.log("form(후) : ", form);
						
						if(form == "양식을 선택해주세요"){
						}else {
							$.ajax({
								url:"<%=request.getContextPath()%>/atrz/insertDoc"
// 								url:"/selectform/spending"
								//ajax data로 보냄(form : 연차신청서)
								,data:{"form" : form}
								,type:"POST"
								,dataType:"text"
								,success: function(result){
									//result :  연차신청서
									console.log("result : " , result);
									// 선택한 문서 양식이 "연차신청서"일 경우
								    if (result == "연차신청서") {
										// 페이지 이동
										location.href="selectForm/holiday";
								    }else if(result == "지출결의서"){
								    	location.href="selectForm/spending";
								    }else if(result == "기안서"){
								    	location.href="selectForm/draft";
								    }else if(result == "급여명세서"){
								    	location.href="selectForm/salary";
								    }else if(result == "급여계좌변경신청서"){
								    	location.href="selectForm/bankAccount";
								    }else if(result == "재직증명서"){
								    	location.href="selectForm/certification";
								    }else {
										location.href="selectForm/resignation";
								    }
									//받아온 결과가 jsp라서 그자리 html을 result로 넣어즘
// 									$("#home-tab-pane").html(result);
								}//ajax success End 
							})//ajax End
						} //else End
						
					})//결재양식선택확인btn End
					
			})//end 달러function
</script>
