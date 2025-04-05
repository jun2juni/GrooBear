<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="메인" />

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport"
        content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"/>
  <meta http-equiv="X-UA-Compatible" content="ie=edge" />
  <title>${title}</title>
  <%@ include file="../layout/prestyle.jsp" %>
</head>
<body>
<%@ include file="../layout/sidebar.jsp" %>
<main class="main-wrapper">
  <%@ include file="../layout/header.jsp" %>
  <section class="section">
    <div class="container-fluid">

      <div class="card-style">
        <jsp:useBean id="notificationVOList" scope="request" type="java.util.List" />
        <c:forEach var="notification" items="${notificationVOList}">
          <div class="single-notification">
<%--            <div class="checkbox">--%>
<%--              <div class="form-check checkbox-style mb-20">--%>
<%--                <input class="form-check-input" type="checkbox" value="" id="checkbox-1">--%>
<%--              </div>--%>
<%--            </div>--%>
            <div class="notification">
              <div class="image ${notification.notificationColor}">
                ${notification.notificationIcon}
              </div>
              <a href="#0" class="content">
                <h6>${notification.ntcnSj}</h6>
                <p class="text-sm text-gray">
                  ${notification.ntcnCn}
                </p>
                <span class="text-sm text-medium text-gray">
                  <fmt:formatDate value="${notification.ntcnCreatDt}" pattern="YYYY.MM.dd. HH:mm"/>
                </span>
              </a>
            </div>
            <div class="action">
              <%-- 삭제 버튼 --%>
              <button class="delete-btn" data-empl-no="${notification.emplNo}" data-ntcn-sn="${notification.ntcnSn}">
                <i class="lni lni-trash-can"></i>
              </button>
              <%--설정 버튼?--%>
              <button class="more-btn dropdown-toggle" id="moreAction" data-bs-toggle="dropdown" aria-expanded="false">
                <i class="lni lni-more-alt"></i>
              </button>
              <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="moreAction" style="">
                <li class="dropdown-item">
                  <a href="#0" class="text-gray">Mark as Read</a>
                </li>
                <li class="dropdown-item">
                  <a href="#0" class="text-gray">Reply</a>
                </li>
              </ul>
            </div>
          </div>
          <!-- end single notification -->
        </c:forEach>
        
        <div class="mt-4"></div>
        <page-navi
            url="/notification/list?"
            current="${articlePage.getCurrentPage()}"
            total="${articlePage.getTotalPages()}"
        ></page-navi>
      </div>
      
    </div>
  </section>
  <%@ include file="../layout/footer.jsp" %>
</main>
<%@ include file="../layout/prescript.jsp" %>

<script>
    document.querySelectorAll(".delete-btn").forEach((item, idx) => {
      item.addEventListener("click", (e) => {
        const {emplNo, ntcnSn} = item.dataset;
        console.log(emplNo, ntcnSn)
        
        try {
          fetch("/notification/delete", {
            method: "post",
            headers: {
              'Content-Type': 'application/json',
            },
            body: JSON.stringify({
              emplNo, ntcnSn
            })
          })
              .then((res) => res.json())
              .then((data) => {
                if (data.result === "success") {
                  document.querySelectorAll(".single-notification")[idx].remove();
                }
              })
        } catch (e) {
          console.error(e);
        }
      })
    })
  
</script>
</body>
</html>
