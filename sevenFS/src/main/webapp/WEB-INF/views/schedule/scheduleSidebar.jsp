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
            <input type="hidden" name="searchSj" class="form-control" id="searchSj" placeholder="검색" maxlength="100">
        </div>
        
        <!-- 일정 필터 -->
        <div class="filter-section">
            <h3>일정 필터</h3>
            <!-- <button type="button" id="filterAll" class="btn btn-primary">전체 보기</button> -->
            <button id="addLabelBtn" type="button" class="btn btn-primary">추가</button>
            <!-- 라벨 추가 팝업 -->
            <div id="labelPopup" class="label-popup input-style-1" style="display: none;">
                <!-- 팝업 내용 -->
                <div class="form-group">
                    <label for="newLabelName">라벨 이름</label>
                    <input type="text" id="newLabelName" class="form-control" placeholder="라벨 이름 입력">
                </div>
                <div class="form-group">
                    <label>색상 선택</label>
                    <div id="colorPicker" class="color-picker">
                        <!-- 색상 셀이 자바스크립트로 여기에 추가됨 -->
                    </div>
                </div>
                <div class="popbutton-group">
                    <button id="saveLabelBtn" class="btn btn-primary">저장</button>
                    <button id="delLabelBtn" class="btn btn-danger" onclick="delLabel(event)" style="display:none;">삭제</button>
                </div>
            </div>
            <div id="filterSection">
                <div class="checkbox-container">
                    <label>전체 선택
                        <input type="checkbox" class="event-filter filterAll" value="" checked>
                    </label>
                </div>
                <div class="checkbox-container">
                    <label>전체 일정
                        <input type="checkbox" class="event-filter" value="2" checked>
                    </label>
                </div>
                <div class="checkbox-container">
                    <label>부서 일정
                        <input type="checkbox" class="event-filter" value="1" checked>
                    </label>
                </div>
                <div class="checkbox-container" id="personalLabel">
                    <label>개인 일정
                        <!-- <i class='fas fa-chevron-left event-filter' id="leftArrIcon" style="cursor: pointer; display: none;"></i>
                        <i class='fas fa-chevron-down event-filter' id="downArrIcon" style="cursor: pointer;"></i> -->
                        <i class='fas fa-chevron-left' id="leftArrIcon" style="cursor: pointer; display: none;"></i>
                        <i class='fas fa-chevron-down' id="downArrIcon" style="cursor: pointer;"></i>
                        <!-- <input type="checkbox" id="labelAll" class="event-filter" value="0" checked> -->
                    </label>
                </div>
                <div class="label-container" id="labelAccordion">
                    <div id="labelSection" style="display: inline;">
                        <!-- 여기에 라벨이 동적으로 추가됩니다 -->
                    </div>
                </div>
            </div>
        </div>
        <!-- 라벨 섹션도 JavaScript에서 생성될 때 동일한 구조로 만들어야 합니다 -->
    </div>

    <!-- 캘린더 영역 -->
    <div id="calendarContent">
        <div id='myCalendar'></div>
    </div>
</div>

