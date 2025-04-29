<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="title" scope="application" value="프로젝트 상세" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <title>${title}</title>
  <%@ include file="../layout/prestyle.jsp" %>
<script>
   const loginUserEmplNo = "${myEmpInfo.emplNo}";
</script>
  <style type="text/css">
    
    /* 1. 업무명 컬럼 너비 조정 */
    .task-name-col { 
      width: 30%; 
      min-width: 250px; 
      max-width: 30%;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }
    
    /* 4. 참여인원 호버 효과 제거 */
.participant-btn {
  pointer-events: none;
}

  </style>
</head>
<body>
<%@ include file="../layout/sidebar.jsp" %>

<c:if test="${not empty message}">
  <script>
    document.addEventListener('DOMContentLoaded', function() {
      swal("알림", "${message}", "${fn:contains(message, '실패') ? 'error' : 'success'}");
    });
  </script>
</c:if>
<main class="main-wrapper">
  <%@ include file="../layout/header.jsp" %>
  <section class="section">
    <div class="container-fluid">
      <div class="card bg-white border-0 shadow-sm p-4">
        <div class="row">
          <div class="col-md-12">
            <div class="form-step">
              <div class="row">
                <div class="col-12">
                  <div class="card border p-4">
                    <div class="d-flex justify-content-between align-items-center">
                      <h4 class="fw-bold mb-3">
                        <i class="fas fa-folder-open me-2 text-primary"></i>프로젝트 상세
                      </h4>
                      <span class="text-muted">프로젝트 번호: ${project.prjctNo}</span>
                    </div>
					
					<div class="row mt-4">
					  <div class="col-6">
						<!-- 1. 기본 정보 -->
						<h5 class="fw-semibold mb-2">1. 기본 정보</h5>
						<table class="table table-bordered mt-2">
						  <tbody>
						  <tr>
							<th class="bg-light w-25 text-center">프로젝트명</th>
							<td class="ps-3 pe-3">${project.prjctNm}</td>
						  </tr>
						  <tr>
							<th class="bg-light text-center">카테고리</th>
							<td class="ps-3 pe-3">${project.ctgryNm}</td>
						  </tr>
						  <tr>
							<th class="bg-light text-center">내용</th>
							<td class="ps-3 pe-3">${project.prjctCn}</td>
						  </tr>
						  <tr>
							<th class="bg-light text-center">기간</th>
							<td class="ps-3 pe-3">${project.prjctBeginDateFormatted} ~ ${project.prjctEndDateFormatted}</td>
						  </tr>
						  <tr>
							<th class="bg-light text-center">상태</th>
							<td class="ps-3 pe-3"><span
								class="badge bg-info text-dark px-2 py-1">${project.prjctSttusNm}</span></td>
						  </tr>
						  <tr>
							<th class="bg-light text-center">등급</th>
							<td class="ps-3 pe-3"><span
								class="badge bg-warning text-dark px-2 py-1">${project.prjctGrad}</span></td>
						  </tr>
						  <tr>
							<th class="bg-light text-center">수주 금액</th>
							<td class="ps-3 pe-3"><fmt:formatNumber value="${project.prjctRcvordAmount}" type="number"
															   groupingUsed="true" /> 원
							</td>
						  </tr>
						  <tr>
							<th class="bg-light text-center">주소</th>
							<td class="ps-3">${project.prjctAdres}</td>
						  </tr>
						  <tr>
							<th class="bg-light text-center">URL</th>
							<td class="ps-3"><a href="${project.prjctUrl}" target="_blank">${project.prjctUrl}</a></td>
						  </tr>
						  </tbody>
						</table>
					  </div>
					  
					  <div class="col-6">
						<!-- 참여 인원 -->
						<h5 class="fw-semibold mb-2">2. 참여 인원</h5>
						<div class="mb-4">
						  <div class="row g-3">
							<div class="col-md-12">
							  <div class="border-top pt-3">
           				   <span class="badge bg-danger text-white mb-2 px-2 py-1">
           					 <i class="fas fa-user-tie me-1"></i> 책임자
           				   </span>
								<div class="d-flex flex-wrap gap-2 small text-muted">
								  <c:forEach var="emp" items="${project.responsibleList}">
									<!-- 4. 호버 효과 제거 -->
									<div class="participant-btn btn btn-outline-danger rounded-3 text-start shadow-sm"
										 style="min-width: 120px; font-size: 0.85rem; border-width: 1px;">
									  <i class="fas fa-user-tie me-1"></i> ${emp.emplNm}
									  <div class="text-muted small">${emp.posNm}</div>
									</div>
								  </c:forEach>
								</div>
							  </div>
							</div>
							<div class="col-md-12">
							  <div class="border-top pt-3">
           				   <span class="badge bg-primary text-white mb-2 px-2 py-1">
           					 <i class="fas fa-user-check me-1"></i> 참여자
           				   </span>
								<div class="d-flex flex-wrap gap-2 small text-muted">
								  <c:forEach var="emp" items="${project.participantList}">
									<!-- 4. 호버 효과 제거 -->
									<div class="participant-btn btn btn-outline-primary rounded-3 text-start shadow-sm"
										 style="min-width: 120px; font-size: 0.85rem; border-width: 1px;">
									  <i class="fas fa-user-check me-1"></i> ${emp.emplNm}
									  <div class="text-muted small">${emp.posNm}</div>
									</div>
								  </c:forEach>
								</div>
							  </div>
							</div>
							<div class="col-md-12">
							  <div class="border-top pt-3">
           				   <span class="badge bg-secondary text-white mb-2 px-2 py-1">
           					 <i class="fas fa-user-clock me-1"></i> 참조자
           				   </span>
								<div class="d-flex flex-wrap gap-2 small text-muted">
								  <c:forEach var="emp" items="${project.observerList}">
									<!-- 4. 호버 효과 제거 -->
									<div
										class="participant-btn btn btn-outline-secondary rounded-3 text-start shadow-sm"
										style="min-width: 120px; font-size: 0.85rem; border-width: 1px;">
									  <i class="fas fa-user-clock me-1"></i> ${emp.emplNm}
									  <div class="text-muted small">${emp.posNm}</div>
									</div>
								  </c:forEach>
								</div>
							  </div>
							</div>
						  </div>
						</div>
					  </div>
					</div>
		 	 
            <!-- 3. 등록된 업무 -->
            <h5 class="mt-5 fw-semibold mb-2 d-flex justify-content-between align-items-center">
			  3. 등록된 업무
			  <button type="button" class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#taskAddModal">
			    <i class="fas fa-plus me-1"></i> 업무 추가
			  </button>
			</h5>
			<div id="taskListSection"></div>
			
 
			<!-- 업무 상세 모달 -->
			<div class="modal fade" id="taskDetailModal" tabindex="-1" aria-labelledby="taskDetailLabel" aria-hidden="true">
			  <div class="modal-dialog modal-lg">
			    <div class="modal-content">
			      
			      <div class="modal-header">
			        <h5 class="modal-title" id="taskDetailLabel">업무 상세 정보</h5>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      
			      <div class="modal-body">
			        <div id="taskDetailContent">로딩 중...</div>
			      </div>
			      
			      <div class="modal-footer justify-content-between">
			        <!-- 왼쪽: 닫기 -->
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
			
			        <div>
			          <!-- 가운데: 수정 -->
			          <button type="button" class="btn btn-outline-warning me-2" onclick="editTask()">수정하기</button>
			          <!-- 오른쪽: 삭제 -->
			          <button type="button" class="btn btn-danger" onclick="deleteTask()">삭제하기</button>
			        </div>
			      </div>
			      
			    </div>
			  </div>
			</div>

          </div>
            <div class="d-flex justify-content-end m-3">
              <button class="btn btn-outline-danger me-2" onclick="deleteCurrentProject(${project.prjctNo})">
                <i class="fas fa-trash-alt"></i> 삭제
              </button>
              <a href="/project/editForm?prjctNo=${project.prjctNo}" class="btn btn-warning me-2">수정</a>
               <a href="/project/tab?tab=list" class="btn btn-secondary">목록</a>
            </div>
        </div>
      </div>
    </div>
  </div>
  
