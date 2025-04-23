<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" %>

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
          <input type="hidden" name="prjctNo" value="${project.prjctNo}" />

          <div class="mb-3">
            <label for="upperTaskSelect" class="form-label fw-semibold">상위 업무 (선택)</label>
            <select class="form-select" id="upperTaskSelect" name="upperTaskNo">
              <option value="">-- 상위 업무 없음 --</option>
              <c:forEach var="task" items="${project.taskList}">
                <c:if test="${empty task.upperTaskNo}">
                  <option value="${task.taskNo}">${task.taskNm}</option>
                </c:if>
              </c:forEach>
            </select>
          </div>

          <div class="mb-3">
            <label for="taskNm" class="form-label fw-semibold">업무명</label>
            <input type="text" class="form-control" id="taskNm" name="taskNm" required placeholder="업무명을 입력하세요" />
          </div>

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

          <div class="mb-3">
            <label for="taskCn" class="form-label fw-semibold">업무 설명</label>
            <textarea class="form-control" id="taskCn" name="taskCn" rows="3" placeholder="업무 내용을 입력하세요"></textarea>
          </div>

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
  const taskAddForm = document.getElementById("taskAddForm");
  if (taskAddForm) {
    taskAddForm.addEventListener("submit", function (e) {
      e.preventDefault();
      const formData = new FormData(this);
      formData.append("source", "gantt");

      fetch("/projectTask/insert", {
        method: "POST",
        body: formData
      })
      .then(res => res.json())
      .then(result => {
        if (result.success) {
          swal("등록 완료", "업무가 성공적으로 등록되었습니다.", "success");
          bootstrap.Modal.getInstance(document.getElementById("taskAddModal")).hide();
          this.reset();
          document.getElementById("fileNameList").innerHTML = "";
          if (typeof loadGanttData === "function") {
            loadGanttData();
          }
        } else {
          swal("등록 실패", result.message || "업무 등록에 실패했습니다.", "error");
        }
      })
      .catch(err => {
        console.error("업무 등록 실패:", err);
        swal("오류", "업무 등록 중 오류가 발생했습니다.", "error");
      });
    });
  }
});
</script>
