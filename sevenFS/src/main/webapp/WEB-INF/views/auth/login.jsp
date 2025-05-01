<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="title" scope="application" value="로그인" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>${title}</title>
  <%@ include file="../layout/prestyle.jsp" %>

  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', sans-serif;
      background-color: #f5f7fa;
    }

    .login-wrapper {
      display: flex;
      height: 100vh;
    }

    .login-left {
      flex: 1.3;
      background: linear-gradient(to bottom right, #1381f8, #ffffff);
      color: white;
      display: flex;
      align-items: center;
      justify-content: center;
      flex-direction: column;
      padding: 60px;
    }

    .login-left h1 {
      font-size: 3rem;
      margin-bottom: 20px;
    }

    .login-left p {
      font-size: 1.4rem;
      max-width: 480px;
      text-align: center;
      line-height: 1.6;
      font-weight: 500;
    }

    .login-right {
      flex: 1;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 60px;
      background-color: #ffffff;
    }

    .login-form {
      width: 100%;
      max-width: 400px;
    }

    .form-label {
      font-weight: 600;
      margin-bottom: 0.5rem;
      display: block;
      color: #333;
    }

    .form-control {
      width: 100%;
      padding: 12px;
      border-radius: 8px;
      border: 1px solid #ccc;
      font-size: 1rem;
      margin-bottom: 1.2rem;
    }

    .form-check {
      margin-bottom: 1.2rem;
    }

    .btn {
      width: 100%;
      padding: 12px;
      background-color: #007bff;
      color: white;
      font-size: 1rem;
      font-weight: bold;
      border: none;
      border-radius: 8px;
      cursor: pointer;
    }

    .btn:hover {
      background-color: #0056b3;
    }

    .alert-danger {
      background-color: #ffe6e6;
      color: #d63031;
      padding: 10px;
      border-radius: 8px;
      text-align: center;
      margin-bottom: 1rem;
    }
  </style>
</head>
<body>
  <div class="login-wrapper">
    <!-- 왼쪽 소개 영역 -->
    <div class="login-left">
       <h1><img src="/assets/images/logo/GoobearTitle.png" alt="logo" id="logoTitle" style="width: 250px; height: auto;"/></h1>
      <p>당신의 업무를 더 스마트하게,<br />
         그룹웨어의 새로운 기준을 경험해보세요.</p>
    </div>

    <!-- 오른쪽 로그인 영역 -->
    <div class="login-right">
      <form action="/auth/login" method="post" class="login-form" novalidate>
        <c:if test="${param.error == 'true'}">
          <div class="alert-danger">로그인 실패했습니다.</div>
        </c:if>

        <label for="username" class="form-label">사원번호</label>
        <input type="text" id="username" name="username" class="form-control" placeholder="사원번호를 입력해주세요" required maxlength="30" />

        <label for="pw" class="form-label">비밀번호</label>
        <input type="password" id="pw" name="password" class="form-control" placeholder="비밀번호를 입력해주세요" required maxlength="30" />

        <div class="form-check">
          <input type="checkbox" class="form-check-input" id="remember-me" name="remember-me" />
          <label class="form-check-label" for="remember-me">로그인 유지</label>
        </div>

        <button type="submit" class="btn">로그인</button>
      </form>
    </div>
  </div>
</body>
</html>
