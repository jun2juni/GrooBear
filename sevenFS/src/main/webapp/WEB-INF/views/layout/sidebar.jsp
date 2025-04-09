<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:set var="currentURL" value="${pageContext.request.requestURI}" />

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
        <li class="nav-item ${fn:contains(currentURL, '/demo') ? 'active' : ''}">
          <a href="/demo">
            <span class="icon material-symbols-outlined">mark_unread_chat_alt</span>
            <span class="text">데모</span>
          </a>
        </li>
        <%-- 메인 --%>
        
        <%-- 메인 --%>
        <li class="nav-item ${fn:contains(currentURL, '/home') ? 'active' : ''}">
          <a href="/">
            <span class="icon material-symbols-outlined">home</span>
            <span class="text">메인</span>
          </a>
        </li>
        <%-- 메인 --%>
        
        <%--프로젝트 사이드 바 --%>

        <li class="nav-item ${fn:contains(currentURL, '/project') ? 'active' : ''}">
          <a href="/project/tab">
            <span class="icon material-symbols-outlined">tactic</span>
            <span class="text">프로젝트</span>
          </a>
        </li>
        
        <%--프로젝트 사이드 바 --%>
        
        <%--전자결재 사이드 바 --%>
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
          </ul>
        </li>
        <%--전자결재 사이드 바 --%>
        
        <%--문서함 사이드 바 --%>
        <li class="nav-item nav-item-has-children">
          <a href="#3" class="${fn:contains(currentURL, '/docbox') ? '' : 'collapsed'}"
             data-bs-toggle="collapse" data-bs-target="#docbox"
             aria-controls="docbox" aria-expanded="false" aria-label="Toggle navigation">
            <span class="icon material-symbols-outlined">
            create_new_folder
            </span>
            <span class="text">문서함</span>
          </a>
          <ul id="docbox" class="dropdown-nav collapse" style="">
            <li>
              <a href="/docbox"> 1뎁스 </a>
            </li>
            <li>
              <a href="/docbox"> 2뎁스 </a>
            </li>
          </ul>
        </li>
        <%--문서함 사이드 바 --%>
        
        <%--일정 사이드 바 --%>
        <li class="nav-item nav-item-has-children">
          <a href="#4" class="${fn:contains(currentURL, '/schdule') ? '' : 'collapsed'}"
             data-bs-toggle="collapse" data-bs-target="#schdule"
             aria-controls="schdule" aria-expanded="false" aria-label="Toggle navigation">
            <span class="icon material-symbols-outlined">
            today
            </span>
            <span class="text">일정</span>
          </a>
          <ul id="schdule" class="dropdown-nav collapse" style="">
            <li>
              <a href="/myCalendar"> 내 일정 </a>
            </li>
            <li>
            </li>
          </ul>
        </li>
        <%--일정 사이드 바 --%>
        
        <%--메일 사이드 바 --%>
        <li class="nav-item nav-item-has-children">
          <a href="#5" class="${fn:contains(currentURL, '/mail') ? '' : 'collapsed'}"
             data-bs-toggle="collapse" data-bs-target="#mail"
             aria-controls="mail" aria-expanded="false" aria-label="Toggle navigation">
            <span class="icon material-symbols-outlined">
            drafts
            </span>
            <span class="text">메일</span>
          </a>
          <ul id="mail" class="dropdown-nav collapse" style="">
            <li>
              <a href="/mail"> 1뎁스 </a>
            </li>
            <li>
              <a href="/mail"> 2뎁스 </a>
            </li>
          </ul>
        </li>
        <%--메일 사이드 바 --%>
        
        <%-- 채팅 --%>
        <li class="nav-item ${fn:contains(currentURL, '/chat') ? 'active' : ''}">
          <a href="/chat/list">
            <span class="icon material-symbols-outlined">mark_unread_chat_alt</span>
            <span class="text">채팅</span>
          </a>
        </li>
        <%-- 채팅 --%>
        
        <%--알림 사이드 바 --%>
        <li class="nav-item ${fn:contains(currentURL, '/notification') ? 'active' : ''}">
          <a href="/notification/list">
            <span class="icon material-symbols-outlined">notifications</span>
            <span class="text">알림</span>
          </a>
        </li>
        <%--알림 사이드 바 --%>
        
        <%--통계 사이드 바 --%>
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
        <%--통계 사이드 바 --%>
        
        <%--게시판 사이드 바 --%>
        <li class="nav-item nav-item-has-children">
          ${bbsCategory}
          <a href="#1" class="${fn:contains(currentURL, '/bbs') ? '' : 'collapsed'}"
             data-bs-toggle="collapse" data-bs-target="#bbs"
             aria-controls="bbs" aria-expanded="false" aria-label="Toggle navigation">
            <span class="icon material-symbols-outlined">
            auto_stories
            </span>
            <span class="text">게시판</span>
          </a>
          <ul id="bbs" class="dropdown-nav collapse" style="">
            <c:forEach var="category" items="${bbsCategory}">
              <li>
                <a href="/bbs/bbsList?bbsCtgryNo=${category.bbsCtgryNo}">${category.ctgryNm}</a>
              </li>
            </c:forEach>
          </ul>
        </li>
        <%--게시판 사이드 바 --%>
        
        <%--근태현황 사이드 바 --%>
        <li class="nav-item nav-item-has-children">
          <a href="#1" class="${fn:contains(currentURL, '/dclzType') ? '' : 'collapsed'}"
             data-bs-toggle="collapse" data-bs-target="#dclzType"
             aria-controls="dclzType" aria-expanded="false" aria-label="Toggle navigation">
			<span class="icon material-symbols-outlined">
			work
			</span>
            <span class="text">근태</span>
          </a>
          <ul id="dclzType" class="dropdown-nav collapse" style="">
            <li>
              <a href="/dclz/dclzType"> 근태현황</a>
            </li>
            <li>
              <a href="/dclz/vacation"> 연차 </a>
            </li>
          </ul>
        </li>
        <%--근태현황 사이드 바 --%>
        
        

        <%--조직도 사이드 바 --%>
        <li class="nav-item">
          <a href="/orglist" class="${fn:contains(currentURL, '/orglist') ? '' : 'collapsed'}" >
            <span class="icon material-symbols-outlined">groups</span>
            <span class="text">조직도</span>
          </a>
          </li>
        <%--조직도 사이드 바 --%>
        
         <%-- 관리자일 경우에만 보임  --%>
        <%--조직관리 사이드 바 --%>
        <sec:authorize access="hasRole('ROLE_ADMIN')">
        <li class="nav-item">
          <a href="/orglistAdmin" class="${fn:contains(currentURL, '/orglistAdmin') ? '' : 'collapsed'}" >
            <span class="icon material-symbols-outlined">
				manage_accounts
			</span>
            <span class="text">조직관리</span>
          </a>
          </li>
          </sec:authorize>
        <%--조직관리 사이드 바 --%>
    </ul>
    
     
    </ul>
    

  </nav>
  <div class="promo-box">
    <div class="promo-icon">
      <img class="mx-auto" src="/assets/images/logo/logo-icon-big.svg" alt="Logo" />
    </div>
    <h3>Upgrade to PRO</h3>
    <p>Improve your development process and start doing more with PlainAdmin PRO!</p>
    <a href="https://plainadmin.com/pro" target="_blank" rel="nofollow" class="main-btn primary-btn btn-hover">
      Upgrade to PRO
    </a>
  </div>
</aside>
<div class="overlay"></div>
<!-- ======== sidebar-nav end =========== -->

    
     
    </ul>
    

  </nav>

</aside>
<div class="overlay"></div>
<!-- ======== sidebar-nav end =========== -->
