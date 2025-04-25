<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript">
	document.addEventListener('DOMContentLoaded', function() {
	    $('.nav-item-myCalendar').addClass('active');
		let emplNo = "${myEmpInfo.emplNo}";
		let deptCode = "${myEmpInfo.deptCode}";
		let shceduleList = [];
		let showList = [];
   		console.log("직원 이름:", emplNo);
   		console.log("직원 부서:", deptCode);
		console.log("FullCalendar 버전:", FullCalendar.version);

		// bootstrap 시작
		window.insModal = new bootstrap.Modal(document.getElementById('myModal'));
		console.log("$('#myModal')[0]",$('#myModal')[0]);
		// console.log('start : ',$('#calAddFrm')[0].start.val);
		console.log('insModal : ',insModal);

		// bootstrap 끝

		
		// ** 박호산나 추가함 
		// 메인에서 일정등록 눌렀을시에만 실행 (myCalendar?openModal=true 일 때)
		let openModal = "${param.openModal}";
		console.log("openModal : ", openModal);
		if(openModal){
			insModal.show();
		}
		// 박호산나 추가함 **

		
		console.log("insModal", insModal);

		//     var calendarEl = document.getElementById('myCalendar');
		var calendarEl = $('#myCalendar')[0];
		// 	console.log("calendarEl",calendarEl);
		// 	console.log("$('#myCalendar')",$('#myCalendar')[0]);

		const headerToolbar = {
			left : 'prevYear,prev,next,nextYear today',
			center : 'title',
			right : 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
		};

		const calendarOption = {
			// nextDayThreshold: '00:00:00',
			// eventDisplay: 'block',
			// dragScroll:true,
		//  slotHeight:25,
			buttonText: {
				today: '오늘',
				month: '월',
				week: '주',
				day: '일',
				list: '목록'
			},
			handleWindowResize:true,
			// height: '100px', // ✅ 부모 높이에 맞춤
			contentHeight: 650,
			expandRows : false,
			headerToolbar : headerToolbar,
			initialView : 'dayGridMonth',
			locale : 'ko', // 'kr'에서 'ko'로 수정
			// timeZone:'Asia/Seoul',
			selectable : true,
			selectMirror : true,
			navLinks : true,
			weekNumbers : true,
			editable : true,
			eventDurationEditable:true,
			eventStartEditable:true,
			eventResizableFromStart: true,
			dayMaxEventRows : true,
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
			},
		};
		var calendar = new FullCalendar.Calendar(calendarEl, calendarOption);
		window.globalCalendar = calendar;

		// 이거 초기에만 실행
		refresh = function() {
			// console.log("refresh================={emplNo:emplNo, dept:myEmpInfo.deptCode} : ",{emplNo:emplNo, deptCode:deptCode});
			return $.ajax({
				url: "/myCalendar/calendarList",
				data:JSON.stringify({emplNo:emplNo, deptCode:deptCode}),
				method: 'post',
				contentType:'application/json',
				success: function(data) {
					// console.log("refresh -> data : ",data);
					let clndr = chngData(data);
					refreshSideBar(data.labelList);
					window.globalCalendar.setOption('events', clndr);
					// console.log("==================refresh : ",clndr);
					// scheduleList = clndr;
				}
			});
		};
		refreshSideBar = function(labelList){
			console.log('refreshSideBar : ',labelList);
			let labelSection = $('#labelSection');
			let checkboxHtml = '<div class="labelCheck" ><label>[기본] 나의 일정<input type="checkbox" class="label-filter" id="def" value="0" checked></label></div>';
			labelList.forEach(label => {
            // 기본 라벨(0)은 건너뛰기 (이미 상단에 고정)
            // if (label.lblNo == 0) return;
            
				let icon = window.createIcon('circle', label.lblColor);
				// 이전에 저장된 상태가 있으면 그 상태를 사용, 없으면 기본적으로 체크
				// checkboxHtml += icon + '<label>' + label.lblNm + 
				// 			'<input type="checkbox" class="label-filter" value="' + 
				// 			label.lblNo + '"' + ' checked ></label><br>';
				checkboxHtml += `
								<div class="labelCheck" >
                                	<label>\${icon}\${label.lblNm}
                                    	<input type="checkbox" class="label-filter" value="\${label.lblNo}" checked>
                                	</label>
                                </div>`;
        	});
			labelSection.append(checkboxHtml);
			fltrLbl.lblNoList = $('.label-filter:checked').map(function(){return $(this).val()}).get();
			console.log('fltrLbl.lblNoList : ',fltrLbl.lblNoList);
		}

		const overChk = function(date1,date2,time,num){
			let differenceInDays
			if(time=="date"){
				differenceInDays = (date2 - date1) / (1000 * 60 * 60 * 24);
// 				console.log('date',differenceInDays)
			}else if(time=="minute"){
				differenceInDays = (date2 - date1) / (1000 * 60 );
				console.log('minute',differenceInDays)
			}
			return differenceInDays>=num?true:false;
		}

		window.modalLblSel = function(labelList){
			let labelSection = $('#scheduleLabel');
			console.log('modalLblSel -> labelList',labelList);
			console.log('modalLblSel -> labelSection : ',labelSection);
			labelSection.empty();
			let checkboxHtml = '<option value="0">[기본] 나의 일정</option>';
			labelList.forEach(label=>{
				// console.log('modalLblSel -> label : ',label);
				// let icon = createIcon('circle',label.lblColor);
				// console.log('icon : ',icon);
				checkboxHtml += '<option type="checkbox" value='+label.lblNo+'>'+label.lblNm+'</option>';
			})
			labelSection.append(checkboxHtml);
		}

		window.chngData = function(dataMap){
			// labelSideBar(dataMap.labelList);
			modalLblSel(dataMap.labelList);

			let returnData=[];
			dataMap.scheduleList.forEach(data=>{
				let startDate = new Date(data.schdulBeginDt);
				let endDate = new Date(data.schdulEndDt);
				let chk = overChk(startDate,endDate,'date',1);
				// console.log("dataMap.data : " , data);
				// console.log("dataMap.labelList : ",dataMap.labelList);
				let selLabel = dataMap.labelList.filter(labeObj=> labeObj.lblNo == data.lblNo)[0];
				let lblColor='';
				let backgroundColor=''
				let textColor=''
				let durationEditable = true
				let startEditable = true
				let title = data.schdulSj;
				let eventContent;
				if(data.schdulTy == '1'){
					console.log('일정 타입',data.schdulTy);
					console.log('일정 넘버',data.schdulNo);
					borderColor = '#0d6efd';
					lblColor = '#ffffff'
					textColor='#000000'
					durationEditable=false
					startEditable=false
					title = '[부] '+title
				}else if(data.schdulTy == '2'){
					console.log('일정 타입',data.schdulTy);
					console.log('일정 넘버',data.schdulNo);
					borderColor = '#dc3545'
					lblColor = '#ffffff'
					textColor='#000000'
					durationEditable=false
					startEditable=false
					title = '[전] '+title;
				}else{
					if(selLabel){
						lblColor = selLabel.lblColor;
					}
					borderColor=lblColor
				}
				// console.log("lblColor : ",lblColor);
				// console.log("borderColor : ",borderColor);
				// console.log("chngData -> schdulNo : ",data.schdulNo);

				// console.log('chngData -> : startDate',startDate);
				// console.log('chngData -> : endDate',endDate);

				returnData.push({
				   "emplNo":data.emplNo,
				   "id":data.schdulNo,
				   "start":startDate,
				   "end":endDate,
				   "title":title,
				   "schdulCn":data.schdulCn,
				   "schdulTy":data.schdulTy,
				   "lblNo":data.lblNo,
				   "schdulPlace":data.schdulPlace,
				   "deptCode":data.deptCode,
				   "durationEditable": durationEditable,
				   "startEditable":startEditable,
				   "backgroundColor":lblColor,
				   "borderColor":borderColor,
				   "textColor":textColor,
				   "allDay":chk
				//    "allDay":false
				})
			});
			return returnData;
		};

		// 캘린더 렌더링 (인자 없이)
		calendar.render();

		// 초기 이벤트 로드
		refresh();

// 이벤트들
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
			$('#schTitle').val('');
			$('#schContent').val('');
			$('#addUpt').val("add");
			$('#schdulNo').val("");
			$('.modal-title').text("일정 등록");
			$("#modalSubmit").text("추가");
			// if($("#deleteBtn").length){
			$("#deleteBtn").hide();
			// }
			// console.log("Selected date" + info.startStr + " to " + info.endStr);
			console.log("select -> info : ", info);
			let startDate;
			let endDate;
			if(info.date){
				// console.log("aaaaa",typeof(info.date));
				startDate = info.date;
				endDate = new Date(info.date);
    			endDate.setDate(endDate.getDate() + 1); // 날짜를 1일 증가시킴
				console.log('startDate',startDate);
				console.log('endDate',endDate);
				
			}else{
				startDate = info.start;
				endDate = info.end;
			}

			// console.log('startDate : ',startDate,'  endDate : ',endDate);
			
			$('.timeInput-toggle.date').css('display','block');
			$('.timeInput-toggle.time').css('display','none');
			$("#allDay").prop("checked",false);

			if(info.view.type=='timeGridDay'||info.view.type=='timeGridWeek'){
				let selectStartDay = date2Str(startDate);
				let selectEndDay = date2Str(endDate);
				let selectStartTime = time2Str(startDate);
				let selectEndTime = time2Str(endDate);
				console.log("selectStartTime",selectStartTime)
				console.log("selectEndTime",selectEndTime)
				$("#schStart").val(selectStartDay);
				$("#schEnd").val(selectEndDay);
				$("#schStartTime").val(selectStartTime);
				$("#schEndTime").val(selectEndTime);
				dateValidate($('#schStart'));
				dateValidate($('#schStartTime'));
				dateValidate($('#schEnd'));
				dateValidate($('#schEndTime'));
			}else if(info.view.type=='timeGridWeek'){

			}else{
				let now = new Date();
				let hours = now.getHours().toString().padStart(2,'0');
				let minutes = now.getMinutes().toString().padStart(2,'0');
				let currentTime = hours+":"+minutes;
				// 선택한 날짜 범위를 폼에 설정
				// console.log("info.start",info.start);
				let startStr = date2Str(startDate);
				let endStr = date2Str(endDate);
				console.log("startStr",startDate);
				console.log("endStr",endDate);

				$("#schStart").val(startStr);
				$("#schEnd").val(endStr);
				$("#schStartTime").val(currentTime);
				$("#schEndTime").val("00:00");
				// console.log('start : ',$('#calAddFrm').find('[name="start"]').val());
				dateValidate($('#schStart'));
				dateValidate($('#schStartTime'));
				dateValidate($('#schEnd'));
				dateValidate($('#schEndTime'));
			}
		}

	// 클릭 및 드래그 선택 이벤트 끝
		let clickTimeout = null;
		let lastClickTime = 0;
		const doubleClickDelay = 200; // 밀리초
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
		let clickTimeoutSel = null;
		let lastClickTimeSel = 0;
		const doubleClickDelaySel = 500; // 밀리초
		function checkDblClkSel(){
			// console.log("클릭");
			const currentTime = new Date().getTime();
			const timeSinceLastClick = currentTime - lastClickTimeSel;
			
			// 이미 존재하는 타임아웃 제거
			if (clickTimeoutSel) {
				clearTimeout(clickTimeoutSel);
				clickTimeoutSel = null;
  			}
			if(timeSinceLastClick < doubleClickDelay){
				// 다음 시퀀스를 위해 초기화
				lastClickTimeSel = 0;
				return true;
			}else{
				// 첫 번째 클릭 - 잠재적인 두 번째 클릭을 위한 타이머 설정
				lastClickTimeSel = currentTime;
				clickTimeoutSel = setTimeout(function() {
					// console.log("clickTimeout",clickTimeout);
					// 지정된 시간 내에 두 번째 클릭이 없으면 실행
					
					// 싱글클릭 시 실행할 동작 (필요한 경우)
					
					// 다음 시퀀스를 위해 초기화
					clickTimeoutSel = null;
					lastClickTimeSel = 0;
				}, doubleClickDelay);
				return false;
			}
		}

		calendar.on("dateClick",function(info){
			let chk = checkDblClk();
			// $('#schdulTy').prop('disabeld',false);
			// $('#scheduleLabel').prop('disabeld',false);
			if(chk&&(info.view.type!='timeGridDay'&&info.view.type!='timeGridWeek')){
				console.log('날짜 더블클릭:', info);
				// insModal.show();
				selectEvent(info);
				$('.modal-title').text("일정 등록");
				$("#modalSubmit").text("등록");
				// if($("#deleteBtn").length){
				$("#deleteBtn").hide();
				// }
			}else{
				// console.log('날짜 싱글클릭:', info.dateStr);
			}
		})
		$('#schdulTy').on('change',function(){
			console.log('일정유형 선택 감지');
			console.log('타입 val : ',$('#schdulTy').val());
			if($('#schdulTy').val()!=0){
				console.log('부서 혹은 전체 선택');
				$('#scheduleLabel').prop('disabled',true);
				$('#scheduleLabel').val(0);
				// console.log('값 변경 확인 : ',$('#scheduleLabel').val(0));
			} else if($('#schdulTy').val()==0){
				console.log('개인 선택');
				$('#scheduleLabel').prop('disabled',false);
			}
		})

		/*
		*/
		function dateValidate(e){
			let inpName = $(e).prop('name');
			// console.log('validation 감지 : ',this)
			// console.log('validation 감지 -> inpName : ',inpName)

			// string type
			let schStart = $('#schStart').val();
			let schStartTime = $('#schStartTime').val();
			let schEnd = $('#schEnd').val();
			let schEndTime = $('#schEndTime').val();
			console.log('schStart : ',schStart);
			console.log('schStartTime : ',schStartTime);
			console.log('schEnd : ',schEnd);
			console.log('schEndTime : ',schEndTime);
			// console.log('schEndTime : ',typeof(schEndTime));
			
			/**/
			// 항상 기본 제약 조건 설정
			$('#schEnd').attr('min', schStart);
    		$('#schStart').attr('max', schEnd);
			
			if($('#schEndTime').val()||$('#schStartTime').val()){
				// 시작 시간이 변경될 때 종료 시간 최소값 업데이트
				console.log('이거 실행 되나?? inpName === startTime')
					let startDate = new Date(schStart.split("-")[0],parseInt(schStart.split("-")[1])-1+"",schStart.split("-")[2],
											schStartTime.split(":")[0],schStartTime.split(":")[1]);
					let endDate = new Date(schEnd.split("-")[0],parseInt(schEnd.split("-")[1])-1+"",schEnd.split("-")[2],
											schEndTime.split(":")[0],schEndTime.split(":")[1]);
					console.log('startTime : ',startDate)
					console.log('startTendTimeme : ',endDate)
					let chk = overChk(startDate,endDate,'minute',1);
					console.log('chk : ',chk)
					if(!chk){
						let errStr = '결과 : '+ chk+ ' validation 대상입니다. '
						swal({title:errStr,icon:"error"});
					}
			}

			// 같은 날짜일 경우 시간 제약 조건 처리
			if (schStart === schEnd) {
				if (inpName === 'start' || inpName === 'end') {
					// 날짜가 같을 때 시간 제약 조건 적용
					$('#schEndTime').attr('min', schStartTime);
					$('#schStartTime').attr('max', schEndTime);
				} else if (inpName === 'startTime' ||inpName === 'endTime') {
					// // 시작 시간이 변경될 때 종료 시간 최소값 업데이트
					// console.log('이거 실행 되나?? inpName === startTime')
					// let startDate = new Date(schStart.split("-")[0],parseInt(schStart.split("-")[1])-1+"",schStart.split("-")[2],
					// 						schStartTime.split(":")[0],schStartTime.split(":")[1]);
					// let endDate = new Date(schEnd.split("-")[0],parseInt(schEnd.split("-")[1])-1+"",schEnd.split("-")[2],
					// 						schEndTime.split(":")[0],schEndTime.split(":")[1]);
					// console.log('startTime : ',startDate)
					// console.log('startTendTimeme : ',endDate)
					// let chk = overChk(startDate,endDate,'minute',1);
					// console.log('chk : ',chk)
					// if(!chk){ alert('결과 : '+ !chk+ ' validation 대상입니다. '); }
				} 
			} else {
				// 다른 날짜일 경우 - 시간 제약 조건 제거
				console.log('다른 날짜일 경우 - 시간 제약 조건 제거')
				$('#schEndTime').removeAttr('min');
				$('#schStartTime').removeAttr('max');
			}
			/*
				const overChk = function(date1,date2,time,num){
					let differenceInDays
					if(time=="date"){
						differenceInDays = (date2 - date1) / (1000 * 60 * 60 * 24);
						console.log('date',differenceInDays)
					}else if(time=="minute"){
						differenceInDays = (date2 - date1) / (1000 * 60 );
						console.log('minute',differenceInDays)
					}
					return differenceInDays>=num?true:false;
				}
			*/
			/**/

			/*
			if(inpName == 'start'){
				console.log(inpName);
				console.log(schStart);
				// 날짜 최소 설정
				$('#schEnd').prop('min',schStart);
			}else if(inpName == 'startTime'){
				console.log(inpName);
				console.log(schStartTime);
				// 날짜 & 시간 최소 설정
				$('#schEnd').prop('min',schStart)
				$('#schEndTime').prop('min',schStartTime)

			}else if(inpName == 'end'){
				console.log(inpName);
				console.log(schEnd);
				// 날짜 최대 설정
				$('#schStart').prop('max',schEnd)
			}else if(inpName == 'endTime'){
				console.log(inpName);
				console.log(schEndTime);
				// 날짜 & 시간 최대 설정
				$('#schStart').prop('max',schEnd)
				$('#schStartTime').prop('max',schEndTime)
			}
			*/
		}
		$('.dateInp').on('change',function(){
			dateValidate($(this));
		})

		// 일자 선택 이벤트
		calendar.on("select", function(info) {
			let chk = checkDblClkSel();
			let startDate = new Date(info.start);
			let endDate = new Date(info.end);

			// $('#schdulTy').prop('disabeld',false);
			// $('#scheduleLabel').prop('disabeld',false);
			// console.log($('sssssssssssssssssssssss','#scheduleLabel').prop());
			if(info.view.type=='timeGridDay'||info.view.type=='timeGridWeek'){
				console.log("dragSel : ",info.view.type,info);
				selectEvent(info);
				$('.modal-title').text("일정 등록");
				$("#modalSubmit").text("등록");
				// if($("#deleteBtn").length){
				$("#deleteBtn").hide();
				// }
			}
			// 더블 클릭 아닌 것(드래그)
			if(!chk){
				// 드래그 선택
				if(overChk(startDate,endDate,'date',2)){
					selectEvent(info);
					$('.modal-title').text("일정 등록");
					$("#modalSubmit").text("등록");
					// if($("#deleteBtn").length){
						$("#deleteBtn").hide();
					// }
				}
			}
		})

	// 클릭 및 드래그 선택 이벤트 끝

		// 등록된 일정 클릭시 이벤트
		calendar.on("eventClick",info=>{
			console.log("eventClick -> info : ", info);
			let popover = document.querySelector(".fc-popover");
			$('#schdulTy').prop('disabled',true);
			if(info.event._def.extendedProps.schdulTy!=0){
				$('#scheduleLabel').prop('disabled',true);
			}else{
				$('#scheduleLabel').prop('disabled',false);
			}
			if(popover){
				popover.remove();
			}
			insModal.show();
			$('.modal-title').text("일정 상세");
			$("#modalSubmit").text("수정");
			// $('#deleteBtn').css('display','block');
			$('#deleteBtn').show();
			let title = info.event._def.title;
			if(info.event._def.extendedProps.schdulTy!='0'){
				title = title.split(']')[1];
			}
			// if($("#deleteBtn").length==0){
				// $("#btnGroup").append('<button type="button" id="deleteBtn" class="main-btn btn btn-danger btn-hover" onclick="fCalDel(event)">삭제</button>');
			// }
			let start = info.event.start;
			let end = info.event.end;
			$('#addUpt').val("update");
			$('#schdulNo').val(info.event._def.publicId);
			$('#schStart').val(date2Str(start));
			$('#schStartTime').val(time2Str(start));
			$('#schEnd').val(date2Str(end));
			$('#schEndTime').val(time2Str(end));
			$('#schTitle').val(title);
			$('#schContent').val(info.event._def.extendedProps.schdulCn);
			$('#schdulTy').val(info.event._def.extendedProps.schdulTy);
			console.log($('#scheduleLabel').val(info.event._def.extendedProps.lblNo));
			dateValidate($('#schStart'));
			dateValidate($('#schStartTime'));
			dateValidate($('#schEnd'));
			dateValidate($('#schEndTime'));
		})	
		
		// allDay 관련 함수들 시작
		document.getElementById("allDay").addEventListener('change',function(e){
			console.log("allDay 실행 : ",e);
			console.log("allDay 이벤트 객체 확인 : ",e.target);
			let isCheck = $("#allDay").prop("checked");
			if(isCheck){
				$('.timeInput-toggle.time').css('display','block');
				$('.timeInput-toggle.date').css('display','none');
			}else{
				$('.timeInput-toggle.time').css('display','none');
				$('.timeInput-toggle.date').css('display','block');

			}
			console.log("allDay : ",isCheck);
			/* 주석 시작 */
			// let startStr = $("#schStart").val();
			// let endStr = $("#schEnd").val();
			// console.log("startStr : ",startStr," , endStr : ",endStr);
			/* 주석 끝 */

			// if(isCheck){
			// 	let dateStr = new Date(startStr);
			// 	console.log("dateStr : ",(dateStr));
			// 	dateStr.setDate(dateStr.getDate()+1)
			// 	// console.log("dateStr-2 : ",(dateStr.getDate()-2));
			// 	console.log("dateStr+1 : ",dateStr.toISOString().split("T")[0]);

			// 	$("#schEnd").val(dateStr.toISOString().split("T")[0]);
			// 	$("#schStartTime").val("00:00");
			// 	$("#schEndTime").val("00:00");
			// }
		});

		// document.querySelectorAll('.dateInp').forEach(input=>{
		// 	input.addEventListener('change',function(){
		// 		let isChecked = $("#allDay").prop("checked");
		// 		// console.log("시간 변경, isChecked 변경 전 : ",isChecked);
		// 		if(isChecked){
		// 			$("#allDay").prop("checked",false);
		// 			// console.log("시간 변경, isChecked 변경 후 : ",$("#allDay").prop("checked"));
		// 		}
		// 	})
		// })
		// allDay 관련 함수들 끝


		
