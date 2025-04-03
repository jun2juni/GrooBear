<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script> -->
<script type="text/javascript">
	document.addEventListener('DOMContentLoaded', function() {
		let emplNo = "${myEmpInfo.emplNo}";
   		console.log("직원 이름:", emplNo);
		console.log("FullCalendar 버전:", FullCalendar.version);

		// bootstrap 시작
		var insModal = new bootstrap.Modal(document.getElementById('myModal'));
		console.log("$('#myModal')[0]",$('#myModal')[0]);
		// console.log('start : ',$('#calAddFrm')[0].start.val);
		console.log('insModal : ',insModal);

		// bootstrap 끝

		console.log("insModal", insModal);

		//     var calendarEl = document.getElementById('myCalendar');
		var calendarEl = $('#myCalendar')[0];
		// 	console.log("calendarEl",calendarEl);
		// 	console.log("$('#myCalendar')",$('#myCalendar')[0]);

		const headerToolbar = {
			left : 'prevYear,prev,next,nextYear today',
			center : 'title',
			right : 'dayGridMonth,timeGridWeek,listWeek,timeGridDay'
		};

		const calendarOption = {
			handleWindowResize:true,
			height : '700px',
			contentHeight: 60,
			expandRows : false,
			headerToolbar : headerToolbar,
			initialView : 'dayGridMonth',
			locale : 'ko', // 'kr'에서 'ko'로 수정
			selectable : true,
			selectMirror : true,
			navLinks : true,
			weekNumbers : true,
			editable : true,
			eventDurationEditable:true,
			eventStartEditable:true,
			eventResizableFromStart: true,
			dayMaxEventRows : 3,
			nowIndicator : true,
			droppable : true,
			eventOverlap : true,
			eventResize: function(info) {
				console.log("리사이즈 실행 : ", info);
				let updData = mkUptData(info);
					$.ajax({
						url:"/myCalendar/uptEvent",
						type:"post",
						data:JSON.stringify(updData),
						contentType:'application/json',
					});
			}
		};
		var calendar = new FullCalendar.Calendar(calendarEl, calendarOption);
		window.globalCalendar = calendar;

		refresh = function() {
			return $.ajax({
				url: "/myCalendar/calendarList",
				method: 'get',
				success: function(data) {
					let clndr = chngData(data);
					console.log("refresh : ",clndr);
					window.globalCalendar.setOption('events', clndr);
				}
			});
		};
		const overChk = function(date1,date2,num){
			let differenceInDays = Math.abs((date2 - date1) / (1000 * 60 * 60 * 24));
			return differenceInDays>=num?true:false;
		}
		const chngData = function(dataList){
			let returnData=[]
			dataList.forEach(data=>{
				let startDate = new Date(data.schdulBeginDt);
				let endDate = new Date(data.schdulEndDt);
				let chk = overChk(startDate,endDate,1);
				
				// console.log("check : ",data.schdulNo,chk);

				returnData.push({
				   "emplNo":data.emplNo,
				   "id":data.schdulNo,
				   "start":data.schdulBeginDt,
				   "end":data.schdulEndDt,
				   "title":data.schdulSj,
				   "schdulCn":data.schdulCn,
				   "schdulTy":data.schdulTy,
				   "lblNo":data.lblNo,
				   "schdulPlace":data.schdulPlace,
				   "deptCode":data.deptCode,
				   "allDay":chk,
				   "durationEditable": true
				})
			});
			return returnData;
		};

		// 캘린더 렌더링 (인자 없이)
		calendar.render();

		// 초기 이벤트 로드
		refresh();

// 이벤트들
		// 드래그로 일정 늘리거나 줄이는 이벤트	=> 이건 위에 있다. 등록되어있음

		// 드래그 앤 드롭 이벤트
		calendar.on("eventDrop", function(info) {
			console.log("eventDrop : ",info);
			let updData = mkUptData(info);
			        $.ajax({
			            url:"/myCalendar/uptEvent",
			            type:"post",
			            data:JSON.stringify(updData),
						contentType:'application/json',
			            success:function(response) {
			                console.log("upt 개수 response : ",response);
			                // refresh(); // 인자 없이 호출
			            },
			            error: function(xhr, status, error) {
			                console.error("AJAX 오류:", error);
			            }
				    });
		})

		const selectEvent = function(info){
			// 모달 표시
			insModal.show();
			$('#addUpt').val("add");
			$('#schdulNo').val("");
			$('.modal-title').text("일정 등록");
			$("#modalSubmit").text("추가");
			if($("#deleteBtn").length){
				$("#deleteBtn").remove();
			}
			console.log("Selected date" + info.startStr + " to " + info.endStr);
			console.log("select -> info : ", info);

			$("#allDay").prop("checked",false);

			if(info.view.type=='timeGridDay'){
				let selectStartDay = date2Str(info.start);
				let selectEndDay = date2Str(info.end);
				let selectStartTime = time2Str(info.start);
				let selectEndTime = time2Str(info.end);
				$("#schStart").val(selectStartDay);
				$("#schEnd").val(selectEndDay);
				$("#schStartTime").val(selectStartTime);
				$("#schEndTime").val(selectEndTime);
			}else{
				let now = new Date();
				let hours = now.getHours().toString().padStart(2,'0');
				let minutes = now.getMinutes().toString().padStart(2,'0');
				let currentTime = hours+":"+minutes;
				// 선택한 날짜 범위를 폼에 설정
				// console.log("info.start",info.start);
				let startStr = date2Str(info.start);
				let endStr = date2Str(info.end);
				console.log("startStr",startStr);
				console.log("endStr",endStr);

				$("#schStart").val(info.startStr);
				$("#schEnd").val(info.endStr);
				$("#schStartTime").val(currentTime);
				$("#schEndTime").val("00:00");
				// console.log('start : ',$('#calAddFrm').find('[name="start"]').val());
			}
		}

	// 클릭 및 드래그 선택 이벤트 끝
		let clickTimeout = null;
		let lastClickTime = 0;
		const doubleClickDelay = 300; // 밀리초
		function checkDblClk(){
			// console.log("클릭");
			const currentTime = new Date().getTime();
			const timeSinceLastClick = currentTime - lastClickTime;
			
			// 이미 존재하는 타임아웃 제거
			if (clickTimeout) {
				clearTimeout(clickTimeout);
				clickTimeout = null;
  			}
			if(timeSinceLastClick < doubleClickDelay){
				// 다음 시퀀스를 위해 초기화
				lastClickTime = 0;
				return true;
			}else{
				// 첫 번째 클릭 - 잠재적인 두 번째 클릭을 위한 타이머 설정
				lastClickTime = currentTime;
				clickTimeout = setTimeout(function() {
					// console.log("clickTimeout",clickTimeout);
					// 지정된 시간 내에 두 번째 클릭이 없으면 실행
					
					// 싱글클릭 시 실행할 동작 (필요한 경우)
					
					// 다음 시퀀스를 위해 초기화
					clickTimeout = null;
					lastClickTime = 0;
				}, doubleClickDelay);
				return false;
			}
		}
		calendar.on("dateClick",function(info){
			let chk = checkDblClk();
			if(chk){
				console.log('날짜 더블클릭:', info);
				insModal.show();
				$('.modal-title').text("일정 등록");
				$("#modalSubmit").text("등록");
				if($("#deleteBtn").length){
					$("#deleteBtn").remove();
				}
			}else{
				// console.log('날짜 싱글클릭:', info.dateStr);
			}
		})

		// 일자 선택 이벤트
		calendar.on("select", function(info) {
			if(!lastClickTime){
				// console.log("select -> lastClickTime 싱글클릭 : ",lastClickTime);
				let startDate = new Date(info.start);
				let endDate = new Date(info.end);
				
				if(overChk(startDate,endDate,2)){
					selectEvent(info);
					$('.modal-title').text("일정 등록");
					$("#modalSubmit").text("등록");
					if($("#deleteBtn").length){
						$("#deleteBtn").remove();
					}
				}
				return;
			}
		})
	// 클릭 및 드래그 선택 이벤트 끝

		// 등록된 일정 클릭시 이벤트
		calendar.on("eventClick",info=>{
			console.log("eventClick -> info : ", info);
			let popover = document.querySelector(".fc-popover");
			if(popover){
				popover.remove();
			}
			insModal.show();
			$('.modal-title').text("일정 상세");
			$("#modalSubmit").text("수정");
			if($("#deleteBtn").length==0){
				$(".button-group").append('<button type="button" id="deleteBtn" class="main-btn danger-btn btn-hover" onclick="fCalDel(event)">삭제</button>');
			}
			let start = info.event.start;
			let end = info.event.end;
			$('#addUpt').val("update");
			$('#schdulNo').val(info.event._def.publicId);
			$('#schStart').val(date2Str(start));
			$('#schStartTime').val(time2Str(start));
			$('#schEnd').val(date2Str(end));
			$('#schEndTime').val(time2Str(end));
			$('#schTitle').val(info.event._def.title);
			$('#schContent').val(info.event._def.extendedProps.schdulCn);
			$('#schdulTy').val(info.event._def.extendedProps.schdulTy);
		})	
		
		// allDay 관련 함수들 시작
		document.getElementById("allDay").addEventListener('change',function(e){
			console.log("allDay 실행 : ",e);
			console.log("allDay 이벤트 객체 확인 : ",e.target);
			let isCheck = $("#allDay").prop("checked");
			console.log("allDay : ",isCheck);
			let startStr = $("#schStart").val();
			let endStr = $("#schEnd").val();
			console.log("startStr : ",startStr," , endStr : ",endStr);
			
			if(isCheck){
				let dateStr = new Date(startStr);
				console.log("dateStr : ",(dateStr));
				dateStr.setDate(dateStr.getDate()+1)
				// console.log("dateStr-2 : ",(dateStr.getDate()-2));
				console.log("dateStr+1 : ",dateStr.toISOString().split("T")[0]);

				$("#schEnd").val(dateStr.toISOString().split("T")[0]);
				$("#schStartTime").val("00:00");
				$("#schEndTime").val("00:00");
			}

		});
		document.querySelectorAll('.dateInput').forEach(input=>{
			input.addEventListener('change',function(){
				let isChecked = $("#allDay").prop("checked");
				// console.log("시간 변경, isChecked 변경 전 : ",isChecked);
				if(isChecked){
					$("#allDay").prop("checked",false);
					// console.log("시간 변경, isChecked 변경 후 : ",$("#allDay").prop("checked"));
				}
			})
		})
		// allDay 관련 함수들 끝
		
// 함수들
		const date2Str = function(date){
			// date는 Date객체
			let newDate = new Date(date);
			let yearStr = newDate.getFullYear().toString();
			let monthStr = (newDate.getMonth()+1).toString().padStart(2,'0');
			let dateStr = newDate.getDate().toString().padStart(2,'0');
			// console.log("yearStr",yearStr);
			// console.log("monthStr",monthStr);
			// console.log("dateStr",dateStr);
			return yearStr+'-'+monthStr+'-'+dateStr;
		}
		const time2Str = function(time){
			let newTime = new Date(time);
			let hoursStr = newTime.getHours().toString().padStart(2,'0');
			let minutesStr = newTime.getMinutes().toString().padStart(2,'0');
			return hoursStr+":"+minutesStr;
		}
		const clickEvent2Date = function(e){
			// 시작 날짜와 종료 날짜를 Date타입으로 리턴한다.
			// 이 함수는 추후에 필요없는거같으면 지울 예정이다.
			let startStr = e.target.form.start.value;
			let startTimeStr = e.target.form.startTime.value;

			let endStr = e.target.form.end.value;
			let endTimeStr = e.target.form.endTime.value;

			let startDate = new Date(startStr.split("-")[0],parseInt(startStr.split("-")[1])-1+"",startStr.split("-")[2],startTimeStr.split(":")[0],startTimeStr.split(":")[1]);
			let endDate = new Date(endStr.split("-")[0],parseInt(endStr.split("-")[1])-1+"",endStr.split("-")[2],endTimeStr.split(":")[0],endTimeStr.split(":")[1]);
			return {startDate,endDate}
		}

		window.fCalAdd= function(e){
			e.preventDefault();
			let status = $('#addUpt').val();
			let postUrl
			
			// console.log("event : ",e);
			// console.log("event -> form : ",e.target.form);
			// console.log("event -> input.start : ",e.target.form.start.value);
			// console.log("event -> input.start : ",e.target.form.startTime.value);
			
			if(!e.target.form.schdulSj.value){
				alert("제목을 입력하세요");
				return;
			}

			let {startDate,endDate} = clickEvent2Date(e);
			console.log("fCalAdd -> startDate : ",startDate);
			console.log("fCalAdd -> endDate : ",endDate);
			let frmData = new FormData();
			frmData.append("emplNo",emplNo);
			frmData.append("schdulBeginDt",startDate);
			frmData.append("schdulEndDt",endDate);
			frmData.append("schdulTy",e.target.form.schdulTy.value);
			frmData.append("schdulSj",e.target.form.schdulSj.value);
			frmData.append("schdulCn",e.target.form.content.value);
			// frmData.append("lblNo",e.target.form.category.value);

			if(status=="add"){
				postUrl = "/myCalendar/addCalendar";
			}else{
				postUrl="/myCalendar/uptCalendar";
				frmData.append("schdulNo",e.target.form.schdulNo.value);
			}
			
			$.ajax({
				url:postUrl,
				type:"post",
				data:frmData,
				contentType:false,
				processData:false,
				success:function(response){
					// console.log("성공 : ",response);
					// alert("성공");
					// alert("fCalAdd -> startDate : ",startDate);
					fMClose();
					// refresh();
					let clndr = chngData(response);
					console.log(clndr);
					window.globalCalendar.setOption('events', clndr);
				},
				error:function(err){
					console.log("err : ",err);
				}
			})
		}
		// 수정 데이터 만드는 함수
		function mkUptData(info){
			console.log("mkUptData -> info", info);
			let uptData = {
				schdulNo:info.event._def.publicId,
				schdulTy:info.event._def.extendedProps.schdulTy,
				schdulBeginDt:info.event.start,
				schdulEndDt:info.event.end,
				schdulSj:info.event.title,
				schdulCn:info.event._def.extendedProps.schdulCn,
				lblNo:info.event._def.extendedProps.lblNo
			}
			console.log("mkUptData -> uptData", uptData);
			return uptData;
		}
		window.fCalDel = function(e){
			let schdulNo = e.target.closest("form").schdulNo.value;
			console.log("event check",schdulNo);
			$.ajax({
				url:"/myCalendar/delCalendar",
				type:"post",
				data:JSON.stringify({schdulNo:schdulNo}),
				// data:schdulNo,
				contentType:"application/json",
				success:function(resp){
					fMClose();
					let clndr = chngData(resp);
					console.log(clndr);
					window.globalCalendar.setOption('events', clndr);
				},
				error:function(err){
					console.log("실패 : ",err);
				}
			})
		};

		window.fMClose = function() {
			insModal.hide();
		};
	})
</script>
</head>
<body>
	<jsp:include page="calendarSidebar.jsp"></jsp:include>
	<jsp:include page="calendarFormModal.jsp"></jsp:include>
	<div id="contentContainer">
		<div id='myCalendar'></div>
	</div>
	
</body>
</html>