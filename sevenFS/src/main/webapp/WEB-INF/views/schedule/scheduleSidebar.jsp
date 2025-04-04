<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="calendarContainer">
    <!-- 왼쪽 사이드바 -->
    <div id="calendarSidebar" class="sidebar">
        <h3>📅 캘린더 메뉴</h3>
        <!-- 일정 추가 버튼 -->
        <div class="add-event">
            <button id="openModalBtn" class="btn btn-primary">일정 추가</button>
        </div>
        
        <div class="input-style-1 form-group col-12">
            <input type="text" name="searchSj" class="form-control" id="searchSj" placeholder="검색" maxlength="100">
        </div>
        
        <!-- 일정 필터 -->
        <div class="filter-section">
            <h3>일정 필터</h3>
            <label><input type="checkbox" id="filter-all" checked> 전체 보기</label><br>
            <label><input type="checkbox" class="event-filter" value="meeting"> 전체일정</label><br>
            <label><input type="checkbox" class="event-filter" value="task"> 부서 일정</label><br>
            <label><input type="checkbox" class="event-filter" value="personal"> 개인 일정</label>
        </div>
        <div class="label-section" id="labelSection">
            <h3>라벨</h3>
            <label><input type="checkbox" id="label-all" checked> 전체 보기</label><br>
        </div>

    </div>

    <!-- 캘린더 영역 -->
    <div id="calendarContent">
        <div id='myCalendar'></div>
    </div>
</div>

<!-- 스타일 -->
<style>
    /* 전체 컨테이너 */
    #calendarContainer {
        display: flex;
        height: 100vh;
        width: 100%;
        overflow: hidden; /* 내용이 넘치지 않도록 설정 */
    }

    /* 왼쪽 사이드바 */
    .sidebar {
        width: 250px;
        min-width: 250px; /* 최소 너비 설정 */
        height: 100%;
        background: #f8f9fa;
        padding: 15px;
        border-right: 1px solid #ddd;
        box-shadow: 2px 0 5px rgba(0,0,0,0.1);
        overflow-y: auto; /* 내용이 많을 경우 스크롤 표시 */
    }

    /* 사이드바 내부 요소들 */
    .sidebar h3 {
        margin-bottom: 15px;
    }

    .filter-section {
        margin-top: 20px;
        margin-bottom: 20px;
    }

    .filter-section label {
        display: block;
        margin-bottom: 5px;
    }

    .add-event {
        margin-top: 20px;
    }

    /* 캘린더 영역 */
    #calendarContent {
        flex: 1; /* 남은 공간을 모두 차지 */
        padding: 20px;
        overflow-y: auto; /* 내용이 많을 경우 스크롤 표시 */
    }
</style>

<!-- 스크립트 -->
<script>
    document.addEventListener("DOMContentLoaded", function() {
        // 필터 변경 시 이벤트
        document.querySelectorAll(".event-filter").forEach(filter => {
            filter.addEventListener("change", function() {
                console.log("필터 변경:", this.value, this.checked);
                
                // 전체 필터와 개별 필터 동기화
                const allFilter = document.getElementById("filter-all");
                const eventFilters = document.querySelectorAll(".event-filter");
                
                // 개별 필터가 변경되면 전체 보기 체크 상태 업데이트
                let allChecked = true;
                eventFilters.forEach(f => {
                    if (!f.checked) allChecked = false;
                });
                
                allFilter.checked = allChecked;
                
                // FullCalendar 필터링 로직 추가 가능
                if (window.globalCalendar) {
                    // 필터 로직 구현
                }
            });
        });

        // 전체 보기 체크박스 이벤트
        document.getElementById("filter-all").addEventListener("change", function() {
            const isChecked = this.checked;
            document.querySelectorAll(".event-filter").forEach(filter => {
                filter.checked = isChecked;
            });
            
            // FullCalendar 필터링 로직 추가 가능
        });

        // 일정 추가 버튼 클릭 이벤트
        document.getElementById("openModalBtn").addEventListener("click", function() {
            console.log("일정 추가 버튼 클릭");
            // 모달 창 열기
            if (window.bootstrap && typeof bootstrap.Modal !== 'undefined') {
                var insModal = new bootstrap.Modal(document.getElementById('myModal'));
                insModal.show();
            }
        });
    });
</script>