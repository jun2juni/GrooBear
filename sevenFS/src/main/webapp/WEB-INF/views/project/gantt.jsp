<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 상단 기능 -->
<div class="d-flex justify-content-between align-items-center mb-3">
  <div>
    <button class="btn btn-sm btn-outline-dark" id="toggleGridBtn">목록 접기/펼치기</button>
    <select id="statusFilter" class="form-select form-select-sm d-inline-block w-auto ms-2">
      <option value="">전체</option>
      <option value="00">대기</option>
      <option value="01">진행중</option>
      <option value="02">완료</option>
    </select>
  </div>
  <div class="btn-group btn-group-sm">
    <button class="btn btn-outline-secondary" id="scale_day">일</button>
    <button class="btn btn-outline-secondary" id="scale_week">주</button>
    <button class="btn btn-outline-secondary" id="scale_month">월</button>
  </div>
</div>

<div id="gantt_here" style="width: 100%; height: 600px;"></div>

<!-- 스타일 -->
<style>
  .today_marker { background-color: rgba(255, 0, 0, 0.1); }
  .today_marker::after {
    content: ''; position: absolute; left: 0; top: 0; bottom: 0; width: 2px; background-color: red;
  }

  /* 상태별 색상 */
  .task-status-waiting .gantt_task_line { background: #dee2e6 !important; border-color: #adb5bd; }
  .task-status-progress .gantt_task_line { background: #cfe2ff !important; border-color: #0d6efd; }
  .task-status-done .gantt_task_line { background: #d1e7dd !important; border-color: #198754; }

  /* 상위 업무 강조 */
  .gantt_row.task-parent {
    background-color: #f3f3f3 !important;
    font-weight: bold;
  }
</style>

<!-- 스크립트 -->
<script>
(function () {
  const prjctNo = "${prjctNo}";
  let currentStatusFilter = "";

  const statusMap = { "00": "대기", "01": "진행중", "02": "완료" };
  const priorityMap = { "00": "낮음", "01": "보통", "02": "높음", "03": "긴급" };

  // ✅ 스케일 전환
  window.setScale = function(type) {
    if (type === 'day') {
      gantt.config.scale_unit = "day";
      gantt.config.date_scale = "%m/%d";
      gantt.config.subscales = [];
    } else if (type === 'week') {
      gantt.config.scale_unit = "week";
      gantt.config.date_scale = "Week #%W";
      gantt.config.subscales = [{ unit: "day", step: 1, date: "%D %d" }];
    } else if (type === 'month') {
      gantt.config.scale_unit = "month";
      gantt.config.date_scale = "%Y/%m";
      gantt.config.subscales = [];
    }
    gantt.render();
  };

  // ✅ 목록 접기/펼치기
  window.toggleGrid = function () {
    gantt.config.show_grid = !gantt.config.show_grid;
    gantt.render();
  };

  // ✅ 설정
  gantt.config.date_format = "%Y-%m-%d %H:%i";
  gantt.config.show_grid = true;

  gantt.config.columns = [
    { name: "text", label: "업무명", tree: true, width: 200 },
    { name: "owner", label: "담당자", align: "center", width: 100 },
    { name: "start_date", label: "시작일", align: "center", width: 90 },
    { name: "end_date", label: "종료일", align: "center", width: 90 },
    {
      name: "priority",
      label: "중요도",
      align: "center",
      width: 80,
      template: function (task) {
        return priorityMap[task.priority] || "-";
      }
    },
    {
      name: "status",
      label: "상태",
      align: "center",
      width: 70,
      template: function (task) {
        return statusMap[task.status] || "-";
      }
    }
  ];

  // ✅ 상태별 색상
  gantt.templates.task_class = function (start, end, task) {
    const classMap = {
      "00": "task-status-waiting",
      "01": "task-status-progress",
      "02": "task-status-done"
    };
    return classMap[task.status] || "";
  };

  // ✅ 상위업무 강조 (depth가 없으므로 upperTaskNo로)
  gantt.templates.grid_row_class = function (start, end, task) {
    return (!task.parent || task.parent === 0) ? "task-parent" : "";
  };

  gantt.templates.task_text = function (start, end, task) {
    return task.text + " " + Math.floor((task.progress || 0) * 100) + "%";
  };

  gantt.templates.task_cell_class = function (task, date) {
    const today = new Date();
    if (date.getDate() === today.getDate() &&
        date.getMonth() === today.getMonth() &&
        date.getFullYear() === today.getFullYear()) {
      return "today_marker";
    }
    return "";
  };

  gantt.init("gantt_here");

  // ✅ 데이터 로딩
  function loadGanttData() {
    fetch(`/project/gantt/data?prjctNo=\${prjctNo}\${currentStatusFilter ? '&status=' + currentStatusFilter : ''}`)
      .then(res => res.json())
      .then(data => {
        if (data.error) {
          console.error("❌ 데이터 오류:", data.error);
          return;
        }

        data.data.forEach(task => {
          if (typeof task.start_date === "string") {
            task.start_date = new Date(task.start_date.replace(" ", "T"));
          }
          if (typeof task.end_date === "string") {
            task.end_date = new Date(task.end_date.replace(" ", "T"));
          }
        });

        gantt.clearAll();
        gantt.parse(data);
      })
      .catch(err => {
        console.error("🚨 Gantt 데이터 로딩 실패:", err);
      });
  }

  // ✅ 일정 업데이트
  gantt.attachEvent("onAfterTaskUpdate", function (id, task) {
    const updateData = {
      taskNo: id,
      taskBeginDt: gantt.date.date_to_str("%Y-%m-%d %H:%i")(task.start_date),
      taskEndDt: gantt.date.date_to_str("%Y-%m-%d %H:%i")(task.end_date),
      progrsrt: Math.floor(task.progress * 100)
    };

    fetch("/project/gantt/updateSchedule", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(updateData)
    })
    .then(res => res.json())
    .then(result => {
      if (!result.success) {
        alert("업무 일정 저장 실패: " + (result.message || ""));
      }
    })
    .catch(err => {
      console.error("업데이트 실패:", err);
      alert("서버 오류로 일정 저장 실패");
    });

    return true;
  });

  // ✅ 바인딩
  document.getElementById("scale_day").addEventListener("click", () => setScale("day"));
  document.getElementById("scale_week").addEventListener("click", () => setScale("week"));
  document.getElementById("scale_month").addEventListener("click", () => setScale("month"));
  document.getElementById("toggleGridBtn").addEventListener("click", toggleGrid);
  document.getElementById("statusFilter").addEventListener("change", function () {
    currentStatusFilter = this.value;
    loadGanttData();
  });

  // ✅ 초기 실행
  setScale("day");
  loadGanttData();
})();
</script>
