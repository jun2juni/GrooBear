<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="통계" />
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="ie=edge" />
<title>${title}</title>
<c:import url="../layout/prestyle.jsp" />

<style type="text/css">
/*  .input-style-1 { */
/*     display: flex; /* 필드들을 한 줄에 배치 */ */
/*     align-items: center; /* 수직 중앙 정렬 */ */
/*     gap: 20px; /* 필드 간 간격 */ */
/*     flex-wrap: nowrap; /* 줄 바꿈 방지 */ */
/* } */

/* .input-style-1 label { */
/*     font-size: 14px; /* 레이블 크기 */ */
/*     margin-right: 8px; /* 레이블과 입력 필드 간 간격 */ */
/* } */

/* .input-style-1 input { */
/*     width: 200px; /* 입력 필드 길이를 줄임 */ */
/*     padding: 3px; /* 입력 필드 내부 여백 */ */
/*     border: 1px solid #ccc; /* 테두리 스타일 */ */
/*     border-radius: 4px; /* 모서리를 둥글게 */ */
/*     box-sizing: border-box; /* padding 포함 크기 계산 */ */
/*     font-size: 14px; /* 입력 필드 텍스트 크기 */ */
/* }  */


</style>
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
										<button class="nav-link active" id="tab2" data-bs-toggle="tab"
											data-bs-target="#content2" type="button" role="tab"
											aria-controls="content2" aria-selected="false">직원관리</button>
									</li>
									<li class="nav-item" role="presentation">
										<button class="nav-link" id="tab3" data-bs-toggle="tab"
											data-bs-target="#content3" type="button" role="tab"
											aria-controls="content3" aria-selected="false">재무</button>
									</li>
									<li class="nav-item" role="presentation">
										<button class="nav-link" id="tab4" data-bs-toggle="tab"
											data-bs-target="#content4" type="button" role="tab"
											aria-controls="content4" aria-selected="false">프로젝트관리</button>
									</li>
								</ul>
							</div>
							<!-- 상위탭 시작  -->

							<!-- 하위탭 시작  -->
							<div class="tab-content mt-3" id="myTabContent">
								<div class="tab-pane fade" id="content1" role="tabpanel"
									aria-labelledby="tab1">
									<!--home 탭키 내부입니다.  -->
								</div>

								<div class="tab-pane fade show active" id="content2"
									role="tabpanel">
									<ul class="nav nav-pills">
										<li class="nav-item"><a class="nav-link" href="http://localhost/statistics/statisticsAWOL">결근</a>
											<!-- active 클래스 위치 수정 --></li>
										<li class="nav-item"><a class="nav-link active" href="http://localhost/statistics/statisticsLATE">지각/조퇴</a>
										</li>
									</ul>
								</div>

								<div class="tab-pane fade" id="content3" role="tabpanel"
									aria-labelledby="tab2">
									<ul class="nav nav-pills">
										<!--Spending Rate 지출율  -->
										<li class="nav-item"><a class="nav-link " href="#">지출
												예정대비 지출율</a></li>
										<!--roa = return on assets 약차 (수금율)  -->
										<li class="nav-item"><a class="nav-link" href="#">수금
												예측대비 수금율</a></li>
										<!-- ror = rate of return 수익율-->
										<li class="nav-item"><a class="nav-link" href="#">예상
												실 수익율 대비 수익율</a></li>
								</div>
								<div class="tab-pane fade" id="content4" role="tabpanel"
									aria-labelledby="tab3">
									<!-- keyPerformanceIndicator-->
									<ul class="nav nav-pills">
										<li class="nav-item"><a class="nav-link " href="#">직급
												별 업무기여도 달성율</a></li>
										<!--Hire And Leaving (입,퇴사자) 통계  -->
										<li class="nav-item"><a class="nav-link" href="#">입,퇴사자</a>
										</li>
								</div>
								<div class="tab-pane fade" id="content5" role="tabpanel"
									aria-labelledby="tab4">
									<ul class="nav nav-pills">
										<li class="nav-item"><a class="nav-link " href="#">프로젝트별
												업무 기여도</a></li>
										<!--Project Acheviement Rate  -->
										<li class="nav-item"><a class="nav-link" href="#">프로젝트
												별 달성율</a></li>
								</div>
								<div class="tab-pane fade" id="content6" role="tabpanel"
									aria-labelledby="tab5">
									<ul class="nav nav-pills">
										<li class="nav-item"><a class="nav-link "
											href="http://localhost/1demo/table">표</a></li>
								</div>
							</div>
							<!-- 하위탭 끝  -->
							<!-- 그래프 내부카드  -->
							<div class="row mt-5">
								<div class="col-4">
									<div class="card-style">
										<!-- 연, 월, 일 선택 라디오 버튼 -->
										<form id="frm">
											<div class="d-flex  align-items-center mb-3">
												<legend>통계 기간 설정</legend>
												<button type="button" onclick="window.location.reload()" class="btn btn-outline-primary text-nowrap">초기화</button>
											</div>
											<div class="form-check radio-style mb-20 " style="display: inline-block;">
												<input class="form-check-input" type="radio" name="interval"value="year" id="year" >
												<label class="form-check-label" for="year">연간</label>
											</div>
											&nbsp;&nbsp;&nbsp;
											<div class="form-check radio-style mb-20" style="display: inline-block;">
												<input class="form-check-input" type="radio" name="interval" value="month" id="month">
												<label class="form-check-label" for="month">월간</label>
											</div>
											&nbsp;&nbsp;&nbsp;
											<div class="form-check radio-style mb-20" style="display: inline-block;">
												<input class="form-check-input" type="radio" name="interval" value="day" id="day">
												<label class="form-check-label" for="day">일간</label>
											</div>
											&nbsp;&nbsp;&nbsp;

											<!-- 동적으로 변경될 입력 필드 -->
											<!-- 기본적으로 숨겨둠 -->
											<div id="dynamicInputYears" style="display: none;">
													<div class="card-header">
														<legend>연간 선택</legend>
													</div>
													<div class="card-body">
														<div class="select-style-1 form-group w-fit"">
															<label for="startYears" class="form-label"> 시작년도</label> 
															<select name="startYearsY" class="form-select" id="startYearsY">
																<option selected="" disabled="" readonly="" value="startYearsY">조회를 시작 할 년도를 선택해주세요</option>
																<option value="202101">2021</option>
																<option value="202201">2022</option>
																<option value="202301">2023</option>
																<option value="202401">2024</option>
																<option value="202501">2025</option>
															</select>
														</div>
														<div class="select-style-1 form-group w-fit">
															<label for="endYearsY" class="form-label"> 종료년도 </label>
															<select name="endYearsY" class="form-select" id="endYearsY">
																<option selected="" disabled="" readonly="" value="endYearsY">조회를 종료 할 년도를 선택해주세요</option>
																<option value="202112">2021</option>
																<option value="202212">2022</option>
																<option value="202312">2023</option>
																<option value="202412">2024</option>
																<option value="202512">2025</option>
															</select>
														</div>
														<!--셀렉트 끝  -->
													</div>
											</div>
											<!--dynamicInputYears 끝  -->

											<div id="dynamicInputMonths" style="display: none;">
													<div class="card-header">
														<legend>월 선택</legend>
													</div>
													<div class="card-body">
														<div class="select-style-1 form-group w-fit">
															<label for="startYearsM" class="form-label"> 시작년도</label> 
															<select name="startYearsM" class="form-select mb-2" id="startYearsM">
																<option selected="" readonly="" value="">조회 년도를 선택 해주세요</option>
																<option value="2021">2021</option>
																<option value="2022">2022</option>
																<option value="2023">2023</option>
																<option value="2024">2024</option>
																<option value="2025">2025</option>
															</select>
															<label for="startYearsM" class="form-label"> 시작월</label>
															<select name="startMonths" class="form-select mb-2" id="startMonths">
																<option selected="" disabled="" readonly="" value="">조회를 종료 할 월을 선택해주세요</option>
																<option value="01">1월</option>
																<option value="02">2월</option>
																<option value="03">3월</option>
																<option value="04">4월</option>
																<option value="05">5월</option>
																<option value="06">6월</option>
																<option value="07">7월</option>
																<option value="08">8월</option>
																<option value="09">9월</option>
																<option value="10">10월</option>
																<option value="11">11월</option>
																<option value="12">12월</option>
															</select> 
															<label for="startMonths" class="form-label"> 종료월</label>
															<select name="endMonths" class="form-select mb-2" id="endMonths">
																<option selected="" disabled="" readonly="" value="">조회를 종료 할 월을 선택해주세요</option>
																<option value="01">1월</option>
																<option value="02">2월</option>
																<option value="03">3월</option>
																<option value="04">4월</option>
																<option value="05">5월</option>
																<option value="06">6월</option>
																<option value="07">7월</option>
																<option value="08">8월</option>
																<option value="09">9월</option>
																<option value="10">10월</option>
																<option value="11">11월</option>
																<option value="12">12월</option>
															</select>
														</div>
													</div>
											</div>

											<div id="dynamicInputDays" style="display: none;">
											    <div class="card-header">
											        <legend>특정 기간 선택</legend>
												    <div class="input-container">
												        <div class="input-style-1">
												            <label>시작일</label>
												            <input id="startDays" name="startDays" type="date" data-listener-added_846ff8c4="true">
												             <label>종료일</label>
												            <input id="endDays" name="endDays" type="date" data-listener-added_846ff8c4="true">
												        </div>
												    </div>
											    </div>
											</div>

											<div class="select-style-1 form-group">
												<label>조회 할 부서를 선택 해 주세요 <span class="text-danger">*</span></label>
												<div class="d-flex flex-wrap gap-4">
										  <div class="select-style-1 form-group">
										
										  <!-- 전체선택 - 한 줄로 표시 -->
										  <div class="form-check checkbox-style d-flex align-items-center mb-3">
										    <input class="form-check-input" type="checkbox" value="selectAll" id="selectAll" onclick="checkedAll(this)" checked>
										    <label class="form-check-label ms-2" for="selectAll">전체선택</label>
										  </div>
										
										  <!-- 부서 목록 - 2열 4행으로 구성 -->
										  <div class="dept-grid row row-cols-2 g-3">
										    <div class="col">
										      <div class="form-check checkbox-style d-flex align-items-center">
										        <input class="form-check-input" type="checkbox" data-dept="인사부" name="dept" value="10" id="checkbox-10" onclick="fck(this)">
										        <label class="form-check-label ms-2" for="checkbox-10">인사부</label>
										      </div>
										    </div>
										    <div class="col">
										      <div class="form-check checkbox-style d-flex align-items-center">
										        <input class="form-check-input" type="checkbox" data-dept="경영지원부" name="dept" value="20" id="checkbox-20" onclick="fck(this)">
										        <label class="form-check-label ms-2" for="checkbox-20">경영지원부</label>
										      </div>
										    </div>
										    <div class="col">
										      <div class="form-check checkbox-style d-flex align-items-center">
										        <input class="form-check-input" type="checkbox" data-dept="영업부" name="dept" value="30" id="checkbox-30" onclick="fck(this)">
										        <label class="form-check-label ms-2" for="checkbox-30">영업부</label>
										      </div>
										    </div>
										    <div class="col">
										      <div class="form-check checkbox-style d-flex align-items-center">
										        <input class="form-check-input" type="checkbox" data-dept="생산부" name="dept" value="40" id="checkbox-40" onclick="fck(this)">
										        <label class="form-check-label ms-2" for="checkbox-40">생산부</label>
										      </div>
										    </div>
										    <div class="col">
										      <div class="form-check checkbox-style d-flex align-items-center">
										        <input class="form-check-input" type="checkbox" data-dept="구매부" name="dept" value="50" id="checkbox-50" onclick="fck(this)">
										        <label class="form-check-label ms-2" for="checkbox-50">구매부</label>
										      </div>
										    </div>
										    <div class="col">
										      <div class="form-check checkbox-style d-flex align-items-center">
										        <input class="form-check-input" type="checkbox" data-dept="품질부" name="dept" value="60" id="checkbox-60" onclick="fck(this)">
										        <label class="form-check-label ms-2" for="checkbox-60">품질부</label>
										      </div>
										    </div>
										    <div class="col">
										      <div class="form-check checkbox-style d-flex align-items-center">
										        <input class="form-check-input" type="checkbox" data-dept="디자인부" name="dept" value="70" id="checkbox-70" onclick="fck(this)">
										        <label class="form-check-label ms-2" for="checkbox-70">디자인부</label>
										      </div>
										    </div>
										    <div class="col">
										      <div class="form-check checkbox-style d-flex align-items-center">
										        <input class="form-check-input" type="checkbox" data-dept="연구소" name="dept" value="80" id="checkbox-80" onclick="fck(this)">
										        <label class="form-check-label ms-2" for="checkbox-80">연구소</label>
										      </div>
										    </div>
										  </div>
										</div>
								</div>


											</div>
										</form>
										<!-- 전체 폼태그 끝 form  -->
										<div class="select-style-1 form-group w-fit">
											<select name="chartType" class="form-select" id="chartType"
												onClick="updateChartType()">
												<label for="chartType" class="form-label">차트 유형 선택:</label>
												<option value="line">선형(line)</option>
												<option value="bars">막대(bar)</option>
												<option value="area">영역(area)</option>
											</select>
										</div>
										<button type="button" id="btnSubmit" tabindex="1" class="btn submit btn-primary col-4 mt-3 text-nowrap">그래프 조회</button>
									</div> <!-- 2번째 내부카드 안 끝 -->
								</div> <!-- 카드끝 col-4 내부카드 -->
								<div class="col-8">
									<div class="card-style">
										<div id="chart_div" style="height: 850px;"></div>
									</div>
								</div>
							<!-- 카드끝 -->
						</div> <!-- 그래프 조회버튼 위 카드/ -->
					</div>
				</div>
				
			</div>
			
		</section>
			

	<%@ include file="../layout/footer.jsp"%>
	</main>
