<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="card-style mb-3" style="height:200px;'">
          <h6 class="text-medium mb-30">👨‍💼 ${emplVac.emplNm} 연차 현황</h6>
			<div class="row">			
	            <div class="col-2" style="border:none;">
	                <div class="mx-auto text-center">
	                 <input type="hidden" id="hiddenEmplNo" value="${emplVac.emplNo}">
	                  <div>
	                  	<h3><span class="status-btn success-btn mb-2 text-dark">성과 보상</span></h3>
	                  </div>
	                  <div>
	                    <c:choose>
		                  	<c:when test="${emplVac.cmpnstnYryc % 1 == 0}">
			                    <h4><span class="text-center">${emplVac.cmpnstnYryc.intValue()}개</span></h4>
		                  	</c:when>
		                  	<c:otherwise>
			                    <h4><span class="text-center">
			                    	${emplVac.cmpnstnYryc}개
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
	                  	<h3><span class="status-btn success-btn mb-2 text-dark">근무 보상</span></h3>
	                  </div>
	                  <div>
	                   <c:choose>
		                  	<c:when test="${emplVac.excessWorkYryc % 1 == 0}">
			                    <h4><span class="text-center">${emplVac.excessWorkYryc.intValue()}개</span></h4>
		                  	</c:when>
		                  	<c:otherwise>
			                    <h4>
			                     <span class="text-center">
			                    	${emplVac.excessWorkYryc}개
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
		                  	<c:when test="${emplVac.totYrycDaycnt % 1 == 0}">
			                    <h4><span class="text-center">${emplVac.totYrycDaycnt.intValue()}개</span></h4>
		                  	</c:when>
		                  	<c:otherwise>
			                    <h4>
			                     <span class="text-center">
			                    	${emplVac.totYrycDaycnt}개
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
		                  	<c:when test="${emplVac.yrycUseDaycnt % 1 == 0}">
			                    <h4><span class="text-center">${emplVac.yrycUseDaycnt.intValue()}개</span></h4>
		                  	</c:when>
		                  	<c:otherwise>
			                    <h4>
			                     <span class="text-center">
			                    	${emplVac.yrycUseDaycnt}개
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
		                  	<c:when test="${emplVac.yrycRemndrDaycnt % 1 == 0}">
			                    <h4><span class="text-center">${emplVac.yrycRemndrDaycnt.intValue()}개</span></h4>
		                  	</c:when>
		                  	<c:otherwise>
			                    <h4>
			                     <span class="text-center">
			                    	${emplVac.yrycRemndrDaycnt}개
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
		<%-- <div>
          <div class="">
            <div class="card-style  mb-30 col-12">
	            <div class="title d-flex flex-wrap">
	                <div class=" justify-content-first" style="width: 40%">
	                  <h6 class="text-medium mb-30">👨‍💼 ${emplVac.emplNm}</h6>
	                  <h6 class="text-medium mb-30">이번달 연차현황</h6>
	                  <!-- 출퇴근만 출력? -->
	                </div>
	                <div class="justify-content-center">
	           		<!-- 달력 페이지네이션 -->
					  <form action="/dclz/vacationAdmin" method="get" id="keywordForm">
					  <nav class="justify-content-center" aria-label="Page navigation example">
						<ul class=" d-flex">
						  <!-- <li class="page-item">
							<button type="button" class="page-link prevBtn">
							  <span aria-hidden="true"><</span>
							</button>
						  </li> -->
						  <input type="hidden" value="${paramKeyword.substring(0,4)}" id="hiddenKeyYear" />
						  <input type="hidden" value="${paramKeyword.substring(5,7)}" id="hiddenKeyword" />
						  <input type="hidden" value="${paramKeyword.substring(0,4)}-${paramKeyword.substring(5,7)}" id="submitKeyword" name="keyword" />
						  <h4 class="ml-10 mr-10" id="dateDisplay">${paramKeyword.substring(0,4)}-${paramKeyword.substring(5,7)}</h4>
						  <!-- <li class="page-item">
							<button type="button" class="page-link nextPage">
							  <span aria-hidden="true">></span>
							</button>
						  </li> -->
						</ul>
					  </nav>
					  </form>
					  <!-- 달력 페이지네이션 -->
	                </div>
	                
	                <div class="input-group mb-3 ms-auto justify-content-end w-20">
	                <a href="/dclz/vacation?targetEmplNo=${emplVac.emplNo}" id="moreViewEmplVacation" class="btn-sm main-btn light-btn-light btn-hover mr-10 rounded">더보기</a>
	                <!-- <form action="/dclz/vacationAdmin" method="get" id="keywordSearchFome"> -->
	                	<!-- <input type="search" class="form-control rounded" placeholder="년도, 연차유형 입력" aria-label="Search"
					              aria-describedby="search-addon" id="schName" name="keywordSearch"
					              onkeydown="fSchEnder(event)"
					       /> -->
		            <!--     </form> -->
					      <!--  <span class="input-group-text border-0" id="search-addon"
					             onclick="fSch()">
					           <i class="fas fa-search"></i>
					       </span> -->
	                </div>
	              </div>
	             ${emplCmmnVacationList}
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
                  	<c:if test="${emplCmmnVacList.size() == 0}">
						<td><h5 style="color:tomato;">연차 사용내역이 없습니다.</h5></td>
                  	</c:if>
					<c:forEach var="emplVacData" items="${emplCmmnVacList}" >
                    <tr>
                      <td class="min-width">
                      	<c:if test="${emplVacData.cmmnCodeNm == '연차'}">
	                      	<h4><span class="badge rounded-pill text-white" style="background-color:pink" id="vacData">
	                      		${emplVacData.cmmnCodeNm}
	                      	</span></h4>
                      	</c:if>
                      	<c:if test="${emplVacData.cmmnCodeNm == '공가'}">
	                      	<h4><span class="badge rounded-pill text-white" style="background-color:peachPuff" id="vacData">
	                      		${emplVacData.cmmnCodeNm}
	                      	</span></h4>
                      	</c:if>
                      	<c:if test="${emplVacData.cmmnCodeNm == '병가'}">
	                      	<h4><span class="badge rounded-pill text-white" style="background-color:tomato" id="vacData">
	                      		${emplVacData.cmmnCodeNm}
	                      	</span></h4>
                      	</c:if>
                      </td>
                      <td class="min-width">
                        <p><span class="text-medium text-dark">
                        <fmt:formatDate value="${emplVacData.dclzBeginDt}" pattern="yyyy-MM-dd" />
                         ~ <fmt:formatDate value="${emplVacData.dclzEndDt}" pattern="yyyy-MM-dd" />
                         </span></p>
                      </td>
                      <td class="min-width">
                        <p>${emplVacData.dclzReason}</p>
                      </td>
                    </tr>
                    </c:forEach>
                    <!-- end table row -->
                  </tbody>
                </table>
                <!-- end table -->
              </div>
               <!-- 페이지네이션 -->
               <page-navi id="page"
				   url="/dclz/vacation?"
				   current="${param.get("currentPage")}"
				   show-max="10"
				   total="${articlePage.totalPages}">
			   </page-navi>
			   <!-- 페이지네이션 -->
            <!-- end card -->
          </div>
          <!-- end col -->
        </div>
		</div> --%>
		
<script type="text/javascript">

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
	 /*  document.querySelector('.prevBtn').addEventListener('click', () => {
		let hiddenKeyword = Number($('#hiddenKeyword').val());
		hiddenKeyword -= 1;

	    if (hiddenKeyword === 0) {
	      const prevYear = Number($('#hiddenKeyYear').val()) - 1;
	      $('#hiddenKeyYear').val(prevYear);
	      hiddenKeyword = 12;
	    }
	    $('#hiddenKeyword').val(hiddenKeyword);
	    updateDateDisplay();
	    
	  }); */
		
	  // --- 다음버튼
	/*   document.querySelector('.nextPage').addEventListener('click', () => {
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
	  });  */

</script>	
	
</body>
</html>