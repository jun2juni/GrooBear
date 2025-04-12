<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="메인" />

<div class="card-style">
    <!-- 검색 폼 추가 -->
<div class="row mb-4">
    <div class="col-md-8 col-lg-6 mx-auto">
        <div class="card border-0 shadow-sm">
            <div class="card-body p-3">
                <form id="searchForm" onsubmit="searchProjects(event)">
                    <div class="input-group">
                        <input type="text" name="keyword" id="keywordInput" value="${param.keyword}" class="form-control" placeholder="프로젝트명, 카테고리, 담당자 검색">
                        <button type="submit" class="btn btn-primary">
                            <i class="material-icons-outlined" style="font-size: 16px; vertical-align: text-bottom;">search</i> 검색
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- 프로젝트 목록 영역 -->
<div class="row">
    <div class="col-12">
        <div class="card border-0 shadow-sm">
            <div class="card-header bg-white d-flex justify-content-between align-items-center py-3">
                <h5 class="mb-0">프로젝트 목록</h5>
                <a href="/project/insert" class="btn btn-sm btn-success">
                    <i class="material-icons-outlined" style="font-size: 16px; vertical-align: text-bottom;">add</i> 신규 프로젝트
                </a>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead class="bg-light">
                            <tr>
                                <th scope="col" class="fw-semibold">프로젝트명</th>
                                <th scope="col" class="fw-semibold">카테고리</th>
                                <th scope="col" class="fw-semibold">책임자</th>
                                <th scope="col" class="fw-semibold">상태</th>
                                <th scope="col" class="fw-semibold">등급</th>
                                <th scope="col" class="fw-semibold text-center">기간</th>
                                <th scope="col" class="fw-semibold">액션</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="project" items="${projectList}">
                                <tr class="align-middle">
                                    <td class="fw-medium">
                                        <a href="/project/projectDetail?prjctNo=${project.prjctNo}" class="text-decoration-none text-primary">
                                            ${project.prjctNm}
                                        </a>
                                    </td>
                                    <td>
                                        <span class="badge rounded-pill bg-light text-dark">
                                            ${project.ctgryNm}
                                        </span>
                                    </td>
                                    <td>${project.prtcpntNm}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${project.prjctSttusNm eq '진행중'}">
                                                <span class="badge bg-success">진행중</span>
                                            </c:when>
                                            <c:when test="${project.prjctSttusNm eq '대기중'}">
                                                <span class="badge bg-warning text-dark">대기중</span>
                                            </c:when>
                                            <c:when test="${project.prjctSttusNm eq '완료'}">
                                                <span class="badge bg-secondary">완료</span>
                                            </c:when>
                                            <c:when test="${project.prjctSttusNm eq '지연'}">
                                                <span class="badge bg-danger">지연</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-info">${project.prjctSttusNm}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${project.prjctGrad eq 'A'}">
                                                <span class="text-danger fw-bold">A</span>
                                            </c:when>
                                            <c:when test="${project.prjctGrad eq 'B'}">
                                                <span class="text-primary fw-bold">B</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">${project.prjctGrad}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <small class="text-muted">
                                            ${project.prjctBeginDateFormatted} ~ ${project.prjctEndDateFormatted}
                                        </small>
                                    </td>
                                    <td>
                                        <div class="dropdown">
                                            <button class="btn btn-sm btn-light border-0" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                <i class="material-icons-outlined" style="font-size: 18px;">more_vert</i>
                                            </button>
                                            <ul class="dropdown-menu">
                                                <li><a class="dropdown-item" href="/project/projectDetail?prjctNo=${project.prjctNo}">상세보기</a></li>
                                                <li><a class="dropdown-item" href="/project/edit/${project.prjctNo}">수정</a></li>
                                                <li><hr class="dropdown-divider"></li>
                                                <li><a class="dropdown-item text-danger" href="#" data-bs-toggle="modal" data-bs-target="#deleteModal" data-project-id="${project.prjctNo}">삭제</a></li>
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <!-- 데이터가 없을 경우 -->
                            <c:if test="${empty projectList}">
                                <tr>
                                    <td colspan="7" class="text-center py-5">
                                        <div class="d-flex flex-column align-items-center">
                                            <i class="material-icons-outlined text-muted" style="font-size: 48px;">search_off</i>
                                            <p class="text-muted mt-3">검색 결과가 없습니다</p>
                                            <button class="btn btn-sm btn-outline-primary mt-2" onclick="loadAllProjects()">전체 목록 보기</button>
                                        </div>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
				<!-- 페이지 네비게이션 -->
				<div class="row mb-4">
				    <div class="col-12">
				        <div class="card-style">
				            <div style="display: flex; justify-content: center;">
				                <page-navi
				                    url="/project/tab?keyword=${param.keyword}"
				                    current="${articlePage.getCurrentPage()}"
				                    show-max="5"
				                    total="${articlePage.getTotalPages()}"
				                ></page-navi>
				            </div>
				        </div>
				    </div>
				</div>
            </div>
        </div>
    </div>
</div>
<!-- 삭제 확인 모달 -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteModalLabel">프로젝트 삭제</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>정말로 이 프로젝트를 삭제하시겠습니까?</p>
                <p class="text-danger small">이 작업은 되돌릴 수 없으며 모든 관련 데이터가 삭제됩니다.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button type="button" class="btn btn-danger" id="confirmDelete">삭제</button>
            </div>
        </div>
    </div>
</div>

<script>
// 삭제 모달 처리
let projectToDelete = 0;

$('#deleteModal').on('show.bs.modal', function (event) {
    const button = $(event.relatedTarget);
    projectToDelete = button.data('project-id');
});

$('#confirmDelete').on('click', function() {
    if (projectToDelete > 0) {
        // AJAX로 삭제 요청
        $.ajax({
            url: '/project/delete',
            type: 'POST',
            data: { prjctNo: projectToDelete },
            success: function(response) {
                $('#deleteModal').modal('hide');
                // 현재 페이지 다시 로드
                loadPage(${articlePage.currentPage}, $('#keywordInput').val());
            },
            error: function(xhr, status, error) {
                alert('프로젝트 삭제 중 오류가 발생했습니다.');
            }
        });
    }
});

// AJAX로 프로젝트 목록 로드
function loadPage(page, keyword) {
    $.ajax({
        url: '/project/projectList',
        type: 'GET',
        data: {
            currentPage: page,
            keyword: keyword
        },
        success: function(response) {
            $('#projectListContent').html(response);
        },
        error: function(xhr, status, error) {
            console.error('페이지 로드 중 오류 발생:', error);
        }
    });
}

// 검색 폼 제출 처리
function searchProjects(event) {
    event.preventDefault();
    const keyword = $('#keywordInput').val();
    loadPage(1, keyword);
}

// 전체 목록 보기
function loadAllProjects() {
    $('#keywordInput').val('');
    loadPage(1, '');
}

// 초기 로드 후 이벤트 처리
$(document).ready(function() {
    // 이미 페이지가 로드된 상태이므로 추가 작업 필요 없음
});
</script>
