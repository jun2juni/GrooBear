<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 간트 차트 CSS와 JS 라이브러리 로드 -->
<link rel="stylesheet"
	href="https://cdn.dhtmlx.com/gantt/edge/dhtmlxgantt.css">
<script src="https://cdn.dhtmlx.com/gantt/edge/dhtmlxgantt.js"></script>

<div class="card">
	<div
		class="card-header d-flex justify-content-between align-items-center">
		<h5 class="card-title mb-0">프로젝트 간트차트</h5>
		<span class="badge bg-primary">프로젝트 번호: ${prjctNo}</span>
	</div>
	<div class="card-body">
		<div id="ganttChartContainer" style="height: 600px; width: 100%;"></div>
	</div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function() {
  initGanttChart();
});

function initGanttChart() {
	  // 프로젝트 번호 가져오기
	  const prjctNo = parseInt("${prjctNo}" || "0");
	  console.log("간트차트 초기화 - 프로젝트 번호:", prjctNo);

	  // 프로젝트 번호가 유효하지 않으면 오류 메시지 표시
	  if (!prjctNo || prjctNo <= 0) {
	    console.error("유효하지 않은 프로젝트 번호:", prjctNo);
	    document.getElementById("ganttChartContainer").innerHTML = 
	      "<div class='alert alert-warning'>유효한 프로젝트 번호가 필요합니다. 프로젝트를 선택해주세요.</div>";
	    return;
	  }

	  // 상태 및 우선순위 코드 정의 (서버에서 전달된 JSTL 리스트 사용)
	  const taskStatusMap = {
	    <c:forEach var="code" items="${taskSttusList}" varStatus="codeStatus">
	      "${code.cmmnCode}": "${code.cmmnCodeNm}"<c:if test="${!codeStatus.last}">,</c:if>
	    </c:forEach>
	  };
	  console.log("상태 코드 맵:", taskStatusMap);

	  const priorityColorMap = {
	    "A": "#f44336", // red
	    "B": "#ff9800", // orange
	    "C": "#ffeb3b", // yellow
	    "D": "#4caf50", // green
	    "E": "#2196f3"  // blue
	  };

	  // 간트 차트 날짜 형식 설정
	  gantt.config.xml_date = "%Y-%m-%d %H:%i";
	  gantt.config.date_format = "%Y-%m-%d %H:%i";
	  
	// 데이터 파서 설정 - 날짜 파싱 로직 추가
gantt.attachEvent("onBeforeParse", function(data) {
  if (data && data.data) {
    data.data.forEach(function(task) {
      // 날짜 형식 확인 및 변환
      try {
        // 시작일, 종료일이 문자열 또는 timestamp인 경우 처리
        if (task.start_date) {
          // 이미 Date 객체인 경우 그대로 사용
          if (!(task.start_date instanceof Date)) {
            task.start_date = new Date(task.start_date);
          }
        } else {
          task.start_date = new Date(); // 기본값: 현재 날짜
          console.log("시작일 null 설정:", task.text);
        }
        
        if (task.end_date) {
          // 이미 Date 객체인 경우 그대로 사용
          if (!(task.end_date instanceof Date)) {
            task.end_date = new Date(task.end_date);
          }
        } else {
          // 종료일이 없으면 시작일 +1일
          let endDate = new Date(task.start_date);
          endDate.setDate(endDate.getDate() + 1);
          task.end_date = endDate;
          console.log("종료일 null 설정:", task.text);
        }
        
        // 시작일과 종료일이 같은 경우 처리
        if (task.start_date.getTime() === task.end_date.getTime()) {
          let endDate = new Date(task.start_date);
          endDate.setDate(endDate.getDate() + 1);
          task.end_date = endDate;
          console.log("시작일=종료일 수정:", task.text);
        }
        
        // 진행률 설정
        if (task.progress === null || task.progress === undefined || isNaN(task.progress)) {
          task.progress = 0;
          console.log("진행률 null 설정:", task.text);
        } else {
          // 숫자가 아니면 숫자로 변환 (100% 기준을 0-1 스케일로 변환)
          if (typeof task.progress === 'string') {
            task.progress = parseFloat(task.progress) / 100;
          } else if (task.progress > 1) {
            task.progress = task.progress / 100;
          }
        }
      } catch (e) {
        console.error("날짜 변환 오류:", e, task);
        // 오류 발생 시 기본값 설정
        task.start_date = new Date();
        let endDate = new Date();
        endDate.setDate(endDate.getDate() + 1);
        task.end_date = endDate;
        task.progress = 0;
      }
    });
  }
  return true;
});
	
//날짜 처리 관련 추가 설정
gantt.config.work_time = false; // 주말도 작업일로 포함
gantt.config.correct_work_time = false; // 작업 시간 자동 조정 비활성화
gantt.config.skip_off_time = false; // 휴일 건너뛰기 비활성화
	  
	  // 간트 차트 열 설정 - 업무명, 시작일, 종료일, 진행률, 상태
	  gantt.config.columns = [
	    { name: "text", label: "업무명", tree: true, width: "*" },
	    { name: "start_date", label: "시작일", align: "center", width: 80 },
	    { name: "end_date", label: "종료일", align: "center", width: 80 },
	    { name: "progress", label: "진행률", align: "center", width: 60, template: function(task) {
	      return Math.round((task.progress || 0) * 100) + "%";
	    }},
	    { name: "status", label: "상태", align: "center", width: 80, template: function(task) {
	      return taskStatusMap[task.status] || "미정";
	    }},
	    { name: "add", label: "", width: 44 }
	  ];

	  // 작업 클래스 스타일링 (우선순위에 따른 색상)
	  gantt.templates.task_class = function(start, end, task) {
	    let base = "gantt_task";
	    if (task.priority && priorityColorMap[task.priority]) {
	      return base + " task-priority-" + task.priority;
	    }
	    return base;
	  };

	  // 우선순위 색상 스타일 동적 주입
	  for (const [priority, color] of Object.entries(priorityColorMap)) {
	    const style = document.createElement("style");
	    style.innerHTML = `
	      .task-priority-\${priority} .gantt_task_progress {
	        background-color: \${color} !important;
	      }
	      .task-priority-\${priority} .gantt_task_content {
	        color: #ffffff;
	      }
	    `;
	    document.head.appendChild(style);
	  }

	  // 작업 툴팁 커스터마이징
	  gantt.templates.tooltip_text = function(start, end, task) {
	    const statusText = taskStatusMap[task.status] || "미정";
	    const ownerText = task.owner || "미지정";
	    
	    return `<div class="gantt-tooltip">
	      <strong>${task.text}</strong><br>
	      <span>시작: \${gantt.templates.tooltip_date_format(start)}</span><br>
	      <span>종료: \${gantt.templates.tooltip_date_format(end)}</span><br>
	      <span>진행률: \${Math.round((task.progress || 0) * 100)}%</span><br>
	      <span>상태: \${statusText}</span><br>
	      <span>담당자: \${ownerText}</span>
	    </div>`;
	  };

	  // 작업 진행률 표시 형식
	  gantt.templates.progress_text = function(start, end, task) {
	    return Math.round((task.progress || 0) * 100) + "%";
	  };

	  // 라이트박스(작업 편집 팝업) 설정
	  gantt.config.lightbox.sections = [
	    { name: "description", height: 38, map_to: "text", type: "textarea", focus: true },
	    { name: "time", height: 72, map_to: "auto", type: "duration" },
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
	    { name: "priority", height: 22, map_to: "priority", type: "select", options: [
	      { key: "", label: "선택하세요" },
	      { key: "A", label: "A (긴급)" },
	      { key: "B", label: "B (높음)" },
	      { key: "C", label: "C (보통)" },
	      { key: "D", label: "D (낮음)" },
	      { key: "E", label: "E (미정)" }
	    ]},
	    { name: "status", height: 22, map_to: "status", type: "select", options: 
	      Object.entries(taskStatusMap).map(([key, value]) => ({ key, label: value }))
	    }
	  ];

	  // 라이트박스 필드 레이블
	  gantt.locale.labels.section_description = "업무명";
	  gantt.locale.labels.section_time = "기간";
	  gantt.locale.labels.section_progress = "진행률";
	  gantt.locale.labels.section_priority = "우선순위";
	  gantt.locale.labels.section_status = "상태";

	  try {
	    // 간트 차트 초기화
	    gantt.init("ganttChartContainer");
	    console.log("간트차트 초기화 성공");
	    
	    // 데이터 로드
	    console.log("간트차트 데이터 로드 시작 - URL:", "/project/gantt/data?prjctNo=" + prjctNo);
	    gantt.load("/project/gantt/data?prjctNo=" + prjctNo, function() {
	      console.log("간트차트 데이터 로드 완료");
	    });

	    // 데이터프로세서 설정 (REST 방식)
	    const dp = new gantt.dataProcessor("/project/gantt");
	    dp.init(gantt);
	    dp.setTransactionMode("REST");
	    
	    // 데이터프로세서 이벤트 핸들러
	    dp.attachEvent("onAfterUpdate", function(id, action, tid, response) {
	      console.log("데이터 업데이트:", action, id, response);
	      // 성공 메시지 표시 가능
	    });
	    
	    dp.attachEvent("onError", function(text, data) {
	      console.error("데이터 처리 오류:", text, data);
	      alert("작업 처리 중 오류가 발생했습니다: " + text);
	    });

	    // 작업 생성 이벤트
	    gantt.attachEvent("onAfterTaskAdd", function(id, task) {
	      console.log("새 작업 생성:", id, task);
	      // 추가 로직이 필요하면 여기에 구현
	    });

	    // 작업 수정 이벤트
	    gantt.attachEvent("onAfterTaskUpdate", function(id, task) {
	      console.log("작업 수정:", id, task);
	      // 추가 로직이 필요하면 여기에 구현
	    });

	    // 작업 삭제 이벤트
	    gantt.attachEvent("onAfterTaskDelete", function(id) {
	      console.log("작업 삭제:", id);
	      // 추가 로직이 필요하면 여기에 구현
	    });

	    // 링크 생성 이벤트
	    gantt.attachEvent("onAfterLinkAdd", function(id, link) {
	      console.log("새 링크 생성:", id, link);
	      // 추가 로직이 필요하면 여기에 구현
	    });

	    console.log("간트차트 초기화 완료");
	  } catch (error) {
	    console.error("간트차트 초기화 실패:", error);
	    document.getElementById("ganttChartContainer").innerHTML = 
	      `<div class='alert alert-danger'>간트차트 초기화 실패: \${error.message}</div>`;
	  }
	}


