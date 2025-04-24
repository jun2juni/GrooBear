<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<div class="modal fade" id="taskAddModal" tabindex="-1" aria-labelledby="taskAddModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content shadow">
      <form id="taskAddForm" enctype="multipart/form-data">
        <div class="modal-header bg-primary text-white">
          <h5 class="modal-title" id="taskAddModalLabel">
            <i class="fas fa-plus-circle me-2"></i>업무 추가 (간트용)
          </h5>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
        </div>

        <div class="modal-body">
          <input type="hidden" name="prjctNo" value="${project.prjctNo}" />

          <!-- 상위 업무 -->
          <div class="mb-3">
            <label class="form-label fw-semibold">상위 업무 (선택)</label>
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
            <label class="form-label fw-semibold">업무명</label>
            <input type="text" name="taskNm" class="form-control" required />
          </div>

          <div class="mb-3">
            <label class="form-label fw-semibold">담당자</label>
            <select name="chargerEmpno" class="form-select" required>
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
              <label class="form-label fw-semibold">시작일</label>
              <input type="date" name="taskBeginDt" class="form-control" />
            </div>
            <div class="col">
              <label class="form-label fw-semibold">종료일</label>
              <input type="date" name="taskEndDt" class="form-control" />
            </div>
          </div>

          <div class="mb-3 row">
            <div class="col">
              <label class="form-label fw-semibold">우선순위</label>
              <select name="priort" class="form-select">
                <option value="">선택</option>
                <option value="00">낮음</option>
                <option value="01">보통</option>
                <option value="02">높음</option>
                <option value="03">긴급</option>
              </select>
            </div>
            <div class="col">
              <label class="form-label fw-semibold">등급</label>
              <select name="taskGrad" class="form-select">
                <option value="">선택</option>
                <option value="A">A등급</option>
                <option value="B">B등급</option>
                <option value="C">C등급</option>
                <option value="D">D등급</option>
                <option value="E">E등급</option>
              </select>
            </div>
          </div>

          <div class="mb-3">
            <label class="form-label fw-semibold">업무 설명</label>
            <textarea name="taskCn" class="form-control" rows="3"></textarea>
          </div>

          <div class="mb-3">
            <label class="form-label fw-semibold">첨부파일</label>
            <input type="file" name="uploadFiles" class="form-control" multiple />
          </div>
        </div>

        <div class="modal-footer bg-light">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
          <button type="button" class="btn btn-primary btn-save">등록</button>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
function bindTaskAddModalEvents() {
  const form = document.getElementById("taskAddForm");
  const saveBtn = form.querySelector(".btn-save");

  if (!form || !saveBtn) return;

  saveBtn.addEventListener("click", function () {
    const formData = new FormData(form);
    formData.append("source", "gantt");

    fetch("/projectTask/insert", {
      method: "POST",
      body: formData
    })
    .then(res => res.json())
    .then(result => {
      if (result.success || !isNaN(Number(result.taskNo))) {
        swal("등록 완료", "업무가 성공적으로 등록되었습니다.", "success");
        bootstrap.Modal.getInstance(document.getElementById("taskAddModal")).hide();
        loadGanttData();
      } else {
        swal("등록 실패", "업무 등록에 실패했습니다.", "error");
      }
    })
    .catch(err => {
      console.error("등록 오류:", err);
      swal("오류", "업무 등록 중 오류 발생", "error");
    });
  });
}
</script>
