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
	<meta
			name="viewport"
			content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"
	/>
	<meta http-equiv="X-UA-Compatible" content="ie=edge" />
	<title>${title}</title>
	<c:import url="../../layout/prestyle.jsp" />
</head>
<body>
<c:import url="../../layout/sidebar.jsp" />
<main class="main-wrapper">
	<c:import url="../../layout/header.jsp" />
	
	<section class="section">
		<div class="container-fluid">
			<!-- 출퇴근 버튼 -->
		   <div class="row">
			<div class="col-4 mb-30">
				<div class="card-style">
					<span class="status-btn dark-btn text-center ml-50 mt-50">${today}</span>
					
					<div class="text-center d-flex mb-30 mt-60 ml-60">
						<div class="content mr-30">
					       	<button type="button" id="${todayWorkTime != null ? '' : 'workStartButton'}" class="btn-sm main-btn success-btn-light rounded-full btn-hover">출근</button>
							<p id="startTime">${todayWorkTime != null ? todayWorkTime : '출근 전'}</p>
					    </div>
					    <div class="content">
					       	<button type="button" id="${todayWorkEndTime != null ? '' : 'workEndButton'}" class="btn-sm main-btn danger-btn-light rounded-full btn-hover">퇴근</button>
							<p id="endTime">${todayWorkEndTime != null ? todayWorkEndTime : '퇴근 전'}</p>
					    </div>
					</div>
				</div>
			</div> 
			
			<div class="col-8">
			<div class="row">
	          <div class="col-6">
	            <div class="icon-card mb-30">
	              <div class="icon orange">
	                <i class="lni lni-user"></i>
	              </div>
	              <div class="content">
		              <h6>근무</h6>
		                <h3 style="margin-top: 20px;" class="text-bold mb-10">${dclzCnt.work == null ? 0 : dclzCnt.work}건</h3>
	                <p class="text-sm text-success">
	                  <span class="text-gray"></span>
	                </p>
	              </div>
	            </div>
	            <!-- End Icon Cart -->
	          </div>
	          <!-- End Col -->
	          <div class="col-6">
	            <div class="icon-card mb-30">
	              <div class="icon success">
	                <i class="lni lni-users"></i>
	              </div>
	              <div class="content">
	                <h6 class="mb-10">출장</h6>
		                <h3 style="margin-top: 20px;" class="text-bold mb-10">${dclzCnt.businessTrip == null ? 0 : dclzCnt.businessTrip}건</h3>
	                <p class="text-sm text-success">
					<c:forEach var="dclzType" items="${empDetailDclzTypeCnt}" varStatus="status">
						<c:choose>
							<c:when test="${dclzType.upperCmmnCode == '30' && dclzType.cnt != 0}">
		                  		<span>${dclzType.cmmnCodeNm} ${dclzType.cnt} / </span>
		                  	</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
					</c:forEach>
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
	              <div class="icon orange">
	                <i class="lni lni-smile"></i>
	              </div>
	              <div class="content">
	                <h6 class="mb-10">휴가</h6>
		                <h3 style="margin-top: 20px;" class="text-bold mb-10">${dclzCnt.vacation == null ? 0 : dclzCnt.vacation}건</h3>
	                <p class="text-sm text-success">
	                <c:forEach var="dclzType" items="${empDetailDclzTypeCnt}" varStatus="status">
						<c:choose>
							<c:when test="${dclzType.upperCmmnCode == '20' && dclzType.cnt != 0}">
		                  		<span>${separator}${dclzType.cmmnCodeNm} ${dclzType.cnt} / </span>
		                  	</c:when>
							<c:otherwise>
								<span> </span>
							</c:otherwise>
						</c:choose>
					</c:forEach>
	                </p>
	              </div>
	            </div>
	            <!-- End Icon Cart -->
	          </div>
	          <div class="col-6">
	            <div class="icon-card">
	              <div class="icon primary">
	                <i class="lni lni-alarm-clock"></i>
	              </div>
	              <div class="content">
	                <h6 class="mb-10">기타</h6>
		              	 <h3 style="margin-top: 20px;" class="text-bold mb-10">${dclzCnt.bad == null ? 0 : dclzCnt.bad}건</h3>
	                <p class="text-sm text-danger">
	                <c:forEach var="dclzType" items="${empDetailDclzTypeCnt}" varStatus="status">
	                  <c:choose>
	                  	<c:when test="${dclzType.upperCmmnCode == '00' && dclzType.cnt != 0}">
	                  		<span>${separator}${dclzType.cmmnCodeNm} ${dclzType.cnt} / </span>
	                  	</c:when>
	                  <c:otherwise>
	                  	<span> </span>
	                  </c:otherwise>
	                  </c:choose>
              	  </c:forEach>
	                </p>
	              </div>
	            </div>
	            <!-- End Icon Cart -->
	          </div>
	          <!-- End Col -->
	        </div>
	        </div>
	        </div>
        
	        
	        <div class="row">
	          <div class="">
	            <div class="card-style mb-30" id="divPage">
	              <div class="title d-flex flex-wrap justify-content-between align-items-center">
	                <div style="width: 50%">
	                  <h6 class="text-medium mb-30">전체 근무일자</h6>
	                  <!-- 출퇴근만 출력? -->
	                </div>
	                <div class="right">
	                  <div class="select-style-1 d-flex">
	                  	<a href="/dclz/dclzType" class="btn-sm main-btn light-btn-light btn-hover mr-10 rounded-md">전체 목록 보기</a>
	                    <div class="select-position select-sm">
	                      <select class="light-bg" id="yearSelect">
	                      <c:set var="prevYear" value="" />
							<option>년도 선택</option>
							<c:forEach var="dclzWork" items="${empDclzList}">
							  <c:set var="currentYear" value="${dclzWork.dclzNo.substring(0, 4)}" />
							  <c:if test="${currentYear != prevYear}">
							    <option value="${currentYear}">${currentYear}</option>
							    <c:set var="prevYear" value="${currentYear}" />
							  </c:if>
							</c:forEach>
		                    <%-- <c:forEach var="dclzWork" items="${empDclzList}">
		                        <option value="${dclzWork.workBeginDate}">${dclzWork.dclzNo.substring(0,4)}</option>
	                        </c:forEach> --%>
	                      </select>
	                    <c:set var="duplMonth" value="" />
	                    </div>
	                    <div class="select-position select-sm ml-10">
	                      <select class="light-bg" id=monthSelect>
	                      <option>월 선택</option>
		                    <c:forEach var="dclzWork" items="${empDclzList}">
						      <c:set var="month" value="${fn:substring(dclzWork.dclzNo, 4, 6)}" />
						      <c:if test="${not fn:contains(duplMonth, month)}">
						        <option value="${month}">${month}</option>
						        <c:set var="duplMonth" value="${duplMonth},${month}" />
						      </c:if>
						    </c:forEach>
	                      </select>
	                    </div>
	                  </div>
	                  <!-- end select -->
	                </div>
	              </div>
	              <!-- End Title -->
	              <%-- ${empDclzList} --%>
	              <div class="table-responsive">
	                <table class="table top-selling-table">
	                  <thead>
	                    <tr>
	                      <th>
	                        <h6 class="text-sm text-medium">일자</h6>
	                      </th>
	                      <th>
	                        <h6 class="text-sm text-medium">근태유형</h6>
	                      </th>
	                      <th class="min-width">
	                        <h6 class="text-sm text-medium">업무시작</h6>
	                      </th>
	                      <th class="min-width">
	                        <h6 class="text-sm text-medium">업무종료</h6>
	                      </th>
	                      <th class="min-width">
	                        <h6 class="text-sm text-medium">총 근무시간</h6>
	                      </th>
	                    </tr>
	                  </thead>
	                  
	                  <!-- 반복문 돌리기 -->
	                <%--   <c:set var="dclzTypeList" value="${empDclzList}"></c:set> --%>
	                  
			          
	                  <tbody id="dclzBody">
	                  <c:forEach var="dclzWork" items="${empDclzList}">
	                  <c:set var="year" value="${dclzWork.dclzNo.substring(0,4)}"></c:set>
			          <c:set var="month" value="${dclzWork.dclzNo.substring(4,6)}"></c:set>
			          <c:set var="day" value="${dclzWork.dclzNo.substring(6,8)}"></c:set>
		                   
	                    <tr>
	                      <td>
	                        <div>
	                          <p class="text-sm">${year}-${month}-${day}</p>
	                        </div>
	                      </td>
	                      <td>
	                        <div>
	                          <h4><span class="badge bg-dark">${dclzWork.cmmnCodeNm}</span></h4>
	                        </div>
	                      </td>
	                      <td>
	                        <p class="text-sm">${dclzWork.workBeginTime}</p>
	                      </td>
	                      <td>
	                      <c:choose>
	                      	<c:when test="${dclzWork.workEndTime == null}">
	                      		<p class="text-sm">미등록</p>
	                      	</c:when>
	                      	<c:otherwise>
	                      		 <p class="text-sm">${dclzWork.workEndTime}</p>
	                      	</c:otherwise>
	                      </c:choose>
	                      </td>
	                      <td>
	                      <c:choose>
	                      	<c:when test="${dclzWork.workHour == 0}">
	                      		<p class="text-sm">0시간 0분</p>
	                      	</c:when>
	                      	<c:otherwise>
	                      		 <p class="text-sm">${dclzWork.workHour}시간 ${dclzWork.workMinutes}분</p>
	                      	</c:otherwise>
	                      </c:choose>
	                       
	                      </td>
	                    </tr>
	                  </c:forEach>
	                  </tbody>
	                </table>
	                  <page-navi id="page"
						url="/dclz/dclzType?"
						current="${param.get("currentPage")}"
						show-max="10"
						total="${articlePage.endPage}"></page-navi>
	                <!-- End Table -->
	              </div>
	            </div>
	          </div>
	          <!— End Col —>
	        </div>
		</div>
	</section>
	<c:import url="../../layout/footer.jsp" />