<%@ include file="../layout/prescript.jsp"%>
<script>

	
	/* 차트 기본형태 : bars */
	let comboChartType = '';
    let checkedDeptArr = ["MONTH"]; // 내가 선택한 부서 담는 배열
	/* 구글차트 패키지모음******* */
	google.charts.load('current', {'packages':['corechart']});
	/* google.charts.setOnLoadCallback(drawVisualization); */
	/* 구글차트 패키지모음********* */ 
	
    // 구글 차트api에서 차트를 그려주는 펑션 function
    async function drawVisualization() {
    	 try {
    			// 여기서 비동기 요청
    			const startYearsY = document.querySelector('#startYearsY');
    			const endYearsY = document.querySelector('#endYearsY');
    			const startYearsM = document.querySelector('#startYearsM');
    			const startMonths = document.querySelector('#startMonths');
    			const endMonths = document.querySelector('#endMonths');

    			const respStartDays = document.querySelector('#startDays');
    			const respEndDays = document.querySelector('#endDays');
    			
    			
    			/*
    			<input id="startDays" name="startDays" type="date" data-listener-added_846ff8c4="true" data-listener-added_1334955c="true">
    			<input id="endDays" name="endDays" type="date" data-listener-added_846ff8c4="true">
    			*/
    			console.log("이거 확인좀 해보자",respStartDays,respEndDays)

    			let fStarted = null;
    			let fEnded = null;

    			//연간
    			if(document.querySelector('#startYearsY').value>0){
    				fStarted = startYearsY.value;
    				fEnded = endYearsY.value;	
    			}
    			
    			//월간
    			if(document.querySelector('#startYearsM').value+document.querySelector('#startMonths').value>0){
    				fStarted = startYearsM.value+startMonths.value;
    				fEnded = startYearsM.value+endMonths.value;
    			}
    			
    			//일간
    			//<input class="form-check-input" type="radio" name="interval" value="day" id="day">
    			let interval = document.querySelector('input[name="interval"]:checked').value;//day
    			if(interval=="day"){
    				fStarted = document.querySelector('#startDays').value;
    				fEnded = document.querySelector('#endDays').value;
    				
    				//2025-04-14 -> 2025-04
    				fStarted = fStarted.substring(0,7);
    				fEnded = fEnded.substring(0,7);
    				
    				//2025-04 -> 202504
    				fStarted = fStarted.replace(/-/g,"");
    				fEnded = fEnded.replace(/-/g,"");
    			}
    			
    			let data = {
    				"started":fStarted,
    				"ended":fEnded
    			};
    			
    			/*
    			JSON Object{"started": "2025-04","ended": "2025-05"}
    			*/
    			console.log("data : ",data);	
    			
    			const response = await fetch('/statistics/resultLATE?'+ new URLSearchParams(data).toString()); // 여기에 파라미터 추가 하기
    			
    			if (!response.ok) {
    				throw new Error(`HTTP error! status: ${response.status}`);
    			}

    			
    			console.log("확인 좀 해보자 : ",response);
    			
    			const fetchData = await response.json();// JSON 데이터로 변환

    			console.log("페치데이터",fetchData);

    			let LATE = fetchData.LATE;

    			console.log("LATE입니다.",LATE);

    			let chartList = [];
    			// let header = ["MONTH", "인사부", "임원진"];
    			chartList.push(checkedDeptArr);


    			LATE.forEach((item) => {
    			let wrap = []
    			for(const head of checkedDeptArr) {
    			wrap.push(item[head]);
    			}
    			chartList.push(wrap);
    			})
    			console.log(chartList)

    			data = google.visualization.arrayToDataTable(chartList);
    			var options = {
    			vAxis: {title: '결근 횟수'},
    			hAxis: {title: '선택 부서 '},
    			seriesType: comboChartType
    			};

    			var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
    			chart.draw(data, options);

    		} catch (error) {
    			console.error('Error fetching data:', error); // 오류 처리
    		}
    }//end drawVisualization
    
    $(document).ready(function () {
        const selectAllCheckbox = document.getElementById("selectAll");

        // 페이지 로드 시 체크된 상태라면 강제로 전체선택 로직 실행
        if (selectAllCheckbox.checked) {
            checkedAll(selectAllCheckbox);
        }
    });

    // 차트 변경
    function updateChartType() {
      const selectElement = document.getElementById('chartType');
      const selectedType = selectElement.value;

      if(selectedType) {
        comboChartType = selectedType; // 선택된 차트 유형으로 업데이트
      }
    }
    
    // 개별 선택 및 배열에 담는 함수
    const ckboxes = document.querySelectorAll("[name=dept]");
    function checkedAll(dThis)  {
      if(dThis.checked){
        checkedDeptArr = ["MONTH"];
        for(let i=0; i< ckboxes.length; i++){
          ckboxes[i].checked=true;
          checkedDeptArr.push(ckboxes[i].dataset.dept);
        }

        console.log("잘담겻낭?"+checkedDeptArr);
      }else {
        for(let i=0; i< ckboxes.length; i++){
          ckboxes[i].checked=false;
        }
        checkedDeptArr = ["MONTH"];

        console.log("지워졌낭??"+checkedDeptArr);
      }

      console.log(checkedDeptArr)
    } // selectAll 끗


    function fck(dThis) {
      let val = dThis.dataset.dept;
      if(dThis.checked) {
        console.log("추가!!",checkedDeptArr);
        checkedDeptArr.push(val);
      } else {
        if(checkedDeptArr.indexOf(val) !=-1){
          console.log("제거!!");
          let schIndex = checkedDeptArr.indexOf(val);
          checkedDeptArr.splice(schIndex,1);
        }
      }
      console.log("현재 배열 상태 !!",checkedDeptArr);
    }

