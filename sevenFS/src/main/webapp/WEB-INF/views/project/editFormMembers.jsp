<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
          <c:forEach var="emp" items="${project.projectEmpVOList}" varStatus="loop">
            <c:set var="roleLabel" value="" />
            <c:set var="badgeClass" value="" />
            <c:set var="rowClass" value="" />
            <c:set var="roleIcon" value="" />
            <c:choose>
              <c:when test="${emp.prtcpntRole eq '00'}">
                <c:set var="roleLabel" value="책임자" />
                <c:set var="badgeClass" value="bg-danger" />
                <c:set var="rowClass" value="table-danger" />
                <c:set var="roleIcon" value="fas fa-user-tie" />
              </c:when>
              <c:when test="${emp.prtcpntRole eq '01'}">
                <c:set var="roleLabel" value="참여자" />
                <c:set var="badgeClass" value="bg-primary" />
                <c:set var="rowClass" value="table-primary" />
                <c:set var="roleIcon" value="fas fa-user-check" />
              </c:when>
              <c:otherwise>
                <c:set var="roleLabel" value="참조자" />
                <c:set var="badgeClass" value="bg-secondary" />
                <c:set var="rowClass" value="table-secondary" />
                <c:set var="roleIcon" value="fas fa-user-clock" />
              </c:otherwise>
            </c:choose>

            <tr class="${rowClass}" data-empno="${emp.prtcpntEmpno}" data-role="${emp.prtcpntRole}">
              <td class="text-center align-middle">
                <span class="badge ${badgeClass} p-2">
                  <i class="${roleIcon} me-1"></i> ${roleLabel}
                </span>
              </td>
              <td class="text-center align-middle"><strong>${emp.emplNm}</strong></td>
              <td class="text-center align-middle">${emp.deptNm}</td>
              <td class="text-center align-middle">${emp.posNm}</td>
              <td class="text-center align-middle">
                <i class="fas fa-phone-alt me-1 text-muted"></i>
                <c:choose>
                  <c:when test="${fn:length(emp.telno) == 11}">
                    ${fn:substring(emp.telno, 0, 3)}-${fn:substring(emp.telno, 3, 7)}-${fn:substring(emp.telno, 7, 11)}
                  </c:when>
                  <c:when test="${fn:length(emp.telno) == 10}">
                    <c:choose>
                      <c:when test="${fn:startsWith(emp.telno, '02')}">
                        ${fn:substring(emp.telno, 0, 2)}-${fn:substring(emp.telno, 2, 6)}-${fn:substring(emp.telno, 6, 10)}
                      </c:when>
                      <c:otherwise>
                        ${fn:substring(emp.telno, 0, 3)}-${fn:substring(emp.telno, 3, 6)}-${fn:substring(emp.telno, 6, 10)}
                      </c:otherwise>
                    </c:choose>
                  </c:when>
                  <c:otherwise>
                    ${emp.telno}
                  </c:otherwise>
                </c:choose>
              </td>
              <td class="text-start align-middle ps-3">
                <i class="fas fa-envelope me-1 text-muted"></i> ${emp.email}
              </td>
  <td class="text-center align-middle">
    <input type="hidden" name="<c:choose>
                                  <c:when test='${emp.prtcpntRole eq "00"}'>responsibleManager</c:when>
                                  <c:when test='${emp.prtcpntRole eq "01"}'>participants</c:when>
                                  <c:otherwise>observers</c:otherwise>
                               </c:choose>[${loop.index}]" 
           value="${emp.prtcpntEmpno}" />
    <button type="button" class="btn btn-sm btn-outline-danger" onclick="this.closest('tr').remove(); updateProjectEmpIndexes();">
      <i class="fas fa-times"></i>
    </button>
  </td>
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
