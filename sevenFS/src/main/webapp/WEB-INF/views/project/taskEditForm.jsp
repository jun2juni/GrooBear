<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="프로젝트 업무 수정" />

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
 	<meta name="viewport"
		  content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"/>
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

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container mt-4">
  <div class="row">
    <!-- 왼쪽 8칸 -->
    <div class="col-md-8">
      <div class="card p-4">
        <h4 class="fw-bold mb-3"><i class="fas fa-edit me-2 text-primary"></i>업무 수정</h4>
        <form action="/projectTask/update" method="post" enctype="multipart/form-data">
          <input type="hidden" name="taskNo" value="${task.taskNo}" />
          <input type="hidden" name="prjctNo" value="${task.prjctNo}" />
          <input type="hidden" id="chargerEmpno" name="chargerEmpno" value="${task.chargerEmpno}" />

          <div class="mb-3">
            <label for="taskNm" class="form-label fw-semibold">업무명</label>
            <input type="text" class="form-control" id="taskNm" name="taskNm" value="${task.taskNm}" required>
          </div>

          <div class="mb-3">
            <label class="form-label fw-semibold">담당자</label>
            <input type="text" class="form-control" id="chargerEmpNm" value="${task.chargerEmpNm}" readonly>
          </div>

          <div class="row mb-3">
            <div class="col">
              <label for="taskBeginDt" class="form-label fw-semibold">시작일</label>
              <input type="date" class="form-control" id="taskBeginDt" name="taskBeginDt"
                     value="<fmt:formatDate value='${task.taskBeginDt}' pattern='yyyy-MM-dd'/>">
            </div>
            <div class="col">
              <label for="taskEndDt" class="form-label fw-semibold">종료일</label>
              <input type="date" class="form-control" id="taskEndDt" name="taskEndDt"
                     value="<fmt:formatDate value='${task.taskEndDt}' pattern='yyyy-MM-dd'/>">
            </div>
          </div>

			<div class="row mb-3">
			  <div class="col-md-6">
			    <label for="priort" class="form-label fw-semibold">중요도</label>
			    <select class="form-select" name="priort" id="priort">
			      <option value="00" ${task.priort == '00' ? 'selected' : ''}>낮음</option>
			      <option value="01" ${task.priort == '01' ? 'selected' : ''}>보통</option>
			      <option value="02" ${task.priort == '02' ? 'selected' : ''}>높음</option>
			      <option value="03" ${task.priort == '03' ? 'selected' : ''}>긴급</option>
			    </select>
			  </div>
			  <div class="col-md-6">
			    <label for="taskGrad" class="form-label fw-semibold">업무 등급</label>
			    <select class="form-select" name="taskGrad" id="taskGrad">
			      <option value="A" ${task.taskGrad == 'A' ? 'selected' : ''}>A</option>
			      <option value="B" ${task.taskGrad == 'B' ? 'selected' : ''}>B</option>
			      <option value="C" ${task.taskGrad == 'C' ? 'selected' : ''}>C</option>
			      <option value="D" ${task.taskGrad == 'D' ? 'selected' : ''}>D</option>
			      <option value="E" ${task.taskGrad == 'E' ? 'selected' : ''}>E</option>
			    </select>
			  </div>
			</div>


          <div class="mb-3">
            <label for="taskCn" class="form-label fw-semibold">업무 내용</label>
            <textarea class="form-control" id="taskCn" name="taskCn" rows="4">${task.taskCn}</textarea>
          </div>
          
          
			<div class="mb-3">
			  <label class="form-label fw-semibold">첨부 파일</label>
			  <input type="file" class="form-control" name="uploadFiles" id="uploadFiles" multiple />
			
			  <c:if test="${not empty task.attachFileList}">
			    <ul class="list-group mt-2">
			      <c:forEach var="file" items="${task.attachFileList}">
			        <li class="list-group-item d-flex justify-content-between align-items-center">
			          <span><i class="fas fa-file-alt me-2 text-primary"></i>${file.fileNm}</span>
			          <div class="d-flex gap-2 align-items-center">
			            <a href="/file/download/${file.fileStrePath}" class="btn btn-sm btn-outline-success">
			              <i class="fas fa-download"></i>
			            </a>
			            <label class="form-check-label text-muted small">
			              <input type="checkbox" name="removeFileId" value="${file.fileSn}" class="form-check-input me-1">
			              삭제
			            </label>
			          </div>
			        </li>
			      </c:forEach>
			    </ul>
			  </c:if>
			</div>

          
          

          <div class="text-end">
            <button type="submit" class="btn btn-primary">저장</button>
            <a href="/project/projectDetail?prjctNo=${task.prjctNo}" class="btn btn-secondary">취소</a>
          </div>
        </form>
      </div>
    </div>

    <!-- 오른쪽 4칸 -->
