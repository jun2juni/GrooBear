<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- DHTMLX Gantt CSS & JS -->
<link rel="stylesheet" href="https://cdn.dhtmlx.com/gantt/edge/dhtmlxgantt.css">
<script src="https://cdn.dhtmlx.com/gantt/edge/dhtmlxgantt.js"></script>

<div class="card">
  <div class="card-header d-flex justify-content-between align-items-center">
    <h5 class="card-title mb-0">프로젝트 간트차트</h5>
  </div>
  <div class="card-body">
    <div id="gantt_here" style="width: 100%; height: 600px;"></div>
  </div>
</div>

<script>
(function () {
  const prjctNo = "${prjctNo}";

  if (!prjctNo) {
    console.error("프로젝트 번호 누락");
    return;
  }

//간트 초기화 전에 날짜 파싱 방식을 커스터마이징
  gantt.templates.parse_date = function(date) {
      // 날짜가 문자열로 오는 경우 Date 객체로 변환
      if (typeof date === "string") {
          // "yyyy-MM-dd HH:mm" 형식 파싱
          let parts = date.split(' ');
          let dateParts = parts[0].split('-');
          let timeParts = parts[1].split(':');
          
          return new Date(
              parseInt(dateParts[0]), 
              parseInt(dateParts[1])-1, // 월은 0부터 시작
              parseInt(dateParts[2]),
              parseInt(timeParts[0]),
              parseInt(timeParts[1])
          );
      }
      return date; // 이미 Date 객체인 경우
  };

  gantt.templates.format_date = function(date) {
      // Date 객체를 "yyyy-MM-dd HH:mm" 형식 문자열로 변환
      if (date instanceof Date) {
          let year = date.getFullYear();
          let month = String(date.getMonth() + 1).padStart(2, '0');
          let day = String(date.getDate()).padStart(2, '0');
          let hours = String(date.getHours()).padStart(2, '0');
          let minutes = String(date.getMinutes()).padStart(2, '0');
          
          return `${year}-${month}-${day} ${hours}:${minutes}`;
      }
      return date; // 이미 문자열인 경우
  };
  
  
  // 기본 간트 설정
  gantt.config.xml_date = "%Y-%m-%d %H:%i";
  gantt.config.date_format = "%Y-%m-%d %H:%i";
  gantt.config.scale_unit = "day";
  gantt.config.date_scale = "%d %M";
  gantt.config.columns = [
    { name: "text", label: "업무명", width: "*", tree: true },
    { name: "owner", label: "담당자", align: "center" },
    { name: "start_date", label: "시작일", align: "center" },
    { name: "end_date", label: "종료일", align: "center" },
    { name: "duration", label: "기간", align: "center" },
    { name: "status", label: "상태", align: "center" },
    { name: "priority", label: "우선순위", align: "center" }
  ];

  gantt.config.readonly = true;
  gantt.init("gantt_here");

  fetch("/project/gantt/data?prjctNo=" + prjctNo)
  .then(res => res.json())
  .then(data => {
      if (data.error) {
          console.error("🚨 서버 오류:", data.error);
          document.getElementById("gantt_here").innerHTML = "<div class='alert alert-danger'>서버 오류: " + data.error + "</div>";
          return;
      }
      
      // 데이터 형식 수정 - 날짜 문자열을 Date 객체로 변환
      data.data.forEach(task => {
          // 날짜 문자열을 Date 객체로 변환
          if (task.start_date) {
              let parts = task.start_date.split(' ');
              if (parts.length === 2) {
                  let dateParts = parts[0].split('-');
                  let timeParts = parts[1].split(':');
                  
                  // JavaScript의 Date 생성자는 월을 0부터 시작하므로 월에서 1을 빼야 함
                  let year = parseInt(dateParts[0]);
                  let month = parseInt(dateParts[1]) - 1; 
                  let day = parseInt(dateParts[2]);
                  let hours = parseInt(timeParts[0]);
                  let minutes = parseInt(timeParts[1]);
                  
                  // 문자열 대신 Date 객체를 직접 설정
                  task.start_date = new Date(year, month, day, hours, minutes);
              }
          }
          
          if (task.end_date) {
              let parts = task.end_date.split(' ');
              if (parts.length === 2) {
                  let dateParts = parts[0].split('-');
                  let timeParts = parts[1].split(':');
                  
                  let year = parseInt(dateParts[0]);
                  let month = parseInt(dateParts[1]) - 1;
                  let day = parseInt(dateParts[2]);
                  let hours = parseInt(timeParts[0]);
                  let minutes = parseInt(timeParts[1]);
                  
                  task.end_date = new Date(year, month, day, hours, minutes);
              }
          }
      });
      
      console.log("변환된 간트 데이터:", data);
      
      try {
          gantt.parse(data);
          console.log("간트 파싱 성공");
      } catch(e) {
          console.error("간트 파싱 오류:", e);
      }
  })
  .catch(err => {
      console.error("🚨 Gantt 데이터 로딩 오류:", err);
      document.getElementById("gantt_here").innerHTML = "<div class='alert alert-danger'>데이터 로딩 오류: " + err.message + "</div>";
  });

})();
</script>
