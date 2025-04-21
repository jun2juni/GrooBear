// 간트 차트 모듈
(function() {
  // 상태 매핑
  const ganttStatusMap = {
    "00": "대기",
    "01": "진행중", 
    "02": "완료",
    "03": "피드백",
    "04": "변경"
  };

  // 초기화 함수
  function initGanttChart() {
    // 프로젝트 번호 가져오기
    const projectNumberElement = document.getElementById("projectNumber");
    if (!projectNumberElement) return;
    
    const projectNumber = projectNumberElement.getAttribute("data-prjct-no") || "";
    if (!projectNumber) {
      showNoDataMessage("프로젝트 번호가 없습니다.");
      return;
    }
    
    // 이벤트 핸들러 설정
    setupEventHandlers();
    
    // 간트 차트 설정
    setupGanttConfig();
    
    // 간트 차트 렌더링
    renderGanttChart(projectNumber);
  }
  
  // 이벤트 핸들러 설정
  function setupEventHandlers() {
    // 업무 추가 버튼
    const addTaskBtn = document.getElementById("addGanttTaskBtn");
    if (addTaskBtn) {
      addTaskBtn.addEventListener("click", function() {
        if (window.gantt) {
          const task = {
            text: "새 업무",
            start_date: new Date(),
            duration: 3,
            progress: 0,
            status: "00"
          };
          window.gantt.addTask(task);
        }
      });
    }
    
    // 업무 추가 폼
    const addTaskForm = document.getElementById("addTaskForm");
    if (addTaskForm) {
      addTaskForm.addEventListener("submit", function(e) {
        e.preventDefault();
        
        const taskName = document.getElementById("taskName").value;
        const startDate = new Date(document.getElementById("taskStartDate").value);
        const duration = parseInt(document.getElementById("taskDuration").value);
        
        const newTask = {
          text: taskName,
          start_date: startDate,
          duration: duration,
          progress: 0,
          status: "00"
        };
        
        try {
          window.gantt.addTask(newTask);
          alert("업무가 추가되었습니다.");
          this.reset();
        } catch (error) {
          console.error("업무 추가 오류:", error);
          alert("업무 추가 중 오류가 발생했습니다: " + error.message);
        }
      });
    }
  }
  
  // 간트 차트 설정
  function setupGanttConfig() {
    if (!window.gantt) {
      console.error("gantt 라이브러리가 로드되지 않았습니다.");
      return;
    }
    
    // 기본 설정
    window.gantt.config.date_format = "%Y-%m-%d %H:%i";
    window.gantt.config.work_time = false;
    window.gantt.config.duration_unit = "day";
    window.gantt.config.row_height = 30;
    window.gantt.config.min_column_width = 30;
    
    // 열 구성
    window.gantt.config.columns = [
      { name: "text", label: "업무명", tree: true, width: "*" },
      { name: "start_date", label: "시작일", align: "center", width: 80 },
      { name: "duration", label: "기간(일)", align: "center", width: 50 },
      { name: "progress", label: "진행률", align: "center", width: 60, template: function(task) {
        return Math.round((task.progress || 0) * 100) + "%";
      }},
      { name: "owner", label: "담당자", align: "center", width: 80 },
      { name: "status", label: "상태", align: "center", width: 80, template: function(task) {
        return ganttStatusMap[task.status] || "미정";
      }},
      { name: "add", label: "", width: 44 }
    ];
    
    // 작업 카드 스타일
    window.gantt.templates.task_class = function(start, end, task) {
      return "status-" + (task.status || "00");
    };
    
    // 툴팁 커스터마이징
    window.gantt.templates.tooltip_text = function(start, end, task) {
      const startStr = window.gantt.date.date_to_str("%Y-%m-%d")(start);
      const endStr = window.gantt.date.date_to_str("%Y-%m-%d")(end);
      
      return "<div>" +
        "<b>" + task.text + "</b><br>" +
        "<span>시작: " + startStr + "</span><br>" +
        "<span>종료: " + endStr + "</span><br>" +
        "<span>진행률: " + Math.round((task.progress || 0) * 100) + "%</span><br>" +
        "<span>상태: " + (ganttStatusMap[task.status] || "미정") + "</span><br>" +
        "<span>담당자: " + (task.owner || "미지정") + "</span>" +
        "</div>";
    };
    
    // 진행률 표시
    window.gantt.templates.progress_text = function(start, end, task) {
      return Math.round((task.progress || 0) * 100) + "%";
    };
    
    // 라이트박스 설정
    window.gantt.config.lightbox.sections = [
      { name: "description", height: 38, map_to: "text", type: "textarea", focus: true },
      { name: "time", type: "duration", map_to: "auto" },
      { name: "progress", height: 22, map_to: "progress", type: "select", options: [
        { key: 0, label: "0%" },
        { key: 0.1, label: "10%" },
        { key: 0.2, label: "20%" },
        { key: 0.3, label: "30%" },
        { key: 0.4, label: "40%" },
        { key: 0.5, label: "50%" },
        { key: 0.6, label: "60%" },
        { key: 0.7, label: "70%" },
        { key: 0.8, label: "80%" },
        { key: 0.9, label: "90%" },
        { key: 1, label: "100%" }
      ]},
      { name: "status", height: 22, map_to: "status", type: "select", options: [
        { key: "00", label: "대기" },
        { key: "01", label: "진행중" },
        { key: "02", label: "완료" },
        { key: "03", label: "피드백" },
        { key: "04", label: "변경" }
      ]},
      { name: "owner", height: 22, map_to: "owner", type: "textarea" }
    ];
    
    // 라이트박스 라벨
    window.gantt.locale.labels.section_description = "업무명";
    window.gantt.locale.labels.section_time = "기간";
    window.gantt.locale.labels.section_progress = "진행률";
    window.gantt.locale.labels.section_status = "상태";
    window.gantt.locale.labels.section_owner = "담당자";
    
    // 새 업무 생성 시 기본값 설정
    window.gantt.attachEvent("onTaskCreated", function(task) {
      task.progress = 0;
      task.status = "00"; // 대기 상태
      return true;
    });
    
    // 데이터 전처리
    window.gantt.attachEvent("onBeforeParse", function(data) {
      console.log("원본 데이터:", data);
      
      // 업무 데이터 처리
      if (data && data.data) {
        data.data = data.data.map(function(task) {
          // ID 처리
          if (!task.id && task.taskId) {
            task.id = task.taskId;
          }
          
          // 날짜 처리
          if (task.start_date && typeof task.start_date === "string") {
            task.start_date = new Date(task.start_date);
          }
          if (task.end_date && typeof task.end_date === "string") {
            task.end_date = new Date(task.end_date);
          }
          
          // 기본값 설정
          if (!task.start_date) {
            task.start_date = new Date();
          }
          if (!task.end_date) {
            let end = new Date(task.start_date);
            end.setDate(end.getDate() + 1);
            task.end_date = end;
          }
          
          // 진행률 정규화
          if (task.progress === undefined || task.progress === null) {
            task.progress = 0;
          } else if (typeof task.progress === 'number' && task.progress > 1) {
            task.progress = task.progress / 100;
          }
          
          return task;
        });
      }
      
      // 링크 데이터 처리
      if (data && data.links) {
        data.links = data.links.map(function(link) {
          // ID 처리
          if (!link.id && link.linkId) {
            link.id = link.linkId;
          }
          
          // source/target 처리
          if (!link.source && link.sourceId) {
            link.source = link.sourceId;
          }
          if (!link.target && link.targetId) {
            link.target = link.targetId;
          }
          
          return link;
        });
      }
      
      console.log("변환된 데이터:", data);
      return true;
    });
  }
  
  // 간트 차트 렌더링
  function renderGanttChart(projectNumber) {
    const container = document.getElementById("ganttChartContainer");
    if (!container) {
      console.error("간트 차트 컨테이너를 찾을 수 없습니다.");
      return;
    }
    
    // 간트 차트 초기화
    window.gantt.init(container);
    
    // 데이터 로드
    const url = "/project/gantt/data?prjctNo=" + projectNumber + "&t=" + new Date().getTime();
    console.log("간트 차트 데이터 로드 URL:", url);
    
    // 백엔드에서 데이터 가져오기
    fetch(url)
      .then(response => response.json())
      .then(data => {
        console.log("백엔드 원본 데이터:", data);
        
        // 데이터 오류 확인
        if (data.error) {
          console.error("백엔드 오류:", data.error);
          window.gantt.parse(createTestData());
          return;
        }
        
        // 빈 데이터 확인
        if (!data.data || data.data.length === 0) {
          console.log("데이터가 없습니다. 링크 개수:", data.links?.length || 0);
          
          // 링크만 있을 경우 샘플 데이터 생성
          if (data.links && data.links.length > 0) {
            try {
              createSampleTasksFromLinks(data);
            } catch (err) {
              console.error("샘플 데이터 생성 오류:", err);
              window.gantt.parse(createTestData());
            }
          } else {
            // 테스트 데이터 사용
            window.gantt.parse(createTestData());
          }
        } else {
          // 정상 데이터 파싱
          window.gantt.parse(data);
        }
      })
      .catch(err => {
        console.error("데이터 로드 오류:", err);
        window.gantt.parse(createTestData());
      });
    
    // 데이터 프로세서 설정
    const dp = new window.gantt.dataProcessor("/project/gantt");
    dp.init(window.gantt);
    dp.setTransactionMode("REST");
  }
  
  // 링크 데이터로부터 샘플 업무 생성
  function createSampleTasksFromLinks(data) {
    // 링크에서 업무 ID 추출
    const taskIds = new Set();
    data.links.forEach(link => {
      if (link.source) taskIds.add(Number(link.source));
      if (link.target) taskIds.add(Number(link.target));
    });
    
    // 유효하지 않은 ID 제거
    const validTaskIds = Array.from(taskIds).filter(id => id && !isNaN(id));
    console.log("유효한 업무 ID:", validTaskIds);
    
    if (validTaskIds.length === 0) {
      throw new Error("유효한 업무 ID가 없습니다.");
    }
    
    // 업무 데이터 생성
    const today = new Date();
    const tasks = validTaskIds.map((id, index) => {
      const startDate = new Date(today);
      startDate.setDate(startDate.getDate() + index * 2);
      
      const endDate = new Date(startDate);
      endDate.setDate(endDate.getDate() + 3);
      
      return {
        id: id,
        text: "업무 " + id,
        start_date: startDate,
        end_date: endDate,
        duration: 3,
        progress: 0.5,
        status: "01"
      };
    });
    
    // 데이터에 업무 추가
    data.data = tasks;
    
    // 간트 차트에 데이터 로드
    window.gantt.parse(data);
  }
  
  // 테스트 데이터 생성
  function createTestData() {
    const today = new Date();
    const tomorrow = new Date(today);
    tomorrow.setDate(tomorrow.getDate() + 1);
    
    const nextWeek = new Date(today);
    nextWeek.setDate(nextWeek.getDate() + 7);
    
    return {
      data: [
        {id: 1, text: "프로젝트 계획", start_date: today, duration: 3, progress: 0.6, status: "01", owner: "홍길동"},
        {id: 2, text: "요구사항 분석", start_date: tomorrow, duration: 2, progress: 0.3, status: "01", owner: "김철수"},
        {id: 3, text: "설계", start_date: nextWeek, duration: 5, progress: 0, status: "00", owner: "박영희", parent: 1}
      ],
      links: [
        {id: 1, source: 1, target: 2, type: "0"},
        {id: 2, source: 2, target: 3, type: "0"}
      ]
    };
  }
  
  // 데이터 없음 메시지 표시
  function showNoDataMessage(message) {
    const container = document.getElementById("ganttChartContainer");
    if (container) {
      container.innerHTML = 
        "<div class='alert alert-info text-center p-5'>" +
        "<i class='material-icons-outlined fs-1 mb-3'>info</i>" +
        "<p class='mb-2'>" + (message || "이 프로젝트에 등록된 업무가 없습니다.") + "</p>" +
        "<p class='small text-muted'>업무를 추가하려면 상단의 '업무 추가' 버튼을 클릭하세요.</p>" +
        "</div>";
    }
  }
  
  // DOM 로드 완료 시 초기화
  document.addEventListener("DOMContentLoaded", initGanttChart);
})();