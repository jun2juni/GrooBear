<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="메인" />

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta
      name="viewport"
      content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"
  />
  <meta http-equiv="X-UA-Compatible" content="ie=edge" />
  <title>${title}</title>
  <c:import url="../layout/prestyle.jsp" />
</head>
<body>
<c:import url="../layout/sidebar.jsp" />
<main class="main-wrapper">
  <c:import url="../layout/header.jsp" />
  
  <section id="userContainer" class="section mt-4">
    <div class="container-fluid">
      
      <div class="row card-style">
        <form id="userAdd" name="loginForm" class="form-valid" novalidate action="/admin/login" method="post" enctype="multipart/form-data">
<%--          <input type="hidden" name="1">--%>
<%--          <input type="radio" name="2">--%>
<%--          <input type="checkbox" name="3">--%>
          
          <%-- 인풋 스타일 --%>
          <div class="input-style-1 form-group col-6">
            <label for="username" class="form-label required">아이디 <span class="text-danger">*</span></label>
            <input type="text" name="username" class="form-control" id="username" placeholder="아이디를 입력해주세요" required>
            <div class="invalid-feedback">아이디를 입력해주세요.</div>
          </div>
          
          <%-- 인풋 스타일 --%>
          <div class="input-style-1 form-group col-6">
            <label for="password" class="form-label">비밀번호 <span class="text-danger">*</span></label>
            <input type="password" name="password" class="form-control" id="password" placeholder="비밀번호를 입력해주세요" required>
            <div class="invalid-feedback">비밀번호를 입력해주세요.</div>
          </div>
          
          <%-- 인풋 스타일 --%>
          <div class="input-style-1 form-group col-6">
            <label for="passwordConfirm" class="form-label">비밀번호 확인 <span class="text-danger">*</span></label>
            <input type="password" name="passwordConfirm" class="form-control" id="passwordConfirm" placeholder="비밀번호를 입력해주세요" required>
            <div class="invalid-feedback">비밀번호 확인을 입력해주세요.</div>
          </div>
  
          <%-- 인풋 스타일 --%>
          <div class="input-style-1 form-group col-6">
            <label for="phoneNumber" class="form-label">핸드폰 전화번호 <span class="text-danger">*</span></label>
            <input type="text" name="phone" class="form-control" id="phoneNumber" placeholder="비밀번호를 입력해주세요" required>
            <div class="invalid-feedback">휴대전화번호를 입력해주세요.</div>
          </div>
  
          
          <%-- text area 스타일 --%>
          <div class="input-style-1 form-group col-6">
            <label for="fullName" class="form-label">이름 <span class="text-danger">*</span></label>
            <textarea name="fullName" class="form-control" id="fullName" cols="10" rows="5" placeholder="이름을 입력해주세요" required></textarea>
            <div class="invalid-feedback">이름을 입력해주세요.</div>
          </div>
          
          <%--셀렉트 박스 --%>
          <div class="select-style-1 form-group w-fit">
            <label for="dept" class="form-label">State</label>
            <select name="dept" class="form-select" id="dept" required>
              <option selected="" disabled="" readonly="" value="">직급을 선택해주세요</option>
              <option value="01">인턴</option>
              <option value="02">사원</option>
            </select>
            <div class="invalid-feedback">직급을 선택해주세요.</div>
          </div>
          
          <%-- 라디오 박스 --%>
          <div class="select-style-1 form-group">
            <label>Category <span class="text-danger">*</span></label>
            <div class="d-flex gap-5">
              <div class="form-check radio-style mb-20">
                <input class="form-check-input" name="radio" type="radio" value="" id="radio-1" required>
                <label class="form-check-label" for="radio-1">Default 1</label>
              </div>
              <div class="form-check radio-style mb-20">
                <input class="form-check-input" name="radio" type="radio" value="" id="radio-2" required>
                <label class="form-check-label" for="radio-2">Default 2</label>
              </div>
              <div class="form-check radio-style mb-20">
                <input class="form-check-input" name="radio" type="radio" value="" id="radio-3" required>
                <label class="form-check-label" for="radio-3">Default 3</label>
              </div>
            </div>
          </div>
          
          <%-- 체크 박스 --%>
          <div class="select-style-1 form-group">
            <label>Category <span class="text-danger">*</span></label>
            <div class="d-flex gap-5">
              <div class="form-check checkbox-style mb-20">
                <input class="form-check-input" type="checkbox" value="" id="checkbox-1" required>
                <label class="form-check-label" for="checkbox-1">Default Checkbox</label>
              </div>
              <div class="form-check checkbox-style mb-20">
                <input class="form-check-input" type="checkbox" value="" id="checkbox-2" required>
                <label class="form-check-label" for="checkbox-2">Default Checkbox</label>
              </div>
              <div class="form-check checkbox-style mb-20">
                <input class="form-check-input" type="checkbox" value="" id="checkbox-3" required>
                <label class="form-check-label" for="checkbox-3">Default Checkbox</label>
              </div>
            </div>
          </div>
          
          <div class="form-check form-switch toggle-switch mb-20">
            <input class="form-check-input" type="checkbox" id="toggleSwitch2" checked="">
            <label class="form-check-label" for="toggleSwitch2">Default switch checkbox input</label>
          </div>
  
          <file-upload
              label="프로필 이미지"
              name="uploadFile"
              max-files="1"
              contextPath="${pageContext.request.contextPath  }"
              required="true"
          ></file-upload>
          
          <button type="submit" tabindex="7" class="btn submit btn-primary col-6">회원가입</button>
        </form>
      </div>
    </div>
  </section>
  <c:import url="../layout/footer.jsp" />
</main>
<c:import url="../layout/prescript.jsp" />
</body>
</html>
