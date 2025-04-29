<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
.modalBtn{
	padding: 10px 20px;
	font-size: 1.1em;
}
</style>
<!-- 결재 양식 선택 모달 -->
<div class="modal fade" id="newAtrzDocModal" tabindex="-1" aria-labelledby="newAtrzDocModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-lg">
	  <div class="modal-content border-0 rounded-4 shadow p-4" style="max-height: 90vh; overflow: hidden;">
  
		<!-- Modal Header -->
		<div class="modal-header border-0">
		  <h5 class="modal-title fw-bold" id="newAtrzDocModalLabel">결재 양식 선택</h5>
		  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		</div>
  
		<!-- Modal Body (scrollable only body) -->
		<div class="modal-body overflow-auto" style="max-height: 80vh;">
		  <div class="mb-4">
			<label for="s_document_form_select" class="form-label fw-semibold">양식 선택</label>
			<select id="s_document_form_select" name="s_document_form_select" class="form-select form-select">
			  <option selected disabled>양식을 선택해주세요</option>
			  <option value="s_holiday_form">연차신청서</option>
			  <option value="s_spending_form">지출결의서</option>
			  <option value="s_draft_form">기안서</option>
			  <option value="s_salary_form">급여명세서</option>
			  <option value="s_account_form">급여계좌변경신청서</option>
			  <option value="s_certifi_form">재직증명서</option>
			  <option value="s_resign_form">퇴사신청서</option>
			</select>
		  </div>
  
		  <div id="s_document_form" class="bg-light p-4 rounded-3 border" style="min-height: 150px;">
			결재 양식 미리보기
		  </div>
		</div>
  
		<!-- Modal Footer -->
		<div class="modal-footer border-0 d-flex justify-content-center gap-3">
		  <button type="button" class="btn btn-outline-secondary rounded-pill px-4" data-bs-dismiss="modal" id="s_cancel_btn">취소</button>
		  <button type="button" class="btn btn-primary rounded-pill px-4" id="liveAlertBtn">확인</button>
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
		}else if(selectValue=="s_salary_form"){  //급여명세서
			$("#s_document_form").load("<%=request.getContextPath()%>/atrz/selectForm/salaryForm");
			$("#s_document_form").html('');
		}else if(selectValue=="s_account_form"){  //급여계좌변경서
			$("#s_document_form").load("<%=request.getContextPath()%>/atrz/selectForm/bankAccountForm");
			$("#s_document_form").html('');
		}else if(selectValue=="s_certifi_form"){  //재직증명서
			$("#s_document_form").load("<%=request.getContextPath()%>/atrz/selectForm/certificationForm");
			$("#s_document_form").html('');
		}else if(selectValue=="s_resign_form"){  //퇴사신청서
			$("#s_document_form").load("<%=request.getContextPath()%>/atrz/selectForm/resignationForm");
			$("#s_document_form").html('');
		}else{   //양식을 선택하지않았다면
			$("#s_document_form").html("<div>양식을 선택해주세요.</div>");		
		}
	});//양식선택 end
	
	//양식선택후 확인 버튼을 눌렀을때
	$("#liveAlertBtn").click(function(){
	    var formValue = $('#s_document_form_select').val(); // 실제 value
	    var formText = $("#s_document_form_select option:selected").text(); // 보여지는 텍스트

	    if (formText === "양식을 선택해주세요") {
	        // 아무것도 선택하지 않았을 때만 경고 메시지
	        $("#s_document_form").html(
	            '<div class="alert alert-danger d-flex align-items-center" role="alert">'
	            + '<i class="bi bi-exclamation-triangle-fill"></i>'
	            + '<div style="margin-left: 5px;">양식 선택 후 확인 버튼을 눌러주세요.</div>'
	            + '</div>'
	        );
	        return; // 여기서 함수 종료
	    }

	    // 양식 정상 선택한 경우
	    $(".btn-close").trigger("click");

	    $.ajax({
	        url: "<%=request.getContextPath()%>/atrz/insertDoc",
	        data: {"form" : formText},
	        type: "POST",
	        dataType: "text",
	        success: function(result) {
	            console.log("result : ", result);
	            if (result == "연차신청서") {
	                location.href = "selectForm/holiday";
	            } else if (result == "지출결의서") {
	                location.href = "selectForm/spending";
	            } else if (result == "기안서") {
	                location.href = "selectForm/draft";
	            } else if (result == "급여명세서") {
	                location.href = "selectForm/salary";
	            } else if (result == "급여계좌변경신청서") {
	                location.href = "selectForm/bankAccount";
	            } else if (result == "재직증명서") {
	                location.href = "selectForm/certification";
	            } else {
	                location.href = "selectForm/resignation";
	            }
	        }
	    });
	});			
	
	
//결재양식선택확인btn End
})//end 달러function
</script>
