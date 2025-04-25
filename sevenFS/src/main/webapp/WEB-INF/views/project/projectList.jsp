<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:choose>
<%-- 🟨 Kanban 모드: 사이드바용 리스트만 출력 --%>
<c:when test="${param.mode eq 'kanban'}">
  <!-- 프로젝트 목록 헤더 추가 -->
  <div class="project-header bg-light p-3 mb-2 border-bottom">
    <h5 class="mb-0 d-flex align-items-center">
      <span class="material-icons-outlined me-2">folder</span>
      프로젝트 목록
    </h5>
  </div>

  <ul class="list-group project-sidebar-list">
    <c:forEach var="proj" items="${projectList}">
      <li class="list-group-item project-item" data-prjct-no="${proj.prjctNo}" style="cursor:pointer">
        ${proj.prjctNm}
      </li>
    </c:forEach>
  </ul>
</c:when>

  <%-- 🟦 일반 프로젝트 목록 테이블 --%>
  <c:otherwise>
    <div class="card-style">
      <!-- 검색 폼 -->
      <div class="row mb-4">
        <div class="col-md-12">
          <div class="d-flex align-items-center justify-content-between">
            <form id="searchForm" class="input-group" style="max-width: 700px;">
              <input type="text" id="keywordInput" class="form-control" placeholder="프로젝트명, 카테고리, 담당자 검색" value="${param.keyword}">
              <button type="submit" class="btn btn-primary d-flex align-items-center">
                <span class="material-icons-outlined">search</span>
                <span class="ms-1">검색</span>
              </button>
            </form>
            
            <div class="d-flex gap-2">
              <a href="/project/downloadExcel?keyword=${param.keyword}" class="btn btn-outline-secondary">엑셀 다운로드</a>
              <a href="/project/insert" class="btn btn-success d-flex align-items-center">
                <span class="material-icons-outlined me-1">add</span>
                프로젝트 생성
              </a>
            </div>
          </div>
        </div>
      </div>
<!-- 총 건수 표시 -->
<div class="d-flex justify-content-between align-items-center mb-2">
  <div class="fw-bold">
    <span>총 ${articlePage.total}건</span>
    <c:if test="${not empty param.keyword}">
      <span class="ms-2 text-primary">"${param.keyword}" 검색결과</span>
    </c:if>
  </div>
</div>
      <!-- 프로젝트 목록 테이블 -->
      <div class="card shadow-sm border-0">
        <div class="card-body p-0">
          <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
              <thead class="bg-light text-center">
                <tr>
                  <th>순번</th>
                  <th class="text-center">프로젝트명</th>
                  <th class="text-center">카테고리</th>
                  <th class="text-center">책임자</th>
                  <th class="text-center">상태</th>
                  <th class="text-center">등급</th>
                  <th class="text-center">기간</th>
                  <th class="text-center"></th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="project" items="${projectList}" varStatus="status">
                  <tr class="align-middle" id="project-row-${project.prjctNo}">
                    <td class="text-center">${project.rnum}</td>
                    <td class="text-start ps-4">
                      <a href="/project/projectDetail?prjctNo=${project.prjctNo}" class="text-decoration-none text-primary">
                        ${project.prjctNm}
                      </a>
                    </td>
                    <td class="text-center"><span class="badge bg-light text-dark">${project.ctgryNm}</span></td>
                    <td class="text-center">${project.prtcpntNm}</td>
                    <td class="text-center">
                      <c:choose>
                        <c:when test="${project.prjctSttusNm eq '진행중'}"><span class="badge bg-success">진행중</span></c:when>
                        <c:when test="${project.prjctSttusNm eq '대기중'}"><span class="badge bg-warning text-dark">대기중</span></c:when>
                        <c:when test="${project.prjctSttusNm eq '완료'}"><span class="badge bg-secondary">완료</span></c:when>
                        <c:when test="${project.prjctSttusNm eq '지연'}"><span class="badge bg-danger">지연</span></c:when>
                        <c:otherwise><span class="badge bg-info">${project.prjctSttusNm}</span></c:otherwise>
                      </c:choose>
                    </td>
                    <td class="text-center">${project.prjctGrad}</td>
                    <td class="text-center">
                      <small class="text-muted">${project.prjctBeginDateFormatted} ~ ${project.prjctEndDateFormatted}</small>
                    </td>
                    <td class="text-center">
                      <div class="dropdown">
                        <button class="btn btn-light btn-sm" data-bs-toggle="dropdown">
                          <i class="material-icons-outlined">more_vert</i>
                        </button>
                        <ul class="dropdown-menu">
                          <li><a class="dropdown-item" href="/project/projectDetail?prjctNo=${project.prjctNo}">상세보기</a></li>
                          <li><a class="dropdown-item" href="/project/editForm?prjctNo=${project.prjctNo}">수정</a></li>
                          <li><hr class="dropdown-divider"></li>
                          <li><a href="javascript:void(0)" class="dropdown-item text-danger" onclick="confirmDelete(event, ${project.prjctNo})">삭제</a></li>
                        </ul>
                      </div>
                    </td>
                  </tr>
                </c:forEach>
                <c:if test="${empty projectList}">
                  <tr><td colspan="8" class="text-center py-4 text-muted">등록된 프로젝트가 없습니다.</td></tr>
                </c:if>
              </tbody>
            </table>
          </div>
        </div>

        <!-- 페이지네이션 -->
        <div class="d-flex justify-content-center align-items-center flex-wrap gap-3 m-4">
          <nav>
            <ul class="pagination pagination-sm mb-0">
              <c:if test="${articlePage.currentPage > 1}">
                <li class="page-item">
                  <a class="page-link" href="javascript:void(0)" onclick="loadPage(1)">&laquo;</a>
                </li>
                <li class="page-item">
                  <a class="page-link" href="javascript:void(0)" onclick="loadPage(${articlePage.currentPage - 1})">&lsaquo;</a>
                </li>
              </c:if>
              <c:forEach begin="${articlePage.startPage}" end="${articlePage.endPage}" var="i">
                <li class="page-item ${i == articlePage.currentPage ? 'active' : ''}">
                  <a class="page-link" href="javascript:void(0)" onclick="loadPage(${i})">${i}</a>
                </li>
              </c:forEach>
              <c:if test="${articlePage.currentPage < articlePage.totalPages}">
                <li class="page-item">
                  <a class="page-link" href="javascript:void(0)" onclick="loadPage(${articlePage.currentPage + 1})">&rsaquo;</a>
                </li>
                <li class="page-item">
                  <a class="page-link" href="javascript:void(0)" onclick="loadPage(${articlePage.totalPages})">&raquo;</a>
                </li>
              </c:if>
            </ul>
          </nav>
        </div>
      </div>
    </div>
  </c:otherwise>
