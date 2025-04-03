<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:set var="title" scope="application" value="메인" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"/>
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

            <!-- Material Icons CDN 추가 -->
            <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">

            <div class="container">
                <!-- 탭 메뉴 -->
                <ul class="nav nav-pills mb-3 d-flex justify-content-center" id="pills-tab" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active d-flex align-items-center" id="pills-home-tab" data-bs-toggle="pill" data-bs-target="#dashBoard" type="button" role="tab" aria-controls="dashBoard" aria-selected="true">
                            <span class="material-icons-outlined me-1">grid_view</span> 대시보드
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link d-flex align-items-center" id="pills-profile-tab" data-bs-toggle="pill" data-bs-target="#List" type="button" role="tab" aria-controls="List" aria-selected="false">
                            <span class="material-icons-outlined me-1">format_list_bulleted</span> 프로젝트 목록
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link d-flex align-items-center" id="pills-project-tab" data-bs-toggle="pill" data-bs-target="#projectKanban" type="button" role="tab" aria-controls="projectKanban" aria-selected="false">
                            <span class="material-icons-outlined me-1">view_kanban</span> 칸반보드(프로젝트)
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link d-flex align-items-center" id="pills-task-tab" data-bs-toggle="pill" data-bs-target="#taskKanban" type="button" role="tab" aria-controls="taskKanban" aria-selected="false">
                            <span class="material-icons-outlined me-1">checklist</span> 칸반보드(업무)
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link d-flex align-items-center" id="pills-gantt-tab" data-bs-toggle="pill" data-bs-target="#gantt" type="button" role="tab" aria-controls="gantt" aria-selected="false">
                            <span class="material-icons-outlined me-1">dvr</span> 간트차트
                        </button>
                    </li>
                </ul>
            </div>

                <!-- 탭 콘텐츠 -->
                <div class="tab-content text-center" id="pills-tabContent">
                    <div class="tab-pane fade show active" id="dashBoard" role="tabpanel" aria-labelledby="pills-home-tab" tabindex="0">
                        <!-- 대시보드 콘텐츠 -->
                    </div>
                    <div class="tab-pane fade" id="List" role="tabpanel" aria-labelledby="pills-profile-tab" tabindex="0">
                        <div id="projectListContent">프로젝트 목록을 불러오는 중...</div>
                    </div>
                    <div class="tab-pane fade" id="projectKanban" role="tabpanel" aria-labelledby="pills-project-tab" tabindex="0">
                        <!-- 칸반보드 (프로젝트) -->
                    </div>
                    <div class="tab-pane fade" id="taskKanban" role="tabpanel" aria-labelledby="pills-task-tab" tabindex="0">
                        <!-- 칸반보드 (업무) -->
                    </div>
                    <div class="tab-pane fade" id="gantt" role="tabpanel" aria-labelledby="pills-gantt-tab" tabindex="0">
                        <!-- 간트차트 -->
                    </div>
                </div>
        </div>
    </section>
    <%@ include file="../layout/footer.jsp" %>
</main>
<%@ include file="../layout/prescript.jsp" %>

</body>

<!-- jQuery 추가 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    $("#pills-profile-tab").on("click", function() {
        $("#projectListContent").load("/project/projectList"); 
    });
});

</script>

</html>
