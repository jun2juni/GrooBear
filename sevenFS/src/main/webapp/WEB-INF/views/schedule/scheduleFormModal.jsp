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
	margin-bottom: 4px;
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

.date-time-group {
	display: flex;
	gap: 6px;
	align-items: flex-end;
	margin-bottom: 10px; /* 각 그룹 간 간격 */
}

.date-time-group .input-style-1 {
	flex: 1;
	margin-bottom: 0;
}

.date-time-group .checkbox-wrapper {
	display: flex;
	align-items: center;
	gap: 8px;
	margin-left: 10px;
	margin-bottom: 10px;
}
.date-time-container {
    display: flex;
    gap: 20px;
}

.date-time-container .date-time-group {
    flex: 1;
    width: 50%;
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
textarea {
    width: 100%;
    height: 6.25em;
    border: none;
    resize: none;
  }
</style>
	<!-- 모달 배경 오버레이 -->
	<!-- 일정 등록 모달 -->
<div class="modal fade" id="myModal" tabindex="-1">
	<div class="modal-dialog modal-dialog-centered modal-lg">
	  <div class="modal-content">
		<div class="modal-header bg-primary">
		  <h5 class="modal-title text-white">일정 등록</h5>
		  <button type="button" class="btn-close text-white" onclick="fMClose()" aria-label="Close"></button>
		</div>
		<div class="modal-body">
		  <form id="calAddFrm" name="calFrm" action="">
			<input type="hidden" name="addUpt" id="addUpt" />
			<input type="hidden" name="schdulNo" id="schdulNo" />
  
			<div class="row g-4">
			  <!-- 제목 -->
			  <div class="col-12">
				<label class="form-label fw-semibold text-dark">제목</label>
				<input type="text" id="schTitle" name="schdulSj" class="form-control" placeholder="일정 제목을 입력하세요" />
			  </div>
  
			  <!-- 내용 -->
			  <div class="col-12">
				<label class="form-label fw-semibold text-dark">내용</label>
				<!-- <input type="text" id="schContent" name="content" class="form-control" placeholder="일정 내용을 입력하세요" /> -->
				<textarea type="text" name="content" id="schContent" class="form-control" placeholder="일정 내용을 입력하세요"></textarea>
			  </div>
			  
				<div class="timeInput-toggle date" style="display: block;">
				  <!-- 시작/종료 일시 -->
				  <div class="col-md-6">
					  <label class="form-label fw-semibold text-dark">시작일</label>
					  <div class="d-flex gap-2">
						  <input type="date" id="schStart" name="start" class="form-control dateInp" />
						  <!-- <input type="time" id="schStartTime" name="startTime" class="form-control" /> -->
						</div>
					</div>
					<div class="col-md-6">
						<label class="form-label fw-semibold text-dark">종료일</label>
						<div class="d-flex gap-2">
							<input type="date" id="schEnd" name="end" class="form-control dateInp" />
							<!-- <input type="time" id="schEndTime" name="endTime" class="form-control" /> -->
						</div>
					</div>
				</div>

				<div class="timeInput-toggle time" style="display: none;">
					<!-- 시작/종료 일시 -->
					<div class="col-md-6">
						<label class="form-label fw-semibold text-dark">날짜 선택</label>
						<div class="d-flex gap-2">
							<input type="date" id="date" name="date" class="form-control dateInp" />
						</div>
					</div>
					<div class="col-md-6">
						<label class="form-label fw-semibold text-dark">시간 선택</label>
						<div class="d-flex gap-2">
							  <input type="time" id="schStartTime" name="startTime" class="form-control" />
							  <input type="time" id="schEndTime" name="endTime" class="form-control" />
						  </div>
					  </div>
				</div>
  
			  <!-- 하루종일 체크 -->
			  <div class="col-12 d-flex align-items-center">
				<input type="checkbox" id="allDay" name="allDay" class="form-check-input me-2" />
				<label for="allDay" class="form-check-label text-dark fw-semibold">하루종일</label>
			  </div>
  
			  <!-- 공개유형, 라벨 -->
			  <div class="col-md-6">
				<label class="form-label fw-semibold text-dark">공개유형</label>
				<select id="schdulTy" name="schdulTy" class="form-select">
				  <option value="0">개인</option>
				  <option value="1">부서</option>
				</select>
			  </div>
			  <div class="col-md-6">
				<label class="form-label fw-semibold text-dark">라벨 선택</label>
				<select id="scheduleLabel" name="lblNo" class="form-select"></select>
			  </div>
			</div>
  
			<!-- 버튼 -->
			<div class="d-flex justify-content-end gap-2 mt-4" id="btnGroup">
			  <button id="modalSubmit" type="button" class="btn btn-primary" onclick="fCalAdd(event)">저장</button>
			  <button id="deleteBtn" type="button" class="btn btn-danger" style="display: none;" onclick="fCalDel(event)">삭제</button>
			  <button type="button" class="btn btn-outline-secondary" onclick="fMClose()">취소</button>
			</div>
		  </form>
		</div>
	  </div>
	</div>
  </div>
  