</c:choose>

<script>
// 전역 변수 정의
var currentPage = ${articlePage.currentPage != null ? articlePage.currentPage : 1};

// 페이지 로드 함수 - 전역에 정의
function loadPage(page) {
  if (!page || isNaN(page)) {
    console.error("유효하지 않은 페이지 번호:", page);
    return;
  }
  
  console.log("페이지 로드: " + page);
  currentPage = page;
  var keyword = document.getElementById("keywordInput") ? document.getElementById("keywordInput").value : '';
  var encodedKeyword = encodeURIComponent(keyword);
  
  fetch("/project/projectList?currentPage=" + page + "&keyword=" + encodedKeyword)
    .then(res => res.text())
    .then(html => {
      const target = document.getElementById("projectListContent");
      if (target) {
        target.innerHTML = html;
        executeInlineScripts("projectListContent");
      }
    })
    .catch(err => console.error("페이지 로드 실패", err));
}

// 엑셀 다운로드 함수
window.downloadExcel = function() {
  var keyword = document.getElementById("keywordInput") ? document.getElementById("keywordInput").value : '';
  var encodedKeyword = encodeURIComponent(keyword);
  
  // 현재 사용자의 검색 키워드를 포함한 URL 생성
  var url = "/project/downloadExcel?keyword=" + encodedKeyword;
  
  // 다운로드 요청
  window.location.href = url;
};

// 삭제 확인 함수 - 전역에 정의
function confirmDelete(event, prjctNo) {
  event.preventDefault();
  console.log("삭제 확인: " + prjctNo);
  
  if (typeof swal === 'undefined') {
    if(confirm("정말로 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.")) {
      deleteProject(prjctNo);
    }
  } else {
    swal({
      title: "정말로 삭제하시겠습니까?",
      text: "이 작업은 되돌릴 수 없습니다.",
      icon: "warning",
      buttons: ["취소", "삭제"],
      dangerMode: true,
    }).then(function(willDelete) {
      if (willDelete) {
        deleteProject(prjctNo);
      }
    });
  }
}

