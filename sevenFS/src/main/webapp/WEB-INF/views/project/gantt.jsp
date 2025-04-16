<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div id="ganttChartContainer" style="height: 800px;"></div>

<!-- DHTMLX Gantt 스타일/스크립트 로드 -->
<link href="https://cdn.dhtmlx.com/gantt/edge/dhtmlxgantt.css" rel="stylesheet" />
<script src="https://cdn.dhtmlx.com/gantt/edge/dhtmlxgantt.js"></script>

<script>
document.addEventListener("DOMContentLoaded", function () {
  const prjctNo = ${prjctNo};

  // 상태 및 우선순위 코드 정의 (서버에서 전달된 JSTL 리스트 사용)
  const taskStatusMap = {
    <c:forEach var="code" items="${taskSttusList}">
      "${code.cmmnCode}": "${code.cmmnCodeNm}"<c:if test="${!codeStatus.last}">,</c:if>
    </c:forEach>
  };

  const priorityColorMap = {
    "A": "#f44336", // red
    "B": "#ff9800", // orange
    "C": "#ffeb3b", // yellow
    "D": "#4caf50", // green
    "E": "#2196f3"  // blue
  };

  gantt.config.xml_date = "%Y-%m-%d %H:%i";

  gantt.config.columns = [
    { name: "text", label: "업무명", tree: true, width: "*" },
    { name: "start_date", label: "시작일", align: "center" },
    { name: "end_date", label: "종료일", align: "center" },
    { name: "priority", label: "등급", align: "center", template: function(task) {
      return task.taskGrad || "";
    }},
    { name: "add", label: "", width: 40 }
  ];

  gantt.templates.task_class = function (start, end, task) {
    let base = "gantt_task";
    if (task.taskGrad && priorityColorMap[task.taskGrad]) {
      return base + " task-priority-" + task.taskGrad;
    }
    return base;
  };

  // 우선순위 색상 스타일 동적 주입
  for (const [grade, color] of Object.entries(priorityColorMap)) {
    const style = document.createElement("style");
    style.innerHTML = `
      .task-priority-\${grade} .gantt_task_content {
        background-color: \${color} !important;
      }
    `;
    document.head.appendChild(style);
  }

  gantt.init("ganttChartContainer");

  gantt.clearAll();
  gantt.load("/project/gantt/data?prjctNo=" + prjctNo);

  // 데이터프로세서 설정 (REST 방식)
  const dp = new gantt.dataProcessor("/project/gantt");
  dp.init(gantt);
  dp.setTransactionMode("REST");

  console.log("간트차트 로딩 완료 for prjctNo:", prjctNo);
});
</script>
