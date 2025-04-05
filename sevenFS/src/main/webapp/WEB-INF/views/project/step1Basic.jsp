<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="form-step" id="step1">
  <div class="row">
    <div class="col-12">
      <div class="input-style-1">
        <label>프로젝트 명 <span class="text-danger">*</span></label>
        <input type="text" name="prjctNm" placeholder="프로젝트 명" class="bg-transparent" required />
      </div>
    </div>
    <div class="col-md-12">
      <div class="select-style-1">
        <label>사업 분류<span class="text-danger">*</span></label>
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