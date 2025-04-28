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
        padding: 1px !important;
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
        justify-content: space-between;
        align-items: center;
        margin-bottom: 10px;
    }
    
    .calendar-header h6 {
        margin: 0;
    }
    
    /* .more-link {
        color: #4a6cf7;
        font-size: 0.875rem;
        font-weight: 600;
        text-decoration: none;
    }
    
    .more-link .material-icons {
        vertical-align: middle;
        font-size: 1rem;
    } */
</style>
<script>
    document.addEventListener('DOMContentLoaded', function() {

        var calendarEl = document.getElementById('myCalendar');
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
            handleWindowResize: true,
            expandRows: true,
            selectable: false,
            selectMirror: false,
            navLinks: false,
            weekNumbers: false,
            editable: false,
            eventDurationEditable: false,
            eventStartEditable: false,
            eventResizableFromStart: false,
            dayMaxEventRows: 1,
            droppable: false,
            aspectRatio: 1.5,
            fixedWeekCount: false,
            contentHeight: 280,
            dayMaxEvents: true,
            eventDisplay: 'none',

            events: [], // 일단 비워놓음

            dayCellDidMount: function(info) {
                // info.el.style.height = '30px';
                const dateStr = info.date.toISOString().split('T')[0];
                const hasEvent = calendar.getEvents().some(event => event.startStr.startsWith(dateStr));
                if (hasEvent) {
                    const dot = document.createElement('div');
                    dot.style.width = '6px';
                    dot.style.height = '6px';
                    dot.style.margin = '0 auto';
                    dot.style.marginTop = '5px';
                    dot.style.backgroundColor = 'blue';
                    dot.style.borderRadius = '50%';
                    info.el.appendChild(dot);
                }
            }
        });
        calendar.render();

        window.globalCalendar = calendar;

        $('.fc-button').css('background-color','#0d6efd');
        $('.fc-button').css('border','none');
        $('.fc-today-button').prop('disabled',false);
        $('.fc-prev-button,.next-button,.fc-today-button').on('click',function(){
            $('.fc-today-button').prop('disabled',false);
        })

        $.ajax({
            url: "/myCalendar/calendarMainHome",
            // data:JSON.stringify({deptCode:deptCode}),
            method: 'get',
            success: function(data) {
                console.log("refresh -> data : ",data);
                let clndr = chngData(data);
                console.log("refresh -> data-> chngData : ",clndr);
                window.globalCalendar.setOption('events', clndr);
                // calendar.render();
                // console.log("==================refresh : ",clndr);
                // scheduleList = clndr;
            }
		});

        const chngData = function(dataMap) {
            let returnData = [];
            dataMap.scheduleList.forEach(data => {
                let startDate = new Date(data.schdulBeginDt);
                let endDate = new Date(data.schdulEndDt);
                returnData.push({
                    "id": data.schdulNo,
                    "start": startDate,
                    "end": endDate,
                })
            });
            return returnData;
        }
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