//gantt.jsp의 데이터 로드 부분 수정(끝까지 테스트 코드 )
console.log("간트차트 데이터 로드 시작 - URL:", "/project/gantt/data?prjctNo=" + prjctNo);

// 테스트 데이터 추가 (임시)
const testData = {
  data: [
    {id: 1, text: "테스트 업무 1", start_date: "2025-04-01 00:00", end_date: "2025-04-10 00:00", progress: 0.6, priority: "A"},
    {id: 2, text: "테스트 업무 2", start_date: "2025-04-05 00:00", end_date: "2025-04-15 00:00", progress: 0.4, priority: "B"}
  ],
  links: [
    {id: 1, source: 1, target: 2, type: "0"}
  ]
};

// 실제 데이터 로드하기 전에 테스트 데이터로 확인
gantt.parse(testData);
console.log("테스트 데이터 로드 완료");

// 실제 데이터 로드 (이 부분은 테스트 후 주석 해제)
/*
gantt.load("/project/gantt/data?prjctNo=" + prjctNo, function() {
  console.log("간트차트 데이터 로드 완료");
});
*/
//데이터 로드 후 콜백

// 디버깅 코드
gantt.attachEvent("onLoadEnd", function() {
  console.log("로드된 데이터:", gantt.getTaskByTime());
  
  // 시작일/종료일 확인
  gantt.getTaskByTime().forEach(function(task) {
    console.log("업무:", task.text, 
                "시작일:", task.start_date, 
                "종료일:", task.end_date,
                "진행률:", task.progress);
  });
});

//추가적인 간트 차트 설정
gantt.config.fit_tasks = true; // 업무가 차트에 맞게 표시
gantt.config.date_grid = "%Y-%m-%d"; // 그리드 날짜 형식
gantt.config.duration_unit = "day"; // 기간 단위
gantt.config.row_height = 30; // 행 높이
gantt.config.min_column_width = 30; // 최소 열 너비


</script>