<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="프로젝트" />

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta
name="viewport"
content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"
/>
<meta http-equiv="X-UA-Compatible" content="ie=edge" />
<title>${title}</title>
<c:import url="../layout/prestyle.jsp" />
<style>
.tab-pane {
  width: 100%;
  padding: 15px 0;
  overflow: scroll;
}

.container-fluid {
  width: 100%;
  padding: 0 15px;
}
</style>
</head>
<body>
<c:import url="../layout/sidebar.jsp" />
<main class="main-wrapper">
<c:import url="../layout/header.jsp" />

<!-- tab -->
<ul class="nav nav-tabs" id="myTab" role="tablist">
<li class="nav-item" role="presentation">
<button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home-tab-pane" type="button" role="tab" aria-controls="home-tab-pane" aria-selected="true">Home</button>
</li>
<li class="nav-item" role="presentation">
<button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile-tab-pane" type="button" role="tab" aria-controls="profile-tab-pane" aria-selected="false">Profile</button>
</li>
<li class="nav-item" role="presentation">
<button class="nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#contact-tab-pane" type="button" role="tab" aria-controls="contact-tab-pane" aria-selected="false">Contact</button>
</li>
<li class="nav-item" role="presentation">
<button class="nav-link" id="disabled-tab" data-bs-toggle="tab" data-bs-target="#disabled-tab-pane" type="button" role="tab" aria-controls="disabled-tab-pane" aria-selected="false" disabled>Disabled</button>
</li>
</ul>
<div class="tab-content" id="myTabContent">
<div class="tab-pane fade show active" id="home-tab-pane" role="tabpanel" aria-labelledby="home-tab" tabindex="0">
<section class="section">
<div class="container-fluid">
<%-- <c:import url="./gantt.jsp" /> --%>
</div>
</section>
</div>
<div class="tab-pane fade" id="profile-tab-pane" role="tabpanel" aria-labelledby="profile-tab" tabindex="0">...</div>
<div class="tab-pane fade" id="contact-tab-pane" role="tabpanel" aria-labelledby="contact-tab" tabindex="0">...</div>
<div class="tab-pane fade" id="disabled-tab-pane" role="tabpanel" aria-labelledby="disabled-tab" tabindex="0">...</div>
</div>

<c:import url="../layout/footer.jsp" />
</main>
<c:import url="../layout/prescript.jsp" />

<!-- 탭 전환 시 간트차트 다시 그리기 -->
<script>
  // 탭 전환 시 간트차트 다시 그리기
  document.querySelectorAll('button[data-bs-toggle="tab"]').forEach(function(tab) {
    tab.addEventListener('shown.bs.tab', function (e) {
      // 탭이 표시될 때 간트차트가 있다면 리사이즈
      if (window.gantt && document.getElementById('gantt_here')) {
        window.gantt.render();
      }
    });
  });
  
//창 크기 조정 시 간트차트 리사이즈
  window.addEventListener("resize", function() {
      if (gantt) {
          gantt.render();
      }
  });

  // 부모 컨테이너의 크기가 변할 때도 간트차트 크기 조정
  function adjustGanttSize() {
      var container = document.getElementById("gantt_here");
      if (container && gantt) {
          // 부모 요소의 너비에 맞춤
          container.style.width = "100%";
          gantt.render();
      }
  }

  // 초기화 및 탭 전환 시 크기 조정
  adjustGanttSize(); 
</script>
</body>
</html>