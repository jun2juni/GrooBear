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
	
<!--스타일태그시작  -->
<style>
  .chart-container {
    width: auto;
    /* max-width: 900px; */
    height: 450px;
  }

   #dynamicInputYears {
         display: none;
    }
   #dynamicInputMonths {
         display: none;
    }
   #dynamicInputDays {
         display: none;
    }
  
</style>
<!--스타일태그끝  -->
	
	
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
	        ['2014', 800, 400, 200],
	        ['2015', 750, 460, 250],
	        ['2016', 800, 1120, 300],
	        ['2017', 1030, 540, 350]
	    ]);
	
	   console.log("데이터 로딩 완료");
	    var materialOptions = {
	        chart: {
	            title: 'Company Performance',
	            subtitle: 'Sales, Expenses, and Profit: 2014-2017',
	        }
	    };
	
	    var materialChart = new google.charts.Bar(document.getElementById('columnchart_material'));
	    materialChart.draw(materialData, google.charts.Bar.convertOptions(materialOptions));
	    /* 세로막대 materialChart - 세로막대그래프 끝 */
	    console.log("차트 그리기 완료");
	    
	    /* Donut chart = 도넛차트 - 도넛차트시작 */
	    var donutData = google.visualization.arrayToDataTable([
	          ['Task', 'Hours per Day'],
	          ['백현명',     3],
	          ['박현준',      4],
	          ['기타',  2],
	        ]);

	        var donutOptions = {
	          title: '개발 1팀 지각비율',
	          pieHole: 0.4,
	        };

	        var donutChart = new google.visualization.PieChart(document.getElementById('donutChart'));
	        donutChart.draw(donutData, donutOptions);
	    /* Donut chart = 도넛차트 - 도넛차트시작 */
        	}
	
	let comboChartType = 'line'; // 콤보차트 그래프 기본형태 -차 후 동적 변동 예정 
	// 콤보차트 예시 
	function drawVisualization() {
        // Some raw data (not necessarily accurate)
        var data = google.visualization.arrayToDataTable([
          ['2025매출실적', 'HJ건설', 'DH리테일', 'JH커피', 'SJ푸드', 'SS로지스', 'HSN아트'],
          ['2025/01',  165,      938,         522,             998,           450,      614.6],
          ['2025/02',  135,      1120,        599,             1268,          288,      682],
          ['2025/03',  157,      1167,        587,             807,           397,      623],
          ['2025/04',  139,      1110,        615,             968,           215,      609.4],
          ['2025/05',  136,      691,         629,             1026,          366,      569.6]
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

	 // 차트 타입 변경 함수
	 function updateChartType() {
            chartType = document.getElementById('chartType').value;
            drawVisualization();
     }
	
	 function handleIntervalChange(event) {
		  const { name,value } = event.target;
		  let dynamicInputYearsDom = document.querySelector("#dynamicInputYears");
		  let dynamicInputMonthsDom = document.querySelector("#dynamicInputMonths");
		  let dynamicInputDaysDom = document.querySelector("#dynamicInputDays");

		  if (value === "year") {
		    dynamicInputYearsDom?.classList.add("d-block");
		    dynamicInputYearsDom?.classList.remove("d-none");

		    dynamicInputMonthsDom?.classList.add("d-none");
		    dynamicInputMonthsDom?.classList.remove("d-block");

		    dynamicInputDaysDom?.classList.add("d-none");
		    dynamicInputDaysDom?.classList.remove("d-block");
		  }

		  if (value === "month") {
		    dynamicInputYearsDom?.classList.add("d-none");
		    dynamicInputYearsDom?.classList.remove("d-block");

		    dynamicInputMonthsDom?.classList.add("d-block");
		    dynamicInputMonthsDom?.classList.remove("d-none");

		    dynamicInputDaysDom?.classList.add("d-none");
		    dynamicInputDaysDom?.classList.remove("d-block");
		  }

		  if (value === "day") {
		    dynamicInputYearsDom?.classList.add("d-none");
		    dynamicInputYearsDom?.classList.remove("d-block");

		    dynamicInputMonthsDom?.classList.add("d-none");
		    dynamicInputMonthsDom?.classList.remove("d-block");

		    dynamicInputDaysDom?.classList.add("d-block");
		    dynamicInputDaysDom?.classList.remove("d-none");
		  }
		}

		document.querySelectorAll("input[name=interval]").forEach((item) => {
		  item.addEventListener("change", handleIntervalChange);
		  item.setAttribute("onclick", "handleIntervalChange(event)");
		});

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
	        <button class="nav-link" id="tab1" data-bs-toggle="tab" data-bs-target="#content1" type="button" onClick="location.href='statisticsHome'"
	         role="tab" aria-controls="content1" aria-selected="true">Home</button>
	      </li>
	      <li class="nav-item" role="presentation">
	        <button class="nav-link active" id="tab2" data-bs-toggle="tab" data-bs-target="#content2" type="button" role="tab" aria-controls="content2" aria-selected="false">직원관리</button>
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
		  <div class="tab-pane fade" id="content1" role="tabpanel" aria-labelledby="tab1">
	      	<!--home 탭키 내부입니다.  -->
	      </div>
	      
	      <div class="tab-pane fade show active" id="content2" role="tabpanel">
			  <ul class="nav nav-pills">
			    <li class="nav-item">
			      <a class="nav-link active" href="#">결근</a> <!-- active 클래스 위치 수정 -->
			    </li>
			    <li class="nav-item">
			      <a class="nav-link" href="#">지각/조퇴</a>
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
							<!-- 연, 월, 일 선택 라디오 버튼 -->
							<form action="" name="">
								<legend>통계 기간 설정</legend>
								<div class="form-check radio-style mb-20">
								<input class="form-check-input" type="radio" name="interval" value="year" id="year" onClick="handleIntervalChange()">
								<label class="form-check-label" for="year">연간</label>
								</div>
								<div class="form-check radio-style mb-20">
								<input class="form-check-input" type="radio" name="interval" value="month" id="month" onClick="handleIntervalChange()">
								<label class="form-check-label" for="month">월간</label>
								</div>
								<div class="form-check radio-style mb-20">
								<input class="form-check-input" type="radio" name="interval" value="day" id="day" onClick="handleIntervalChange()">
								<label class="form-check-label" for="day">일간</label>
								</div>
							</form>  
							
							<!-- 동적으로 변경될 입력 필드 --> <!-- 기본적으로 숨겨둠 -->
							<div id="dynamicInputYears" >
								<div class="card-style mb-30">
									<h6 class="mb-25">연간 선택</h6>
										<div class="select-style-1 form-group w-fit">
								            <label for="startYears" class="form-label">시작년도</label>
								            <select name="startYears" class="form-select" id="startYears" >
								              <option selected="" disabled="" readonly="" value="">조회를 시작 할 년도를 선택해주세요</option>
										      <option value="2025">2025</option>
										      <option value="2024">2024</option>
									       	  <option value="2023">2023</option>
									       	  <option value="2023">2022</option>
									          <option value="2023">2021</option>
								            </select>
								         </div> 
										<div class="select-style-1 form-group w-fit">
								            <label for="endYears" class="form-label">종료년도</label>
								            <select name="endYears" class="form-select" id="endYears" >
								              <option selected="" disabled="" readonly="" value="">조회를 종료 할 년도를 선택해주세요</option>
											      <option value="2025">2025</option>
											      <option value="2024">2024</option>
										       	  <option value="2023">2023</option>
										       	  <option value="2023">2022</option>
										          <option value="2023">2021</option>
								            </select>
								         </div> 
								         <!--셀렉트 끝  -->
	  							</div><!--year  -->
  							</div><!--dynamicInputYears 끝  -->
  							
							<div id="dynamicInputMonths">
								<div class="card-style mb-30">
									<h6 class="mb-25">월간 선택</h6>
									<div class="select-style-1 form-group w-fit">
									<label for="startMonths" class="form-label">시작월</label>
								    <select name="startMonths" class="form-select" id="startMonths" >
								    	<option selected="" disabled="" readonly="" value="">조회를 종료 할 월을 선택해주세요</option>
								    		<option value="Jan">1월</option>
									        <option value="Feb">2월</option>
									        <option value="Mar">3월</option>
									        <option value="Apr">4월</option>
									        <option value="May">5월</option>
									        <option value="Jun ">6월</option>
									        <option value="Jul">7월</option>
									        <option value="Aug">8월</option>
									        <option value="Sep">9월</option>
									        <option value="Oct">10월</option>
									        <option value="Nov">11월</option>
									        <option value="Dec">12월</option>	
									  </select><br>
									<label for="startMonths" class="form-label">시작월</label>
								    <select name="startMonths" class="form-select" id="startMonths" >
								    	<option selected="" disabled="" readonly="" value="">조회를 종료 할 월을 선택해주세요</option>
								    		<option value="Jan">1월</option>
									        <option value="Feb">2월</option>
									        <option value="Mar">3월</option>
									        <option value="Apr">4월</option>
									        <option value="May">5월</option>
									        <option value="Jun ">6월</option>
									        <option value="Jul">7월</option>
									        <option value="Aug">8월</option>
									        <option value="Sep">9월</option>
									        <option value="Oct">10월</option>
									        <option value="Nov">11월</option>
									        <option value="Dec">12월</option>	
									  </select>       
								</div>
  							</div>
  						</div>
							<div id="dynamicInputDays">
								<div class="card-style mb-30">
									<h6 class="mb-25">특정 기간 조회</h6>
									<div class="input-style-1">
									  <label>시작일</label>
									  <input type="date" data-listener-added_846ff8c4="true">
									</div>
									<div class="input-style-1">
									  <label>종료일</label>
									  <input type="date" data-listener-added_846ff8c4="true">
									</div>
									<!-- end input -->
								 </div>
  							</div>
  							
							<form action="">
								<div class="select-style-1 form-group w-fit">
									<select name="dept" class="form-select" id="dept" >
									<label for="chartType" class="form-label">차트 유형 선택:</label>
									<select id="chartType" onchange="updateChartType()">
									  <option selected="" disabled="" readonly="" value="">직급을 선택해주세요</option>
									  <option value="01">인턴</option>
									  <option value="02">사원</option>
									</select>
									<div class="invalid-feedback">직급을 선택해주세요.</div>
								</div>
								<label for="chartType">차트 유형 선택:</label>
								<select id="chartType" onchange="updateChartType()">
									<option value="line">선형(Line)</option>
									<option value="bars">막대(Bar)</option>
									<option value="area">영역(Area)</option>
								</select>
							</form>
                			<!-- end radio -->
              			</div>
				</div> <!-- 카드끝 -->
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
