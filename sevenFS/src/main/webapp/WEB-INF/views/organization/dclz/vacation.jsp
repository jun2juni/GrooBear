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
              <div class="row">
	            <div>
	              <h6>연차 사용 내역</h6>
	             </div> 
	             <div class="">
                <!-- 연차유형 selectBox -->
                <div class="col-12 d-flex justify-content-end">
	             <a href="/dclz/vacation" class="btn-sm light-btn-light btn-hover mr-10 rounded-md">전체 목록 보기</a>
				<form method="get" action="/dclz/vacation" id="selType" class="mr-10" style="height:40px;">
                <c:set var="duplTypes" value=""></c:set>
                <div class="input-style-1 form-group col-3">
				  <select id="vacType" class="form-select w-auto" required="required" name="keyword">
				    <option>유형 선택</option>
				    <c:forEach var="vacType" items="${emplCmmnVacationList}">
				      <!-- 중복 확인: printedTypes에 포함되어 있지 않은 경우만 출력 -->
				      <c:if test="${not fn:contains(duplTypes,vacType.cmmnCodeNm)}">
				        <option value="${vacType.cmmnCodeNm}">${vacType.cmmnCodeNm}</option>
				        <!-- 출력한 값 저장 -->
				        <c:set var="duplTypes" value="${duplTypes},${vacType.cmmnCodeNm}" />
				      </c:if>
				    </c:forEach>
				  </select>
				</div>
				 </form>
			  	<!-- 년도 selectBox -->
                <form method="get" action="/dclz/vacation" id="selYear" class="mr-10" style="height:40px;">
			  	<c:set var="duplYears" value="" />
                <div class="input-style-1 form-group col-3">
	     	     <select id="vacYear" class="form-select w-auto" required="required">
					<option>년도 선택</option>
					<c:forEach var="vacDate" items="${emplCmmnVacationList}">
						<fmt:formatDate value="${vacDate.dclzBeginDt}" pattern="yyyy" var="vacYear" />
						<c:if test="${not fn:contains(duplYears, vacYear)}">
							<option value="${vacYear}">${vacYear}</option>
							<c:set var="duplYears" value="${duplYears},${vacYear}" />
						</c:if>	
					</c:forEach>
				 </select> 
				 <input type="hidden" id="yearKeyword" name="keyword">
			  	</div>
			  	</form>
			 </div>
              </div>
              <div class="table-wrapper table-responsive mt-40">
                <table class="table clients-table" id="vacTable">
                  <thead>
                    <tr>
                      <th>
                        <h6></h6>
                      </th>
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
                      <td>
                        <div>
                        </div>
                      </td>
                      <td class="min-width">
                      <h4><span class="badge rounded-pill text-white" style="background-color:pink" id="vacData">${emplVacationData.cmmnCodeNm}</span></h4>
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
               <page-navi id="page"
				   url="/dclz/vacation?"
				   current="${param.get("currentPage")}"
				   show-max="10"
				   total="${articlePage.totalPages}">
			   </page-navi>
			   <!-- 페이지네이션 -->
            </div>
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


$(function(){
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
