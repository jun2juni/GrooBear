<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
<style>
    /* 캘린더 컨테이너 스타일 */
    #calendarContainer {
        padding: 5px;
        width: 100%;
    }
    
    /* 캘린더 자체 스타일 */
    #myCalendar {
        height: 330px !important; /* 고정된 높이 설정 */
        max-height: 330px !important;
        width: 100%;
        font-size: 0.9em;
    }
    
    /* 날짜 셀 간격 조정 */
    .fc-daygrid-day {
        height: 40px !important;
        max-height: 40px !important;
        min-height: 40px !important;
        box-sizing: border-box !important;
    }

    /* 날짜 셀 내부 컨테이너 */
    .fc-daygrid-day-frame {
        height: 100% !important;
        display: flex !important;
        flex-direction: column !important;
    }

    /* 날짜 상단 영역 */
    .fc-daygrid-day-top {
        display: flex !important;
        padding: 2px 4px !important;
        height: auto !important;
    }

    /* 날짜 이벤트 영역 - 숨김 처리 */
    .fc-daygrid-day-events {
        height: 0 !important;
        margin: 0 !important;
        padding: 0 !important;
        visibility: hidden !important;
    }

    /* 날짜 바텀 영역 - 숨김 처리 */
    .fc-daygrid-day-bottom {
        height: 0 !important;
        margin: 0 !important;
        padding: 0 !important;
        visibility: hidden !important;
    }
    /* 더보기 링크 숨기기 */
    .fc-more-link {
        display: none !important;
    }

    /* 이벤트 표시 관련 스타일 */
    .event-indicator-container {
        position: relative;
        display: inline-flex;
        align-items: center;
        margin-left: 3px;
        padding: 0;
        line-height: 1;
        gap: 2px; /* 점 사이 간격 추가 */
    }

    /* 기본 이벤트 점 스타일 */
    .event-dot {
        width: 5px;
        height: 5px;
        border-radius: 50%;
        display: inline-block;
        flex-shrink: 0;
    }

    /* 일정 유형별 색상 */
    .event-dot-personal {
        background-color: green; /* 개인일정: 녹색 */
    }
    
    .event-dot-department {
        background-color: blue; /* 부서일정: 파란색 */
    }
    
    .event-dot-public {
        background-color: red; /* 전체일정: 빨간색 */
    }

     /* 헤더 부분 크기 조정 */
    .fc-header-toolbar {
        margin-bottom: 0.5em !important;
        font-size: 0.9em !important;
    }
    
    /* 헤더 타이틀 크기 조정 */
    .fc-toolbar-title {
        font-size: 1.2em !important;
    }
    
    /* 이벤트 표시 스타일 조정 */
    .fc-event {
        border-radius: 3px;
        font-size: 0.8em;
    }
    
    /* 오늘 날짜 강조 */
    .fc-day-today {
        background-color: rgba(230, 230, 250, 0.3) !important;
    }
     /* 캘린더 날짜 숫자 크기 조정 */
    .fc-daygrid-day-number {
        font-size: 0.85em;
        padding: 2px 4px !important;
    }
    
    /* "더보기" 링크 스타일 */
    .calendar-header {
        display: flex;
        align-items: center;
        justify-content: flex-start;
        padding: 2px 4px !important;
        font-size: 0.85em;
    }
    
    .calendar-header h6 {
        margin: 0;
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
</style>
<script>
    document.addEventListener('DOMContentLoaded', function() {

        var calendarEl = document.getElementById('myCalendar');

        // 현재 날짜 가져오기
        const today = new Date();

        // 현재 달의 첫날 구하기
        const firstDayOfMonth = new Date(today.getFullYear(), today.getMonth(), 1);

        // 현재 달의 마지막 날 구하기
        const lastDayOfMonth = new Date(today.getFullYear(), today.getMonth() + 1, 0);

        // 전역변수로 캘린더 저장 (다른 함수에서 접근 가능하도록)
        window.globalCalendar = null;
        
        var calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            locale: 'ko',
            headerToolbar: {
                left: 'prev,today,next',
                center: 'title',
                right: ''
            },
            buttonText: {
                prev: '<',
                next: '>'
            },
            nowIndicator: true,
            eventOverlap: false,
            handleWindowResize: false,
            expandRows: false,
            selectable: false,
            selectMirror: false,
            navLinks: false,
            weekNumbers: false,
            editable: false,
            eventDurationEditable: false,
            eventStartEditable: false,
            eventResizableFromStart: false,
            dayMaxEventRows: 0,
            dayMaxEvents: 0,
            droppable: false,
            aspectRatio: 1.5,
            fixedWeekCount: false,
            height:'auto',
            contentHeight: 280,
            eventDisplay: 'none',
            showNonCurrentDates:true,
            fixedWeekCount:true,
            events: [], // 일단 비워놓음
            // rerenderDelay: 100, // 이벤트 변경 시 리렌더링 지연시간 설정
            eventContent: function() { return null; }, // 이벤트 자체는 표시하지 않음
            dayCellDidMount: function(info) {
                // 셀 프레임에 고정 높이 적용
                const cellFrame = info.el.querySelector('.fc-daygrid-day-frame');
                if (cellFrame) {
                    cellFrame.style.height = '40px';
                }
                
                // 현재 날짜의 시작 (00:00:00)
                const currentDate = info.date;
                const startOfDay = new Date(currentDate);
                startOfDay.setHours(0, 0, 0, 0);
                
                // 현재 날짜의 끝 (23:59:59)
                const endOfDay = new Date(currentDate);
                endOfDay.setHours(23, 59, 59, 999);
                
                // 이벤트 타입별로 그룹화할 객체 초기화
                const eventTypes = {
                    personal: false,    // 개인일정 (0)
                    department: false,  // 부서일정 (1)
                    public: false       // 전체일정 (2)
                };
                
                // 모든 이벤트를 가져와서 각 타입별로 처리
                const allEvents = calendar.getEvents();
                // console.log('날짜:', info.date, '이벤트 수:', allEvents.length);
                
                // 현재 날짜에 해당하는 이벤트 확인
                allEvents.forEach(event => {
                    const eventStart = event.start;
                    const eventEnd = event.end || new Date(eventStart);
                    
                    // 이벤트 종료일이 없는 경우 시작일의 끝으로 설정
                    if (!event.end) {
                        eventEnd.setHours(23, 59, 59, 999);
                    }
                    
                    // 이벤트 날짜가 현재 날짜와 겹치는지 확인
                    if ((eventStart <= endOfDay) && (eventEnd >= startOfDay)) {
                        // 이벤트 타입에 따라 표시 설정
                        const schdulTy = event.extendedProps.schdulTy;
                        if (schdulTy === 0) {
                            eventTypes.personal = true;
                        } else if (schdulTy === 1) {
                            eventTypes.department = true;
                        } else if (schdulTy === 2) {
                            eventTypes.public = true;
                        }
                    }
                });
                
                // 이벤트가 존재하는 경우에만 점 표시
                if (eventTypes.personal || eventTypes.department || eventTypes.public) {
                    // 날짜 숫자 요소 찾기
                    const dayTop = info.el.querySelector('.fc-daygrid-day-top');
                    
                    if (dayTop) {
                        // 기존에 있던 이벤트 표시기 제거 (중복 방지)
                        const existingIndicator = dayTop.querySelector('.event-indicator-container');
                        if (existingIndicator) {
                            existingIndicator.remove();
                        }
                        
                        // 새 이벤트 표시기 컨테이너 생성
                        const indicatorContainer = document.createElement('div');
                        indicatorContainer.className = 'event-indicator-container';
                        
                        // 전체일정 점 추가 (빨간색)
                        if (eventTypes.public) {
                            const publicDot = document.createElement('div');
                            publicDot.className = 'event-dot event-dot-public';
                            indicatorContainer.appendChild(publicDot);
                        }
                        
                        // 부서일정 점 추가 (파란색)
                        if (eventTypes.department) {
                            const deptDot = document.createElement('div');
                            deptDot.className = 'event-dot event-dot-department';
                            indicatorContainer.appendChild(deptDot);
                        }
                        
                        // 개인일정 점 추가 (녹색)
                        if (eventTypes.personal) {
                            const personalDot = document.createElement('div');
                            personalDot.className = 'event-dot event-dot-personal';
                            indicatorContainer.appendChild(personalDot);
                        }
                        
                        // 날짜 상단 영역에 컨테이너 추가
                        dayTop.appendChild(indicatorContainer);
                    }
                }
            }
        });

        // 전역 변수에 캘린더 객체 저장
        window.globalCalendar = calendar;

        

        refresh = function(){
            return $.ajax({
            url: "/myCalendar/calendarMainHome",
            method: 'get',
            success: function(data) {
                    console.log("refresh -> data : ",data);
                    let clndr = chngData(data);
                    console.log("refresh -> data-> chngData : ",clndr);
                    
                    // 기존 이벤트 모두 제거
                    let oldEvents = window.globalCalendar.getEvents();
                    oldEvents.forEach(event => event.remove());
                    
                    // 새 이벤트 추가
                    clndr.forEach(eventData => {
                        window.globalCalendar.addEvent(eventData);
                    });
                    
                    console.log('추가 후 이벤트 수:', window.globalCalendar.getEvents().length);
                    
                    // 모든 날짜 셀을 재구성하도록 강제 리렌더링
                    window.globalCalendar.render();
                }
		    });
        }

        const chngData = function(dataMap) {
            let returnData = [];
            if (!dataMap || !dataMap.scheduleList) {
                console.error('일정 데이터가 없거나 형식이 맞지 않습니다:', dataMap);
                return returnData;
            }
            
            // console.log('일정 데이터 개수:', dataMap.scheduleList.length);
            
            dataMap.scheduleList.forEach(data => {
                // 날짜 문자열인 경우 타임존 이슈를 방지하기 위해 직접 파싱
                let startDate, endDate;
                
                if (typeof data.schdulBeginDt === 'string') {
                    // 문자열 형식이 "YYYY-MM-DD" 또는 "YYYY-MM-DD HH:MM:SS" 형태라고 가정
                    if (data.schdulBeginDt.includes('T') || data.schdulBeginDt.includes(' ')) {
                        // ISO 형식이나 공백으로 구분된 날짜 시간
                        startDate = new Date(data.schdulBeginDt);
                    } else {
                        // 날짜만 있는 경우 (YYYY-MM-DD)
                        const parts = data.schdulBeginDt.split('-');
                        if (parts.length === 3) {
                            startDate = new Date(
                                parseInt(parts[0]), 
                                parseInt(parts[1]) - 1, // 월은 0부터 시작
                                parseInt(parts[2])
                            );
                        } else {
                            startDate = new Date(data.schdulBeginDt);
                        }
                    }
                } else {
                    startDate = new Date(data.schdulBeginDt);
                }
                
                if (typeof data.schdulEndDt === 'string') {
                    // 문자열 형식이 "YYYY-MM-DD" 또는 "YYYY-MM-DD HH:MM:SS" 형태라고 가정
                    if (data.schdulEndDt.includes('T') || data.schdulEndDt.includes(' ')) {
                        // ISO 형식이나 공백으로 구분된 날짜 시간
                        endDate = new Date(data.schdulEndDt);
                    } else {
                        // 날짜만 있는 경우 (YYYY-MM-DD)
                        const parts = data.schdulEndDt.split('-');
                        if (parts.length === 3) {
                            endDate = new Date(
                                parseInt(parts[0]), 
                                parseInt(parts[1]) - 1, // 월은 0부터 시작
                                parseInt(parts[2])
                            );
                            // 종일 이벤트인 경우 해당 날짜의 23:59:59로 설정
                            endDate.setHours(23, 59, 59, 999);
                        } else {
                            endDate = new Date(data.schdulEndDt);
                        }
                    }
                } else {
                    endDate = new Date(data.schdulEndDt);
                }
                
                // console.log('시작일:', startDate, '종료일:', endDate);
                
                // 종료일이 시작일보다 빠르거나 같은 경우, 종료일을 시작일의 23:59:59로 설정
                if (endDate <= startDate) {
                    endDate = new Date(startDate);
                    endDate.setHours(23, 59, 59, 999);
                }
                
                // schdulTy가 숫자가 아닌 경우 기본값 0으로 설정
                let schdulTy = data.schdulTy;
                if (typeof schdulTy !== 'number') {
                    schdulTy = parseInt(schdulTy, 10);
                    if (isNaN(schdulTy)) {
                        schdulTy = 0; // 기본값은 개인일정
                    }
                }
                
                returnData.push({
                    "id": data.schdulNo,
                    "start": startDate,
                    "end": endDate,
                    "extendedProps": {
                        "schdulTy": schdulTy // 일정 타입 정보 추가 (0:개인, 1:부서, 2:전체)
                    }
                });
            });
            
            // 생성된 이벤트 데이터 확인
            console.log('생성한 이벤트 데이터:', returnData);
            return returnData;
        }
        calendar.render();
        refresh();
        // 버튼 설정
        $('.fc-button').css('background-color','#0d6efd');
        $('.fc-button').css('border','none');
        $('.fc-today-button').prop('disabled',false);
        $('.fc-prev-button,.fc-next-button,.fc-today-button').on('click',function(){
            $('.fc-today-button').prop('disabled',false);
        })
    })
</script>
</head>
<body>
     <!-- 타이틀과 캘린더를 함께 표시 -->
     <div id="calendarContainer">
        <div class="calendar-header">
            <a href="/myCalendar" class="text-sm fw-bolder" style="margin-left: auto; display: flex; align-items: center;">
                더보기 
                <span class="material-symbols-outlined" style="margin-left: 4px;">chevron_right</span>
            </a>
        </div>
        <div id="myCalendar"></div>
    </div>
</body>
</html>