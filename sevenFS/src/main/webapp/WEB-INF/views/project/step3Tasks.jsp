<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
.btn-danger {
  background-color: #dc3545;
} 
.btn-primary {
  background-color: #4f6df5;
} 
.btn-secondary {
  background-color: #6c757d;
} 
</style>

<div class="row g-4">
  <!-- 왼쪽 8 영역 -->
  <div class="col-md-8">
    <div class="card border rounded-3 shadow-sm mb-4">
      <div class="card-body p-4">
        <h5 class="card-title fw-bold mb-4">
          <i class="fas fa-tasks text-primary me-2"></i>업무 등록
        </h5>
        
        <div class="row g-3">
          <!-- 업무명 및 상위업무명 -->
          <div class="col-md-8">
            <label class="form-label fw-semibold">업무명 <span class="text-danger">*</span></label>
            <input type="text" id="taskNm" class="form-control" placeholder="업무 제목을 입력하세요" />
          </div>

          <div class="col-md-4">
			  <label class="form-label fw-semibold">상위 업무명</label>
			  <input type="text" id="parentTaskNm" class="form-control bg-light" readonly placeholder="상위 업무명" style="cursor: not-allowed;" />
			</div>

          <!-- 담당자 -->
          <div class="col-md-4">
            <label class="form-label fw-semibold">담당자 <span class="text-danger">*</span></label>
            <input type="text" id="chargerEmpNm" class="form-control" placeholder="담당자 선택" readonly />
            <input type="hidden" id="chargerEmpno" />
          </div>
          
          <!-- 담당자 선택 -->
          <div class="col-md-12 mt-2">
            <label class="form-label fw-semibold">담당자 선택</label>
            <div id="memberSelectBtns" class=" mt-2 mb-2"></div>
          </div>

          <!-- 날짜 및 중요도/등급 -->
          <div class="col-md-3">
            <label class="form-label fw-semibold">시작일</label>
            <input type="date" id="taskBeginDt" class="form-control" />
          </div>

          <div class="col-md-3">
            <label class="form-label fw-semibold">종료일</label>
            <input type="date" id="taskEndDt" class="form-control" />
          </div>

          <div class="col-md-3">
            <label class="form-label fw-semibold">중요도</label>
            <select id="taskPriort" class="form-select">
              <option value="">선택하세요</option>
              <option value="00">낮음</option>
              <option value="01" selected>보통</option>
              <option value="02">높음</option>
              <option value="03">긴급</option>
            </select>
          </div>

          <div class="col-md-3">
            <label class="form-label fw-semibold">업무 등급</label>
            <select id="taskGrad" class="form-select">
              <option value="">선택하세요</option>
              <option value="A">A</option>
              <option value="B">B</option>
              <option value="C" selected>C</option>
              <option value="D">D</option>
              <option value="E">E</option>
            </select>
          </div>

          <!-- 업무 내용 -->
          <div class="col-12">
            <label class="form-label fw-semibold">업무 내용</label>
            <textarea id="taskCn" rows="4" class="form-control" placeholder="업무에 대한 상세 내용을 입력하세요"></textarea>
          </div>

          <!-- 첨부파일 -->
          <div class="col-md-5">
            <label for="uploadTaskFiles" class="form-label fw-semibold">업무 첨부파일</label>
            <input type="file" id="uploadTaskFiles" name="uploadTaskFiles[]" class="form-control" multiple>
            <small class="text-muted mt-1 d-block">첨부 파일은 최대 5개까지 등록 가능합니다.</small>
          </div>
          
          <div class="col-12 mt-3">
			<ul id="fileNameList" class="list-group">
			  <li id="noFileMessage" class="list-group-item text-center text-muted py-3">
			    <i class="fas fa-file-slash me-2"></i>추가한 파일이 없습니다.
			  </li>
			  <!-- 여기에 파일 항목들이 추가됩니다 -->
			</ul>
          </div>
        </div>

        <div class="text-end mt-4">
          <button type="button" class="btn btn-outline-secondary me-2" onclick="resetTaskForm()">
            <i class="fas fa-undo-alt me-1"></i> 초기화
          </button>
          <button type="button" id="addTaskBtn" class="btn btn-primary">
            <i class="fas fa-plus me-1"></i> 업무 추가
          </button>
        </div>
      </div>
    </div>
  </div>

  <!-- 오른쪽 4 영역 -->
  <div class="col-md-4">
    <!-- 설명 카드 -->
    <div class="card border rounded-3 shadow-sm mb-4">
      <div class="card-body p-4">
        <h5 class="card-title fw-bold mb-4">
          <i class="fas fa-info-circle text-primary me-2"></i>업무 관리 안내
        </h5>
        <ul class="mb-0 ps-3">
          <li class="mb-2">업무명, 담당자, 기간 등 업무 정보를 입력하세요.</li>
          <li class="mb-2">중요도와 등급을 설정해 우선순위를 조절하세요.</li>
          <li class="mb-2">첨부파일은 최대 5개까지 가능합니다.</li>
          <li class="mb-2">하단 목록에서 하위업무 추가 및 삭제 가능합니다.</li>
        </ul>
      </div>
    </div>
    
    <!-- 등록된 업무 목록 -->
    <div class="card border rounded-3 shadow-sm mb-4">
      <div class="card-body p-4">
        <h5 class="card-title fw-bold mb-4">
          <i class="fas fa-list-ul text-primary me-2"></i>등록된 업무 목록
        </h5>
        <ul class="list-group" id="taskList">
          <li class="list-group-item text-center text-muted py-3">
            <i class="fas fa-clipboard-list me-2"></i>등록된 업무가 없습니다.
          </li>
        </ul>
      </div>
    </div>
  </div>
</div>