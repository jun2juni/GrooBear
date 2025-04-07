<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
/* 모달 기본 스타일 */
.modal-dialog {
	max-width: 600px;
	margin: 1.75rem auto;
}

.modal-content {
	border: none;
	border-radius: 12px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
	overflow: hidden;
}

.modal-header {
	background-color: #4a6cf7;
	padding: 20px 30px;
	border-bottom: none;
}

.modal-title {
	color: #fff;
	font-size: 18px;
	font-weight: 600;
	margin: 0;
}

.modal-body {
	padding: 30px;
	background-color: #fff;
}

/* 폼 그리드 레이아웃 */
.form-grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 20px;
}

.full-width {
	grid-column: span 2;
}

/* 입력 필드 스타일 */
.input-style-1 {
	margin-bottom: 1px;
}

.input-style-1 label {
	display: block;
	font-weight: 500;
	color: #5d657b;
	margin-bottom: 10px;
	font-size: 14px;
}

.input-style-1 input[type="date"], .input-style-1 input[type="time"], .input-style-1 input[type="text"] {
	width: 100%;
	height: 50px;
	padding: 0 15px;
	border: 1px solid #e2e8f0;
	border-radius: 6px;
	background: #f9fafc;
	color: #5d657b;
	font-size: 14px;
	transition: all 0.3s ease;
}

.input-style-1 input[type="date"]:focus, .input-style-1 input[type="text"]:focus
	{
	border-color: #4a6cf7;
	background: #fff;
	box-shadow: 0 0 0 3px rgba(74, 108, 247, 0.1);
	outline: none;
}

/* 체크박스 스타일 */
.checkbox-wrapper {
	display: flex;
	align-items: center;
	margin-top: 5px;
}

.checkbox-wrapper label {
	width: 100px;
	margin-bottom: 0;
	margin-right: 15px;
}

.checkbox-style {
	width: 20px;
	height: 20px;
	cursor: pointer;
	accent-color: #4a6cf7;
}

/* 버튼 그룹 스타일 */
.button-group {
	display: flex;
	justify-content: flex-end;
	gap: 15px;
	margin-top: 30px;
}

.main-btn {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	padding: 0 25px;
	height: 50px;
	border: none;
	border-radius: 6px;
	font-weight: 500;
	font-size: 15px;
	cursor: pointer;
	transition: all 0.3s;
}

.primary-btn {
	background: #4a6cf7;
	color: #fff;
}

.primary-btn:hover {
	background: #3b5de7;
	transform: translateY(-2px);
	box-shadow: 0 4px 12px rgba(74, 108, 247, 0.2);
}

.danger-btn {
	background: #f9fafc;
	color: #5d657b;
	border: 1px solid #e2e8f0;
}

.danger-btn:hover {
	background: #f1f5f9;
	color: #374151;
	transform: translateY(-2px);
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

/* 반응형 조정 */
@media ( max-width : 768px) {
	.form-grid {
		grid-template-columns: 1fr;
	}
	.full-width {
		grid-column: span 1;
	}
	.modal-body {
		padding: 20px;
	}
	.button-group {
		flex-direction: column;
	}
	.main-btn {
		width: 100%;
		margin-bottom: 10px;
	}
}

/* 플레이스홀더 스타일 */
::placeholder {
	color: #cbd5e0;
	opacity: 1;
}
</style>
	<!-- 모달 배경 오버레이 -->
	<div class="modal fade" id="myModal" tabindex="-1"
		style="display: none; padding-right: 17px;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">일정 등록</h5>
					<button type="button" class="btn-close" onclick="fMClose()"
						style="background: none; border: none; color: white; font-size: 20px; padding: 0; cursor: pointer;">
						<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
							viewBox="0 0 24 24" fill="none" stroke="currentColor"
							stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <line x1="18" y1="6" x2="6" y2="18"></line>
              <line x1="6" y1="6" x2="18" y2="18"></line>
            </svg>
					</button>
				</div>
				<div class="modal-body">
					<form id="calAddFrm" name="calFrm" action="">
						<div class="form-grid">
							<input type="hidden" name="addUpt" id="addUpt" value="">
							<input type="hidden" name="schdulNo" id="schdulNo" value="">
							<div class="input-style-1">
								<label>시작일</label>
                <input class="dateInput" type="date" id="schStart" name="start" value="">
							</div>
							<div class="input-style-1">
                <label>시간</label>
                <input class="dateInput" type="time" id="schStartTime" name="startTime" value="">
							</div>

							<div class="input-style-1">
								<label>종료일</label>
                <input class="dateInput" type="date" id="schEnd" name="end" value="">
							</div>
              <div class="input-style-1">
                <label>시간</label>
                <input class="dateInput" type="time" id="schEndTime" name="endTime" value="" >
							</div>
              <!-- <div class="input-style-1">
                <label>시간</label>
                <input type="datetime-local" id="schStartTime" name="startTime" value="">
							</div> -->

							<div class="input-style-1 full-width">
								<label>제목</label> 
                <input type="text" id="schTitle" name="schdulSj" value="" placeholder="일정 제목을 입력하세요">
							</div>

							<div class="input-style-1 full-width">
								<label>내용</label> 
                <input type="text" id="schContent" name="content" value="" placeholder="일정 내용을 입력하세요">
							</div>

							<!-- <div class="input-style-1 full-width">
								<label>카테고리</label>
                <input type="text" id="schCategory" name="category" value="" placeholder="카테고리를 입력하세요">
							</div> -->
              <div class="select-style-1">
                <label>공개유형</label>
                <div class="select-position">
                  <select id="schdulTy" name="schdulTy">
                    <option value="0">개인</option>
                    <option value="1">부서</option>
                    <!-- <option value="2">전체</option> 이건 추후에 관리자만 보이게 할것! -->
                  </select>
                </div>
              </div>
							<div class="input-style-1">
								<div class="checkbox-wrapper">
									<label>하루종일</label>
                  <input type="checkbox" id="allDay" name="allDay" class="checkbox-style">
								</div>
							</div>
							<div class="select-style-1 full-width">
								<label>라벨 선택</label>
								<div class="select-position">
								  <select id="scheduleLabel" name="lblNo">
								  </select>
								</div>
							  </div>
						</div>
						<div class="button-group" style="margin-top: 1px;">
							<button id="modalSubmit" type="button" class="main-btn primary-btn btn-hover"
							onclick="fCalAdd(event)"></button>
							<button type="button" class="main-btn danger-btn btn-hover"
								onclick="fMClose()">취소</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>