// 함수들
		const date2Str = function(date){
			// date는 Date객체
			let newDate = new Date(date);
			let yearStr = newDate.getFullYear().toString();
			let monthStr = (newDate.getMonth()+1).toString().padStart(2,'0');
			let dateStr = newDate.getDate().toString().padStart(2,'0');
			console.log("yearStr",yearStr);
			console.log("monthStr",monthStr);
			console.log("dateStr",dateStr);
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
			let chk = e.target.form.allDay.checked;
			// console.log('clickEvent2Date -> : ',chk)
			let startStr;
			let startTimeStr;
			let endStr;
			let endTimeStr;
			let startDate;
			let endDate;
			console.log('e.target.form',e.target.form)
			if(chk){
				startStr = e.target.form.date.value;
				startTimeStr = e.target.form.startTime.value;
				endStr = e.target.form.date.value;
				endTimeStr = e.target.form.endTime.value;
				
				startDate = new Date(startStr.split("-")[0],parseInt(startStr.split("-")[1])-1+"",startStr.split("-")[2],startTimeStr.split(":")[0],startTimeStr.split(":")[1]);
				endDate = new Date(endStr.split("-")[0],parseInt(endStr.split("-")[1])-1+"",endStr.split("-")[2],endTimeStr.split(":")[0],endTimeStr.split(":")[1]);
			}else{
				startStr = e.target.form.start.value;
				endStr = e.target.form.end.value;
				
				startDate = new Date(startStr.split("-")[0],parseInt(startStr.split("-")[1])-1+"",startStr.split("-")[2]);
				endDate = new Date(endStr.split("-")[0],parseInt(endStr.split("-")[1])-1+"",endStr.split("-")[2]);
			}
			// console.log('clickEvent2Date -> startStr: ',startStr);
			// console.log('clickEvent2Date -> startTimeStr: ',startTimeStr);
			// console.log('clickEvent2Date -> endStr: ',endStr);
			// console.log('clickEvent2Date -> endTimeStr: ',endTimeStr);

			// console.log('clickEvent2Date -> : ',{startDate,endDate});
			return {startDate,endDate}
		}

		window.fCalAdd= function(e){
			// 여기 분기처리 해야함!
			// 하루종일 체크 여부에 따라 input 선택하는거 달라짐

			// e는 버튼을 가져오려고
			e.preventDefault();
			console.log("실행!!!!!!!!!",e)
			if($('#scheduleLabel').val()!=0){
				$('#scheduleLabel').prop('disabled',false);
			}
			let status = $('#addUpt').val();
			let postUrl = '';
			
			console.log("event : ",e);
			// console.log("event -> form : ",e.target.form);
			// console.log("event -> input.start : ",e.target.form.start.value);
			// console.log("event -> input.start : ",e.target.form.startTime.value);
			
			if(!e.target.form.schdulSj.value){
				swal({title:'제목을 입력하세요',icon:"error"});
				return;
			}

			let {startDate,endDate} = clickEvent2Date(e);
			console.log("fCalAdd -> startDate : ",startDate);
			console.log("fCalAdd -> endDate : ",endDate);
			// return
			let frmData = new FormData();
			frmData.append("emplNo",emplNo);
			frmData.append("deptCode",deptCode);
			frmData.append("lblNo",e.target.form.lblNo.value);
			frmData.append("schdulBeginDt",startDate);
			frmData.append("schdulEndDt",endDate);
			frmData.append("schdulTy",e.target.form.schdulTy.value);
			frmData.append("schdulSj",e.target.form.schdulSj.value);
			frmData.append("schdulCn",e.target.form.content.value);
			frmData.append("lblNo",e.target.form.lblNo.value);
			console.log("fCalAdd -> frmData : ",frmData);			
			if(status=="add"){
				postUrl = "/myCalendar/addCalendar";
			}else{
				postUrl="/myCalendar/uptCalendar";
				frmData.append("schdulNo",e.target.form.schdulNo.value);
			}
			$('#schdulTy').prop('disabeld',false);
			$('#scheduleLabel').prop('disabeld',false);
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
			// if(!confirm('삭제하시겠습니까??')) { return; }
			Swal.fire({
				title: '삭제하시겠습니까?',
				icon: 'warning',
				showCancelButton: true,
				confirmButtonText: '확인',
				cancelButtonText: '취소'
			}).then((result) => {
				if(result.isConfirmed) {
				// 확인 버튼 클릭 시 실행할 코드
					let schdulNo = e.target.closest("form").schdulNo.value;
					console.log("event check",schdulNo);
					$.ajax({
						url:"/myCalendar/delCalendar",
						type:"post",
						data:JSON.stringify({schdulNo : schdulNo, emplNo : emplNo, deptCode : deptCode}),
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
					console.log('삭제 확인됨');
				} else {
					// 취소 버튼 클릭 시 실행할 코드
					console.log('삭제 취소됨');
					return;
				}
			});
		};
		
		calendar.on("eventMouseEnter",function(info){
			// console.log(info)
		})
		
		window.fMClose = function() {
			$('#calAddFrm input').val('');
			$('#schdulTy').val(0);
			$('#scheduleLabel').val(0);
			$('')
			// console.log("calAddFrm",calAddFrm);
			$('#schdulTy').prop('disabled',false);
			$('#scheduleLabel').prop('disabled',false);
			$('.timeInput-toggle.date').css('display','block');
			$('.timeInput-toggle.time').css('display','none');
			insModal.hide();
		};
		// let btnclass = $('.fc-button').attr('class');
		// $('.fc-button').attr('class',btnclass+' btn-primary');
		// $('.fc-button').prop('class','btn btn-primary');
		$('.fc-button').css('background-color','#0d6efd');

		$('.fc-dayGridMonth-button.fc-button.fc-button-primary').css('background-color','#88A1F8');
		$('.fc-timeGridWeek-button.fc-button.fc-button-primary').css('background-color','#88A1F8');
		$('.fc-timeGridDay-button.fc-button.fc-button-primary').css('background-color','#88A1F8');
		$('.fc-listWeek-button.fc-button.fc-button-primary').css('background-color','#88A1F8');

		$('.fc-button-active').css('background-color','#0d6efd');
		$('.fc-button').on('click',function(){
			$('.fc-button-active').css('background-color','#0d6efd');

			$('.fc-dayGridMonth-button.fc-button.fc-button-primary').not('.fc-button-active').css('background-color','#88A1F8');
			$('.fc-timeGridWeek-button.fc-button.fc-button-primary').not('.fc-button-active').css('background-color','#88A1F8');
			$('.fc-timeGridDay-button.fc-button.fc-button-primary').not('.fc-button-active').css('background-color','#88A1F8');
			$('.fc-listWeek-button.fc-button.fc-button-primary').not('.fc-button-active').css('background-color','#88A1F8');
		})
		// $('.fc-button').css('margin','0.5px');
		// $('.fc-button').css('border','0px');
		$('.fc-daygrid-day-number').css('text-decoration','none');
		$('.fc-col-header-cell-cushion').css('text-decoration','none');

		// 이벤트 위임을 사용하여 문제 해결
		$(document).on('mouseenter', '.fc-daygrid-day-frame', function() {
			let code = `<div class="fc-daygrid-bg-harness" style="left: 0px; right: 0px;"><div class="fc-highlight"></div></div>`;
			$(this).find('.fc-daygrid-day-bg').append(code);
		});
		// fc-listWeek-view fc-view fc-list fc-list-sticky
		$(document).on('mouseleave', '.fc-daygrid-day-frame', function() {
			$(this).find('.fc-daygrid-bg-harness').remove();
		});

		// 휠 이벤트
		// function throttle(callback,limit){
		// 	let waiting = false;
		// 	return function(...arguments){
		// 		if(!waiting){
		// 			callback.apply(this,arguments);
		// 			waiting = true;
		// 			setTimeout(function(){
		// 				waiting = false;
		// 			},limit)
		// 		}
		// 	};
		// }
		// $(document).on('wheel',"#myCalendar .fc-dayGridMonth-view,#myCalendar .fc-listWeek-view", throttle(function(event){
		// 	console.log(event);
		// 	if(event.originalEvent.deltaY<0){
		// 		console.log('위로');
		// 		$('.fc-prev-button').trigger('click');
		// 	}else{
		// 		console.log('아래로');
		// 		$('.fc-next-button').trigger('click');

		// 	}
		// }),500)
		$(document).on('wheel',"#myCalendar .fc-dayGridMonth-view,#myCalendar .fc-listWeek-view", function(event){
			console.log(event);
			if(event.originalEvent.deltaY<0){
				console.log('위로');
				$('.fc-prev-button').trigger('click');
			}else{
				console.log('아래로');
				$('.fc-next-button').trigger('click');

			}
		})

		$('#myCalendar').mousedown(function(e){
			if(e.which == 2){
				e.preventDefault();
				$('.fc-today-button').trigger('click');
			}
		})
	})
