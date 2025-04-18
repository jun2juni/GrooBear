<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="나의 연차 내역 " />
<c:set var="copyLight" scope="application" value="by 박호산나" />

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
	.s_ho_cnt {
	border-right: 1px solid;
	height: 90px;
	float: left;
	margin: 0px;
}
</style>
</head>
<body>
<%@ include file="../../layout/sidebar.jsp" %>
<main class="main-wrapper">
  <%@ include file="../../layout/header.jsp" %>
	<section class="section">
		<div class="container-fluid">
			<%-- ${emplVacation} --%>
			 <div>
               <c:set var="beginDt" value="${emplVacation.yrycUseBeginDate}"></c:set>
               <c:set var="bgYear" value="${beginDt.substring(0,4)}"></c:set>
               <c:set var="bgMonth" value="${beginDt.substring(4,6)}"></c:set>
               <c:set var="bgDay" value="${beginDt.substring(6,8)}"></c:set>
               <c:set var="endDt" value="${emplVacation.yrycUseEndDate}"></c:set>
               <c:set var="edYear" value="${endDt.substring(0,4)}"></c:set>
               <c:set var="edMonth" value="${endDt.substring(4,6)}"></c:set>
               <c:set var="edDay" value="${endDt.substring(6,8)}"></c:set>
                <div class="text-center mb-20">
			  		<h4><p class="status-btn" style="color:thistle; font-size:20px; font-weight:bold; background-color: white;">
			  		${bgYear}.${bgMonth}.${bgDay} ~ ${edYear}.${edMonth}.${edDay} </p></h4>
	          </div>
             </div>
            <div class="card-style mb-3" style="height:130px;'">
			<div class="row">			
	            <div class="col-2" style="border:none;">
	                <div class="mx-auto text-center">
	                  <div>
	                  	<h3><span class="status-btn success-btn mb-2 text-dark">성과 보상</span></h3>
	                  </div>
	                  <div>
	                    <c:choose>
		                  	<c:when test="${emplVacation.excessWorkYryc % 1 == 0}">
			                    <h4><span class="text-center">${emplVacation.excessWorkYryc.intValue()}개</span></h4>
		                  	</c:when>
		                  	<c:otherwise>
			                    <h4><span class="text-center">
			                    	${mplVacation.excessWorkYryc}개
			                    </span></h4>
		                  	</c:otherwise>
	                  	</c:choose>
	                  </div>
	                </div>
	            </div>
	            
				<div class="col-2" style="border:none;">
	          	<div class="s_ho_cnt"></div>
	                <div class="mx-auto text-center ml-5">
	                  <div>
	                  	<h3><span class="status-btn success-btn mb-2 text-dark">근무 보상 연차</span></h3>
	                  </div>
	                  <div>
	                   <c:choose>
		                  	<c:when test="${emplVacation.cmpnstnYryc % 1 == 0}">
			                    <h4><span class="text-center">${emplVacation.cmpnstnYryc.intValue()}개</span></h4>
		                  	</c:when>
		                  	<c:otherwise>
			                    <h4>
			                     <span class="text-center">
			                    	${emplVacation.cmpnstnYryc}개
			                    </span>
			                   </h4>
		                  	</c:otherwise>
	                  	</c:choose>
	                  </div>
	                </div>
	              <!-- End Icon Cart -->
	            </div>
	            
				<div class="col-2" style="border:none;">
				<div class="s_ho_cnt"></div>
	                <div class="mx-auto text-center mt-1">
	                  <div>
	                   <h4><span class="status-btn secondary-btn mb-2 text-dark">총 연차 수</span></h4>
	                  </div>
	                  <div>
	                   <c:choose>
		                  	<c:when test="${emplVacation.totYrycDaycnt % 1 == 0}">
			                    <h4><span class="text-center">${emplVacation.totYrycDaycnt.intValue()}개</span></h4>
		                  	</c:when>
		                  	<c:otherwise>
			                    <h4>
			                     <span class="text-center">
			                    	${emplVacation.totYrycDaycnt}개
			                    </span>
			                   </h4>
		                  	</c:otherwise>
	                  	</c:choose>
	                  </div>
	                </div>
	              <!-- End Icon Cart -->
	            </div>
				<div class="col-3" style="border:none;">
				 <div class="s_ho_cnt"></div>
	                <div class="mx-auto text-center">
	                  <div>
	                  	<h3><span class="status-btn secondary-btn mb-2 text-dark">사용 연차 수</span></h3>
	                  </div>
	                  <div>
	                    <c:choose>
		                  	<c:when test="${emplVacation.yrycUseDaycnt % 1 == 0}">
			                    <h4><span class="text-center">${emplVacation.yrycUseDaycnt.intValue()}개</span></h4>
		                  	</c:when>
		                  	<c:otherwise>
			                    <h4>
			                     <span class="text-center">
			                    	${emplVacation.yrycUseDaycnt}개
			                    </span>
			                   </h4>
		                  	</c:otherwise>
	                  	</c:choose>
	                  </div>
	                </div>
	              <!-- End Icon Cart -->
	            </div>
				<div class="col-3" style="border:none;">
				 <div class="s_ho_cnt"></div>
	                <div class="mx-auto text-center">
	                  <div>
	                  	<h3><span class="status-btn secondary-btn mb-2 text-dark">잔여 연차 수</span></h3>
	                  </div>
	                  <div>
	                    <c:choose>
		                  	<c:when test="${emplVacation.yrycRemndrDaycnt % 1 == 0}">
			                    <h4><span class="text-center">${emplVacation.yrycRemndrDaycnt.intValue()}개</span></h4>
		                  	</c:when>
		                  	<c:otherwise>
			                    <h4>
			                     <span class="text-center">
			                    	${emplVacation.yrycRemndrDaycnt}개
			                    </span>
			                   </h4>
		                  	</c:otherwise>
	                  	</c:choose>
	                  </div>
	                </div>
	              <!-- End Icon Cart -->
	            </div>
			</div>
		</div>
		<div>
          <div class="">
            <div class="card-style  mb-30 col-12">
	            <div class="title d-flex flex-wrap">
	                <div class=" justify-content-first" style="width: 40%">
	                  <h6 class="text-medium mb-30">이번달 연차현황</h6>
	                  <!-- 출퇴근만 출력? -->
	                </div>
	                <div class="justify-content-center">
	           		<!-- 달력 페이지네이션 -->
					  <form action="/dclz/vacation" method="get" id="keywordForm">
					  <nav class="justify-content-center" aria-label="Page navigation example">
						<ul class=" d-flex">
						  <li class="page-item">
							<button type="button" class="page-link prevBtn">
							  <span aria-hidden="true"><</span>
							</button>
						  </li>
						  <input type="hidden" value="${paramKeyword.substring(0,4)}" id="hiddenKeyYear" />
						  <input type="hidden" value="${paramKeyword.substring(5,7)}" id="hiddenKeyword" />
						  <input type="hidden" value="${paramKeyword.substring(0,4)}-${paramKeyword.substring(5,7)}" id="submitKeyword" name="keyword" />
						  <h4 class="ml-10 mr-10" id="dateDisplay">${paramKeyword.substring(0,4)}-${paramKeyword.substring(5,7)}</h4>
						  <li class="page-item">
							<button type="button" class="page-link nextPage">
							  <span aria-hidden="true">></span>
							</button>
						  </li>
						</ul>
					  </nav>
					  </form>
					  <!-- 달력 페이지네이션 -->
	                </div>
	                <div class="input-group mb-3 ms-auto justify-content-end w-20">
	                <a href="/dclz/vacation" class="btn-sm main-btn light-btn-light btn-hover mr-10 rounded">전체 목록 보기</a>
	                <form action="/dclz/vacation" method="get" id="keywordSearchFome">
	                	<input type="search" class="form-control rounded" placeholder="년도, 연차유형 입력" aria-label="Search"
					              aria-describedby="search-addon" id="schName" name="keywordSearch"
					              onkeydown="fSchEnder(event)"
					       />
		                </form>
					       <span class="input-group-text border-0" id="search-addon"
					             onclick="fSch()">
					           <i class="fas fa-search"></i>
					       </span>
	                </div>
	              </div>
              <div class="table-wrapper table-responsive">
                <table class="table clients-table" id="vacTable">
                  <thead>
                    <tr>
                      <th>
                        <h6>연차 유형</h6>
                      </th>
                      <th>
                        <h6>사용 기간</h6>
                      </th>
                      <th>
                        <h6>연차사유</h6>
                      </th>
                    </tr>
                    <!-- end table row-->
                  </thead>
                  <tbody id="vacBody">
					<c:forEach var="emplVacationData" items="${emplCmmnVacationList}" >
                    <tr>
                      <td class="min-width">
                      	<c:if test="${emplVacationData.cmmnCodeNm == '연차'}">
	                      	<h4><span class="badge rounded-pill text-white" style="background-color:pink" id="vacData">
	                      		${emplVacationData.cmmnCodeNm}
	                      	</span></h4>
                      	</c:if>
                      	<c:if test="${emplVacationData.cmmnCodeNm == '공가'}">
	                      	<h4><span class="badge rounded-pill text-white" style="background-color:peachPuff" id="vacData">
	                      		${emplVacationData.cmmnCodeNm}
	                      	</span></h4>
                      	</c:if>
                      	<c:if test="${emplVacationData.cmmnCodeNm == '병가'}">
	                      	<h4><span class="badge rounded-pill text-white" style="background-color:tomato" id="vacData">
	                      		${emplVacationData.cmmnCodeNm}
	                      	</span></h4>
                      	</c:if>
                      </td>
                      <td class="min-width">
                        <p><span class="text-medium text-dark">
                        <fmt:formatDate value="${emplVacationData.dclzBeginDt}" pattern="yyyy-MM-dd" />
                         ~ <fmt:formatDate value="${emplVacationData.dclzEndDt}" pattern="yyyy-MM-dd" />
                         </span></p>
                      </td>
                      <td class="min-width">
                        <p>${emplVacationData.dclzReason}</p>
                      </td>
                    </tr>
                    </c:forEach>
                    <!-- end table row -->
                  </tbody>
                </table>
                <!-- end table -->
              </div>
               <!-- 페이지네이션 -->
               <%-- <page-navi id="page"
				   url="/dclz/vacation?"
				   current="${param.get("currentPage")}"
				   show-max="10"
				   total="${articlePage.totalPages}">
			   </page-navi> --%>
			   <!-- 페이지네이션 -->
            <!-- end card -->
          </div>
          <!-- end col -->
        </div>
		</div>
		</div>
	</section>
  <%@ include file="../../layout/footer.jsp" %>
