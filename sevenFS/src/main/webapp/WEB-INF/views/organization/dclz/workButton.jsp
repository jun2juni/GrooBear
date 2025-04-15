<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- 디지털 시계 -->
<%
	java.util.Date now = new java.util.Date();
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("HH:mm:ss");
	java.text.SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	dateFormat.applyPattern("yyyy년 MM월 dd일");
	String serverTime = sdf.format(now);
	String serverDate = dateFormat.format(now);
%>

<!-- 출퇴근 버튼 -->
<div class="">
	<div class=" text-center">
		<span class="status-btn dark-btn text-center mt-30"><%= serverDate %></span>
		<div id="clock" style="font-size: 24px; font-weight: bold;"></div>
		<div class="d-flex mb-30 mt-3 justify-content-center">
			<div class="content mr-30">
		       	<button type="button" id="${todayWorkTime != null ? '' : 'workStartButton'}" class="btn-sm main-btn primary-btn-light rounded-full btn-hover">출근</button>
				<p id="startTime">${todayWorkTime != null ? todayWorkTime : '출근 전'}</p>
		    </div>
		    <div class="content">
		       	<button type="button" id="${todayWorkEndTime != null ? '' : 'workEndButton'}" class="btn-sm main-btn danger-btn-light rounded-full btn-hover">퇴근</button>
				<p id="endTime">${todayWorkEndTime != null ? todayWorkEndTime : '퇴근 전'}</p>
		    </div>
		</div>
	</div>
</div> 


<script type="text/javascript">
// 비동기로 출퇴근 시간 출력하기
 document.addEventListener("DOMContentLoaded", function() {
	 
	 $("#workStartButton").on("click", function(){
		//alert("출근");
		
		const startTime = $('#startTime').val();
		
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
				
				$("#workStartButton").prop("disabled", true);
				
				location.href="/main/home";
				
			})
			}else{
				swal("출근 버튼을 다시 눌러주세요.", " ", "warning");
			};
		})
		.catch(err => {
			swal("출근 버튼을 다시 눌러주세요.", " ", "warning");
		})// end fetch
	}) // end startBtn 
		
		
	$("#workEndButton").on("click", function(){
		//alert("퇴근");		
		
		const endTime = $('#endTime').val();	
		//console.log(endTime);
		
		// 비동기로 update 하고 퇴근 시간 가져오기
		 fetch("/main/todayWorkEnd", {
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
				location.href="/main/home";
				endTime.disabled = true;
			})
			}else{
				swal("퇴근 버튼을 다시 눌러주세요.", " ", "warning");
			};
		})
		.catch(err => {
			swal("퇴근 버튼을 다시 눌러주세요.", " ", "warning");
		})// end fetch 
	}) // end endBtn
}); // end fn		


//디지털시계
  let timeParts = '<%= serverTime %>'.split(':');
  let hours = parseInt(timeParts[0]);
  let minutes = parseInt(timeParts[1]);
  let seconds = parseInt(timeParts[2]);

  function updateClock() {
    seconds++;
    if (seconds >= 60) {
      seconds = 0;
      minutes++;
    }
    if (minutes >= 60) {
      minutes = 0;
      hours++;
    }
    if (hours >= 24) {
      hours = 0;
    }

    const formattedTime = 
      String(hours).padStart(2, '0') + ':' +
      String(minutes).padStart(2, '0') + ':' +
      String(seconds).padStart(2, '0');

    document.getElementById('clock').textContent = formattedTime;
  }

  setInterval(updateClock, 1000);
</script>


</body>
</html>