</div>
</div>
</div>
    <%@ include file="taskAddModal.jsp" %>
	</section>
  <%@ include file="../layout/footer.jsp" %>
</main>
<%@ include file="../layout/prescript.jsp" %>

<script>
document.addEventListener("DOMContentLoaded", function () {
	  refreshTaskList();
	});

	function refreshTaskList() {
	  const prjctNo = "${project.prjctNo}";

	  fetch(`/projectTask/partialList?prjctNo=\${prjctNo}`)
	    .then(res => res.text())
	    .then(html => {
	      const container = document.getElementById("taskListSection");
	      if (container) {
	        container.innerHTML = html;
	      }
	    })
	    .catch(err => {
	      console.error("업무 목록 갱신 실패:", err);
	      alert("업무 목록을 불러오지 못했습니다.");
	    });
	}

	function openTaskModal(taskNo) {
	  const modal = new bootstrap.Modal(document.getElementById('taskDetailModal'));
	  const contentEl = document.getElementById('taskDetailContent');
	  contentEl.innerHTML = '로딩 중...';

	  fetch(`/projectTask/detail?taskNo=\${taskNo}`)
	    .then(res => res.text())
	    .then(html => {
	      contentEl.innerHTML = html;
	      modal.show();
	    })
	    .catch(() => {
	      contentEl.innerHTML = '업무 상세 정보를 불러오지 못했습니다.';
	    });
	}

	function editTask() {
	  const taskDetailEl = document.querySelector('#taskDetailContent [data-task-no]');
	  if (!taskDetailEl) {
	    alert("업무 정보가 없습니다.");
	    return;
	  }
	  const taskNo = taskDetailEl.getAttribute('data-task-no');
	  location.href = `/projectTask/editForm?taskNo=\${taskNo}`;
	}
	
	function deleteCurrentProject(prjctNo) {
		  swal({
		    title: "정말 삭제하시겠습니까?",
		    text: "삭제하면 복구할 수 없습니다!",
		    icon: "warning",
		    buttons: ["취소", "삭제"],
		    dangerMode: true,
		  })
		  .then((willDelete) => {
		    if (willDelete) {
		      fetch(`/project/delete/\${prjctNo}`, {
		        method: 'DELETE',
		        headers: {
		          'Accept': 'application/json'
		        }
		      })
		      .then(res => {
		        if (!res.ok) throw new Error("삭제 실패: 상태코드 " + res.status);
		        swal("삭제 완료!", "프로젝트가 성공적으로 삭제되었습니다.", "success")
		          .then(() => {
		            location.href = "/project/tab?tab=list";
		          });
		      })
		      .catch(err => {
		        console.error("삭제 실패 에러:", err);
		        swal("삭제 실패!", "프로젝트 삭제 중 오류가 발생했습니다.", "error");
		      });
		    }
		  });
		}

	
	
	function deleteTask() {
		  const taskDetailEl = document.querySelector('#taskDetailContent [data-task-no]');
		  if (!taskDetailEl) {
		    swal("오류", "업무 정보가 없습니다.", "error");
		    return;
		  }

		  const taskNo = taskDetailEl.getAttribute('data-task-no');
		  const prjctNo = "${project.prjctNo}";

		  // 하위 업무 존재 여부 확인
		  fetch(`/projectTask/hasChildTasks?taskNo=\${taskNo}`)
		    .then(res => res.json())
		    .then(data => {
		      if (data.hasChildren) {
		        swal("삭제 불가", "하위 업무가 있는 업무는 삭제할 수 없습니다.\n먼저 하위 업무를 삭제해주세요.", "warning");
		      } else {
		        swal({
		          title: "업무 삭제",
		          text: "정말 이 업무를 삭제하시겠습니까?\n삭제 후에는 복구할 수 없습니다.",
		          icon: "warning",
		          buttons: ["취소", "삭제"],
		          dangerMode: true
		        }).then((willDelete) => {
		          if (willDelete) {
		            location.href = `/projectTask/delete?taskNo=\${taskNo}&prjctNo=\${prjctNo}`;
		          }
		        });
		      }
		    })
		    .catch(err => {
		      console.error("확인 실패:", err);
		      swal("오류", "업무 확인 중 오류가 발생했습니다.", "error");
		    });
		}

	
	// 프로젝트 상세 페이지 JS에 추가할 코드 (페이지네이션 함수)
	// project/projectDetail.jsp 파일의 기존 script 태그 내부에 추가

	// 페이지네이션 함수 추가
	function goToTaskPage(page) {
	  const prjctNo = "${project.prjctNo}";
	  
	  fetch(`/projectTask/partialList?prjctNo=\${prjctNo}&page=\${page}`)
	    .then(res => res.text())
	    .then(html => {
	      document.getElementById("taskListSection").innerHTML = html;
	      
	      // 스크롤을 테이블 맨 위로 이동
	      document.getElementById("taskListSection").scrollIntoView({
	        behavior: "smooth",
	        block: "start"
	      });
	    })
	    .catch(err => {
	      console.error("업무 목록 페이지 로드 실패:", err);
	      alert("업무 목록을 불러오는데 실패했습니다.");
	    });
	}
	
	</script>
	<script src="/js/project/taskAnswer.js"></script>
		
	</body>
</html>