<!-- 스타일 -->
<style>
    /* 아코디언 시작 */
    .labelSection{
        overflow: hidden;
        padding-left: 10px;
        display: none;
    }
    /* 아코디언 끝 */

    #saveLabelBtn, #delLabelBtn, #addLabelBtn, #filterAll{
        padding: 4px 8px; /* 내부 여백 줄이기 */
        font-size: 12px; /* 글자 크기 줄이기 */
        width: auto; /* 자동 크기 조정 */
        height: 30px; /* 높이 설정 */
        margin: 3px;
    }

    .label-popup {
        display: none; /*처음엔 숨김*/
        position: absolute;
        background: white;
        border: 1px solid #ccc;
        padding: 10px;
        /* box-shadow: 0 2px 8px rgba(0,0,0,0.15); */
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
        /* box-shadow: 2px 0 5px rgba(0,0,0,0.1); */
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
    /**/
    .label-section {
        margin-top: 20px;
        margin-bottom: 20px;
    }

    .label-section label {
        display: block;
        margin-bottom: 5px;
    }
    /**/

    .add-event {
        margin-top: 20px;
    }

    /* 캘린더 영역 */
    #calendarContent {
        flex: 1; /* 남은 공간을 모두 차지 */
        padding: 20px;
        overflow-y: hidden; /*내용이 많을 경우 스크롤 표시*/
    }
    .lblIcon:hover {
        transform: scale(1.3); /* 20% 확대 */
        transition: transform 0.3s ease-in-out; /* 부드러운 애니메이션 효과 */
    }

    /* 버튼 크기 통일 및 정렬 */
    /* .btn {
        padding: 4px 8px;
        font-size: 12px;
        height: 30px;
        min-width: 80px;
        margin-bottom: 5px;
        border-radius: 4px;
        transition: all 0.2s ease;
    } */

    .btn:hover {
        transform: translateY(-1px);
        /* box-shadow: 0 2px 5px rgba(0,0,0,0.1); */
    }

    /* 체크박스 컨테이너 스타일 */
    .checkbox-container {
        display: flex;
        align-items: center;
        margin-bottom: 8px;
        padding: 4px;
        border-radius: 4px;
        transition: background-color 0.2s ease;
    }

    .checkbox-container:hover {
        background-color: #f0f0f0;
    }

    /* 체크박스 라벨 스타일 */
    .checkbox-container label {
        display: flex;
        align-items: center;
        width: 100%;
        cursor: pointer;
        font-size: 14px;
    }

    /* 체크박스 스타일 */
    .checkbox-container input[type="checkbox"] {
        margin-left: auto;
        cursor: pointer;
        width: 16px;
        height: 16px;
    }
    #leftArrIcon, #downArrIcon{
        margin-left: auto;
        cursor: pointer;
        width: 16px;
        height: 16px;
    }

    /* 필터 섹션 스타일 */
    .filter-section, .label-section {
        padding: 10px;
        margin-bottom: 15px;
        background-color: #f8f9fa;
        border-radius: 5px;
        border: 1px solid #e9ecef;
    }

    /* 섹션 제목 스타일 */
    .filter-section h3, .label-section h3 {
        margin-bottom: 10px;
        font-size: 16px;
        color: #495057;
        border-bottom: 1px solid #dee2e6;
        padding-bottom: 5px;
    }




    /**/
    .labelCheck {
        display: flex;
        align-items: center;
        margin-bottom: 8px;
        padding: 4px;
        border-radius: 4px;
        transition: background-color 0.2s ease;
    }

    .labelCheck:hover {
        background-color: #f0f0f0;
    }

    .labelCheck label {
        display: flex;
        align-items: center;
        width: 100%;
        cursor: pointer;
        font-size: 14px;
    }

    .labelCheck input[type="checkbox"] {
        margin-left: auto;
        cursor: pointer;
        width: 16px;
        height: 16px;
    }
    /**/



    #calendarSidebar {
        position: relative;
        background-color: #FFFFFF;
    }

