<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<!-- 업무 추가 모달 -->
<div class="modal fade" id="taskAddModal" tabindex="-1" aria-labelledby="taskAddModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content shadow-lg">
      <form id="taskAddForm" method="POST" action="/projectTask/insert" enctype="multipart/form-data">
        <div class="modal-header bg-primary text-white">
          <h5 class="modal-title fw-bold" id="taskAddModalLabel"><i class="fas fa-plus-circle me-2"></i>업무 추가</h5>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="닫기"></button>
        </div>

        <div class="modal-body">
          <!-- 숨겨진 필드 -->
          <input type="hidden" name="prjctNo" value="${project.prjctNo}" />
          <input type="hidden" id="upperTaskNo" name="upperTaskNo" />

          <!-- 상위 업무 선택 -->
          <div class="mb-3">
            <label for="upperTaskSelect" class="form-label fw-semibold">상위 업무 (선택)</label>
            <select class="form-select" id="upperTaskSelect">
              <option value="">-- 상위 업무 없음 --</option>
              <c:forEach var="task" items="${project.taskList}">
                <c:if test="${empty task.upperTaskNo}">
                  <option value="${task.taskNo}">${task.taskNm}</option>
                </c:if>
              </c:forEach>
            </select>
          </div>

          <!-- 업무명 -->
          <div class="mb-3">
            <label for="taskNm" class="form-label fw-semibold">업무명</label>
            <input type="text" class="form-control" id="taskNm" name="taskNm" required placeholder="업무명을 입력하세요" />
          </div>

          <!-- 담당자 선택 -->
          <div class="mb-3">
            <label for="chargerEmpno" class="form-label fw-semibold">담당자</label>
            <select class="form-select" id="chargerEmpno" name="chargerEmpno" required>
              <option value="">담당자를 선택하세요</option>
              <c:forEach var="emp" items="${project.responsibleList}">
                <option value="${emp.prtcpntEmpno}">${emp.emplNm} (${emp.posNm})</option>
              </c:forEach>
              <c:forEach var="emp" items="${project.participantList}">
                <option value="${emp.prtcpntEmpno}">${emp.emplNm} (${emp.posNm})</option>
              </c:forEach>
              <c:forEach var="emp" items="${project.observerList}">
                <option value="${emp.prtcpntEmpno}">${emp.emplNm} (${emp.posNm})</option>
              </c:forEach>
            </select>
          </div>

          <!-- 기간 -->
          <div class="mb-3 row">
            <div class="col">
              <label for="taskBeginDt" class="form-label fw-semibold">시작일</label>
              <input type="date" class="form-control" id="taskBeginDt" name="taskBeginDt" />
            </div>
            <div class="col">
              <label for="taskEndDt" class="form-label fw-semibold">종료일</label>
              <input type="date" class="form-control" id="taskEndDt" name="taskEndDt" />
            </div>
          </div>

          <!-- 우선순위 및 등급 -->
          <div class="mb-3 row">
            <div class="col-6">
              <label for="priort" class="form-label fw-semibold">우선순위</label>
              <select class="form-select" id="priort" name="priort">
                <option value="">선택</option>
                <option value="00">낮음</option>
                <option value="01">보통</option>
                <option value="02">높음</option>
                <option value="03">긴급</option>
              </select>
            </div>
            <div class="col-6">
              <label for="taskGrad" class="form-label fw-semibold">업무 등급</label>
              <select class="form-select" id="taskGrad" name="taskGrad">
                <option value="">선택</option>
                <option value="A">A 등급</option>
                <option value="B">B 등급</option>
                <option value="C">C 등급</option>
                <option value="D">D 등급</option>
                <option value="E">E 등급</option>
              </select>
            </div>
          </div>

          <!-- 업무 설명 -->
          <div class="mb-3">
            <label for="taskCn" class="form-label fw-semibold">업무 설명</label>
            <textarea class="form-control" id="taskCn" name="taskCn" rows="3" placeholder="업무 내용을 입력하세요"></textarea>
          </div>

          <!-- 파일 업로드 -->
			<div class="mb-3">
			  <label for="uploadFilesField" class="form-label fw-semibold">첨부파일 (최대 5개)</label>
			  <input type="file" class="form-control" name="uploadFiles" id="uploadFilesField" multiple />
			  <ul class="list-group mt-2" id="fileNameList"></ul>
			</div>
        </div>

        <div class="modal-footer bg-light">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
          <button type="submit" class="btn btn-primary">등록</button>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
	  // 상위 업무 선택 시 hidden input에 반영
	  const upperTaskSelect = document.getElementById("upperTaskSelect");
	  const upperTaskNoInput = document.getElementById("upperTaskNo");
	  if (upperTaskSelect && upperTaskNoInput) {
	    upperTaskSelect.addEventListener("change", function () {
	      upperTaskNoInput.value = this.value;
	    });
	  }

	  // 파일 이름 리스트 표시
	  const uploadInput = document.getElementById("uploadFilesField");
	  if (uploadInput) {
	    uploadInput.addEventListener("change", function () {
	      const list = document.getElementById("fileNameList");
	      list.innerHTML = "";

	      Array.from(this.files).forEach(file => {
	        const li = document.createElement("li");
	        li.className = "list-group-item";
	        li.textContent = `\${file.name} (\${(file.size / 1024).toFixed(1)} KB)`;
	        list.appendChild(li);
	      });
	    });
	  }

	  // 업무 등록 폼 제출 처리
	  const taskAddForm = document.getElementById("taskAddForm");
	  if (taskAddForm) {
	    taskAddForm.addEventListener("submit", function (e) {
	      e.preventDefault();

	      const formData = new FormData(this);
	      const prjctNo = formData.get("prjctNo");

	      fetch("/projectTask/insert", {
	        method: "POST",
	        body: formData
	      })
	        .then(res => res.json())
	        .then(result => {
	          if (result.success || !isNaN(Number(result.taskNo))) {
	            swal("등록 완료!", "업무가 성공적으로 등록되었습니다.", "success")
	              .then(() => {
	                // 모달 닫기
	                const modal = bootstrap.Modal.getInstance(document.getElementById("taskAddModal"));
	                if (modal) modal.hide();

	                // 폼 초기화
	                taskAddForm.reset();
	                const list = document.getElementById("fileNameList");
	                if (list) list.innerHTML = "";

	                // 업무 목록 즉시 새로고침 (F5 없이)
	                if (typeof loadTaskList === "function") {
	                	console.log(" 업무 목록 갱신 시작");
	                  loadTaskList(prjctNo);
	                } else if (typeof refreshTaskList === "function") {
	                  refreshTaskList(); // 대체 함수 지원
	                }
	              });
	          } else {
	            swal("등록 실패", "업무 등록에 실패했습니다.", "error");
	          }
	        })
	        .catch(err => {
	          console.error("업무 등록 실패:", err);
	          swal("에러 발생", "업무 등록 중 오류가 발생했습니다.", "error");
	        });
	    });
	  }
	});

	
