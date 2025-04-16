<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="메인" />

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="ie=edge" />
<title>${title}</title>
<%@ include file="../layout/prestyle.jsp"%>
</head>
<body>
	<%@ include file="../layout/sidebar.jsp"%>
	<main class="main-wrapper">
		<%@ include file="../layout/header.jsp"%>
		<section class="section">
			<div class="container-fluid">
				<div class="row mt-5">
					<div class="col-12">
						<div class="card-style">
							<!-- 상위탭 시작  -->
							<div class="mb-20">
								<ul class="nav nav-tabs" id="myTab" role="tablist">
									<li class="nav-item" role="presentation">
										<button class="nav-link" id="tab1" data-bs-toggle="tab"
											data-bs-target="#content1" type="button"
											onClick="location.href='comunityHome'" role="tab"
											aria-controls="content1" aria-selected="true">Home</button>
									</li>
									<li class="nav-item" role="presentation">
										<button class="nav-link" id="tab2" data-bs-toggle="tab"
											data-bs-target="#content2" type="button" role="tab"
											onClick="location.href='comunityClubList'"
											aria-controls="content2" aria-controls="content2"
											aria-selected="false">스느스</button>
									</li>
									<li class="nav-item" role="presentation">
										<button class="nav-link" id="tab3" data-bs-toggle="tab"
											data-bs-target="#content3" type="button" role="tab"
											onClick="location.href='comunitySurveyList'"	
											aria-controls="content3" aria-selected="false">설문조사/투표</button>
									</li>
									<li class="nav-item" role="presentation">
										<button class="nav-link" id="tab4" data-bs-toggle="tab"
											data-bs-target="#content4" type="button"
											onClick="location.href='comunityMonthMenuList'" role="tab"
											aria-controls="content4" aria-selected="false">월별식단표</button>
									</li>
								</ul>
							</div> <!--내부 탭 분리 지점   -->
							 <!-- (나머지 게시판 및 테이블 내용) -->
					          <nav class="navbar navbar-light">
					            <div class="container-fluid" style="padding-left:0px;">
					              <form action="/bbs/bbsList" method="get" class="d-flex">
					              <input type="hidden" value="${bbsVO.bbsCtgryNo}" name="bbsCtgryNo">
					                <!-- 카테고리 선택 드롭다운 -->
					                <select name="category" class="form-select me-2" style="width: 100px;">
									  <option value="bbscttSj"	
									    <c:if test="${selectedCategory == 'bbscttSj'}">selected</c:if>
									  >제목</option>
									
									  <option value="bbscttCn"
									    <c:if test="${selectedCategory == 'bbscttCn'}">selected</c:if>
									  >내용</option>
									</select>
					
					
					                
					                <!-- 검색어 입력 필드 -->
					                <input type="text" name="searchKeyword" value="${SearchKeyword}" class="form-control me-2 col-auto flex-grow-1" placeholder="검색어 입력"">
					                
					                <!-- 검색 버튼 -->
					                <button style="white-space: nowrap;" type="submit" class="btn btn-outline-primary">검색</button>
					              </form>
					              	<button type="button" onclick = "location.href = '/comunity/comunitySurveyInsert'" class="btn btn-outline-primary text-nowrap">설문입력</button>
					            </div>
					          </nav> <!-- navBar navBar-light 끝  -->
					          <div class="table">
					            <table class="table table-hover align-middle text-center" style="table-layout: fixed; width: 100%;">
					              <thead class="table-light">
					                <tr>
					                  <th style="width: 8%;">게시글 번호</th>
					                  <th style="width: 5%;"></th>
					                  <th style="width: 50%;">제목</th>
					                  <th style="width: 10%;">작성자</th>
					                  <th style="width: 10%;">작성일</th>
					                  <th style="width: 10%;">조회수</th>
					                  <th style="width: 10%;">좋아요</th>
					                </tr>
					              </thead>
					              <tbody>
					                <c:forEach var="bbsVO" items="${bbsList}">
					                  	<tr onClick="location.href='/comunity/comunityMonthMenuDetail?bbsSn=${bbsVO.bbsSn}'" style="cursor:pointer;">
					                    <td style="border-bottom:1px solid #efefef;">${bbsVO.rowNumber}</td>
					                    <td style="border-bottom:1px solid #efefef;">
					                    	<c:if test="${bbsVO.upendFixingYn == 'Y'}">
										        <span style="color: red; font-weight: bold;">[고정]</span>
										    </c:if>
					                    </td>
					                    <td style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis; text-align: left;border-bottom:1px solid #efefef;">
					                    	${bbsVO.bbscttSj}
					                    	<c:choose>
					                        <c:when test="${not empty bbsVO.files and bbsVO.files.size() > 0}">
					                          	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-paperclip" viewBox="0 0 16 16">
												  <path d="M4.5 3a2.5 2.5 0 0 1 5 0v9a1.5 1.5 0 0 1-3 0V5a.5.5 0 0 1 1 0v7a.5.5 0 0 0 1 0V3a1.5 1.5 0 1 0-3 0v9a2.5 2.5 0 0 0 5 0V5a.5.5 0 0 1 1 0v7a3.5 3.5 0 1 1-7 0z"/>
												</svg>
					                        </c:when>
					                      </c:choose>
					                      <c:if test="${bbsVO.commentCnt != null}">
										        <span style="color: red;">[${bbsVO.commentCnt}]</span>
										  </c:if>
					                    </td>
					                    <td style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;border-bottom:1px solid #efefef;">${bbsVO.emplNm}</td>
					                    <td style="border-bottom:1px solid #efefef;">${fn:substring(bbsVO.bbscttCreatDt, 0, 10)}</td>
					                    <td style="border-bottom:1px solid #efefef;">
					                      ${bbsVO.rdcnt}
					                    </td>
					                    <td style="border-bottom:1px solid #efefef;">
					                      ${bbsVO.likeCnt}
					                    </td>
					                  </tr>
					                </c:forEach>
					              </tbody>
					            </table>
					            <div class="row mb-4">
									<div class="col-12">
										<div class="card-style">
										  <page-navi
											url="/bbs/bbsList?${articlePage.getSearchVo()}"
											current="${articlePage.getCurrentPage()}"
											show-max="5"
											total="${articlePage.getTotalPages()}"
										></page-navi>
										</div>
									</div>
								</div>
					          </div> <!-- 표 끝 -->
						</div>
					</div>
				</div>	
			 </div>		
		</section>
		<%@ include file="../layout/footer.jsp"%>
	</main>
	<%@ include file="../layout/prescript.jsp"%>
</body>
</html>
