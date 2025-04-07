<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<script type="text/javascript">
// 비동기로 출퇴근 시간 출력하기
 document.addEventListener("DOMContentLoaded", function() {
	 $("#workStartButton").on("click", function(){
		//alert("출근");
		
		const startTime = $('#startTime').val();
		//startTime.disabled = false;
		
/* 		if(startTime != null){
			swal("이미 출근이 등록된 사원입니다.", " ", "warning");
		}else{   */
			
		// 비동기로 insert 하고 출근 시간 가져오기
		fetch("/dclz/todayWorkStart", {
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
				location.href="/dclz/dclzType";
				startTime.disabled = true;
			})
			}else{
				swal("출근 버튼을 다시 눌러주세요.", " ", "warning");
			};
		})
		.catch(err => {
			swal("출근 버튼을 다시 눌러주세요.", " ", "warning");
		})// end fetch
	 /*    }   */
	}) // end startBtn 
		
		
	$("#workEndButton").on("click", function(){
		//alert("퇴근");
		
		const endTime = $('#endTime').val();
		//endTime.disabled = false;
		
		//console.log(endTime);
		
		// 이미 퇴근을 눌렀으면 경고창
	/* 	 if(endTime != null){
			swal("이미 퇴근처리가 완료된 사원입니다.", " ", "warning");
		} else{  */ 
		// 비동기로 update 하고 퇴근 시간 가져오기
		 fetch("/dclz/todayWorkEnd", {
			method : "get",
			headers : {
				"Content-Type": "application/json"
			}
		})
		.then(resp => resp.text())
		.then(res => {
			if(res != null){
				swal("퇴근이 완료되었습니다.", " ", "success")
				.then((value) => {
				console.log("퇴근 시간 : " , res);
				$("#endTime").html(res);
				location.href="/dclz/dclzType";
				endTime.disabled = true;
			})
			}else{
				swal("퇴근 버튼을 다시 눌러주세요.", " ", "warning");
			};
		})
		.catch(err => {
			swal("퇴근 버튼을 다시 눌러주세요.", " ", "warning");
		})// end fetch 
	/*    }   */
	}) // end endBtn
		
}); // end fn		
</script>


</body>
</html>