</main>
<c:import url="../../layout/prescript.jsp" />
<c:import url="./workButton.jsp"></c:import>
<script type="text/javascript">
$(function(){
	$("#yearSelect").on("change", function(){
		// 선택 년도 보내기
		const yearSelect = this.value;
		//console.log("selYear : " , yearSelect);
		
		const emplNo = ${emplNo}
		//console.log("emplNo : " , emplNo)
		
		fetch("/dclz/yearSelect",{
			method : "post",
		    headers : {
		        "Content-Type": "application/json"
	       },
	       body : JSON.stringify({
	    	   workBeginDate : yearSelect,
	    	   emplNo : emplNo
	       })
		})
		.then(resp => resp.json())
		.then(res => {
			//console.log("선택년도의 데이터 : " , res);
			
			const dclzBody = $("#dclzBody");
			const page = $("#page");

			dclzBody.html("");
			page.html("");
			
			const selYearList = res.selYearList;
			//console.log("선택년도 데이터 : " , selYearList);
			
			const currentPage = res.currentPage;
			//console.log("페이지 : " , currentPage);
			
			//const nullEndTime = [];
			selYearList.map((item) => {
				
				const tr = document.createElement('tr');
				tr.innerHTML = `
					 <td>
                    <div>
                      <p class="text-sm">\${item.dclzNo.substring(0,4)}-\${item.dclzNo.substring(4,6)}-\${item.dclzNo.substring(6,8)}
                      </p>
                    </div>
                  </td>
                  <td>
                    <div>
                  	  <h4><span class="badge bg-dark">\${item.cmmnCodeNm}</span></h4>
                    </div>
                  </td>
                  <td>
                    <p class="text-sm">\${item.workBeginTime === null ? '미등록' : item.workBeginTime}</p>
                  </td>
                  <td>
                    <p class="text-sm">\${item.workEndTime === null ? '미등록' : item.workEndTime}</p>
                  </td>
                  <td>
                    <p class="text-sm">\${item.workHour === null ? 0 : item.workHour}시간 \${item.workMinutes === null ? 0 : item.workMinutes}분</p>
                  </td>
				`
				dclzBody.append(tr);
			});
			// 년도 선택시 페이징처리
			page.html(`
					 <page-navi
					url="/dclz/dclzType?"
					current="${param.get('currentPage')}"
					show-max="10"
					total="${res.endPage}"></page-navi>
					`)
		
			// 월 넣어줄 select box
			const selMonth = $("#monthSelect");
			selMonth.html("");
			
			// 중복값 제거
			let notDuplMonth = [];
			selYearList.forEach(item =>{
				 if(!notDuplMonth.includes(item.dclzNo.substring(4,6))){
					 notDuplMonth.push(item.dclzNo.substring(4,6));
				 }
			})
			//console.log("화긴: ",notDuplMonth);
			
			notDuplMonth.map((items) => {
				selMonth.append(
					`
					<option value="\${items}" id="mon">\${items}</option>
					`		
				);
			})  
		})		
	}) // end sel
}) // end fn

