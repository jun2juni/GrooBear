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
 	<meta name="viewport"
		  content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"/>
	<meta http-equiv="X-UA-Compatible" content="ie=edge" />
	<!-- <title>${title}</title> -->
  <%@ include file="../layout/prestyle.jsp" %>
</head>
<style>
.wdBtn {
	--bs-btn-padding-y: .25rem;
	--bs-btn-padding-x: 4rem;
	--bs-btn-font-size: .75rem;
	background-color: pink;
	color: white;
}

.actBtn {
	width: 50px;
	height: 20px;
	font-size: 0.8em;
	padding: 0;
	border: 0;
	text-align: center;
}

.atrzContSc {
	border: 1px solid lightgray;
	border-radius: 10px;
	height: 300px;
	margin-top: 10px;
	margin-bottom: 10px;
	margin-left: 10px;
	margin-right: 10px;
	padding: 20px;
	padding-bottom: 50px;
}

.atrzTabCont {
	border: 1px solid lightgray;
	border-radius: 10px;
	margin-top: 10px;
	margin-left: 10px;
	margin-right: 10px;
	margin-bottom: 10px;
}
.listCont {
        display: block;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;

    }

#contact1-tab-pane {
	padding-bottom: 10px;;
}

#critical {
	padding-left: 4px;
}
.newAtrzDocBtn{
	padding: 0.5rem 1rem; 
	font-size: 0.875rem;
}
.modalBtn{
	padding: 10px 20px;
	font-size: 1.1em;
}
.emptyList{
	padding: 50px 0; 
	font-size: 1.2rem; 
	color: gray;
}