</script>

<script>

function handleIntervalChange(event) {
	console.log("왔다");

	//event : change 이벤트
	//event.target : <input class="form-check-input" type="radio" name="interval" value="year" id="year"> 
	  const { name,value } = event.target;
	  let dynamicInputYearsDom = document.querySelector("#dynamicInputYears");//<div id="dynamicInputYears"..
	  let dynamicInputMonthsDom = document.querySelector("#dynamicInputMonths");//<div id="dynamicInputMonths"..
	  let dynamicInputDaysDom = document.querySelector("#dynamicInputDays");//<div id="dynamicInputDays"..

	  //year, month, day
	  
	  if (value === "year") {
		console.log("헤이!")
        $('#startYearsM,#startMonths,#endMonths,#startDays,#endDays').prop('selectedIndex', 0);
        $('#startDays').val('');
        $('#endDays').val('');
        
	    dynamicInputYearsDom?.classList.add("d-block");
	    dynamicInputYearsDom?.classList.remove("d-none");

	    dynamicInputMonthsDom?.classList.add("d-none");
	    dynamicInputMonthsDom?.classList.remove("d-block");

	    dynamicInputDaysDom?.classList.add("d-none");
	    dynamicInputDaysDom?.classList.remove("d-block");
	  }

	  if (value === "month") {
		 
		$('#startYearsY, #endYearsY').prop('selectedIndex', 0);
		$('#startDays').val('');
	    $('#endDays').val('');
		  
		document.getElementById("dynamicInputYears").value = '';
		document.getElementById("dynamicInputDays").value = '';
		  
	    dynamicInputYearsDom?.classList.add("d-none");
	    dynamicInputYearsDom?.classList.remove("d-block");

	    dynamicInputMonthsDom?.classList.add("d-block");
	    dynamicInputMonthsDom?.classList.remove("d-none");

	    dynamicInputDaysDom?.classList.add("d-none");
	    dynamicInputDaysDom?.classList.remove("d-block");
	  }

	  if (value === "day") {
		 
		$('#startYearsY, #endYearsY,#startYearsM,#startMonths,#endMonths').prop('selectedIndex', 0);
		  
		document.getElementById("dynamicInputYears").value = '';
		document.getElementById("dynamicInputMonths").value = '';  
		  
	    dynamicInputYearsDom?.classList.add("d-none");
	    dynamicInputYearsDom?.classList.remove("d-block");

	    dynamicInputMonthsDom?.classList.add("d-none");
	    dynamicInputMonthsDom?.classList.remove("d-block");

	    dynamicInputDaysDom?.classList.add("d-block");
	    dynamicInputDaysDom?.classList.remove("d-none");
	  }
	}//end handleIntervalChange

	$(function(){
		console.log("개똥이!");
		
		$("#btnSubmit").on("click", function(e){
			drawVisualization();
        });
		
		$("input[name='interval']").on("change", function(e){ 
			console.log("개똥이2!");
		    handleIntervalChange(e);
		});
	});

	
</script>
</body>
</html>
