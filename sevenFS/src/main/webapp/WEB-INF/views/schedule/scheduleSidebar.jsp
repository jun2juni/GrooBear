<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="calendarContainer">
    <!-- 왼쪽 사이드바 -->
    <div id="calendarSidebar" class="sidebar">
        <h3>📅 캘린더 메뉴</h3>
        <!-- 일정 추가 버튼 -->
        <div class="add-event" style="margin-bottom: 10px;">
            <button id="openModalBtn" class="btn btn-primary">일정 추가</button>
        </div>
        
        <div class="input-style-1 form-group col-12">
            <input type="text" name="searchSj" class="form-control" id="searchSj" placeholder="검색" maxlength="100">
        </div>
        
        <!-- 일정 필터 -->
        <div class="filter-section">
            <h3>일정 필터</h3>
            <button type="button" id="filterAll"> 전체 보기</button><br>
            <div id="filterSection">
                <label>전체 일정<input type="checkbox" class="event-filter" value="2" checked></label><br>
                <label>부서 일정<input type="checkbox" class="event-filter" value="1" checked></label><br>
                <label>개인 일정<input type="checkbox" class="event-filter" value="0" checked></label>
            </div>
        </div>
        <!-- 라벨 필터 -->
        <div class="label-section">
            <h3>라벨</h3>
            <button type="button" id="labelAll">전체 보기</button>
            <div class="label-action-wrapper" style="position: relative; display: inline-block;">
                <button id="addLabelBtn" type="button">추가</button>
                <!-- 라벨 추가 팝업 -->
                <div id="labelPopup" class="label-popup" style="display: none;" >
                    <div id="colorPicker" class="color-picker">
                        <!-- 여기에 색상 셀이 들어감 -->
                    </div>
                    <input type="text" class="input-style-1" id="newLabelName" placeholder="라벨 이름 입력" />
                    <button id="saveLabelBtn">저장</button>
                </div>
            </div>
            <br>
            <label>[기본] 나의 일정<input type="checkbox" class="label-filter" id="def" value="0" checked></label><br>
            <div id="labelSection">
            </div>
        </div>

    </div>

    <!-- 캘린더 영역 -->
    <div id="calendarContent">
        <div id='myCalendar'></div>
    </div>
</div>

<!-- 스타일 -->
<style>
    .label-popup {
        /* display: none; //처음엔 숨김 */
        position: absolute;
        background: white;
        border: 1px solid #ccc;
        padding: 10px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.15);
        z-index: 1000;
        width: 200px;
        border-radius: 5px;
    }
    .color-picker {
    display: grid;
    grid-template-columns: repeat(5, 20px);
    gap: 5px;
    margin: 10px 0;
}

    .color-cell {
        width: 20px;
        height: 20px;
        border-radius: 3px;
        cursor: pointer;
        border: 2px solid transparent;
        position: relative;
    }

    .color-cell.selected {
        border: 2px solid #333;
    }
    .color-cell.selected::after {
        content: '✔'; /* 혹은 ✓ */
        color: white;
        font-size: 14px;
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
    }



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
    .lblIcon:hover {
        transform: scale(1.3); /* 20% 확대 */
        transition: transform 0.3s ease-in-out; /* 부드러운 애니메이션 효과 */
    }



