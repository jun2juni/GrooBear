<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="연차 내역" />
<c:set var="copyLight" scope="application" value="by 박호산나" />

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport"
		content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
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
      
      <style type="text/css">
.fixed-header-table {
  max-height: 400px;
  overflow-y: auto;
  position: relative;
}

.fixed-header-table thead th {
  position: sticky;
  top: 0;
  background-color: white;
  z-index: 10;
}
</style>
  </style>
</head>
<body>
<%@ include file="../../layout/sidebar.jsp" %>
<main class="main-wrapper">
  <%@ include file="../../layout/header.jsp" %>
  <section class="section">
	<div class="container-fluid">
	  <div>
		<c:set var="beginDt" value="${emplVacation.yrycUseBeginDate}" />
		<c:set var="bgYear" value="${beginDt.substring(0,4)}" />
		<c:set var="bgMonth" value="${beginDt.substring(4,6)}" />
		<c:set var="bgDay" value="${beginDt.substring(6,8)}" />
		<c:set var="endDt" value="${emplVacation.yrycUseEndDate}" />
		<c:set var="edYear" value="${endDt.substring(0,4)}" />
		<c:set var="edMonth" value="${endDt.substring(4,6)}" />
		<c:set var="edDay" value="${endDt.substring(6,8)}" />
		<div class="text-center mb-20">
			  <h4><p class="status-btn" style="color:gray; font-size:15px; font-weight:bold; background-color: white;">
			연차 사용기간 : ${bgYear}.${bgMonth}.${bgDay} ~ ${edYear}.${edMonth}.${edDay} </p></h4>
	  </div>
	  </div>
	  <div class="row mb-4">
		<c:set var="vacationItems" value="${[
		  {'label':'성과 보상','value':emplVacation.cmpnstnYryc,'type':'success', 'col': 'col-2'},
		  {'label':'근무 보상 연차','value':emplVacation.excessWorkYryc,'type':'success', 'col': 'col-2'},
		  {'label':'총 연차 수','value':emplVacation.totYrycDaycnt,'type':'secondary', 'col': 'col-2'},
		  {'label':'사용 연차 수','value':emplVacation.yrycUseDaycnt,'type':'secondary', 'col': 'col-3'},
		  {'label':'잔여 연차 수','value':emplVacation.yrycRemndrDaycnt,'type':'secondary', 'col': 'col-3'}
		]}" />
	 
		<c:forEach var="item" items="${vacationItems}">
		  <div class="${item.col}">
			<div class="card shadow-sm text-center border-0">
			  <div class="card-body">
				<h6 class="text-${item.type} fw-bold mb-3">${item.label}</h6>
				<h4 class="mb-0">
				  <c:choose>
					<c:when test="${item.value % 1 == 0}">
					  ${item.value.intValue()}개
					</c:when>
					<c:otherwise>
					  ${item.value}개
					</c:otherwise>
				  </c:choose>
				</h4>
			  </div>
			</div>
		  </div>
		</c:forEach>
	  </div>
	  <div class="card-style mb-30 col-12">
		<div class="title d-flex flex-wrap">
		  <div class=" justify-content-first" style="width: 40%">
			<h6 class="text-medium">👨‍💼 ${emplVacation.emplNm}님의 이번달 연차현황</h6>
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
				 
				  <input type="hidden" value="${paramKeyword}" id="hiddemParamKeyword" />
				  <c:if test="${not empty paramKeyword and fn:length(paramKeyword) >= 7}">
					  <input type="hidden" value="${paramKeyword.substring(0,4)}" id="hiddenKeyYear" />
					  <input type="hidden" value="${paramKeyword.substring(5,7)}" id="hiddenKeyword" />
					  <input type="hidden" value="${paramKeyword.substring(0,4)}-${paramKeyword.substring(5,7)}"
							 id="submitKeyword" name="keyword" />
					  <input type="hidden" value="${emplVacation.emplNo}" id="submitTargetEmplNo" name="targetEmplNo" />
					  <h4 class="ml-10"
						  id="dateDisplay">${paramKeyword.substring(0,4)}-${paramKeyword.substring(5,7)}</h4>
				  </c:if>
				  	<h4 class="mr-5 ml-5" id="searchVacationType">  </h4>
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
		   <c:if test="${not empty emplCmmnVacationList}">
                 <p class="mb-0 text-sm text-muted ms-auto">총 ${fn:length(emplCmmnVacationList)}건</p>
		  </c:if>
		   <c:if test="${empty emplCmmnVacationList}">
                 <p class="mb-0 text-sm text-muted ms-auto">총 0건</p>
		  </c:if>
		  <div class="input-group mb-3 ms-auto justify-content-end w-10 d-flex mt-20">
			<a href="/dclz/vacation" class="btn-xs main-btn light-btn-light btn-hover mr-5 rounded">전체 목록 보기</a>
			<%--  <form>
			  <div class="col-2 mr-5">
				  <select class="form-select w-auto">
				    <c:forEach var="selYear" items="${emplCmmnVacationList}">
				    <fmt:formatDate value="${selYear.dclzEndDt}" pattern="yyyy" var="select"/>
					  	<option>${select}</option>
				    </c:forEach>
				  </select>
			  </div>
			  </form> --%>
			<form action="/dclz/vacation" method="get" id="keywordSearchFome" class="col-2">
			  <input type="search" class="form-control rounded" placeholder="연차, 반차, 공가, 병가 검색" aria-label="Search"
					 aria-describedby="search-addon" id="schName" name="keywordSearch"
					 onkeydown="fSchEnder(event)"
			  />
			</form>
			<span class="input-group-text" id="search-addon"
				  onclick="fSch()">
						   <i class="fas fa-search"></i>
					   </span>
		  </div>
		</div>
		<div class="table-wrapper table-responsive fixed-header-table" style="max-height: 400px; overflow-y: auto;">
		  <table class="table clients-table" id="vacTable">
			<thead>
			<tr>
			  <th>
			  	<h6 class="text-sm text-center text-medium" style="text-center;">번호</h6>
			  </th>
			  <th>
				<h6 class="text-sm text-center text-medium" style="text-center;">연차유형</th>
			  <th>
				<h6 class="text-center">사용 기간</h6>
			  </th>
			  <th>
				<h6>연차사유</h6>
			  </th>
			</tr>
			<!-- end table row-->
			</thead>
			<%-- ${emplCmmnVacationList} --%>
			<tbody id="vacBody">
			<c:forEach var="emplVacationData" items="${emplCmmnVacationList}">
			  <tr>
			    <td>
			    	<p class="text-center">${emplVacationData.rnum}</p>
			    </td>
				<td class="text-center">
				  <c:if test="${emplVacationData.cmmnCodeNm == '연차'}">
					<h4><span class="badge rounded-pill text-white" style="background-color:pink" id="vacData">
						${emplVacationData.cmmnCodeNm}
					</span></h4>
				  </c:if>
				  <c:if test="${emplVacationData.cmmnCodeNm == '반차'}">
					<h4><span class="badge rounded-pill text-white" style="background-color:plum" id="vacData">
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
				  <p class="text-center"><span class="text-medium text-dark">
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
  </section>
  <%@ include file="../../layout/footer.jsp" %>
