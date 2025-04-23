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
  <div class="ms-auto me-3">
    <button class="btn btn-sm btn-success" id="addTaskBtn">
      <i class="fas fa-plus-circle"></i> 업무 추가
    </button>
  </div>
  <div class="btn-group btn-group-sm">
    <button class="btn btn-outline-secondary" id="scale_day">일</button>
    <button class="btn btn-outline-secondary" id="scale_week">주</button>
    <button class="btn btn-outline-secondary" id="scale_month">월</button>
  </div>
</div>

<div id="gantt_here" style="width: 100%; height: 600px;"></div>

<!-- SweetAlert v1 -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<script>
(function () {
  const prjctNo = "${prjctNo}";
  let currentStatusFilter = "";

  const statusMap = { "00": "대기", "01": "진행중", "02": "완료" };
  const priorityMap = { "00": "낮음", "01": "보통", "02": "높음", "03": "긴급" };

  window.setScale = function(type) {
    if (type === 'day') {
      gantt.config.scale_unit = "day";
      gantt.config.date_scale = "%m/%d";
      gantt.config.subscales = [];
    } else if (type === 'week') {
      gantt.config.scale_unit = "week";
      gantt.config.date_scale = "Week #%W";
      gantt.config.subscales = [];
    } else if (type === 'month') {
      gantt.config.scale_unit = "month";
      gantt.config.date_scale = "%Y/%m";
      gantt.config.subscales = [];
    }
    gantt.render();
  };

  window.toggleGrid = function () {
    gantt.config.show_grid = !gantt.config.show_grid;
    gantt.render();
  };

  gantt.templates.scale_cell_class = function (date) {
    const day = date.getDay();
    if (gantt.config.scale_unit === "month") return "";
    if (day === 6) return "gantt-saturday";
    if (day === 0) return "gantt-sunday";
    return "";
  };

  gantt.config.date_format = "%Y-%m-%d %H:%i";
  gantt.config.show_grid = true;
  gantt.config.columns = [
    { name: "text", label: "업무명", tree: true, width: 200 },
    { name: "owner", label: "담당자", align: "center", width: 100 },
    { name: "start_date", label: "시작일", align: "center", width: 90 },
    { name: "end_date", label: "종료일", align: "center", width: 90 },
    {
      name: "priority", label: "중요도", align: "center", width: 80,
      template: task => priorityMap[task.priority] || "-"
    },
    {
      name: "status", label: "상태", align: "center", width: 70,
      template: task => statusMap[task.status] || "-"
    }
  ];

  gantt.templates.task_class = (start, end, task) => "task-status-" + task.status;
  gantt.templates.grid_row_class = (start, end, task) => (!task.parent || task.parent === 0) ? "task-parent" : "";
  gantt.templates.task_text = (start, end, task) => task.text + " " + Math.floor((task.progress || 0) * 100) + "%";

  gantt.init("gantt_here");

  window.loadGanttData = function() {
    fetch(`/project/gantt/data?prjctNo=\${prjctNo}\${currentStatusFilter ? '&status=' + currentStatusFilter : ''}`)
      .then(res => res.json())
      .then(data => {
        if (data.error) return console.error("❌ 데이터 오류:", data.error);
        data.data.forEach(task => {
          task.start_date = new Date(task.start_date.replace(" ", "T"));
          task.end_date = new Date(task.end_date.replace(" ", "T"));
          task.open = true;
        });
        gantt.clearAll();
        gantt.parse(data);
      })
      .catch(err => console.error("🚨 Gantt 데이터 로딩 실패:", err));
  };

  function bindTaskEditModalEvent() {
    const btn = document.getElementById("submitEditTaskBtn");
    if (!btn) return;
    btn.addEventListener("click", () => {
      const form = document.getElementById("taskEditForm");
      if (!form) return swal("오류", "수정 폼을 찾을 수 없습니다.", "error");

      const formData = new FormData(form);
      formData.append("source", "gantt");

      fetch("/projectTask/update", {
        method: "POST",
        body: formData
      })
      .then(res => res.text())
      .then(() => {
        const modalElement = document.getElementById("taskEditModal");
        if (!modalElement) return;
        const modal = bootstrap.Modal.getInstance(modalElement);
        if (modal) modal.hide();
        loadGanttData();
        swal("수정 완료", "업무가 성공적으로 수정되었습니다.", "success");
      })
      .catch(err => {
        console.error("❌ 수정 실패:", err);
        swal("수정 실패", "오류가 발생했습니다:\n" + err.message, "error");
      });
    });
  }

  gantt.attachEvent("onTaskDblClick", function(id, e) {
    const task = gantt.getTask(id);
    const taskId = Number(task.id);
    fetch(`/projectTask/taskEditModal?taskNo=\${taskId}`)
      .then(res => res.text())
      .then(html => {
        document.getElementById("taskEditModal")?.remove();
        document.body.insertAdjacentHTML("beforeend", html);
        const modalElement = document.getElementById("taskEditModal");
        if (!modalElement) return;
        const modal = new bootstrap.Modal(modalElement);
        modal.show();
        bindTaskEditModalEvent();
      })
      .catch(err => {
        console.error("모달 불러오기 실패:", err);
        swal("모달 오류", "업무 정보를 불러올 수 없습니다.", "error");
      });
    return false;
  });

  document.getElementById("addTaskBtn").addEventListener("click", () => {
    fetch(`/projectTask/taskAddModal?prjctNo=\${prjctNo}`)
      .then(res => res.text())
      .then(html => {
        document.getElementById("taskAddModal")?.remove();
        document.body.insertAdjacentHTML("beforeend", html);
        new bootstrap.Modal(document.getElementById("taskAddModal")).show();
      })
      .catch(err => swal("모달 오류", "업무 추가 모달을 불러올 수 없습니다.", "error"));
  });

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
        if (!result.success) swal("저장 실패", result.message || "일정 저장 실패", "error");
      })
      .catch(err => swal("서버 오류", err.message, "error"));
    return true;
  });

  document.getElementById("scale_day").addEventListener("click", () => setScale("day"));
  document.getElementById("scale_week").addEventListener("click", () => setScale("week"));
  document.getElementById("scale_month").addEventListener("click", () => setScale("month"));
  document.getElementById("toggleGridBtn").addEventListener("click", toggleGrid);
  document.getElementById("statusFilter").addEventListener("change", function () {
    currentStatusFilter = this.value;
    loadGanttData();
  });

  setScale("day");
  loadGanttData();
})();
</script>
