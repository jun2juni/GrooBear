<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="currentURL" value="${pageContext.request.requestURI}" />

<%-- 읽기 권한 확인 --%>
<c:set var="readProject" value="${myEmpInfo.skillAuth.get(0).skllAuthorCode.substring(0, 1) == '1'}" />
<c:set var="readBbs" value="${myEmpInfo.skillAuth.get(1).skllAuthorCode.substring(0, 1) == '1'}" />
<c:set var="readAtrz" value="${myEmpInfo.skillAuth.get(2).skllAuthorCode.substring(0, 1) == '1'}" />
<c:set var="readWebFolder" value="${myEmpInfo.skillAuth.get(3).skllAuthorCode.substring(0, 1) == '1'}" />
<c:set var="readSchdule" value="${myEmpInfo.skillAuth.get(4).skllAuthorCode.substring(0, 1) == '1'}" />
<c:set var="readMail" value="${myEmpInfo.skillAuth.get(5).skllAuthorCode.substring(0, 1) == '1'}" />
<c:set var="readChat" value="${myEmpInfo.skillAuth.get(6).skllAuthorCode.substring(0, 1) == '1'}" />
<c:set var="readNotification" value="${myEmpInfo.skillAuth.get(7).skllAuthorCode.substring(0, 1) == '1'}" />
<c:set var="readStatics" value="${myEmpInfo.skillAuth.get(8).skllAuthorCode.substring(0, 1) == '1'}" />
<%-- 읽기 권한 확인 --%>

<style>
/* 자식이 없을때 화살표 제거 */
.nav-item-has-children:not(:has(ul)) > a::after {
  display: none !important;
}
</style>

<div id="preloader">
  <div class="spinner"></div>
</div>