</main>
<%@ include file="../../layout/prescript.jsp" %>

<script type="text/javascript">

  function fSchEnder(e) {
    if(e.code === "Enter") {
      const keywordVal = $('#submitKeyword').val();
      console.log('dkdkdk : ', keywordSearch);
      $('#keywordSearchFome').submit();
    }
  }

$(function() {
     const queryString = window.location.search;
	 const urlParams = new URLSearchParams(queryString); 
	 const keywordSearch = urlParams.get('keywordSearch');
	 $('#searchVacationType').text(keywordSearch);
	 
	 $('#schName').val(keywordSearch);
	
    function updateDateDisplay() {
    
   	  const keywordSearch = $('#keywordSearch').val();
      const year = $('#hiddenKeyYear').val();
      const month = $('#hiddenKeyword').val();
      const formattedMonth = String(month).padStart(2, '0');
      
      
      if(keywordSearch == null || keywordSearch == ''){
	      document.getElementById('dateDisplay').textContent = year + '-' + formattedMonth;
	      const newDate = $('#dateDisplay').text();
	      console.log(" ddddddd ", newDate);
	
	      $('#submitKeyword').val(newDate) 
	      console.log('보낼키워드 : ', $('#submitKeyword').val());
      }else{
	      $('#submitKeyword').val('');
      }
      $('#keywordForm').submit();
  }

    // --- 이전버튼
    document.querySelector('.prevBtn').addEventListener('click', () => {
      let hiddenKeyword = Number($('#hiddenKeyword').val());
      hiddenKeyword -= 1;

      if(hiddenKeyword === 0) {
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

      if(hiddenKeyword === 13) {
        const nextYear = Number($('#hiddenKeyYear').val()) + 1;
        $('#hiddenKeyYear').val(nextYear);
        hiddenKeyword = 1;
      }
      $('#hiddenKeyword').val(hiddenKeyword);
      updateDateDisplay();
    });


    // 연차 유형 선택시
    $('#vacType').on('change', function() {
      //alert("dididi");
      // keyword를 submit
      $('#selType').submit();
    })

    // 년도 선택시
    $('#vacYear').on('change', function() {
      const vacYear = $('#vacYear').val();
      //console.log('vacYear : ' , vacYear);
      //const cleanYear = vacYear.substring(0,4);
      // input hidden 값 변경해주고 submit
      const yearKey = $('#yearKeyword').val(vacYear);
      console.log('yearKey : ', yearKey.val())
      $('#selYear').submit();
    })

    const vacData = $('#vacData').val();
    if(vacData == null) {
      const vacTable = $('#vacTable');
      vacTable.innerHtml = "";
      $('#vacTable').html(`<div class="alert alert-light m-2 mt-4 text-center" role="alert">연차 사용 내역이 없습니다.</div>`);
    }
  })

</script>

</body>
</html>
