<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="메인" />
<c:set var="copyLight" scope="application" value="7FS" />

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
		    <div class="card-style mb-3" style="box-shadow: 1px 1px 20px 1px rgba(0,0,0,0.3); backdrop-filter: blur(15px);">
		      <c:import url="./organization/dclz/workButton.jsp" />
		    </div>
		    <!-- 출퇴근 -->

			<!-- 메일 + 일정 -->		    
		    <div class="card-style mb-3" style="box-shadow: 1px 1px 20px 1px rgba(0,0,0,0.3); backdrop-filter: blur(15px);">
		    <!-- 메일 위젯 -->
		    <div class="mb-4 text-center">
		    	<div class="rounded-4" style="background-color : rgb(230,230,250,0.3);">
			  	   	<a href="/mail/mailSend" class="btn-sm main-btn square-btn btn-hover mr-10 text-dark">
				  	   	<i class="lni lni-envelope"></i>
				  	   	메일쓰기
				  	</a>
			  	</div>
			    <div class="d-flex flex-column text-center">
			    	<p>미확인 <span class="text-medium text-dark ml-10">0건</span></p>
			    </div>
		    </div>
		    <!-- 메일 위젯 -->
		    <!-- 일정 위젯 -->
		    <div class="text-center">
		    	<div class="rounded-4" style="background-color : rgb(230,230,250,0.3);">
			  	   	<a href="/mail/mailSend" class="btn-sm main-btn square-btn btn-hover mr-10 text-dark ">
				  	   	<i class="lni lni-calendar"></i>
				  	   	일정등록
				  	</a>
			  	</div>
			    <div class="d-flex flex-column text-center">
			    	<p>오늘 일정 <span class="text-medium text-dark ml-10">2건</span></p>
			    </div>
		    </div>
		    <!-- 일정 위젯 -->
		    </div>
		    <!-- 메일 + 일정 -->
		    
		   <!-- 알림 -->
	       <div style="box-shadow: 1px 1px 20px 1px rgba(0,0,0,0.3); backdrop-filter: blur(15px);">
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
                 <div class="mb-4">
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
	  	  <div class="card-style mb-3">
	  	  	일정 목록
	  	  </div>
	  	  <!-- todo list-->
	  </div>
		
		  <!-- 오른쪽: 나머지 콘텐츠 카드 (약 3/4 비율) -->
		  <div class="col-md-9">
	   	   <!-- 전자결재 -->
			<div class="row">
	          <div class="col-6">
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
	          <div class="col-6">
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
            </div>
	          <!-- End Col -->
	         <div class="row">
	          <div class="col-6">
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
	          <div class="col-6">
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
	        </div>
	        <!-- 전자결재 -->
	        
	        <!-- 프로젝트 -->
			 <div class="card-style mb-3">
			 	프로젝트
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
		    <div class="card-style">
		     	통계
		    </div>
		    <!-- 통계 -->
		  </div>
		</div>

        
    </div>
  </section>
  <%@ include file="./layout/footer.jsp" %>
</main>
<%@ include file="./layout/prescript.jsp" %>
</body>
</html>
