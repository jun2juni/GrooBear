
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

<!-- 스타일 -->
<style>
  .today_marker { background-color: rgba(255, 0, 0, 0.1); }
  .today_marker::after {
    content: ''; position: absolute; left: 0; top: 0; bottom: 0; width: 2px; background-color: red;
  }

/* 상태별 배경색 */
.gantt_task_line.task-status-00 {
  background-color: #6c757d !important; 
  border: 1px solid #495057;
  color: white;
}

.gantt_task_line.task-status-02 {
  background-color: #198754 !important;
  border: 1px solid #14532d;
  color: white;
}
  /* 상위 업무 강조 */
  .gantt_row.task-parent {
    background-color: #f5eefb !important;
    font-weight: bold;
  }

.gantt-sunday {
  color: red !important;
  background-color: #ffe5e5 !important;
}
.gantt-saturday {
  color: #0d6efd !important;
  background-color: #e2edff !important;
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
    	gantt.config.date_scale = "Week #%W"; // 또는 "1주", "2주" 등으로 바꿔도 됨
    	gantt.config.subscales = []; // 일단 하위스케일 없음
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
  
  // 하위업무 접었다 펴기 기능 제거 (요청에 따라 삭제)

  gantt.templates.scale_cell_class = function (date) {
	  if (gantt.config.scale_unit === "month") return ""; // 월 스케일일 땐 적용 X

	  const day = date.getDay();
	  if (day === 6) return "gantt-saturday";  // 토요일
	  if (day === 0) return "gantt-sunday";    // 일요일
	  return "";
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

  //  상태별 색상
gantt.templates.task_class = function (start, end, task) {
  return "task-status-" + task.status;
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
  window.loadGanttData = function() {
    fetch(`/project/gantt/data?prjctNo=\${prjctNo}\${currentStatusFilter ? '&status=' + currentStatusFilter : ''}`)
      .then(res => res.json())
      .then(data => {
        if (data.error) {
          console.error("❌ 데이터 오류:", data.error);
          return;
        }

        // 날짜 포맷 및 open 속성 추가
        data.data.forEach(task => {
          if (typeof task.start_date === "string") {
            task.start_date = new Date(task.start_date.replace(" ", "T"));
          }
          if (typeof task.end_date === "string") {
            task.end_date = new Date(task.end_date.replace(" ", "T"));
          }

          // 하위업무 펼침을 위해 open 속성 추가
          task.open = true;
        });

        gantt.clearAll();
        gantt.parse(data);
      })
      .catch(err => {
        console.error("🚨 Gantt 데이터 로딩 실패:", err);
      });
  };

//✅ 업무 더블클릭 → 수정모달
  gantt.attachEvent("onTaskDblClick", function(id, e) {
    const task = gantt.getTask(id);
    if (!task || !task.id) {
      console.error("유효하지 않은 업무 ID:", id);
      return false;
    }
    
    // 로그 추가
    console.log("더블클릭한 업무:", task);
    console.log("업무 ID:", task.id, "타입:", typeof task.id);
    
    // taskNo가 문자열이 아닌 숫자로 전달되도록 명시적 변환
    const taskId = Number(task.id);
    
    fetch(`/projectTask/taskEditModal?taskNo=\${taskId}`)
      .then(response => {
        if (!response.ok) {
          console.error("서버 응답 상태:", response.status, response.statusText);
          throw new Error('서버 응답 오류: ' + response.status);
        }
        return response.text();
      })
      .then(html => {
        console.log("모달 HTML 로드 성공"); // 로그 추가
        
        // 기존 모달이 있으면 제거
        const existingModal = document.getElementById("taskEditModal");
        if (existingModal) {
          existingModal.remove();
        }
        
        document.body.insertAdjacentHTML("beforeend", html);
        
        // 모달 요소가 실제로 삽입되었는지 확인
        const modalElement = document.getElementById("taskEditModal");
        if (!modalElement) {
          console.error("모달 요소가 DOM에 추가되지 않았습니다.");
          return;
        }
        
        // Bootstrap이 로드되었는지 확인
        if (typeof bootstrap === 'undefined' || !bootstrap.Modal) {
          console.error("Bootstrap Modal이 정의되지 않았습니다.");
          alert("페이지에 Bootstrap이 제대로 로드되지 않았습니다. 페이지를 새로고침해 주세요.");
          return;
        }
        
        try {
          const modal = new bootstrap.Modal(modalElement);
          modal.show();
        } catch (error) {
          console.error("모달 초기화 또는 표시 오류:", error);
          alert("모달을 표시할 수 없습니다: " + error.message);
        }
      })
      .catch(err => {
        console.error("업무 정보 불러오기 실패:", err);
        alert("업무 정보를 불러올 수 없습니다: " + err.message);
      });
    return false;
  });
  
  // ✅ 업무 추가 모달 열기
  document.getElementById("addTaskBtn").addEventListener("click", function () {
    // prjctNo가 문자열이 아닌 숫자로 전달되도록 명시적 변환
    const projectId = Number(prjctNo);
    
    fetch(`/projectTask/taskAddModal?prjctNo=\${projectId}`)
      .then(response => {
        if (!response.ok) {
          throw new Error('서버 응답 오류: ' + response.status);
        }
        return response.text();
      })
      .then(html => {
        // 기존 모달이 있으면 제거
        const existingModal = document.getElementById("taskAddModal");
        if (existingModal) {
          existingModal.remove();
        }
        
        document.body.insertAdjacentHTML("beforeend", html);
        const modal = new bootstrap.Modal(document.getElementById("taskAddModal"));
        modal.show();
      })
      .catch(err => {
        console.error("모달 로딩 실패:", err);
        alert("업무 추가 모달을 불러올 수 없습니다: " + err.message);
      });
  });
  
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

  
//✅ 업무 더블클릭 → 수정 페이지로 이동 (응급 조치)
  gantt.attachEvent("onTaskDblClick", function(id, e) {
    const task = gantt.getTask(id);
    if (!task || !task.id) {
      return false;
    }
    
    // 페이지 이동 방식으로 수정
    window.location.href = `/projectTask/taskEditModal?taskNo=\${task.id}`;
    return false;
  });
  
  
  // ✅ 초기 실행
  setScale("day");
  loadGanttData();
})();
</script>
```