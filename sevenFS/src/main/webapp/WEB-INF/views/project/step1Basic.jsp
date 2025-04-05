<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="row">
  <!-- 📌 왼쪽 8 영역: 기본 정보 입력 -->
  <div class="col-md-8">
    <div class="form-step">
      <div class="row">
        <div class="col-12">
          <div class="input-style-1">
            <label>프로젝트 명 <span class="text-danger">*</span></label>
            <input type="text" name="prjctNm" placeholder="프로젝트 명" class="bg-transparent" required />
          </div>
        </div>

        <div class="col-md-12">
          <div class="select-style-1">
            <label>사업 분류 <span class="text-danger">*</span></label>
            <div class="select-position">
              <select name="ctgryNo" required>
                <option value="">선택하세요</option>
                <option value="00">국가지원사업</option>
                <option value="01">법인자체사업</option>
                <option value="02">산학협력사업</option>
                <option value="03">민간수주사업</option>
                <option value="04">해외협력사업</option>
              </select>
            </div>
          </div>
        </div>

        <div class="col-12">
          <div class="input-style-1">
            <label>프로젝트 내용 <span class="text-danger">*</span></label>
            <textarea name="prjctCn" placeholder="내용" rows="5" class="bg-transparent" required></textarea>
          </div>
        </div>

        <div class="col-md-6">
          <div class="input-style-1">
            <label>사업 시작일 <span class="text-danger">*</span></label>
            <input type="date" name="prjctBeginDate" required />
          </div>
        </div>

        <div class="col-md-6">
          <div class="input-style-1">
            <label>사업 종료일 <span class="text-danger">*</span></label>
            <input type="date" name="prjctEndDate" required />
          </div>
        </div>

        <div class="col-md-6">
          <div class="select-style-1">
            <label>프로젝트 상태 <span class="text-danger">*</span></label>
            <div class="select-position">
              <select name="prjctSttus" required>
                <option value="">선택하세요</option>
                <option value="00">대기</option>
                <option value="01">진행중</option>
                <option value="02">완료</option>
                <option value="03">취소</option>
              </select>
            </div>
          </div>
        </div>

        <div class="col-md-6">
          <div class="select-style-1">
            <label>프로젝트 등급 <span class="text-danger">*</span></label>
            <div class="select-position">
              <select name="prjctGrad" required>
                <option value="">선택하세요</option>
                <option value="A">A</option>
                <option value="B">B</option>
                <option value="C">C</option>
                <option value="D">D</option>
                <option value="E">E</option>
              </select>
            </div>
          </div>
        </div>

        <div class="col-12">
          <div class="input-style-1">
            <label>프로젝트 URL</label>
            <input type="url" name="prjctUrl" placeholder="https://example.com" class="bg-transparent" />
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- ℹ️ 오른쪽 4 영역: 설명 영역 -->
  <div class="col-md-4">
    <div class="card p-3 bg-light">
      <h6 class="mb-3 text-primary"><i class="fas fa-info-circle me-2"></i>기본 정보 입력 안내</h6>
      <ul class="text-muted small ps-3">
        <li>프로젝트 명은 간결하고 명확하게 작성해주세요.</li>
        <li>프로젝트 내용에는 목적, 기대효과 등을 포함해주세요.</li>
        <li>시작일과 종료일을 정확히 설정해주세요.</li>
        <li>상태는 현재 진행 상황에 맞게 선택해주세요.</li>
        <li>등급은 A(가장 중요) ~ E 중에서 선택해주세요.</li>
      </ul>
    </div>
  </div>
</div>