</style>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        /* 아코디언 시작 */
        // $('.personal-schedule-header').on('click', function() {
        //     var $icon = $(this).find('.accordion-icon');
        //     var $content = $('#personalLabelsAccordion');
            
        //     if ($content.is(':visible')) {
        //         $content.slideUp(300);
        //         $icon.css('transform', 'rotate(0deg)');
        //     } else {
        //         $content.slideDown(300);
        //         $icon.css('transform', 'rotate(180deg)');
        //     }
        // });
        /* 아코디언 끝 */

        $('#personalLabel').on('click',function(){
            $('#labelAccordion').toggle();
            $('#leftArrIcon').toggle();
            $('#downArrIcon').toggle();
        })

        $('#openModalBtn').on('click',function(){
            $("#schStart").removeAttr('max')
            $("#schEnd").removeAttr('min')
            $("#schStartTime").removeAttr('max')
            $("#schEndTime").removeAttr('min')
            $("#schTitle").val('');
            $("#schContent").val('');
            $('#addUpt').val('add');
            $('.modal-title').text("일정 등록");
			$("#modalSubmit").text("등록");
//             console.log('$("#deleteBtn")',$("#deleteBtn"))
            let today = new Date().toISOString().split('T')[0];
            $('#schStart').val(today);
            $('#schEnd').attr('min',today);
            insModal.show();
			$("#deleteBtn").css('display','none');
        })
        
    	// 사이드바 라벨 관련 요소
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

        // 아이콘 클릭 시 팝업창 표시 로직 (lblIcon 클릭 및 addLabelBtn 클릭 모두 해당)
        $(document).on('click', '.lblIcon, #addLabelBtn', function(e) {
            e.stopPropagation(); // 이벤트 버블링 방지
            e.preventDefault(); // 기본 동작 방지
            
            const $popup = $('#labelPopup');
            const $icon = $(this);
            
            // 기존 팝업을 먼저 숨김
            $popup.hide();
            
            // 클릭한 요소가 addLabelBtn인지 lblIcon인지 확인하여 처리
            if ($(this).attr('id') === 'addLabelBtn') {
                $('#lblNoInp').remove();
                $('#delLabelBtn').css('display', 'none');
                $('#newLabelName').val('');
            } else {
                // lblIcon인 경우 - 편집 모드
                let selLblNo = $(this).next('input').val();
                console.log('selLblNo : ',selLblNo)
                $('#delLabelBtn').css('display', 'inline-block');
                $('#lblNoInp').remove();
                let lblNoInp = '<input hidden name="lblNo" id="lblNoInp" value="' + selLblNo + '" />';
                $('#labelPopup').append(lblNoInp);
                
                // 라벨 정보 가져오기
                let labelText = '';
                if ($(this).next('label').length) {
                    labelText = $(this).next('label').clone().children().remove().end().text().trim();
                } else if ($(this).parent().is('label')) {
                    labelText = $(this).parent().clone().children().remove().end().text().trim();
                }
                $('#newLabelName').val(labelText);
                
                // 현재 아이콘의 배경색 가져오기
                const currentBgColor = $(this).css('background-color');
                updateColorPicker(currentBgColor);
            }
            
            // 아이콘의 sidebar 내부에서의 위치 계산 (사이드바 스크롤 고려)
            const $sidebar = $('#calendarSidebar');
            const iconPositionTop = $icon.position().top; // 부모 요소 기준 상단 위치
            const iconPositionLeft = $icon.position().left; // 부모 요소 기준 좌측 위치
            const iconHeight = $icon.outerHeight();
            const popupHeight = $popup.outerHeight() || 150; // 팝업 높이 (없으면 예상값)
            
            // 팝업창이 사이드바 밖으로 나가지 않도록 제한
            const sidebarWidth = $sidebar.width();
            const popupWidth = 200; // 팝업 너비
            
            let leftPosition = iconPositionLeft;
            // 오른쪽 경계를 넘어가면 조정
            if (leftPosition + popupWidth > sidebarWidth) {
                leftPosition = sidebarWidth - popupWidth - 10; // 여백 10px
            }
            
            // 위쪽에 표시 (팝업이 아이콘 위에 나타나도록)
            let topPosition = iconPositionTop - popupHeight - 5; // 아이콘 위 5px 간격
            
            // 만약 위쪽 공간이 부족하면 아래쪽에 표시
            if (topPosition < 0) {
                topPosition = iconPositionTop + iconHeight + 5; // 아이콘 아래 5px 간격
            }
            
            // 팝업을 사이드바에 직접 추가하고 위치 설정
            $popup.appendTo($sidebar).css({
                'position': 'absolute',
                'top': topPosition + 'px',
                'left': leftPosition + 'px',
                'z-index': '9999',
                'display': 'block'
            });
            
            // 기존 문서 클릭 이벤트 핸들러를 일시적으로 제거
            $(document).off('click.labelPopup');
            
            // 문서 클릭 이벤트 다시 바인딩 (팝업 외부 클릭 시 닫기)
            setTimeout(() => {
                $(document).on('click.labelPopup', function(event) {
                    if (!$(event.target).closest('#labelPopup').length && 
                        !$(event.target).is('.lblIcon') && 
                        !$(event.target).is('#addLabelBtn') &&
                        !$(event.target).hasClass('color-cell')) {
                        $popup.hide();
                        $(document).off('click.labelPopup');
                    }
                });
            }, 100);
        });

        // 컬러 피커 업데이트 함수 
        function updateColorPicker(currentBgColor) {
            // RGB 색상을 Hex로 변환하는 함수
            const rgbToHex = (rgb) => {
                if (!rgb) return '#000000';
                
                // RGB 문자열에서 숫자만 추출
                const rgbArr = rgb.match(/\d+/g);
                if (!rgbArr || rgbArr.length !== 3) return '#000000';
                
                return '#' + rgbArr.map(x => {
                    const hex = parseInt(x).toString(16);
                    return hex.length === 1 ? '0' + hex : hex;
                }).join('');
            };
            
            const hexColor = rgbToHex(currentBgColor);
            
            // 컬러피커 업데이트
            $('.color-cell').removeClass('selected');
            
            // 가장 비슷한 색상 선택
            $('.color-cell').each(function() {
                const cellColor = $(this).css('background-color');
                const cellHex = rgbToHex(cellColor);
                
                if (cellHex.toLowerCase() === hexColor.toLowerCase()) {
                    $(this).addClass('selected');
                    selectedColor = cellHex;
                }
            });
            
            // 첫번째 셀을 기본 선택 (일치하는 색상이 없을 경우)
            if ($('.color-cell.selected').length === 0) {
                $('.color-cell').first().addClass('selected');
                selectedColor = colorOptions[0];
            }
        }
        // 저장 버튼 클릭 시 라벨 추가
        saveLabelBtn.addEventListener('click', function () {
            const labelName = document.getElementById('newLabelName').value.trim();
            if (!labelName) {
                swal('라벨 이름을 입력해주세요.')
                return;
            }
            let labelData = {
                'lblNm': labelName,
                'lblColor': selectedColor,
                'emplNo': emplNo,
                'deptCode': deptCode
            };

            let ajaxUrl = ''
            console.log("$('#lblNoInp')",$('#lblNoInp'));
            if($('#lblNoInp').val()){
                ajaxUrl = "/myCalendar/labelUpdate"
                labelData.lblNo = $('#lblNoInp').val();
            }else{
                ajaxUrl = "/myCalendar/labelAdd"
            }
            console.log('라벨 생성 / 업데이트 요청 전 확인 /ajaxUrl : ',ajaxUrl,' /labelData : ',labelData);
            // 라벨 추가 AJAX 요청
            $.ajax({
                url: ajaxUrl,
                type: "post",
                data: JSON.stringify(labelData),
                contentType: "application/json",
                success: function(response) {
                    console.log('분기처리 전 response : ',response);
                    if(response.labelList){
                        console.log('response.labelList====================',response.labelList);
                        labelSideBar(response.labelList);
                        let clndr = chngData(response);
                        window.globalCalendar.setOption('events', clndr);
                    }
                    else{
                        labelSideBar(response);
                        modalLblSel(response)
                    }
                    console.log("라벨 추가 성공:", response);
                    
                    // 입력 필드 초기화 및 팝업 닫기
                    document.getElementById('newLabelName').value = '';
                    document.getElementById('labelPopup').style.display = 'none';
                },
                error: function(err) {
                    console.error("라벨 추가 실패:", err);
                    swal('라벨 추가 중 오류가 발생했습니다.')
                }
            });
        });
         
        $('.filterAll').on('change',function(){
            // console.log('filter changed 확인');
            let filtered = [];
            let labeled = [];
            let chk = $(this).is(':checked')
            // console.log('chk',chk);
            if(chk){
                $('.event-filter').not('.filterAll').each(function() {
                    this.checked = true;
                    filtered.push($(this).val()); // 체크된 요소의 값만 가져옴
                 });
                $('.label-filter').each(function() {
                    this.checked = true;
                    labeled.push($(this).val()); // 체크된 요소의 값만 가져옴
                });
            }else{
                $('.event-filter').not('.filterAll').each(function() {
                    this.checked = false;
                 });
                $('.label-filter').each(function() {
                    this.checked = false;
                });
            }  
            // $('.event-filter').not('.filterAll').first().trigger('change');
            // $('.label-filter').first().trigger('change');
            fltrLbl.schdulTyList = filtered;
            fltrLbl.lblNoList = labeled;
            console.log('fltrLbl : ',fltrLbl);
            fltrLblAjx();
        })

        // 일정 필터링
        $(document).on('change', '.event-filter', function() {
            let filtered = [];
            let allChecked = $('.event-filter').not('.filterAll').length + $('.label-filter').length === 
                            $('.event-filter:checked').not('.filterAll').length + $('.label-filter:checked').length;
            console.log(allChecked);
            if(!$(this).is(':checked')){
                $('.filterAll').prop('checked',false);
            }
            if(allChecked){
                $('.filterAll').prop('checked',true);
            }
            $('.event-filter:checked').each(function() {
                filtered.push($(this).val()); // 체크된 요소의 값만 가져옴
            });
            console.log('결과 : ',filtered);
            fltrLbl.schdulTyList = filtered;
            console.log(fltrLbl);
            fltrLblAjx();
        })
        // 라벨 필터링 이벤트 처리
        $(document).on('change', '.label-filter', function() {
            let labeled = [];
            let allChecked = $('.event-filter').not('.filterAll').length + $('.label-filter').length === 
                            $('.event-filter:checked').not('.filterAll').length + $('.label-filter:checked').length;
            console.log(allChecked);
            if(!$(this).is(':checked')){
                $('.filterAll').prop('checked',false);
            }
            if(allChecked){
                $('.filterAll').prop('checked',true);
            }
            $('.label-filter:checked').each(function() {
                labeled.push($(this).val());
            });
            window.fltrLbl.lblNoList = labeled;
            
            // 필터링 AJAX 호출
            fltrLblAjx();
        });
        
        // 전체 보기 버튼 이벤트
        // $('#labelAll').on('click', function() {
        //     $('.label-filter').each(function() {
        //         this.checked = true;
        //     });
            
        //     let labeled = $('.label-filter').map(function() {
        //         return $(this).val();
        //     }).get();
            
        //     window.fltrLbl.lblNoList = labeled;
        //     fltrLblAjx();
        // });
        
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
        // 라벨 삭제
        window.delLabel = function(e){
            // console.log('delLabel',e.target);
            // console.log('삭제 데이터 확인 : ','delLabel',$('#delLabelBtn').data().selLblNo);
            let lblNo = $('#lblNoInp').val();
            $.ajax({
                url:'/myCalendar/delLabel',
                method:'post',
                contentType:'application/json',
                data: JSON.stringify({
                        emplNo:emplNo,
                        lblNo:lblNo,
                        deptCode: deptCode
                }),
                success:function(resp){
                    let clndr = chngData(resp);
                    console.log('필터링된 일정',resp);
                    window.globalCalendar.setOption('events', clndr);

                    labelSideBar(resp.labelList);
                    
                    // 입력 필드 초기화 및 팝업 닫기
                    document.getElementById('newLabelName').value = '';
                    document.getElementById('labelPopup').style.display = 'none';
                    
                },
                error: function(err) {
                    console.error("필터링 실패:", err);
                }
            });
        }
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
            
            labelSection.empty();
            let checkboxHtml = `<div class="labelCheck" >
                                    <label >[기본] 나의 일정
                                        <input type="checkbox" class="label-filter" id="def" value="0" checked>
                                    </label>
                                </div>`;
            
            labelList.forEach(label => {
                // 기본 라벨(0)은 건너뛰기 (이미 상단에 고정)
                if (label.lblNo == 0) return;
                
                let icon = window.createIcon('circle', label.lblColor);
                // 이전에 저장된 상태가 있으면 그 상태를 사용, 없으면 기본적으로 체크
                let isChecked = Object.keys(checkedLabels).length > 0 ? 
                            (checkedLabels[label.lblNo] === true) : 
                            false; // 초기 상태는 모두 체크
                
                checkboxHtml += `
                                <div class="labelCheck" >
                                    <label>\${icon}\${label.lblNm}
                                        <input type="checkbox" class="label-filter" value="\${label.lblNo}"\${isChecked ? ' checked' : ''}>
                                    </label>
                                </div>`;
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
    