</main>
<%@ include file="../../layout/prescript.jsp" %>

<script type="text/javascript">

function fSchEnder(e){
	if(e.code === "Enter"){
		const keywordSearch = $('#keywordSearch').val();
		console.log('dkdkdk : ', keywordSearch);
	}
}

$(function(){
	
	function updateDateDisplay(){
		 const year = $('#hiddenKeyYear').val();
		 const month = $('#hiddenKeyword').val();
		 const formattedMonth = String(month).padStart(2, '0');
		 document.getElementById('dateDisplay').textContent = year + '-' + formattedMonth;
		 
		 const newDate = $('#dateDisplay').text(); 
	     console.log(" ddddddd " , newDate);
	     
	     $('#submitKeyword').val(newDate);
	     console.log('보낼키워드 : ' , $('#submitKeyword').val());
		 $('#keywordForm').submit();
	  }
	
	  // --- 이전버튼
	  document.querySelector('.prevBtn').addEventListener('click', () => {
		let hiddenKeyword = Number($('#hiddenKeyword').val());
		hiddenKeyword -= 1;

	    if (hiddenKeyword === 0) {
	      const prevYear = Number($('#hiddenKeyYear').val()) - 1;
	      $('#hiddenKeyYear').val(prevYear);
	      hiddenKeyword = 12;
	    }
	    $('#hiddenKeyword').val(hiddenKeyword);
	    updateDateDisplay();
	    
	  });
		
	  // --- 다음버튼
	  document.querySelector('.nextPage').addEventListener('click', () => {
		  let hiddenKeyword = Number($('#hiddenKeyword').val());
		  //let monthNum = Number(hiddenKeyword);
		  hiddenKeyword += 1;
		  
		  if (hiddenKeyword === 13) {
			    const nextYear = Number($('#hiddenKeyYear').val()) + 1;
			    $('#hiddenKeyYear').val(nextYear);
			    hiddenKeyword = 1;
			  }
		  $('#hiddenKeyword').val(hiddenKeyword);
		  updateDateDisplay();
	  });
	
	
	
	
	
	
	// 연차 유형 선택시
	$('#vacType').on('change', function(){
		//alert("dididi");
		// keyword를 submit
		$('#selType').submit();
	})
	
	// 년도 선택시
	$('#vacYear').on('change', function(){
		const vacYear = $('#vacYear').val();
		//console.log('vacYear : ' , vacYear);
		//const cleanYear = vacYear.substring(0,4);
		// input hidden 값 변경해주고 submit
		const yearKey = $('#yearKeyword').val(vacYear);
		console.log('yearKey : ' , yearKey.val())
		$('#selYear').submit();
	})
	
	const vacData = $('#vacData').val();
	if(vacData == null){
		const vacTable = $('#vacTable');
		vacTable.innerHtml = "";
		$('#vacTable').html('연차 사용 내역이 없습니다.');
	}
})
	
</script>

</body>
</html>
