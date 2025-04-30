<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<!-- 업무 수정 모달 -->
<div class="modal fade" id="taskEditModal" tabindex="-1" aria-labelledby="taskEditModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content">
      <form id="taskEditForm" method="post" enctype="multipart/form-data" action="/projectTask/update">
        <div class="modal-header bg-primary text-white">
          <h5 class="modal-title" id="taskEditModalLabel"><i class="fas fa-edit me-2"></i>업무 수정</h5>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="닫기"></button>
        </div>
        <div class="modal-body">

          <input type="hidden" name="taskNo" value="${task.taskNo}" />
          <input type="hidden" name="prjctNo" value="${task.prjctNo}" />
          <input type="hidden" name="atchFileNo" value="${task.atchFileNo}" />
          <input type="hidden" name="source" value="gantt" />
          
          <!-- 중요: 상위 업무 ID 추가 -->
          <input type="hidden" name="upperTaskNo" value="${task.upperTaskNo}" />
          

          <c:if test="${not empty task.parentTaskNm}">
            <div class="mb-2">
              <label class="form-label fw-semibold text-muted">상위 업무</label>
              <div class="form-control bg-light">${task.parentTaskNm}</div>
            </div>
          </c:if>

          <div class="mb-3">
            <label class="form-label fw-semibold">업무명</label>
            <input type="text" name="taskNm" class="form-control" value="${task.taskNm}" required />
          </div>

          <div class="mb-3">
            <label class="form-label fw-semibold">담당자</label>
            <select name="chargerEmpno" class="form-select">
<c:forEach var="emp" items="${project.responsibleList}">
  <option value="${emp.prtcpntEmpno}" ${emp.prtcpntEmpno == task.chargerEmpno ? 'selected' : ''}>${emp.emplNm} (${emp.posNm})</option>
</c:forEach>
<c:forEach var="emp" items="${project.participantList}">
  <option value="${emp.prtcpntEmpno}" ${emp.prtcpntEmpno == task.chargerEmpno ? 'selected' : ''}>${emp.emplNm} (${emp.posNm})</option>
</c:forEach>
<c:forEach var="emp" items="${project.observerList}">
  <option value="${emp.prtcpntEmpno}" ${emp.prtcpntEmpno == task.chargerEmpno ? 'selected' : ''}>${emp.emplNm} (${emp.posNm})</option>
</c:forEach>
            </select>
          </div>

          <div class="row mb-3">
            <div class="col">
              <label class="form-label fw-semibold">시작일</label>
              <input type="date" name="taskBeginDt" class="form-control"
                     value="<fmt:formatDate value='${task.taskBeginDt}' pattern='yyyy-MM-dd'/>" />
            </div>
            <div class="col">
              <label class="form-label fw-semibold">종료일</label>
              <input type="date" name="taskEndDt" class="form-control"
                     value="<fmt:formatDate value='${task.taskEndDt}' pattern='yyyy-MM-dd'/>" />
            </div>
          </div>

          <div class="row mb-3">
            <div class="col-md-6">
              <label class="form-label fw-semibold">중요도</label>
              <select name="priort" class="form-select">
                <option value="00" ${task.priort == '00' ? 'selected' : ''}>낮음</option>
                <option value="01" ${task.priort == '01' ? 'selected' : ''}>보통</option>
                <option value="02" ${task.priort == '02' ? 'selected' : ''}>높음</option>
                <option value="03" ${task.priort == '03' ? 'selected' : ''}>긴급</option>
              </select>
            </div>
            <div class="col-md-6">
              <label class="form-label fw-semibold">업무 등급</label>
              <select name="taskGrad" class="form-select">
                <option value="A" ${task.taskGrad == 'A' ? 'selected' : ''}>A등급</option>
                <option value="B" ${task.taskGrad == 'B' ? 'selected' : ''}>B등급</option>
                <option value="C" ${task.taskGrad == 'C' ? 'selected' : ''}>C등급</option>
                <option value="D" ${task.taskGrad == 'D' ? 'selected' : ''}>D등급</option>
                <option value="E" ${task.taskGrad == 'E' ? 'selected' : ''}>E등급</option>
              </select>
            </div>
          </div>

          <div class="row mb-3">
            <div class="col-md-6">
              <label class="form-label fw-semibold">진행률 (%)</label>
              <input type="number" name="progrsrt" min="0" max="100" class="form-control" value="${task.progrsrt}" />
            </div>
            <div class="col-md-6">
              <label class="form-label fw-semibold">업무 상태</label>
              <select name="taskSttus" class="form-select">
                <option value="00" ${task.taskSttus == '00' ? 'selected' : ''}>대기</option>
                <option value="01" ${task.taskSttus == '01' ? 'selected' : ''}>진행중</option>
                <option value="02" ${task.taskSttus == '02' ? 'selected' : ''}>완료</option>
              </select>
            </div>
          </div>

          <div class="mb-3">
            <label class="form-label fw-semibold">업무 내용</label>
            <textarea name="taskCn" class="form-control" rows="4">${task.taskCn}</textarea>
          </div>

          <div class="mb-3">
            <label class="form-label fw-semibold">첨부파일</label>
            <input type="file" name="uploadFiles[]" class="form-control" multiple />
          </div>

          <c:if test="${not empty task.attachFileList}">
            <ul class="list-group">
              <c:forEach var="file" items="${task.attachFileList}">
                <li class="list-group-item d-flex justify-content-between align-items-center">
                  <span>${file.fileNm}</span>
                  <label class="form-check-label text-danger small">
                    <input type="checkbox" name="removeFileId" value="${file.fileSn}" class="form-check-input me-1" />
                    삭제
                  </label>
                </li>
              </c:forEach>
            </ul>
          </c:if>

        </div>
        <div class="modal-footer">
          <button type="button" id="submitEditTaskBtn" class="btn btn-primary">수정 완료</button>
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
let isHandlerAttached = false;

function setupModalHandler() {
  if (isHandlerAttached) return;

  const submitBtn = document.getElementById("submitEditTaskBtn");
  if (!submitBtn) {
    console.error(" 수정 버튼 없음");
    return;
  }

  submitBtn.addEventListener("click", function () {
    console.log(" 수정 완료 버튼 클릭됨");

    const form = document.getElementById("taskEditForm");
    const formData = new FormData(form);

    fetch("/projectTask/updateAjax", {
      method: "POST",
      body: formData
    })
    .then(res => {
      if (!res.ok) throw new Error("서버 오류: " + res.status);
      return res.text();
    })
    .then(() => {
      const modal = bootstrap.Modal.getInstance(document.getElementById("taskEditModal"));
      if (modal) modal.hide();
      if (typeof loadGanttData === "function") loadGanttData();

      swal("수정 완료!", "업무가 성공적으로 수정되었습니다.", "success");
    })
    .catch(err => {
      console.error(" 업무 수정 실패:", err);
      swal("수정 실패", "오류가 발생했습니다.\n" + err.message, "error");
    });

  });

  isHandlerAttached = true;
  console.log(" 수정 핸들러 연결 완료");
}

// 모달이 로드되면 자동 실행
setupModalHandler();
</script>
