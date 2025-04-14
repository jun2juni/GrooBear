<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="통계" />

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<meta
			name="viewport"
			content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"
	/>
	<meta http-equiv="X-UA-Compatible" content="ie=edge" />
	<title>${title}</title>
	<c:import url="../layout/prestyle.jsp" />

<style>
  .chart-container {
    width: auto;
    /* max-width: 900px; */
    height: 450px;
  }
</style>

	
	
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<script type="text/javascript">
	/* 구글차트 패키지모음******* */
	google.charts.load('current', { packages: ['bar', 'corechart']});
	google.charts.setOnLoadCallback(drawChart);
	google.charts.setOnLoadCallback(drawVisualization);
	/* 구글차트 패키지모음********* */ 
	
     /* drawChart  */
	function drawChart() {
		/* 실행여부확인  */
		console.log("drawchart실행됨");
		
	   /*  materialChart  - 세로막대그래프 시작 */
	   var materialData = google.visualization.arrayToDataTable([
	        ['Year', '매출목표', '매출실적', '실수익'],
	        ['2020', 800, 500, 300,],
	        ['2021', 800, 350, 250,],
	        ['2022', 800, 600, 250,],
	        ['2023', 800, 900, 300,],
	        ['2024', 800, 1000, 400,],

	    ]);
	
	   console.log("데이터 로딩 완료");
	    var materialOptions = {
	        chart: {
	            title: '',
	            subtitle: '',
	        }
	    };
	
	    var materialChart = new google.charts.Bar(document.getElementById('columnchart_material'));
	    materialChart.draw(materialData, google.charts.Bar.convertOptions(materialOptions));
	    /* 세로막대 materialChart - 세로막대그래프 끝 */
	    console.log("차트 그리기 완료");
	    
	    /* Donut chart = 도넛차트 - 도넛차트시작 */
	    var donutData = google.visualization.arrayToDataTable([
	          ['Task', 'Hours per Day'],
	          ['HJ건설',     3],
	          ['DH리테일',      4],
	          ['SS로지스',      6],
	          ['HSN아트',      1],
	          ['SS로지스',      5],
	          ['SJ푸드',      2],
	          ['기타',  2],
	        ]);

	        var donutOptions = {
	          title: '영업 이익 비율',
	          pieHole: 0.1,
	        };

	        var donutChart = new google.visualization.PieChart(document.getElementById('donutChart'));
	        donutChart.draw(donutData, donutOptions);
	    /* Donut chart = 도넛차트 - 도넛차트시작 */
        	}
	
	let comboChartType = 'bars'; // 콤보차트 그래프 기본형태 -차 후 동적 변동 예정 
	// 콤보차트 예시 
	function drawVisualization() {
        // Some raw data (not necessarily accurate)
        var data = google.visualization.arrayToDataTable([
          ['2025매출실적', 'HJ건설', 'DH리테일', 'JH커피', 'SJ푸드', 'SS로지스', 'HSN아트',],
          ['2025/01',  165,      938,         522,             998,           450,      614.6],
          ['2025/02',  135,      1120,        599,             1268,          288,      682],
          ['2025/03',  157,      1167,        587,             807,           397,      623],
          ['2025/04',  139,      1110,        615,             968,           215,      609.4],
          ['2025/05',  136,      691,         629,             1026,          366,      569.6],
        ]);

        var options = {
          title : '2025 계약현황',
          vAxis: {title: '매출금 (단위:10,000)'},
          hAxis: {title: '2025 월'},
          seriesType: comboChartType,
          series: {5: {type: ''}}
        };

        var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
	// 콤보차트 끝 	 

        
	</script>
 
</head>
<body>
<c:import url="../layout/sidebar.jsp" />
<main class="main-wrapper">
	<c:import url="../layout/header.jsp" />
	
	<section class="section mt-4">
		<div class="container-fluid">
		<div class="row mt-5">
			<div class="col-12">
				<div class="card-style">
			<!-- 상위탭 시작  -->
		<div>
			<ul class="nav nav-tabs" id="myTab" role="tablist">
	      <li class="nav-item" role="presentation">
	        <button class="nav-link active" id="tab1" data-bs-toggle="tab" data-bs-target="#content1" type="button" role="tab" aria-controls="content1" aria-selected="true">Home</button>
	      </li>
	      <li class="nav-item" role="presentation">
	        <button class="nav-link" id="tab2" data-bs-toggle="tab" data-bs-target="#content2" type="button" role="tab" aria-controls="content2" aria-selected="false">직원관리</button>
	      </li>
	      <li class="nav-item" role="presentation">
	        <button class="nav-link" id="tab3" data-bs-toggle="tab" data-bs-target="#content3" type="button" role="tab" aria-controls="content3" aria-selected="false">재무</button>
	      </li>
	      <li class="nav-item" role="presentation">
	        <button class="nav-link" id="tab4" data-bs-toggle="tab" data-bs-target="#content4" type="button" role="tab" aria-controls="content4" aria-selected="false">프로젝트관리</button>
	      </li>
	    </ul>
		</div>
		<!-- 상위탭 시작  -->
		
		<!-- 하위탭 시작  -->
		<div class="tab-content mt-3" id="myTabContent">
		  <div class="tab-pane fade active" id="content1" role="tabpanel" aria-labelledby="tab1">
	      </div>
	      <div class="tab-pane fade" id="content2" role="tabpanel">
	        <ul class="nav nav-pills">
	        <!-- Absenteeism Rate 결근율 -->
	          <li class="nav-item">
	            <a class="nav-link " href="http://localhost/statistics/statisticsAWOL">결근</a>
	          </li>
	          <!-- 지각-조퇴율, AttendLateChart  -->
	          <li class="nav-item">
	            <a class="nav-link" href="http://localhost/statistics/statisticsLATE">지각/조퇴</a>
	          </li>
	        </ul>
	      </div>
	      
	      <div class="tab-pane fade" id="content3" role="tabpanel" aria-labelledby="tab2">
	        <ul class="nav nav-pills">
	        	<!--Spending Rate 지출율  -->
	          <li class="nav-item">
	            <a class="nav-link "  href="#">지출 예정대비 지출율</a>
	          </li>
	          <!--roa = return on assets 약차 (수금율)  -->
	          <li class="nav-item">
	            <a class="nav-link" href="#">수금 예측대비 수금율</a>
	          </li>
	          <!-- ror = rate of return 수익율-->
	          <li class="nav-item">
	            <a class="nav-link" href="#">예상 실 수익율 대비 수익율</a>
	          </li>
	          <!-- 지출예정율 -->
	          <li class="nav-item">
	            <a class="nav-link" href="#">총 예산 대비 항목별 지출 예정 비율</a>
	          </li>
	      </div>
	      <div class="tab-pane fade" id="content4" role="tabpanel" aria-labelledby="tab3">
	       <!-- keyPerformanceIndicator-->
	        <ul class="nav nav-pills">
	          <li class="nav-item">
	            <a class="nav-link "  href="#">직급 별 업무기여도 달성율</a>
	          </li>
	          <!--Hire And Leaving (입,퇴사자) 통계  -->
	          <li class="nav-item">
	            <a class="nav-link" href="#">입,퇴사자</a>
	          </li>
	          <!--Long Term Employeement 장기 근속율   -->
	          <li class="nav-item">
	            <a class="nav-link" href="#">장기 근속 율</a>
	          </li>
	      </div>
	      <div class="tab-pane fade" id="content5" role="tabpanel" aria-labelledby="tab4">
	        <ul class="nav nav-pills">
	          <li class="nav-item">
	            <a class="nav-link "  href="#">프로젝트별 업무 기여도</a>
	          </li>
	          <!--Project Acheviement Rate  -->
	          <li class="nav-item">
	            <a class="nav-link" href="#">프로젝트 별 달성율</a>
	          </li>
	          <!-- Task Achievement Rate -->
	          <li class="nav-item">
	            <a class="nav-link" href="#">과제 달성율</a>
	          </li>
	      </div>
	      <div class="tab-pane fade" id="content6" role="tabpanel" aria-labelledby="tab5">
	        <ul class="nav nav-pills">
	          <li class="nav-item">
	            <a class="nav-link "  href="http://localhost/1demo/table">표</a>
	          </li>
	      </div>
	    </div>
	    <!-- 하위탭 끝  -->
	    <!-- 그래프 내부카드  -->
		    <div class="row mt-5">
				<div class="col-12">
						<div class="card-style">
							<div id="columnchart_material" class="chart-container"></div>
							<div id="donutChart" class="chart-container"></div>
							<div id="chart_div" class="chart-container" ></div>
						</div>
				</div>
						 
				</div>
			</div>
		<!-- 그래프 내부카드  -->	
			</div>
		</div>
	</div>
	</section>
  <%@ include file="../layout/footer.jsp" %>
</main>
<%@ include file="../layout/prescript.jsp" %>

</body>
</html>