<!-- 오른쪽 4칸 - 담당자 선택 -->
<div class="col-md-4">
  <div class="card p-3 bg-light">
    <h6 class="mb-3 text-primary"><i class="fas fa-user-check me-2"></i>참여자 중에서 담당자 선택</h6>

    <!-- 선택된 담당자 표시 -->
    <div class="mb-3">
      <label class="form-label fw-semibold">담당자</label>
      <input type="text" class="form-control" id="chargerEmpNm" name="chargerEmpNm" value="${task.chargerEmpNm}" readonly />
      <input type="hidden" id="chargerEmpno" name="chargerEmpno" value="${task.chargerEmpno}" />
    </div>

    <!-- 책임자 리스트 -->
    <div class="mb-3">
      <span class="badge btn-danger mb-2 px-2 py-1"><i class="fas fa-user-tie me-1"></i> 책임자</span>
      <div class="d-flex flex-wrap gap-2 small text-muted">
        <c:forEach var="emp" items="${project.responsibleList}">
          <button type="button" class="btn btn-outline-danger rounded-3 text-start shadow-sm text-dark"
                  style="min-width: 120px; font-size: 0.85rem; border-width: 1px;"
                  onclick="selectCharger('${emp.emplNo}', '${emp.emplNm}')">
            <i class="fas fa-user-tie me-1"></i> ${emp.emplNm}
            <div class="text-muted small">${emp.posNm}</div>
          </button>
        </c:forEach>
      </div>
    </div>

    <!-- 참여자 리스트 -->
    <div class="mb-3">
      <span class="badge btn-primary mb-2 px-2 py-1"><i class="fas fa-user-check me-1"></i> 참여자</span>
      <div class="d-flex flex-wrap gap-2 small text-muted">
        <c:forEach var="emp" items="${project.participantList}">
          <button type="button" class="btn btn-outline-primary rounded-3 text-start shadow-sm text-dark"
                  style="min-width: 120px; font-size: 0.85rem; border-width: 1px;"
                  onclick="selectCharger('${emp.emplNo}', '${emp.emplNm}')">
            <i class="fas fa-user-check me-1"></i> ${emp.emplNm}
            <div class="text-muted small">${emp.posNm}</div>
          </button>
        </c:forEach>
      </div>
    </div>

    <!-- 참조자 리스트 -->
    <div class="mb-3">
      <span class="badge btn-secondary mb-2 px-2 py-1"><i class="fas fa-user-clock me-1"></i> 참조자</span>
      <div class="d-flex flex-wrap gap-2 small text-muted">
        <c:forEach var="emp" items="${project.observerList}">
          <button type="button" class="btn btn-outline-secondary rounded-3 text-start shadow-sm text-dark"
                  style="min-width: 120px; font-size: 0.85rem; border-width: 1px;"
                  onclick="selectCharger('${emp.emplNo}', '${emp.emplNm}')">
            <i class="fas fa-user-clock me-1"></i> ${emp.emplNm}
            <div class="text-muted small">${emp.posNm}</div>
          </button>
        </c:forEach>
      </div> 
    </div>
  </div>
</div>

<script>
  function selectCharger(empNo, empNm) {
    document.getElementById('chargerEmpno').value = empNo;
    document.getElementById('chargerEmpNm').value = empNm;
  }
</script>


	 
		</div>
	</section>
  <%@ include file="../layout/footer.jsp" %>
</main>
<%@ include file="../layout/prescript.jsp" %>
</body>
</html>

