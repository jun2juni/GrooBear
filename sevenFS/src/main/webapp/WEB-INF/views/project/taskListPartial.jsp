<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<table class="table table-sm table-bordered">
  <thead class="table-light">
    <tr>
      <th style="text-align:center">업무명</th>
      <th style="text-align:center">담당자</th>
      <th style="text-align:center">기간</th>
      <th style="text-align:center">중요도</th>
      <th style="text-align:center">등급</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="task" items="${project.taskList}">
      <tr class="${not empty task.parentTaskNm ? 'table-light' : ''}" style="cursor:pointer" onclick="openTaskModal(${task.taskNo})">
        <td>
          <div style="margin-left:${(task.depth != null && task.depth > 0) ? task.depth * 20 : 15}px;">
            <c:if test="${not empty task.upperTaskNo}">
              <i class="fas fa-level-up-alt fa-rotate-90 me-2 text-primary"></i>
            </c:if>
            <strong>${task.taskNm}</strong>
          </div>
        </td>
        <td class="text-center">
          <c:choose>
            <c:when test="${task.role == '00'}"><span class="badge bg-danger">${task.chargerEmpNm}</span></c:when>
            <c:when test="${task.role == '01'}"><span class="badge bg-primary">${task.chargerEmpNm}</span></c:when>
            <c:otherwise><span class="badge bg-secondary">${task.chargerEmpNm}</span></c:otherwise>
          </c:choose>
        </td>
        <td class="text-center">
          <fmt:formatDate value="${task.taskBeginDt}" pattern="yyyy-MM-dd" /> ~ 
          <fmt:formatDate value="${task.taskEndDt}" pattern="yyyy-MM-dd" />
        </td>
        <td class="text-center">
          <c:choose>
            <c:when test="${task.priort == '00'}"><span class="badge bg-success">낮음</span></c:when>
            <c:when test="${task.priort == '01'}"><span class="badge bg-info">보통</span></c:when>
            <c:when test="${task.priort == '02'}"><span class="badge bg-warning">높음</span></c:when>
            <c:when test="${task.priort == '03'}"><span class="badge bg-danger">긴급</span></c:when>
            <c:otherwise>-</c:otherwise>
          </c:choose>
        </td>
        <td class="text-center">${task.taskGrad}</td>
      </tr>
    </c:forEach>
  </tbody>
</table>


<script>
function refreshTaskList() {
  const prjctNo = "${project.prjctNo}";

  fetch(`/projectTask/partialList?prjctNo=${prjctNo}`)
    .then(res => res.text())
    .then(html => {
      document.getElementById("taskListSection").innerHTML = html;

      // 포커싱 처리
      document.getElementById("taskListSection").scrollIntoView({
        behavior: "smooth",
        block: "start"
      });
    })
    .catch(err => {
      console.error("업무 목록 갱신 실패:", err);
      alert("업무 목록을 불러오는데 실패했습니다.");
    });
}
</script>