const taskAddModal = document.getElementById('taskAddModal');
if (taskAddModal) {
  taskAddModal.addEventListener('shown.bs.modal', function () {
    // 폼 초기화
    document.getElementById("taskAddForm").reset();
    document.getElementById("fileNameList").innerHTML = "";
    
    // 파일 입력 필드 재생성 (브라우저 캐시 방지)
    const fileInputContainer = document.querySelector('.mb-3 > #uploadFilesField').parentNode;
    const oldInput = document.getElementById("uploadFilesField");
    const newInput = document.createElement("input");
    newInput.type = "file";
    newInput.className = "form-control";
    newInput.name = "uploadFiles";
    newInput.id = "uploadFilesField";
    newInput.multiple = true;
    
    if (oldInput && fileInputContainer) {
      oldInput.parentNode.replaceChild(newInput, oldInput);
      
      // 이벤트 리스너 재설정
      newInput.addEventListener("change", function () {
        const list = document.getElementById("fileNameList");
        list.innerHTML = "";
        
        Array.from(this.files).forEach(file => {
          const li = document.createElement("li");
          li.className = "list-group-item";
          li.textContent = file.name + " (" + (file.size / 1024).toFixed(1) + " KB)";
          list.appendChild(li);
        });
      });
    }
  });
}

function loadTaskList(prjctNo) {
	  fetch(`/project/taskListPartial?prjctNo=\${prjctNo}`)
	    .then(res => res.text())
	    .then(html => {
	      document.getElementById("taskListContainer").innerHTML = html;
	    });
	}

	
</script>
