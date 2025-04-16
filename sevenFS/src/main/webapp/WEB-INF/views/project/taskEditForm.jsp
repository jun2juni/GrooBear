<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="title" scope="application" value="프로젝트 업무 수정" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>${title}</title>
  <%@ include file="../layout/prestyle.jsp" %>
  
</head>
<body>
<%@ include file="../layout/sidebar.jsp" %>
<main class="main-wrapper">
  <%@ include file="../layout/header.jsp" %>
  <section class="section">
    <div class="container-fluid">
      <div class="row">
        <!-- 좌측 업무 수정 -->
        <div class="col-md-8">
          <div class="card p-4">
            <h4 class="fw-bold mb-3"><i class="fas fa-edit me-2 text-primary"></i>업무 수정</h4>

            <form action="/projectTask/update" method="post" enctype="multipart/form-data">
              <input type="hidden" name="taskNo" value="${task.taskNo}" />
              <input type="hidden" name="prjctNo" value="${task.prjctNo}" />
              <input type="hidden" name="chargerEmpno" id="chargerEmpno" value="${task.chargerEmpno}" />
              <input type="hidden" name="atchFileNo" value="${task.atchFileNo}" />

				<c:if test="${not empty task.parentTaskNm}">
				  <div class="mb-3">
				    <label class="form-label fw-semibold">상위 업무</label>
				    <input type="text" class="form-control bg-light" value="${task.parentTaskNm}" readonly />
				  </div>
				</c:if>


              <div class="mb-3">
                <label class="form-label fw-semibold">업무명</label>
                <input type="text" name="taskNm" class="form-control" value="${task.taskNm}" required />
              </div>

              <div class="mb-3">
                <label class="form-label fw-semibold">담당자</label>
                <input type="text" class="form-control bg-light" id="chargerEmpNm" value="${task.chargerEmpNm}" readonly />
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
                    <option value="A" ${task.taskGrad == 'A' ? 'selected' : ''}>A</option>
                    <option value="B" ${task.taskGrad == 'B' ? 'selected' : ''}>B</option>
                    <option value="C" ${task.taskGrad == 'C' ? 'selected' : ''}>C</option>
                    <option value="D" ${task.taskGrad == 'D' ? 'selected' : ''}>D</option>
                    <option value="E" ${task.taskGrad == 'E' ? 'selected' : ''}>E</option>
                  </select>
                </div>
              </div>

              <div class="mb-3">
                <label class="form-label fw-semibold">업무 내용</label>
                <textarea name="taskCn" class="form-control" rows="4">${task.taskCn}</textarea>
              </div>

              <!-- 파일 업로드 -->
              <div class="mb-3">
                <label class="form-label fw-semibold">첨부파일 (최대 5개)</label>
                <input type="file" name="uploadFiles" class="form-control" multiple />
              </div>

              <!-- 기존 파일 리스트 -->
              <c:if test="${not empty task.attachFileList}">
                <ul class="list-group mt-2">
                  <c:forEach var="file" items="${task.attachFileList}">
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                      <span><i class="fas fa-file-alt me-2 text-primary"></i>${file.fileNm}</span>
                      <div>
                        <a href="/projectTask/download?fileName=${file.fileStrePath}" class="btn btn-sm btn-outline-success me-2">
                          <i class="fas fa-download"></i>
                        </a>
                        <label class="form-check-label text-danger small d-flex align-items-center">
                          <input type="checkbox" name="removeFileId" value="${file.fileSn}" class="form-check-input me-1" />
                          삭제
                        </label>
                      </div>
                    </li>
                  </c:forEach>
                </ul>
              </c:if>

              <!-- 버튼 -->
              <div class="text-end mt-4">
                <button type="submit" class="btn btn-primary">수정 완료</button>
                <a href="/project/projectDetail?prjctNo=${task.prjctNo}" class="btn btn-secondary">취소</a>
              </div>
            </form>
          </div>
        </div>

        <!-- 우측 담당자 선택 -->
        <div class="col-md-4">
          <div class="card p-3 bg-light">
            <h6 class="mb-3 text-primary"><i class="fas fa-user-check me-2"></i>참여자 중에서 담당자 선택</h6>

            <c:if test="${not empty project}">
              <div class="mb-3">
                <span class="badge btn-danger mb-2">책임자</span>
                <div class="d-flex flex-wrap gap-2 small">
                  <c:forEach var="emp" items="${project.responsibleList}">
                    <button type="button" class="btn btn-outline-danger btn-sm text-start text-dark"
                            onclick="selectCharger('${emp.prtcpntEmpno}', '${emp.emplNm}')">
                      ${emp.emplNm}<div class="text-muted small">${emp.posNm}</div>
                    </button>
                  </c:forEach>
                </div>
              </div>

              <div class="mb-3">
                <span class="badge btn-primary mb-2">참여자</span>
                <div class="d-flex flex-wrap gap-2 small">
                  <c:forEach var="emp" items="${project.participantList}">
                    <button type="button" class="btn btn-outline-primary btn-sm text-start text-dark"
                            onclick="selectCharger('${emp.prtcpntEmpno}', '${emp.emplNm}')">
                      ${emp.emplNm}<div class="text-muted small">${emp.posNm}</div>
                    </button>
                  </c:forEach>
                </div>
              </div>

              <div class="mb-3">
                <span class="badge btn-secondary mb-2">참조자</span>
                <div class="d-flex flex-wrap gap-2 small">
                  <c:forEach var="emp" items="${project.observerList}">
                    <button type="button" class="btn btn-outline-secondary btn-sm text-start text-dark"
                            onclick="selectCharger('${emp.prtcpntEmpno}', '${emp.emplNm}')">
                      ${emp.emplNm}<div class="text-muted small">${emp.posNm}</div>
                    </button>
                  </c:forEach>
                </div>
              </div>
            </c:if>
          </div>
        </div>
      </div>
    </div>
  </section>
  <%@ include file="../layout/footer.jsp" %>
</main>
<%@ include file="../layout/prescript.jsp" %>

<script>
  function selectCharger(empNo, empNm) {
    document.getElementById('chargerEmpno').value = empNo;
    document.getElementById('chargerEmpNm').value = empNm;
  }

</script>
</body>
</html>
