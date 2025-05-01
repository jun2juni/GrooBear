<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<script type="text/javascript">
// 비동기로 출퇴근 시간 출력하기
 document.addEventListener("DOMContentLoaded", function() {
	 
	 const startTime = $('#inputTodWorkTime').val();	
	 console.log('startTime : ' ,startTime);
		
	 $("#workStartButton").on("click", function(){
			//alert("출근");
			//const startTime = $('#startTime').val();
			/* if(startTime == null && startTime == ''){ */
				// 비동기로 insert 하고 출근 시간 가져오기
				fetch("/main/todayWorkStart", {
					method : "get",
					headers : {
						"Content-Type": "application/json"
					}
				})
				.then(resp => resp.text())
				.then(res => {
					if(res != null){
						swal("출근이 등록되었습니다.", " ", "success")
						.then((value) => {
						//console.log("출근 시간 : " , res);
						$("#startTime").html(res);
						//$("#workStartButton").prop("disabled", true);
						location.href="/main/home";
					})
					}else{
						swal("출근 버튼을 다시 눌러주세요.", " ", "warning");
					};
				})
				.catch(err => {
					swal("출근 버튼을 다시 눌러주세요.", " ", "warning");
				})// end fetch
			/* } */
		}) // end startBtn 
	
		
		
	$("#workEndButton").on("click", function(){
		//alert("퇴근");		
		
		const endTime = $('#endTime').val();	
		//console.log(endTime);
		console.log(endTime);
		
		if(endTime == null && endTime == ''){
			// 비동기로 update 하고 퇴근 시간 가져오기
			 fetch("/main/todayWorkEnd", {
				method : "get",
				headers : {
					"Content-Type": "application/json"
				}
			})
			.then(resp => resp.text())
			.then(res => {
				if(res != null && res != ''){
					swal("퇴근이 완료되었습니다.", " ", "success")
					.then((value) => {
					console.log("퇴근 시간 : " , res);
					$("#endTime").html(res);
					location.href="/main/home";
					//$("#workEndButton").prop("disabled", true);
				})
				}
				else if(endTime != null && endTime != ''){
					swal("퇴근 버튼을 다시 눌러주세요.", " ", "warning");
				};
			})
			.catch(err => {
				swal("퇴근 버튼을 다시 눌러주세요.", " ", "warning");
			})// end fetch 
		}
		else{
			swal({
				title: "퇴근 등록",
				text: "정말로 퇴근을 등록하시겠습니까?",
				icon: "warning",
				buttons: {
					cancel: {
						text: "취소",
						value: null,
						visible: true,
						closeModal: true
					},
					confirm: {
						text: "확인",
						value: true,
						closeModal: true
					}
				} 
				})
				.then((willConfirm) => {
					if(willConfirm){
						fetch("/main/todayWorkEnd", {
							method : "get",
							headers : {
								"Content-Type": "application/json"
							}
						})
						.then(resp => resp.text())
						.then(res => {
							if(res != null){
								swal({
									icon : 'success',
									text : '퇴근이 완료되었습니다.',
									buttons: {
										confirm : {
											text : '확인',
											value : 'true',
							                closeModal: true
										}
									}
								})
								.then((value) => {
								console.log("퇴근 시간 : " , res);
								$("#endTime").html(res);
								location.href="/main/home";
							})
							}
							else{
								swal("퇴근 버튼을 다시 눌러주세요.", " ", "warning");
							};
						})
						.catch(err => {
							swal("퇴근 버튼을 다시 눌러주세요.", " ", "warning");
						})
					}
				})
			}
		}) // end endBtn
	
	
	
}); // end fn		



</script>


</body>
</html>