// 프로젝트 삭제 함수 - 전역에 정의
function deleteProject(prjctNo) {
  console.log("삭제 실행: " + prjctNo);
  
  fetch("/project/delete/" + prjctNo, {
    method: 'DELETE',
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .then(function(res) {
    console.log("응답 상태: " + res.status);
    return res.json();
  })
  .then(function(data) {
    console.log("응답 데이터:", data);
    if (data.success) {
      if (typeof swal !== 'undefined') {
        swal("삭제 완료", "프로젝트가 삭제되었습니다.", "success")
          .then(function() {
            window.location.reload();
          });
      } else {
        alert("프로젝트가 삭제되었습니다.");
        window.location.reload();
      }
    } else {
      if (typeof swal !== 'undefined') {
        swal("삭제 실패", data.message || "프로젝트를 삭제할 수 없습니다.", "error");
      } else {
        alert("삭제 실패: " + (data.message || "프로젝트를 삭제할 수 없습니다."));
      }
    }
  })
  .catch(function(err) {
    console.error("삭제 요청 오류:", err);
    if (typeof swal !== 'undefined') {
      swal("삭제 실패", "서버 오류가 발생했습니다.", "error");
    } else {
      alert("삭제 실패: 서버 오류가 발생했습니다.");
    }
  });
}

// 간트차트 탭 전환 및 해당 프로젝트 로드 - 전역에 정의
function loadGanttChart(prjctNo) {
  console.log("간트차트 로드: " + prjctNo);
  
  // 탭 전환
  var ganttTabBtn = document.querySelector('[data-bs-target="#tab-gantt"]');
  if (ganttTabBtn) {
    new bootstrap.Tab(ganttTabBtn).show();
  }
  
  // 간트차트 로드
  fetch("/project/gantt?prjctNo=" + prjctNo)
    .then(function(res) { return res.text(); })
    .then(function(html) {
      var ganttArea = document.getElementById("ganttChartArea");
      if (ganttArea) {
        ganttArea.innerHTML = html;
        
        // 스크립트 실행
        var scripts = ganttArea.querySelectorAll("script");
        scripts.forEach(function(oldScript) {
          var newScript = document.createElement("script");
          if (oldScript.src) {
            newScript.src = oldScript.src;
          } else {
            newScript.textContent = oldScript.textContent;
          }
          document.body.appendChild(newScript);
        });
      }
    })
    .catch(function(err) {
      console.error("간트차트 로드 실패:", err);
      var ganttArea = document.getElementById("ganttChartArea");
      if (ganttArea) {
        ganttArea.innerHTML = "<p class='text-danger'>간트차트를 불러오지 못했습니다.</p>";
      }
    });
}

// 페이지 로드 후 이벤트 리스너 설정
document.addEventListener('DOMContentLoaded', function() {
  // 검색 폼 제출 이벤트
  var searchForm = document.getElementById('searchForm');
  if (searchForm) {
    searchForm.addEventListener('submit', function(e) {
      e.preventDefault();
      loadPage(1);
    });
  }
  
  // 삭제 버튼 이벤트 리스너 (onclick 속성이 없는 요소를 위해)
  document.querySelectorAll('.delete-project-btn').forEach(function(btn) {
    if (!btn.hasAttribute('onclick')) {
      btn.addEventListener('click', function(e) {
        e.preventDefault();
        confirmDelete(e, this.getAttribute('data-project-id'));
      });
    }
  });
  
  // 페이지네이션 이벤트 리스너 (onclick 속성이 없는 요소를 위해)
  document.querySelectorAll('.page-link').forEach(function(link) {
    if (!link.hasAttribute('onclick') && link.getAttribute('data-page')) {
      link.addEventListener('click', function(e) {
        e.preventDefault();
        loadPage(parseInt(this.getAttribute('data-page')));
      });
    }
  });
  
  // 간트차트 링크 이벤트 리스너 (onclick 속성이 없는 요소를 위해)
  document.querySelectorAll('.gantt-tab-link').forEach(function(link) {
    if (!link.hasAttribute('onclick')) {
      link.addEventListener('click', function(e) {
        e.preventDefault();
        loadGanttChart(this.getAttribute('data-project-id'));
      });
    }
  });
  
  document.querySelector('a[onclick*="downloadExcel"]').addEventListener('click', function(e) {
	    e.preventDefault();
	    var keyword = document.getElementById("keywordInput") ? document.getElementById("keywordInput").value : '';
	    var encodedKeyword = encodeURIComponent(keyword);
	    
	    // 다운로드 URL 생성
	    var url = "/project/downloadExcel?keyword=" + encodedKeyword;
	    
	    // 다운로드 요청
	    window.location.href = url;
	  });
});

// 검색
document.getElementById("searchForm")?.addEventListener("submit", function(e) {
  e.preventDefault();
  loadPage(1);
});
</script>