<!-- ======== sidebar-nav start =========== -->
<aside class="sidebar-nav-wrapper">
  <div class="navbar-logo">
    <a href="/">
      <img src="/assets/images/logo/logo.svg" alt="logo" />
    </a>
  </div>
  <nav class="sidebar-nav">
    <ul>
      <%--
          설명
          a 태그에 collapsed 이게 없어야 클릭 되어있는 거임
          
          2뎁스는 active class 주면 활성화
          
          뎁스가 없는 구조인 경우
          채팅 사이드바 활용
      --%>
        
        <%-- 메인 --%>
        <%--<li class="nav-item ${fn:contains(currentURL, '/demo') ? 'active' : ''}">
          <a href="/demo">
            <span class="icon material-symbols-outlined">mark_unread_chat_alt</span>
            <span class="text">데모</span>
          </a>
        </li>--%>
        <%-- 메인 --%>
        
        <%-- 메인 --%>
        <li class="nav-item ${fn:contains(currentURL, '/home') ? 'active' : ''}">
          <a href="/main/home">
            <span class="icon material-symbols-outlined">home</span>
            <span class="text">메인</span>
          </a>
        </li>
        <%-- 메인 --%>
        
        <%--프로젝트 사이드 바 --%>
        <c:if test="${readProject}">
          <li class="nav-item ${fn:contains(currentURL, '/project') ? 'active' : ''}">
            <a href="/project/tab">
              <span class="icon material-symbols-outlined">tactic</span>
              <span class="text">프로젝트</span>
            </a>
          </li>
        </c:if>
        
        <%--프로젝트 사이드 바 --%>
        
        <%--전자결재 사이드 바 --%>
        <c:if test="${readAtrz}">
          <li class="nav-item nav-item-has-children">
                  <a href="#2" class="${fn:contains(currentURL, '/atrz') ? '' : 'collapsed'}"
                     data-bs-toggle="collapse" data-bs-target="#atrz"
                     aria-controls="atrz" aria-expanded="true" aria-label="Toggle navigation">
                    <span class="icon material-symbols-outlined">
                      inventory
                    </span>
                    <span class="text">전자결재</span>
                  </a>
                  <ul id="atrz" class="dropdown-nav collapse ${fn:contains(currentURL, '/atrz') ? 'show' : ''}" style="">
                    <li>
                      <a href="/atrz/home" class="${fn:contains(currentURL, '/atrz/home') ? 'active' : ''}"> 전자결재 </a>
                    </li>
                    <li>
                      <a href="/atrz/approval" class="${fn:contains(currentURL, '/atrz/approval') ? 'active' : ''}"> 결재 대기 문서 </a>
                    </li>
                    <li>
                      <a href="/atrz/document" class="${fn:contains(currentURL, '/atrz/document') ? 'active' : ''}"> 전자결재 문서함 </a>
                    </li>
                    <li>
                      <a href="/atrz/companion" class="${fn:contains(currentURL, '/atrz/companion') ? 'active' : ''}"> 반려문서함 </a>
                    </li>
                  </ul>
                </li>
        </c:if>
        <%--전자결재 사이드 바 --%>
        
        <%--문서함 사이드 바 --%>
        <c:if test="${readWebFolder}">
        <li class="nav-item ${fn:contains(currentURL, '/myCalendar') ? 'active' : ''}">
          <a href="http://localhost:3000" target="_blank">
            <span class="icon material-symbols-outlined">create_new_folder</span>
            <span class="text">문서함</span>
          </a>
        </li>
        </c:if>
        <%--문서함 사이드 바 --%>
        
        <%--일정 사이드 바 --%>
        <c:if test="${readSchdule}">
        <li class="nav-item ${fn:contains(currentURL, '/myCalendar') ? 'active' : ''}">
          <a href="/myCalendar">
            <span class="icon material-symbols-outlined">today</span>
            <span class="text">내 일정</span>
          </a>
        </li>
        </c:if>
        <%--일정 사이드 바 --%>
        
        <%--메일 사이드 바 --%>
        <c:if test="${readMail}">
        <li class="nav-item ${fn:contains(currentURL, '/mail') ? 'active' : ''}">
          <a href="/mail">
            <span class="icon material-symbols-outlined">drafts</span>
            <span class="text">메일</span>
          </a>
        </li>
        </c:if>
        <%--메일 사이드 바 --%>

        
        <%-- 채팅 --%>
        <c:if test="${readChat}">
        <li class="nav-item ${fn:contains(currentURL, '/chat') ? 'active' : ''}">
          <a href="/chat/list">
            <span class="icon material-symbols-outlined">mark_unread_chat_alt</span>
            <span class="text">채팅</span>
          </a>
        </li>
        </c:if>
        <%-- 채팅 --%>
        
        <%--알림 사이드 바 --%>
        <c:if test="${readNotification}">
        <li class="nav-item ${fn:contains(currentURL, '/notification') ? 'active' : ''}">
          <a href="/notification/list">
            <span class="icon material-symbols-outlined">notifications</span>
            <span class="text">알림</span>
          </a>
        </li>
        </c:if>
        <%--알림 사이드 바 --%>
        
        <%--통계 사이드 바 --%>
        <c:if test="${readStatics}">
        <li class="nav-item nav-item-has-children">
          <a href="#7" class="${fn:contains(currentURL, '/statistics') ? '' : 'collapsed'}"
             data-bs-toggle="collapse" data-bs-target="#statistics"
             aria-controls="statistics" aria-expanded="false" aria-label="Toggle navigation">
            <span class="icon material-symbols-outlined">monitoring</span>
            <span class="text">통계</span>
          </a>
          <ul id="statistics" class="dropdown-nav collapse" style="">
            <li>
              <a href="/statistics"> 1뎁스 </a>
            </li>
            <li>
              <a href="/statistics"> 2뎁스 </a>
            </li>
          </ul>
        </li>
        </c:if>
        <%--통계 사이드 바 --%>
        
        <%--게시판 사이드 바 --%>
        <c:set var="selectedCtgryNo" value="${param.get('bbsCtgryNo')}" />
        <c:if test="${readBbs}">
		<li class="nav-item nav-item-has-children">
		  <a href="#1" class="${fn:contains(currentURL, '/bbs') ? '' : 'collapsed'}"
		     data-bs-toggle="collapse" data-bs-target="#bbs"
		     aria-controls="bbs" aria-expanded="false" aria-label="Toggle navigation">
		    <span class="icon material-symbols-outlined">auto_stories</span>
		    <span class="text">게시판</span>
		  </a>
		
		  <ul id="bbs" class="dropdown-nav collapse ${fn:contains(currentURL, '/bbs') ? 'show' : ''}">
		    <c:set var="selectedCtgryNo" value="${param.get('bbsCtgryNo')}" />

			<c:forEach var="category" items="${bbsCategory}">
			  <c:set var="hasSelectedChild" value="false" />
			  <c:forEach var="child" items="${category.children}">
			    <c:if test="${selectedCtgryNo == child.bbsCtgryNo}">
			      <c:set var="hasSelectedChild" value="true" />
			    </c:if>
			  </c:forEach>
			
			  <li class="nav-item 
			             nav-item-has-children 
			             ${fn:length(category.children) == 0 ? 'no-toggle' : ''}">
			
			    <c:choose>
			      <c:when test="${fn:length(category.children) > 0}">
			        <!-- 하위 있음 -->
			        <a href="#cat${category.bbsCtgryNo}"
			           class="d-flex justify-content-between align-items-center collapsed
			           ${(selectedCtgryNo == category.bbsCtgryNo or hasSelectedChild) ? 'active fw-bold text-dark' : 'text-muted'}"
			           data-bs-toggle="collapse"
			           data-bs-target="#cat${category.bbsCtgryNo}"
			           aria-expanded="${hasSelectedChild}">
			          <span>${category.ctgryNm}</span>
			        </a>
			
			        <ul id="cat${category.bbsCtgryNo}"
			            class="dropdown-nav collapse ${hasSelectedChild ? 'show' : ''} ps-3">
			          <c:forEach var="child" items="${category.children}">
			            <li>
			              <a href="/bbs/bbsList?bbsCtgryNo=${child.bbsCtgryNo}"
			                 class="${selectedCtgryNo == child.bbsCtgryNo ? 'active fw-bold text-dark' : 'text-muted'}">
			                ${child.ctgryNm}
			              </a>
			            </li>
			          </c:forEach>
			        </ul>
			      </c:when>
			
			      <c:otherwise>
			        <!-- 하위 없음 -->
			        <a href="/bbs/bbsList?bbsCtgryNo=${category.bbsCtgryNo}"
			           class="d-flex justify-content-between align-items-center
			           ${selectedCtgryNo == category.bbsCtgryNo ? 'active fw-bold text-dark' : 'text-muted'}">
			          <span>${category.ctgryNm}</span>
			        </a>
			      </c:otherwise>
			    </c:choose>
			  </li>
			</c:forEach>


		  </ul>
		</li>

        </c:if>
        <%--게시판 사이드 바 --%>
        
        <%--근태현황 사이드 바 --%>
        <li class="nav-item nav-item-has-children">
          <a href="#1" class="${fn:contains(currentURL, '/dclzType') ? '' : 'collapsed'}"
             data-bs-toggle="collapse" data-bs-target="#dclzType"
             aria-controls="dclzType" aria-expanded="true" aria-label="Toggle navigation">
			<span class="icon material-symbols-outlined">
			work
			</span>
            <span class="text">근태</span>
          </a>
          <ul id="dclzType" class="dropdown-nav collapse ${fn:contains(currentURL, '/dclz') ? 'show' : ''}" style="">
            <li>
              <a href="/dclz/dclzType" class="${fn:contains(currentURL, '/dclz/dclzType') ? 'active' : ''}"> 근태현황 </a>	
            </li>
            <li>
              <a href="/dclz/vacation" class="${fn:contains(currentURL, '/dclz/vacation') ? 'active' : ''}"> 연차 </a>
            </li>
            <sec:authorize access="hasRole('ROLE_ADMIN')">
            <li>
              <a href="/dclz/vacAdmin" class="${fn:contains(currentURL, '/dclz/vacAdmin') ? 'active' : ''}"> 연차관리 </a>
            </li>
            </sec:authorize>
          </ul>
        </li>
        
        <%--근태현황 사이드 바 --%>
        
        <%--조직도 사이드 바 --%>
        <sec:authorize access="hasRole('ROLE_MEMBER')">
        <li class="nav-item ${fn:contains(currentURL, '/organization/organizationList') ? 'active' : ''}">
        	${pageContext.request.contextPath}
          <a href="/orglist">
             <span class="icon material-symbols-outlined">groups</span>
            <span class="text">조직도</span>
          </a>
        </li>
        </sec:authorize>
        <%--조직도 사이드 바 --%>
        
         <%-- 관리자일 경우에만 보임  --%>
        <%--조직관리 사이드 바 --%>
        <sec:authorize access="hasRole('ROLE_ADMIN')">
        <li class="nav-item ${fn:contains(currentURL, '/organization/orglistAdmin') ? 'active' : ''}">
        	${pageContext.request.contextPath}
          <a href="/orglistAdmin">
             <span class="icon material-symbols-outlined">groups</span>
            <span class="text">조직관리</span>
          </a>
        </li>
        </sec:authorize>
        <%--조직관리 사이드 바 --%>

    </ul>
    
     
    </ul>
    

  </nav>
  

<%--  <div class="promo-box">--%>
<%--    <div class="promo-icon">--%>
<%--      <img class="mx-auto" src="/assets/images/logo/logo-icon-big.svg" alt="Logo" />--%>
<%--    </div>--%>
<%--    <h3>Upgrade to PRO</h3>--%>
<%--    <p>Improve your development process and start doing more with PlainAdmin PRO!</p>--%>
<%--    <a href="https://plainadmin.com/pro" target="_blank" rel="nofollow" class="main-btn primary-btn btn-hover">--%>
<%--      Upgrade to PRO--%>
<%--    </a>--%>
<%--  </div>--%>
</aside>
<div class="overlay"></div>
<!-- ======== sidebar-nav end =========== -->

    
     
    </ul>
    

  </nav>

</aside>
<div class="overlay"></div>
<!-- ======== sidebar-nav end =========== -->
