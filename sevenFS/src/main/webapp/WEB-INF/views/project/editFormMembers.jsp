<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<h5 class="fw-semibold mb-2 mt-4">3. 참여 인원</h5>

<div class="btn-group mb-3" role="group">
  <button type="button" class="btn btn-outline-danger open-org-chart" data-bs-toggle="modal" data-bs-target="#orgChartModal" data-target="responsibleManager">책임자</button>
  <button type="button" class="btn btn-outline-primary open-org-chart" data-bs-toggle="modal" data-bs-target="#orgChartModal" data-target="participants">참여자</button>
  <button type="button" class="btn btn-outline-secondary open-org-chart" data-bs-toggle="modal" data-bs-target="#orgChartModal" data-target="observers">참조자</button>
</div>

<div class="table-responsive">
  <table class="table table-bordered table-hover" id="selectedMembersTable">
    <thead>
      <tr class="table-light text-center align-middle">
        <th>역할</th>
        <th>이름</th>
        <th>부서명</th>
        <th>직급</th>
        <th>연락처</th>
        <th>이메일</th>
        <th>삭제</th>
      </tr>
    </thead>
    <tbody>
      <c:choose>
        <c:when test="${not empty project.projectEmpVOList}">
          <c:forEach var="emp" items="${project.projectEmpVOList}">
            <tr class="server-member"
                data-emp-id="${emp.prtcpntEmpno}"
                data-role="${emp.prtcpntRole}"
                data-name="${emp.emplNm}"
                data-dept="${emp.deptNm}"
                data-pos="${emp.posNm}"
                data-telno="${emp.telno}"
                data-email="${emp.email}">
              <td colspan="7" class="text-center text-muted">로딩 중...</td>
            </tr>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <tr class="empty-row">
            <td colspan="7" class="text-center text-muted py-4">
              <i class="fas fa-info-circle me-1"></i> 선택된 인원이 없습니다. 조직도에서 프로젝트 참여자를 선택해주세요.
            </td>
          </tr>
        </c:otherwise>
      </c:choose>
    </tbody>
  </table>
</div>
