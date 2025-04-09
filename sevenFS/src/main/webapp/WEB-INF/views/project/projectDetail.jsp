<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="row">
  <div class="col-md-8">
    <div class="form-step">
      <div class="row">
        <div class="col-12">
          <div class="card border p-4">
            <h4 class="fw-bold mb-3"><i class="fas fa-folder-open me-2 text-primary"></i>프로젝트 상세</h4>

            <!-- 1. 기본 정보 -->
            <h5 class="mt-4 fw-semibold">1. 기본 정보</h5>
            <table class="table table-bordered table-sm mt-2">
              <tbody>
                <tr><th class="bg-light w-25 text-center">프로젝트명</th><td class="ps-3">${project.prjctNm}</td></tr>
                <tr><th class="bg-light text-center">카테고리</th><td class="ps-3">${project.ctgryNm}</td></tr>
                <tr><th class="bg-light text-center">내용</th><td class="ps-3">${project.prjctCn}</td></tr>
                <tr><th class="bg-light text-center">기간</th><td class="ps-3">${project.prjctBeginDate} ~ ${project.prjctEndDate}</td></tr>
                <tr><th class="bg-light text-center">상태</th><td class="ps-3"><span class="badge bg-info text-dark px-2 py-1">${project.prjctSttusNm}</span></td></tr>
                <tr><th class="bg-light text-center">등급</th><td class="ps-3"><span class="badge bg-warning text-dark px-2 py-1">${project.prjctGrad}</span></td></tr>
              </tbody>
            </table>

            <!-- 2. 참여 인원 -->
            <h5 class="mt-5 fw-semibold">2. 참여 인원</h5>
            <div class="mb-4">
              <div class="row g-3">
                <div class="col-md-12">
                  <div class="border-top pt-3">
                    <span class="badge btn-danger mb-2 px-2 py-1">
                      <i class="fas fa-user-tie me-1"></i> 책임자
                    </span>
                    <div class="d-flex flex-wrap gap-2 small text-muted">
                      <c:forEach var="emp" items="${project.responsibleList}">
                        <button type="button" class="btn btn-outline-danger rounded-3 text-start shadow-sm" style="min-width: 120px; font-size: 0.85rem; border-width: 1px;">
                          <i class="fas fa-user-tie me-1"></i> ${emp.emplNm}
                          <div class="text-muted small">${emp.posNm}</div>
                        </button>
                      </c:forEach>
                    </div>
                  </div>
                </div>
                <div class="col-md-12">
                  <div class="border-top pt-3">
                    <span class="badge btn-primary mb-2 px-2 py-1">
                      <i class="fas fa-user-check me-1"></i> 참여자
                    </span>
                    <div class="d-flex flex-wrap gap-2 small text-muted">
                      <c:forEach var="emp" items="${project.participantList}">
                        <button type="button" class="btn btn-outline-primary rounded-3 text-start shadow-sm" style="min-width: 120px; font-size: 0.85rem; border-width: 1px;">
                          <i class="fas fa-user-check me-1"></i> ${emp.emplNm}
                          <div class="text-muted small">${emp.posNm}</div>
                        </button>
                      </c:forEach>
                    </div>
                  </div>
                </div>
                <div class="col-md-12">
                  <div class="border-top pt-3">
                    <span class="badge btn-secondary mb-2 px-2 py-1">
                      <i class="fas fa-user-clock me-1"></i> 참조자
                    </span>
                    <div class="d-flex flex-wrap gap-2 small text-muted">
                      <c:forEach var="emp" items="${project.observerList}">
                        <button type="button" class="btn btn-outline-secondary rounded-3 text-start shadow-sm" style="min-width: 120px; font-size: 0.85rem; border-width: 1px;">
                          <i class="fas fa-user-clock me-1"></i> ${emp.emplNm}
                          <div class="text-muted small">${emp.posNm}</div>
                        </button>
                      </c:forEach>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- 3. 등록된 업무 -->
            <h5 class="mt-5 fw-semibold">3. 등록된 업무</h5>
            <div class="mb-4">
              <table class="table table-sm table-bordered">
                <thead class="table-light">
                  <tr>
                    <th style="text-align:left">업무명</th>
                    <th style="text-align:center">담당자</th>
                    <th style="text-align:center">기간</th>
                    <th style="text-align:center">중요도</th>
                    <th style="text-align:center">등급</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="task" items="${project.taskList}">
                    <tr class="${not empty task.parentTaskNm ? 'table-light' : ''}">
                      <td><c:if test="${not empty task.parentTaskNm}"><i class="fas fa-level-up-alt fa-rotate-90 me-1 text-primary"></i>&nbsp;&nbsp;</c:if><strong>${task.taskNm}</strong></td>
                      <td class="text-center">${task.chargerEmpNm}</td>
                      <td class="text-center">${task.taskBeginDt} ~ ${task.taskEndDt}</td>
                      <td class="text-center">
                        <c:choose>
                          <c:when test="${task.taskPriort == '00'}"><span class="badge bg-success">낮음</span></c:when>
                          <c:when test="${task.taskPriort == '01'}"><span class="badge bg-info">보통</span></c:when>
                          <c:when test="${task.taskPriort == '02'}"><span class="badge bg-warning">높음</span></c:when>
                          <c:when test="${task.taskPriort == '03'}"><span class="badge bg-danger">긴급</span></c:when>
                          <c:otherwise>-</c:otherwise>
                        </c:choose>
                      </td>
                      <td class="text-center">${task.taskGrad}</td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </div>

            <!-- 4. 세부 정보 -->
            <h5 class="mt-5 fw-semibold">4. 세부 정보</h5>
            <table class="table table-bordered table-sm">
              <tbody>
                <tr><th class="bg-light w-25 text-center">수주 금액</th><td class="ps-3"><fmt:formatNumber value="${project.prjctRcvordAmount}" type="number" groupingUsed="true" /> 원</td></tr>
                <tr><th class="bg-light text-center">주소</th><td class="ps-3">${project.prjctAdres}</td></tr>
                <tr><th class="bg-light text-center">URL</th><td class="ps-3"><a href="${project.prjctUrl}" target="_blank">${project.prjctUrl}</a></td></tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- 오른쪽 안내 영역 -->
  <div class="col-md-4">
    <div class="card p-3 bg-light">
      <h6 class="mb-3 text-primary"><i class="fas fa-info-circle me-2"></i>프로젝트 상세 안내</h6>
      <ul class="text-muted small ps-3">
        <li>이 프로젝트는 저장된 상세 정보입니다.</li>
        <li>업무 및 참여자 정보는 수정 불가 상태입니다.</li>
        <li>관리자 권한이 있을 경우 편집 또는 삭제할 수 있습니다.</li>
      </ul>
    </div>
  </div>
</div>
