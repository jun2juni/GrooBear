<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="알림" />

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport"
        content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"/>
  <meta http-equiv="X-UA-Compatible" content="ie=edge" />
  <title>${title}</title>
  <%@ include file="../layout/prestyle.jsp" %>
  <style>
  .notification {
    position: relative;
    display: flex;
    align-items: flex-start;
    gap: 16px;
    background-color: #fff;
    border-radius: 12px;
    padding: 16px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.06);
    transition: transform 0.2s ease;
  }

  .notification:hover {
    transform: translateY(-3px);
  }

  .notification .image {
    flex-shrink: 0;
    width: 48px;
    height: 48px;
    border-radius: 50%;
    background-color: var(--bs-light);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 20px;
  }

  .notification .content {
    flex-grow: 1;
    text-decoration: none;
    color: inherit;
  }

  .notification .content h6 {
    margin-bottom: 6px;
    font-weight: 600;
    font-size: 16px;
  }

  .notification .content p {
    margin-bottom: 4px;
    font-size: 14px;
    color: #6c757d;
    overflow: hidden;
    text-overflow: ellipsis;
    min-height: 60px;
  }

  .notification .content span {
    font-size: 12px;
    color: #adb5bd;
  }

  .notification .delete-btn {
    position: absolute;
    top: 12px;
    right: 12px;
    font-size: 14px;
    color: #adb5bd;
    display: flex;
    align-items: center;
    gap: 4px;
    transition: color 0.2s ease;
  }

  .notification .delete-btn:hover {
    color: #dc3545;
  }
</style>
</head>
<body>
<%@ include file="../layout/sidebar.jsp" %>
<main class="main-wrapper">
  <%@ include file="../layout/header.jsp" %>
  <section class="section">
    <div class="container-fluid">

      <div class="">
        <jsp:useBean id="notificationVOList" scope="request" type="java.util.List" />
        <c:if test="${notificationVOList.size() == 0}">
            <div style="padding: 2rem; text-align: center; color: #999; font-size: 1.1rem; background-color: #f9f9f9; border-radius: 8px; box-shadow: 0 2px 6px rgba(0,0,0,0.05);">
                <p style="margin: 0;">새로운 알림이 없습니다.</p>
            </div>
        </c:if>

        <div class="row g-4">
          <c:forEach var="notification" items="${notificationVOList}">
            <div class="single-notification-remove col-12 col-md-6">
              <div class="notification">
                <div class="image ${notification.notificationColor} text-white">
                  ${notification.notificationIcon}
                </div>
                <a href="${notification.originPath}" class="content">
                  <h6>${notification.ntcnSj}</h6>
                  <p>${notification.ntcnCn}</p>
                  <span>
                    <fmt:formatDate value="${notification.ntcnCreatDt}" pattern="yyyy-MM-dd. HH:mm"/>
                  </span>
                </a>
                <a href="#" class="delete-btn" data-empl-no="${notification.emplNo}" data-ntcn-sn="${notification.ntcnSn}">
                  <i class="lni lni-trash-can"></i>
                  <span>삭제</span>
                </a>
              </div>
            </div>
          </c:forEach>
        </div>
        
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
      item.addEventListener("click", async (e) => {
        const {emplNo, ntcnSn} = item.dataset;
        console.log(emplNo, ntcnSn)
          	let result = await swal({
                title: "정말 삭제하시겠습니까?",
                icon: "warning",
                buttons: {
                    cancle : {
                        text : '취소',
                        value : false
                    },
                    confirm : {
                        text : '삭제',
                        value : true
                    }
                },
                dangerMode: true
              })
        try {
          if (result) {
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
                    document.querySelectorAll(".single-notification-remove")[idx].remove();
                    swal("삭제 완료", "알림이 삭제되었습니다.", "success");
                  }
                })
          }
        } catch (e) {
          console.error(e);
        }
      })
    })
  
</script>
</body>
</html>
