<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="row">
  <div class="col-md-8">
    <div class="form-step">
      <!-- 업무 입력 카드 -->
      <div class="card border p-3 mb-4">
        <h6 class="mb-3">업무 등록</h6>
        <div class="row g-3">
          <div class="col-md-12">
            <label>상위 업무명</label>
            <input type="text" id="parentTaskNm" class="form-control bg-transparent" readonly />
          </div>

          <div class="col-md-6">
            <label>업무명 <span class="text-danger">*</span></label>
            <input type="text" id="taskNm" class="form-control bg-transparent" placeholder="업무 제목" />
          </div>

          <div class="col-md-6">
            <label>담당자 <span class="text-danger">*</span></label>
            <input type="text" id="chargerEmpNm" class="form-control bg-transparent" placeholder="담당자 이름" readonly />
            <input type="hidden" id="chargerEmpno" />
          </div>

          <div class="col-md-6">
            <label>시작일</label>
            <input type="date" id="taskBeginDt" class="form-control bg-transparent" />
          </div>

          <div class="col-md-6">
            <label>종료일</label>
            <input type="date" id="taskEndDt" class="form-control bg-transparent" />
          </div>

          <div class="col-md-6">
            <label>중요도</label>
            <select id="taskPriort" class="form-select bg-transparent">
              <option value="">선택하세요</option>
              <option value="00">낮음</option>
              <option value="01">보통</option>
              <option value="02">높음</option>
              <option value="03">긴급</option>
            </select>
          </div>

          <div class="col-md-6">
            <label>업무 등급</label>
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
            <label>업무 내용</label>
            <textarea id="taskCn" rows="4" class="form-control bg-transparent" placeholder="업무 상세 내용"></textarea>
          </div>

          <div class="col-12">
            <label>파일 업로드</label>
            <file-upload label="업무 첨부파일" name="uploadFile" max-files="5" contextPath="${pageContext.request.contextPath}" />
          </div>
        </div>

        <div class="text-end mt-3">
          <button type="button" id="addTaskBtn" class="btn btn-success">
            <i class="fas fa-plus me-1"></i> 업무 추가
          </button>
        </div>
      </div>

      <!-- 등록된 업무 목록 -->
      <div class="card border p-3">
        <h6 class="mb-3">등록된 업무 목록</h6>
        <ul class="list-group" id="taskList">
          <li class="list-group-item text-muted">등록된 업무가 없습니다.</li>
        </ul>
      </div>
    </div>
  </div>

  <!-- 우측 설명 및 담당자 버튼 -->
  <div class="col-md-4">
    <div class="card p-3 bg-light">
      <h6 class="mb-3 text-primary"><i class="fas fa-tasks me-2"></i>업무 관리 안내</h6>
      <ul class="text-muted small ps-3">
        <li>업무명, 담당자, 기간 등 업무 정보를 입력하세요.</li>
        <li>중요도와 등급을 설정해 우선순위를 조절하세요.</li>
        <li>첨부파일은 최대 5개까지 가능합니다.</li>
        <li>하단 목록에서 하위업무 추가 및 삭제 가능합니다.</li>
        <li>모든 업무는 프로젝트 생성 시 함께 저장됩니다.</li>
      </ul>
    </div>

    <!-- 선택된 인원 버튼 -->
    <div class="mt-3">
      <label class="form-label fw-bold">담당자 선택</label>
      <div id="memberSelectBtns" class="d-flex flex-wrap gap-2"></div>
    </div>
  </div>
</div>