</script>
</head>
<body>
	<jsp:include page="scheduleSidebar.jsp"></jsp:include>
	<jsp:include page="scheduleFormModal.jsp"></jsp:include>
	<div id="contentContainer" style="height:100%;" >
		<div id='myCalendar' style="height:100%;" ></div>
	</div>
	
</body>
<style>
	.fc-event-title-container{
		cursor: pointer;
	}
	.fc-button{
		background-color: #88A1F8;
	}
	.fc-button-active {
		/* background-color: rgb(13, 110, 253); */
		color: white;
		transform: scale(1.1);
		transition: transform 0.3s ease, background-color 0.3s ease;
		
	}
	.fc-date:hover{
		background-color: #BCE8F14D;
	}
	.promo-box{
		display: none;
	}
	#calendarContainer{
		height: 80vh;
		position: relative;
		top: -20px;
	}
	#calendarContent{
		background-color: white;
	}

	:is(.fc-day-mon, .fc-day-tue, .fc-day-wed, .fc-day-thu, .fc-day-fri) .fc-daygrid-day-number,
	:is(.fc-day-mon, .fc-day-tue, .fc-day-wed, .fc-day-thu, .fc-day-fri) .fc-col-header-cell-cushion,
	:is(.fc-day-mon, .fc-day-tue, .fc-day-wed, .fc-day-thu, .fc-day-fri) .fc-list-day-text,
	:is(.fc-day-mon, .fc-day-tue, .fc-day-wed, .fc-day-thu, .fc-day-fri) .fc-list-day-side-text {
		color: black;
	}
	.fc-day-sun .fc-col-header-cell-cushion,
	.fc-day-sun .fc-list-day-text,
	.fc-day-sun .fc-daygrid-day-number{
		color : red;
	}

	.fc-day-sat .fc-col-header-cell-cushion,
	.fc-day-sat .fc-list-day-text,
	.fc-day-sat .fc-daygrid-day-number {
		color : blue;
	}
	/* .fc-timegrid-slot .fc-daygrid-day-frame:hover {
	} */
</style>
</html>