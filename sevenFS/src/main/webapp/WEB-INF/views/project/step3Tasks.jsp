<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="row">
  <!-- 왼쪽 8 영역 -->
  <div class="col-md-8">
    <div class="form-step h-100 d-flex flex-column">
      <!-- 업무 입력 카드 -->
      <div class="card mb-3 p-3 shadow-sm">
        <h6 class="mb-3 fw-bold"><i class="fas fa-tasks me-2 text-primary"></i>업무 등록</h6>
        <div class="row g-3">
          <div class="col-md-6">
            <label class="form-label">업무명 <span class="text-danger">*</span></label>
            <input type="text" id="taskNm" class="form-control bg-transparent" placeholder="업무 제목" />
          </div>

          <div class="col-md-6">
            <label class="form-label">상위 업무명</label>
            <input type="text" id="parentTaskNm" class="form-control bg-transparent" readonly />
          </div>

          <div class="col-md-6">
            <label class="form-label">담당자 <span class="text-danger">*</span></label>
            <input type="text" id="chargerEmpNm" class="form-control bg-transparent" placeholder="담당자 이름" readonly />
            <input type="hidden" id="chargerEmpno" />
          </div>
          
              <!-- 담당자 선택 -->
		    <div class="col-md-6">
		      <h6 class="mb-2 fw-bold"><i class="fas fa-users me-2 text-primary"></i>담당자 선택</h6>
		      <div id="memberSelectBtns" class="d-flex flex-wrap gap-1"></div>
		    </div>

          <div class="col-md-6">
            <label class="form-label">시작일</label>
            <input type="date" id="taskBeginDt" class="form-control bg-transparent" />
          </div>

          <div class="col-md-6">
            <label class="form-label">종료일</label>
            <input type="date" id="taskEndDt" class="form-control bg-transparent" />
          </div>

          <div class="col-md-6">
            <label class="form-label">중요도</label>
            <select id="taskPriort" class="form-select bg-transparent">
              <option value="">선택하세요</option>
              <option value="00">낮음</option>
              <option value="01">보통</option>
              <option value="02">높음</option>
              <option value="03">긴급</option>
            </select>
          </div>

          <div class="col-md-6">
            <label class="form-label">업무 등급</label>
            <select id="taskGrad" class="form-select bg-transparent">
              <option value="">선택하세요</option>
              <option value="A">A</option>
              <option value="B">B</option>
              <option value="C">C</option>
              <option value="D">D</option>
              <option value="E">E</option>
            </select>
          </div>

          <div class="col-12">
            <label class="form-label">업무 내용</label>
            <textarea id="taskCn" rows="4" class="form-control bg-transparent" placeholder="업무 상세 내용"></textarea>
          </div>

          <div class="col-12">
            <label for="uploadTaskFiles" class="form-label">업무 첨부파일</label>
            <input type="file" id="uploadTaskFiles" name="uploadTaskFiles[]" class="form-control" multiple>
            <ul id="fileNameList" class="mt-2 list-group">
              <!-- 파일 이름이 표시되는 영역 -->
            </ul>
          </div>
        </div>

        <div class="text-end mt-3">
          <button type="button" id="resetTaskForm" class="btn btn-outline-secondary me-2">
            <i class="fas fa-undo me-1"></i> 초기화
          </button>
          <button type="button" id="addTaskBtn" class="btn btn-success">
            <i class="fas fa-plus me-1"></i> 업무 추가
          </button>
        </div>
      </div>
    </div>
  </div>

  <!-- 오른쪽 4 영역 -->
  <div class="col-md-4">
    <!-- 설명 카드 -->
    <div class="card p-3 bg-light mb-3 shadow-sm">
      <h6 class="mb-3 fw-bold text-primary"><i class="fas fa-info-circle me-2"></i>업무 관리 안내</h6>
      <ul class="text-muted small ps-3 mb-2">
        <li>업무명, 담당자, 기간 등 업무 정보를 입력하세요.</li>
        <li>중요도와 등급을 설정해 우선순위를 조절하세요.</li>
        <li>첨부파일은 최대 5개까지 가능합니다.</li>
        <li>하단 목록에서 하위업무 추가 및 삭제 가능합니다.</li>
      </ul>
    </div>
    

    
    <!-- 등록된 업무 목록 -->
    <div class="card p-3 shadow-sm">
      <h6 class="mb-3 fw-bold"><i class="fas fa-list-ul me-2 text-primary"></i>등록된 업무 목록</h6>
      <ul class="list-group shadow-sm" id="taskList">
        <li class="list-group-item text-muted">등록된 업무가 없습니다.</li>
      </ul>
    </div>
  </div>
</div>