</style>
<body>
<%@ include file="../layout/sidebar.jsp" %>
<main class="main-wrapper">
<%@ include file="../layout/header.jsp" %>
<section class="section">
	<div class="container-fluid">
			<!-- 여기서 작업 시작 -->
			<div class="col-sm-13" id="divCard">
				<div class="card">
					<div class="card-body">
						<div class="d-flex justify-content-between align-items-center">
							<div id="atrNavBar">
								<ul class="nav nav-pills" id="myTab" role="tablist">
									<li class="nav-item" role="presentation">
										<button id="s_eap_btn" class="main-btn active-btn rounded-full btn-hover newAtrzDocBtn"
									data-bs-toggle="modal" data-bs-target="#newAtrzDocModal">
									새 결재 진행</button>
									</li>
								</ul>
							</div>
							<!-- 오른쪽: 검색창 -->
							<div class="table_search d-flex align-items-center gap-2">
								<form id="searchForm" method="get" action="/atrz/companion" class="d-flex gap-2">
										<input type="hidden" name="currentPage" id="currentPage" value="${param.currentPage}" />
										<input type="hidden" name="duration" value="${param.duration}" />
									<select id="duration" class="form-select w-auto">
									<option value="all" <c:if test="${param.duration == 'all'}">selected</c:if>>전체기간</option>
									<option value="1" <c:if test="${param.duration == '1'}">selected</c:if>>1개월</option>
									<option value="6" <c:if test="${param.duration == '6'}">selected</c:if>>6개월</option>
									<option value="12" <c:if test="${param.duration == '12'}">selected</c:if>>1년</option>
									<option value="period" <c:if test="${param.duration == 'period'}">selected</c:if>>기간입력</option>
								</select>
								<div id="durationPeriod" class="search_option d-none align-items-center">
									<input id="fromDate" name="fromDate" value="${param.fromDate}" class="form-control" type="text" style="width: 150px;"> ~ 
									<input id="toDate" name="toDate" value="${param.toDate}"  class="form-control" type="text" style="width: 150px;">
								</div>
								<!-- 검색 유형 선택 -->
								<select id="searchType" name="searchType" class="form-select w-auto">
									<option value="title" ${param.searchType == 'title' ? 'selected' : ''}>제목</option>
									<option value="drafterName" ${param.searchType == 'drafterName' ? 'selected' : ''}>기안자</option>
									<option value="drafterDeptName" ${param.searchType == 'drafterDeptName' ? 'selected' : ''}>기안부서</option>
									<option value="formName" ${param.searchType == 'formName' ? 'selected' : ''}>결재양식</option>
								</select>
								<section class="search2">
									<div class="search_wrap d-flex align-items-center border rounded px-2">
										<!--focus되면 "search_focus" multi class로 추가해주세요.-->
										<input id="keyword" class="form-control border-0" type="text" name="keyword" value="${param.keyword}" placeholder="검색"> 
										<button type="button" id="searchBtn" class="border-0 bg-transparent">
											<span class="material-symbols-outlined">search</span>
										</button>
									</div>
					</form>
								</section>
							</div>
						</div>
					</div>
				<!-- <p>${atrzVOList}</p> -->
				<!-- 메뉴바 끝 -->
				<!-- 컨텐츠1 시작 -->
				<div class="tab-content" id="myTabContent">
					<!--일괄결재모달 시작-->
					<div class="modal fade" id="allApproval" tabindex="-1"
						aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-body">
									<form>
										<div class="mt-1 mb-3">
											<h4 class="form-label">정말로 일괄 결재하시겠습니까?</h4>
										</div>
										<div class="mb-3">
											<textarea class="form-control" id="message-text"
												style="height: 200px" placeholder="의견을 작성해주세요"></textarea>
										</div>
									</form>
								</div>
								<div class="modal-footer border-0">
									<button type="button" class="main-btn primary-btn rounded-full btn-hover modalBtn">확인</button>
									<button type="button" class="main-btn light-btn rounded-full btn-hover modalBtn"
										data-bs-dismiss="modal">취소</button>
								</div>
							</div>
						</div>
					</div>
					<!--일괄결재모달 끝-->
					<div class="tab-pane fade show active" id="contact1-tab-pane"
						role="tabpanel" aria-labelledby="contact1-tab" tabindex="0">
						<div class="atrzTabCont">
							<!-- <div class="container mt-4"> -->
							<div class="row">
								<div class="col-lg-12">
									<div class="card-style">
										<div class="d-flex justify-content-between align-items-center mb-3">
											<h6 class="mb-10">반려문서함</h6>
											<p class="mb-0 text-sm text-muted">총 ${companionTotal}건</p>
										</div>
										<div class="table-wrapper table-responsive">
											<c:choose>
												<c:when test="${empty companionArticlePage.content}">
													<div class="text-center emptyList" >
														결재 대기중인 문서가 없습니다.
													</div>
												</c:when>
												<c:otherwise>
													<table class="table striped-table">
														<thead>
															<tr>
																<!-- select박스 -->
																<th class="text-center">
																	<h6 class="fw-bolder">반려일시</h6>
																</th>
																<th></th>
																<th>
																	<h6 class="fw-bolder">제목</h6>
																</th>
																<th class="text-center">
																	<h6 class="fw-bolder">반려의견</h6>
																</th>
																<th class="text-center">
																	<h6 class="fw-bolder">결재상태</h6>
																</th>
															</tr>
													</thead>
													<c:forEach var="atrzVO" items="${companionArticlePage.content}">
														<tbody>
															<tr>
																<td class="text-center">
																	<!--글씨체 두껍게 b태그 사용하기-->
																	<p class="text-sm fw-bolder">
																		<fmt:formatDate value="${atrzVO.atrzComptDt}" pattern="yyyy-MM-dd" var="onlyDate" />
																		<fmt:formatDate value="${atrzVO.atrzComptDt}" pattern="HH:mm:ss" var="onlyTime" />
																		${onlyDate}&nbsp;&nbsp;&nbsp;&nbsp; ${onlyTime}</p></p>
																</td>
																<td style="text-align: right;">
																	<c:choose>
																		<c:when test="${not empty atrzVO.atchFileNo and atrzVO.atchFileNo != 0}">
																			<span class="material-symbols-outlined" style="font-size: 14px;">
																				attach_file
																			</span>
																		</c:when>
																		<c:otherwise>
																			<span class="material-symbols-outlined" style="font-size: 14px; visibility: hidden;">
																				attach_file
																			</span>
																		</c:otherwise>
																	</c:choose>
																</td>
																<td style="text-align:left;">
																	<a href="/atrz/selectForm/atrzDetail?atrzDocNo=${atrzVO.atrzDocNo}" class="text-sm fw-bolder listCont" style="display: flex; align-items: center;">
																		${atrzVO.atrzSj}
																	</a>
																</td>
																<td class="text-center">
																	<p class="fw-bolder">${atrzVO.atrzOpinion}</p>
																</td>
																<td class="text-center">
																	<p>
																		<c:choose>
																			<c:when test="${atrzVO.atrzSttusCode == '00' }">
																				<span class="status-btn close-btn actBtn col-sm-6 col-md-4" style="background-color: #fbf5b1; color: #dd9e5f;">진행중</span>
																			</c:when>
																			<c:when test="${atrzVO.atrzSttusCode == '10' }">
																				<span class="status-btn active-btn actBtn col-sm-6 col-md-4">완료</span>
																			</c:when>
																			<c:when test="${atrzVO.atrzSttusCode == '20' }">
																				<span class="status-btn close-btn actBtn col-sm-6 col-md-4">반려</span>
																			</c:when>
																			<c:when test="${atrzVO.atrzSttusCode == '30' }">
																				<span class="status-btn success-btn actBtn col-sm-6 col-md-4">회수</span>
																			</c:when>
																			<c:when test="${atrzVO.atrzSttusCode == '40' }">
																				<span class="status-btn info-btn actBtn actBtn col-sm-6 col-md-4" style="background-color: pink; color: #ed268a;">취소</span>
																			</c:when>
																			<c:otherwise>
																				<span class="status-btn info-btn actBtn actBtn col-sm-6 col-md-4">임시저장</span>
																			</c:otherwise>
																		</c:choose>
																	</p>
																</td>
															</tr>
														</tbody>
													</c:forEach>
												</table>
												<div style="margin-top: 20px;">
													<!-- 페이지네이션 시작 -->
													<c:if test="${companionArticlePage.totalPages > 1}">
														${companionArticlePage.pagingArea}
													</c:if>
												</div>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>
						</div>
						<!--기안진행 문서 끝-->
					</div>
				</div>
			</div>
				<!-- 컨텐츠1 끝 -->
			</div>
		</div>
	</div>