$(document).on('change', '#monthSelect', function(e) {
	
	const employeeNo = ${emplNo};
	
	const monVal = e.target.value;
	//console.log(monVal);
	
	const page = $("#page");
	
	const yearVal = $('#yearSelect').val();
	//console.log(yearVal);
	
	// 선택한 달 보내기
	fetch("/dclz/yearSelect",{
		method : 'post',
		 headers : {
		        "Content-Type": "application/json"
	       },
	       body : JSON.stringify({
	    	   workBeginDate : yearVal,
	    	   workEndDate : monVal,
	    	   emplNo : employeeNo
	       })
		})
		.then(resp => resp.json())
		.then(res => {
			//console.log("월까지 선택한 결과 : " ,res.selMonList);
			
			const selMonList = res.selMonList;
			
			const dclzBody = $("#dclzBody");
			
			dclzBody.html("");
			page.html("");
			
			selMonList.map((item) => {
				const tr = document.createElement('tr');
				tr.innerHTML = `
					 <td>
                    <div>
                      <p class="text-sm">\${item.dclzNo.substring(0,4)}-\${item.dclzNo.substring(4,6)}-\${item.dclzNo.substring(6,8)}
                      </p>
                    </div>
                  </td>
                  <td>
                    <div>
                      <h4><span class="badge bg-dark">\${item.cmmnCodeNm}</span></h4>
                    </div>
                  </td>
                  <td>
                    <p class="text-sm">\${item.workBeginTime === null ? '미등록' : item.workBeginTime}</p>
                  </td>
                  <td>
                    <p class="text-sm">\${item.workEndTime === null ? '미등록' : item.workEndTime}</p>
                  </td>
                  <td>
                    <p class="text-sm">\${item.workHour === null ? 0 : item.workHour}시간 \${item.workMinutes === null ? 0 : item.workMinutes}분</p>
                  </td>
				`
				dclzBody.append(tr);
			});
			// 년도+월 선택시 페이징처리
			page.html(`
					 <page-navi
					url="/dclz/dclzType?"
					current="${param.get('currentPage')}"
					show-max="10"
					total="${res.endPage}"></page-navi>
					`)
		})
});

</script>

</body>
</html>