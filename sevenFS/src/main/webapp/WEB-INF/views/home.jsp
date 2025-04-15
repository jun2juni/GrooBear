<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="메인" />
<c:set var="copyLight" scope="application" value="7FS" />

<!-- 디지털 시계 -->
<%
	java.util.Date now = new java.util.Date();
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("HH:mm:ss");
	java.text.SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	dateFormat.applyPattern("yyyy년 MM월 dd일");
	String serverTime = sdf.format(now);
	String serverDate = dateFormat.format(now);
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport"
        content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"/>
  <meta http-equiv="X-UA-Compatible" content="ie=edge" />
  <title>${title}</title>
  <%@ include file="./layout/prestyle.jsp" %>
</head>
<body>
<%@ include file="./layout/sidebar.jsp" %>
<main class="main-wrapper">
  <%@ include file="./layout/header.jsp" %>
  <section class="section">
		<div class="container-fluid">
		  <div class="row">
		  <div class="col-md-3">
		    <!-- 출퇴근-->
		    <div class="card-style mb-3" style="box-shadow: 1px 1px 20px 1px rgba(0,0,2,0.1);">
		      <c:import url="./organization/dclz/workButton.jsp" />
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
		    </div>
		    <!-- 출퇴근 -->

			<!-- 메일 + 일정 -->		    
		    <div class="card-style mb-3 d-flex flex justify-content-center" style="box-shadow: 1px 1px 20px 1px rgba(0,0,2,0.1); backdrop-filter: blur(15px);">
			    <div class="d-flex justify-content-center">
			    <!-- 메일 위젯 -->
			    <div class="text-center mr-15">
			    	 <div class="rounded-4" style="background-color : rgb(230,230,250,0.5); display: inline-block;"> 
				  	   	<a href="/mail/mailSend" class="btn-sm main-btn square-btn btn-hover text-dark" style="padding:8px;">
					  	   	<i class="lni lni-envelope"></i>
					  	   	메일쓰기
					  	</a>
				  	 </div>
				    <!-- <div class="d-flex flex-column text-center"> -->
				    	<p>미확인 <span class="text-sm text-dark ml-2">0건</span></p>
				    <!-- </div> -->
			    </div>
			    <!-- 메일 위젯 -->
			    <!-- 일정 위젯 -->
			    <div class="text-center">
			    	<div class="rounded-4" style="background-color : rgb(230,230,250,0.5); display: inline-block;">
				  	   	<a href="/mail/mailSend" class="btn-sm main-btn square-btn btn-hover mr-10 text-dark" style="padding:8px;">
					  	   	<i class="lni lni-calendar"></i>
					  	   	일정등록
					  	</a>
				  	 </div>
				    <!-- <div class="d-flex flex-column text-center"> -->
				    	<p>오늘 일정 <span class="text-sm text-dark ml-2">2건</span></p>
				    <!-- </div> -->
			    </div>
			    <!-- 일정 위젯 -->
			    </div>
		    <!-- 메일 + 일정 -->
		    </div>
		    
		   <!-- 알림 -->
	       <div style="box-shadow: 1px 1px 20px 1px rgba(0,0,2,0.1); backdrop-filter: blur(15px);">
			<div class="card-style mb-3	">
				<div class="row mb-4">
				<div class="text-bold">
                    💌
			    	<span class="text-dark text-bold ml-3">최근 알림</span>
                 </div>
				</div>
				<div class=" row d-flex">
                  <div class="mb-4">
	              <a href="#0" class="content">
	              	<span class="text-black text-sm">
	              		게시판 알림
	              	</span>
	                <span class="text-sm text-gray">
	               		"2025.04.15. 01:33"
	                </span>
	              </a>
                 </div>
                 <hr/>
                 <div class="mb-4">
	              <a href="#0" class="content">
	                <span class="text-black text-sm">
	                	공지 알림
	                </span>
	                <span class="text-sm text-gray">
	               	    "2025.04.15. 01:33"
	                </span>
	              </a>
                 </div>
                 <hr/>
                 <div class="">
	              <a href="#0" class="content">
	                <span class="text-black text-sm">
					'모바일 쿠폰 서비스
					임직원을 위한 맞춤형 쿠폰 발송, ONE-STOP으로 해결!</h6>
	                </span>
	                  <span class="text-sm text-gray">"2025.04.15. 01:33"</span>
	              </a>
                 </div>
              </div>
       		 </div>
	  	  </div>
	  	  <!-- 알림 -->
	  	  <!-- todo list -->
	  	  <div class="card-style mb-3" style="box-shadow: 1px 1px 20px 1px rgba(0,0,2,0.1);">
	  	  	일정 목록
	  	  </div>
	  	  <!-- todo list-->
	  </div>
		
		  <!-- 오른쪽: 나머지 콘텐츠 카드 (약 3/4 비율) -->
		  <div class="col-md-9">
	   	   <!-- 전자결재 -->
			<div class="row">
	          <div class="col-3">
	            <div class="icon-card mb-30">
	              <div class="icon orange">
	                <i class="lni lni-more"></i>
	              </div>
	              <div class="content">
		              <h6>결재 대기중</h6>
		                <h4>
		                	<a href="/atrz/approval" style="margin-top: 20px;" class="text-bold mb-10">0건</a>
		                </h4>
	                <p class="text-sm text-success">
	                </p>
	              </div>
	            </div>
	            <!-- End Icon Cart -->
	          </div>
	          <!-- End Col -->
	          <div class="col-3">
	            <div class="icon-card mb-30">
	              <div class="icon purple">
	                <i class="lni lni-spinner"></i>
	              </div>
	              <div class="content">
	                <h6>결재 진행중</h6>
		                 <h4>
		                	<a href="/atrz/home" style="margin-top: 20px;" class="text-bold mb-10">0건</a>
		                </h4>
	                <p class="text-sm text-success">
					</p>
	              </div>
	            </div>
	            <!-- End Icon Cart -->
	          </div>
	          <!-- End Col -->
           <!--  </div> -->
	          <!-- End Col -->
	        <!--  <div class="row"> -->
	          <div class="col-3">
	            <div class="icon-card mb-30">
	              
	              <div class="icon success">
                    <i class="lni lni-checkmark-circle"></i>
                  </div>
	              <div class="content">
	                <h6>결재 완료</h6>
		                 <h4>
		                 	<a href="#0" style="margin-top: 20px;" class="text-bold mb-10">0건</a>
		                 </h4>
	                <p class="text-sm text-success">
	                </p>
	              </div>
	            </div>
	            <!-- End Icon Cart -->
	          </div>
	          <div class="col-3">
	            <div class="icon-card">
	              <div class="icon orange" style="background-color : #ffe4e1; color:red;">
	                <i class="lni lni-cross-circle"></i>
	              </div>
	              <div class="content">
	                <h6>결재 반려</h6>
		              	  <h4>
		              	  	<a href="#0" style="margin-top: 20px;" class="text-bold mb-10">0건</a>
		              	  </h4>
	                <p class="text-sm text-danger">
	               
	                </p>
	              </div>
	            </div>
	            <!-- End Icon Cart -->
	          </div>
	          <!-- End Col -->
	        <!--    </div> -->
	        <!-- 전자결재 -->
	        
	        <!-- 프로젝트 -->
	        <div class="col-lg-12">
              <div class="card-style mb-30">
              	프로젝트 목록
               </div>
             </div>
	        <!-- 프로젝트 -->
	        
		    <!-- 게시판 -->
            <div class="col-lg-12">
              <div class="card-style mb-30">
                <h6 class="mb-10">전사게시판 최근글</h6>
                <div class="bd-example">
				<ul class="nav nav-tabs">
				  <li class="nav-item">
				    <a class="nav-link active" aria-current="page" href="#">공지사항</a>
				  </li>
				  <li class="nav-item">
				    <a class="nav-link" href="#">오늘의 식단</a>
				  </li>
				  <li class="nav-item">
				    <a class="nav-link" href="#">Link</a>
				  </li>
				</ul>
				</div>
                <hr/>
                <div class="table-wrapper table-responsive">
                  <table class="table">
                    <tbody>
                         <div class="lead">
                           <div class="lead-image">
                             <img src="assets/images/lead/lead-1.png" alt="">
                           </div>
                           <div class="lead-text">
                             <span class="text-dark text-bold text-sm">🖥 - 전자결재 '이것' 하나면 업무가 훨씬 가벼워져요! 바로 다우오피스의 전자결재 기능인데요🤗 원하는대로 양식을 편집하고, 클릭 한 번으로 언제 </span>
                           </div>
                            <p>2024-02-02 14:25 한성준 과장</p>
                         </div>
                         <div class="lead">
                           <div class="lead-image">
                             <img src="assets/images/lead/lead-1.png" alt="">
                           </div>
                           <div class="lead-text">
                             <span class="text-dark text-bold text-sm">📧메일 기능 메일 이렇게 쓰면 센스있단 소리 들어요! 다우오피스의 메일 기능 한 눈에 알아보기👀자동 분류, 자동 검색, 보안 메일, 대용량 신속 발송까지! </span>
                           </div>
                            <p>2024-02-01 11:20 한성준 과장</p>
                         </div>
                    </tbody>
                  </table>
                  <!-- end table -->
                </div>
              </div>
              <!-- end card -->
            </div>
            <!-- 게시판 -->
		    <!-- 통계 -->
		    <div class="col-lg-12">
              <div class="card-style mb-30">
              	통계
               </div>
             </div>
		    <!-- 통계 -->
		  </div>
		</div>

        
    </div>
  </section>
  <%@ include file="./layout/footer.jsp" %>
</main>
<%@ include file="./layout/prescript.jsp" %>

<script type="text/javascript">
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