</section>
<%@ include file="../layout/footer.jsp" %>
</main>
<%@ include file="../layout/prescript.jsp" %>
<!-- jquery 사용시 여기 이후 작성하기 -->
<!-- 새결재 진행 모달import -->
<c:import url="newAtrzDocModal.jsp" />
<script>

//기간입력 선택시 활성화 시키는 스크립트
document.getElementById("duration").addEventListener("change",function() {
	var durationPeriod = document.getElementById("durationPeriod");
	if (this.value == "period") {
		durationPeriod.classList.remove("d-none");
		durationPeriod.classList.add("d-flex");
	} else {
		durationPeriod.classList.remove("d-flex");
		durationPeriod.classList.add("d-none");
	}
})

//검색버튼 클릭시 컨트롤러로 파라이터 넘겨주기
$('#searchBtn').on("click",function(event){
	event.preventDefault(); // 기본 동작 방지

	const keyword = $('#keyword').val();
	const searchType = $('#searchType').val();
	const duration = $('#duration').val();
	const fromDate = $('#fromDate').val();
	const toDate = $('#toDate').val();
	let tab = "${param.tab}";

	if(tab == null || tab == ""){
		tab = "1";
	}

	console.log("keyword : ", keyword);//계란
	console.log("searchType : ", searchType);//title
	console.log("duration : ", duration);//period
	console.log("fromDate : ", fromDate);//2025-04-22
	console.log("toDate : ", toDate);//2025-04-22

	let url = `/atrz/companion?tab=\${tab}&keyword=\${encodeURIComponent(keyword)}&searchType=\${searchType}&duration=\${duration}`;
    if (duration === "period") {
        url += `&fromDate=\${fromDate}&toDate=\${toDate}`;
    }
	console.log("url : ", url);

	location.href = url;
});
</script>
</body>
</html>
