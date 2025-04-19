<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- DHTMLX Gantt Chart CSS/JS -->
<link rel="stylesheet" href="https://cdn.dhtmlx.com/gantt/edge/dhtmlxgantt.css">
<script src="https://cdn.dhtmlx.com/gantt/edge/dhtmlxgantt.js"></script>

<div class="card">
  <div class="card-header d-flex justify-content-between align-items-center">
    <h5 class="card-title mb-0">프로젝트 간트차트</h5>
    <div class="d-flex gap-2 align-items-center">
      <span class="badge bg-primary">프로젝트명: ${project.projectNm}</span>
      <button class="btn btn-sm btn-outline-primary" onclick="gantt.createTask(null)">
        <i class="material-icons-outlined">add</i> 업무 추가
      </button>
    </div>
  </div>

  <div class="card-body">
    <div id="ganttChartContainer" style="height: 600px; width: 100%;"></div>
  </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function() {
  gantt.config.xml_date = "%Y-%m-%d %H:%i";
  gantt.config.date_format = "%Y-%m-%d %H:%i";

  // 컬럼 구성
  gantt.config.columns = [
    { name: "text", label: "업무명", tree: true, width: 250 },
    { name: "start_date", label: "시작일", align: "center", width: 90 },
    { name: "end_date", label: "종료일", align: "center", width: 90 },
    { name: "progress", label: "진행률", align: "center", width: 70, template: task => Math.round((task.progress || 0) * 100) + "%" },
    { name: "owner", label: "담당자", align: "center", width: 90 },
    { name: "status", label: "상태", align: "center", width: 90, template: task => taskStatusMap[task.status] || "미정" }
  ];

  // 상태코드 매핑 객체 (서버에서 JSTL로 출력됨)
  const taskStatusMap = {
    <c:forEach var="code" items="${taskSttusList}" varStatus="status">
      "${code.cmmnCode}": "${code.cmmnCodeNm}"<c:if test="${!status.last}">,</c:if>
    </c:forEach>
  };

  // 툴팁
  gantt.templates.tooltip_text = function(start, end, task) {
    const statusText = taskStatusMap[task.status] || "미정";
    return `
      <div class="gantt-tooltip">
        <strong>\${task.text}</strong><br>
        <span>시작: \${gantt.templates.tooltip_date_format(start)}</span><br>
        <span>종료: \${gantt.templates.tooltip_date_format(end)}</span><br>
        <span>진행률: \${Math.round((task.progress || 0) * 100)}%</span><br>
        <span>상태: \${statusText}</span><br>
        <span>담당자: \${task.owner || "미지정"}</span>
      </div>`;
  };

  // 라이트박스 구성 변경
  gantt.config.lightbox.sections = [
    { name: "parent", height: 30, map_to: "parent", type: "template", readonly: true },
    { name: "text", height: 30, map_to: "text", type: "template", readonly: true },
    { name: "owner", height: 30, map_to: "owner", type: "template", readonly: true },
    { name: "priority", height: 30, map_to: "priority", type: "template", readonly: true },
    { name: "grade", height: 30, map_to: "grade", type: "template", readonly: true },
    { name: "description", height: 60, map_to: "description", type: "textarea" },
    { name: "time", type: "duration", map_to: "auto" }
  ];

  // 라벨 한글화
  gantt.locale.labels.section_parent = "상위 업무";
  gantt.locale.labels.section_text = "업무명";
  gantt.locale.labels.section_owner = "담당자";
  gantt.locale.labels.section_priority = "중요도";
  gantt.locale.labels.section_grade = "업무 등급";
  gantt.locale.labels.section_description = "업무 내용";
  gantt.locale.labels.section_time = "일정";

  // 날짜 한국식 포맷
  gantt.date.date_to_str = gantt.date.date_to_str("%Y년 %m월 %d일 %H:%i");

  // Gantt 초기화 및 데이터 로드
  gantt.init("ganttChartContainer");
  gantt.load("/project/gantt/data?prjctNo=${project.prjctNo}");

  const dp = new gantt.dataProcessor("/project/gantt");
  dp.init(gantt);
  dp.setTransactionMode("REST");
});
</script>