</style>
<script>
    document.addEventListener('DOMContentLoaded', function () {
    // 사이드바 라벨 관련 요소
        // const addLabelBtn = $('#addLabelBtn');
        // const labelPopup = $('#labelPopup');
        // const saveLabelBtn = $('#saveLabelBtn');
        // const labelSection = $('#labelSection');
        const addLabelBtn = document.getElementById('addLabelBtn');
        const labelPopup = document.getElementById('labelPopup');
        const saveLabelBtn = document.getElementById('saveLabelBtn');
        const labelSection = document.getElementById('labelSection');
        
        // 색상 옵션
        const colorOptions = [
            "#D50000", "#C51162", "#AA00FF", "#6200EA", "#304FFE",
            "#2962FF", "#0091EA", "#00B8D4", "#00BFA5", "#00C853",
            "#64DD17", "#AEEA00", "#FFD600", "#FFAB00", "#FF6D00",
            "#DD2C00", "#8D6E63", "#9E9E9E", "#607D8B", "#000000"
        ];
        
        // 직원 정보
        let emplNo = "${myEmpInfo.emplNo}";
        let deptCode = "${myEmpInfo.deptCode}";
        
        // 전역적으로 접근 가능한 필터 객체
        window.fltrLbl = {
            'schdulTyList': $('.event-filter:checked').map(function(){return $(this).val()}).get(),
            'lblNoList': []
        };
        console.log(fltrLbl);
        
        const colorPicker = document.getElementById('colorPicker');
        let selectedColor = colorOptions[0]; // 기본 색상
        
        // 색상 셀 생성
        colorOptions.forEach((color, index) => {
            const cell = document.createElement('div');
            cell.className = 'color-cell';
            cell.style.backgroundColor = color;
            
            // 기본 선택 상태
            if (index === 0) {
                cell.classList.add('selected');
            }
            
            cell.addEventListener('click', () => {
                // 선택 해제
                document.querySelectorAll('.color-cell').forEach(c => c.classList.remove('selected'));
                // 선택 적용
                cell.classList.add('selected');
                selectedColor = color;
            });
            
            colorPicker.appendChild(cell);
        });
        
        // 라벨 추가 버튼 클릭 이벤트
        addLabelBtn.addEventListener('click', function () {
            labelPopup.style.display = (labelPopup.style.display === 'block') ? 'none' : 'block';
        });
        $(document).on('click','.lblIcon',function(e){
            // e.stopPropagation(); // 이벤트 버블링 방지 (팝업이 바로 닫히는 문제 해결)
            const $popup = $('#labelPopup');
            console.log('lblIcon 테스트',$popup);
            console.log('lblIcon 테스트',$(this));
            const offset = $(this).offset(); // 아이콘 위치 가져오기
            // 팝업 위치를 아이콘 기준으로 설정
            $popup.css({
                top: offset.top + 25 + 'px',
                left: offset.left + 'px',
                display: 'block'
            });
            // 선택된 라벨 정보 저장 (필요시)
            const labelValue = $(this).siblings('input.label-filter');
            console.log('lblIcon 테스트 씨블링',labelValue);
            $('#newLabelName').val($(this).parent().text().trim()); // 이름 자동 입력
        })
        
        // 바깥 클릭 시 팝업 닫기
        document.addEventListener('click', function (event) {
            if (!labelPopup.contains(event.target) && event.target !== addLabelBtn) {
                labelPopup.style.display = 'none';
            }
        });
        
        // 저장 버튼 클릭 시 라벨 추가
        saveLabelBtn.addEventListener('click', function () {
            const labelName = document.getElementById('newLabelName').value.trim();
            
            if (!labelName) {
                alert('라벨 이름을 입력해주세요');
                return;
            }
            
            let labelData = {
                'lblNm': labelName,
                'lblColor': selectedColor,
                'emplNo': emplNo,
                'deptCode': deptCode
            };
            
            // 라벨 추가 AJAX 요청
            $.ajax({
                url: "/myCalendar/labelAdd",
                type: "post",
                data: JSON.stringify(labelData),
                contentType: "application/json",
                success: function(response) {
                    console.log("라벨 추가 성공:", response);
                    
                    // 응답으로 받은 데이터로 라벨 사이드바와 캘린더 이벤트 업데이트
                    if (response) {
                        labelSideBar(response);
                        // modalLblSel(response.labelList);
                    }
                    
                    // if (response.scheduleList) {
                    //     let clndr = chngData(response);
                    //     window.globalCalendar.setOption('events', clndr);
                    // }
                    
                    // 입력 필드 초기화 및 팝업 닫기
                    document.getElementById('newLabelName').value = '';
                    document.getElementById('labelPopup').style.display = 'none';
                },
                error: function(err) {
                    console.error("라벨 추가 실패:", err);
                    alert("라벨 추가 중 오류가 발생했습니다.");
                }
            });
        });
        $(document).on('change', '.event-filter', function() {
            // console.log('changed 확인');
            let filtered = [];
            $('.event-filter:checked').each(function() {
                filtered.push($(this).val()); // 체크된 요소의 값만 가져옴
            });
            console.log('결과 : ',filtered);
            fltrLbl.schdulTyList = filtered;
            console.log(fltrLbl);
            fltrLblAjx();
        }) 
            $('#filterAll').on('click',function(){
                // console.log('filter changed 확인');
                let filtered = [];
                $('.event-filter').each(function() {
                    this.checked = true;
                    filtered.push($(this).val()); // 체크된 요소의 값만 가져옴
                });
                console.log('필터 결과 : ',filtered);
                fltrLbl.schdulTyList = filtered;
                console.log(fltrLbl);
                fltrLblAjx();
            })
        // 라벨 필터링 이벤트 처리 (문서 전체에 위임)
        $(document).on('change', '.label-filter', function() {
            let labeled = [];
            $('.label-filter:checked').each(function() {
                labeled.push($(this).val());
            });
            window.fltrLbl.lblNoList = labeled;
            
            // 필터링 AJAX 호출
            fltrLblAjx();
        });
        
        // 전체 보기 버튼 이벤트
        $('#labelAll').on('click', function() {
            $('.label-filter').each(function() {
                this.checked = true;
            });
            
            let labeled = $('.label-filter').map(function() {
                return $(this).val();
            }).get();
            
            window.fltrLbl.lblNoList = labeled;
            fltrLblAjx();
        });
        
        // 필터링 AJAX 함수 - 전역 스코프로 이동
        window.fltrLblAjx = function() {
            let reqData = {
                schdulTyList: window.fltrLbl.schdulTyList,
                lblNoList: window.fltrLbl.lblNoList,
                emplNo: emplNo,
                deptCode: deptCode
            };
            console.log('요청 전 확인 : ',reqData);
            $.ajax({
                url: '/myCalendar/labeling',
                type: 'post',
                data: JSON.stringify(reqData),
                contentType: 'application/json',
                success: function(response) {
                    let clndr = chngData(response);
                    console.log('필터링된 일정',response);
                    window.globalCalendar.setOption('events', clndr);
                },
                error: function(err) {
                    console.error("필터링 실패:", err);
                }
            });
        };
        
        // 기존 코드와 통합을 위한 함수들
        window.createIcon = function(type, color) {
            let style = 'display: inline-block; width: 12px; height: 12px; margin-right: 8px;';
            
            if (type === 'circle') {
                style += 'border-radius: 50%;';
            } else {
                style += 'border-radius: 0;';
            }
            
            style += 'background-color: ' + color + ';';
            
            return '<span class="lblIcon" style="' + style + '"></span>';
        };
        
        window.labelSideBar = function(labelList) {
            let labelSection = $('#labelSection');
            console.log('labelSideBar : ',labelList);
            // 기존 체크박스의 상태를 저장
            let checkedLabels = {};
            $('.label-filter').each(function() {
                checkedLabels[$(this).val()] = $(this).prop('checked');
            });
            
            // fltrLbl.lblNoList에서 현재 선택된 라벨 정보도 사용
            if (window.fltrLbl && window.fltrLbl.lblNoList && window.fltrLbl.lblNoList.length > 0) {
                window.fltrLbl.lblNoList.forEach(lblNo => {
                    checkedLabels[lblNo] = true;
                });
            }
            
            // 기본 라벨 유지를 위한 HTML 코드 저장
            let defaultLabelHtml = '<label>[기본] 나의 일정<input type="checkbox" class="label-filter" id="def" value="0" checked></label><br>';
            
            labelSection.empty();
            let checkboxHtml = '';
            
            labelList.forEach(label => {
                // 기본 라벨(0)은 건너뛰기 (이미 상단에 고정)
                if (label.lblNo == 0) return;
                
                let icon = window.createIcon('circle', label.lblColor);
                // 이전에 저장된 상태가 있으면 그 상태를 사용, 없으면 기본적으로 체크
                let isChecked = Object.keys(checkedLabels).length > 0 ? 
                            (checkedLabels[label.lblNo] === true) : 
                            false; // 초기 상태는 모두 체크
                
                checkboxHtml += icon + '<label>' + label.lblNm + 
                            '<input type="checkbox" class="label-filter" value="' + 
                            label.lblNo + '"' + (isChecked ? ' checked' : '') + '></label><br>';
            });
            
            labelSection.append(checkboxHtml);
        };
        
        // 검색 기능 추가
        $('#searchSj').on('keyup', function() {
            let searchText = $(this).val().toLowerCase();
            
            // 검색 AJAX 요청
            if (searchText.length >= 2) { // 최소 2글자 이상일 때 검색
                $.ajax({
                    url: '/myCalendar/search',
                    type: 'post',
                    data: JSON.stringify({
                        searchText: searchText,
                        emplNo: emplNo,
                        deptCode: deptCode
                    }),
                    contentType: 'application/json',
                    success: function(response) {
                        let clndr = chngData(response);
                        window.globalCalendar.setOption('events', clndr);
                    }
                });
            } else if (searchText.length === 0) {
                // 검색어가 없으면 전체 목록 표시
                // refresh();
            }
        });
    });
</script>
    