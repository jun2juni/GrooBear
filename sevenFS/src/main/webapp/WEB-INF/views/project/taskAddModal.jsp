<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<!-- 업무 추가 모달 -->
<div class="modal fade" id="taskAddModal" tabindex="-1" aria-labelledby="taskAddModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content shadow-lg">
      <form id="taskAddForm" enctype="multipart/form-data">
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
            <input type="text" class="form-control" id="taskNm" name="taskNm" placeholder="업무명을 입력하세요" required />
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

          <!-- 우선순위 / 등급 -->
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

          <!-- 첨부파일 -->
          <div class="mb-3">
            <label for="uploadFiles" class="form-label fw-semibold">첨부파일</label>
            <input class="form-control" type="file" name="uploadFiles" id="uploadFiles" multiple />
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
  // 파일명 리스트 출력
  document.getElementById("uploadFiles").addEventListener("change", function () {
    const list = document.getElementById("fileNameList");
    list.innerHTML = "";
    Array.from(this.files).forEach(file => {
      const li = document.createElement("li");
      li.className = "list-group-item";
      li.textContent = file.name;
      list.appendChild(li);
    });
  });

  // 상위 업무 셀렉트 변경 → hidden input에 값 반영
  document.getElementById("upperTaskSelect").addEventListener("change", function () {
    document.getElementById("upperTaskNo").value = this.value;
  });

  // 업무 등록
  document.getElementById("taskAddForm").addEventListener("submit", function (e) {
    e.preventDefault();
    const formData = new FormData(this);

    fetch("/projectTask/insert", {
      method: "POST",
      body: formData
    })
    .then(res => res.text())
    .then(result => {
      if (result.includes("success") || !isNaN(Number(result))) {
        // 업무 등록 성공 처리
        alert("업무가 성공적으로 등록되었습니다.");

        const modalEl = document.getElementById("taskAddModal");
        let modal = bootstrap.Modal.getInstance(modalEl);
        if (!modal) modal = new bootstrap.Modal(modalEl);
        modal.hide();

        this.reset();
        document.getElementById("fileNameList").innerHTML = "";

        if (typeof refreshTaskList === 'function') {
          refreshTaskList();
        }

      } else {
        alert("업무 등록에 실패했습니다. 서버 응답: " + result);
      }
    })
    .catch(err => {
      console.error("업무 등록 실패:", err);
      alert("업무 등록 중 오류가 발생했습니다.");
    });
  });
});
</script>
