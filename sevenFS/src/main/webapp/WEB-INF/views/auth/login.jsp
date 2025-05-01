<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="로그인" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta
        name="viewport"
        content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"
    />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
<style>
body {
    margin: 0;
    font-family: 'Segoe UI', sans-serif;
    align-items: center;
    justify-content: center;
}
.login-box {
    background: #ffffff;
    border-radius: 16px;
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
    padding: 40px 30px;
    max-width: 420px;
    width: 100%;
}

.login-box h1 {
    font-size: 1.8rem;
    font-weight: bold;
    color: #2c3e50;
    margin-bottom: 10px;
    text-align: center;
}

.login-box p {
    font-size: 0.95rem;
    color: #7f8c8d;
    margin-bottom: 30px;
    text-align: center;
}

.form-label {
    font-weight: 500;
    margin-bottom: 0.5rem;
    display: block;
    color: #34495e;
}

.form-control {
    width: 100%;
    padding: 12px 16px;
    font-size: 1rem;
    border-radius: 8px;
    border: 1px solid #ccc;
    margin-bottom: 16px;
}

.form-control:focus {
    outline: none;
    border-color: #3498db;
    box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.25);
}

.form-check {
    margin-bottom: 20px;
}

.form-check-input {
    margin-right: 8px;
}

.form-check-label {
    color: #555;
}

.btn-primary {
    width: 100%;
    background-color: #3498db;
    color: white;
    padding: 12px;
    font-size: 1rem;
    border-radius: 8px;
    border: none;
    font-weight: bold;
    transition: background-color 0.3s;
}

.btn-primary:hover {
    background-color: #2d80b3;
}

.alert-danger {
    background-color: #ffe6e6;
    color: #e74c3c;
    font-weight: bold;
    padding: 10px;
    border-radius: 8px;
    margin-bottom: 20px;
    text-align: center;
}

</style>
    <title>${title}</title>
    <%@ include file="../layout/prestyle.jsp" %>
</head>
<body>
<main id="userContainer" class="main-wrapper" style="margin-left: 0px;">
    <section class="section">
        <div class="container-fluid min-vh-100 d-flex align-items-center justify-content-center bg-light">
            <div class="row w-100 shadow-lg rounded-4 overflow-hidden" style="max-width: 960px;">
                <!-- Left side: Welcome -->
                <div class="col-lg-6 bg-primary-100 d-flex flex-column justify-content-center text-center p-5">
                    <div>
                        <div class="mb-4">
                            <h1><img src="/assets/images/logo/GoobearTitle.png" alt="logo" id="logoTitle" style="width: 250px; height: auto;"/></h1>
                        </div>
                        <!-- <h1 class="text-primary mb-3 fw-bold">Welcome Back</h1> -->
                        <p class="text-medium fs-5">환영합니다! <br/>업무를 시작하려면 로그인해 주세요.</p>
                    </div>
                </div>
        
                <!-- Right side: Form -->
                <div class="col-lg-6 bg-white p-5">
                   
                    <form action="/auth/login" name="loginForm" class="needs-validation" novalidate method="post">
                        <!-- Username -->
                        <div class="mb-4">
                            <label for="username" class="form-label fs-5">아이디</label>
                            <input type="text" name="username" id="username" class="form-control form-control-lg"
                                   placeholder="아이디를 입력해주세요" value="${username}" required maxlength="30">
                            <div class="invalid-feedback">아이디를 입력해주세요.</div>
                        </div>
        
                        <!-- Password -->
                        <div class="mb-4">
                            <label for="pw" class="form-label fs-5">비밀번호</label>
                            <input type="password" name="password" id="pw" class="form-control form-control-lg"
                                   placeholder="비밀번호를 입력해주세요" required maxlength="30">
                            <div class="invalid-feedback">비밀번호를 입력해주세요.</div>
                        </div>
        
                        <!-- Remember Me -->
                        <div class="form-check form-switch mb-4">
                            <input class="form-check-input fs-5" type="checkbox" name="remember-me" id="remember-me">
                            <label class="form-check-label fs-5" for="remember-me">로그인 유지</label>
                        </div>
        
                        <!-- Login Error -->
                        <c:if test="${param.error == 'true'}">
                            <div class="alert alert-danger">로그인 실패했습니다.</div>
                        </c:if>
                    
        
                        <!-- Submit Button -->
                        <button type="submit" class="btn btn-primary btn-lg w-100 mt-2" style="background-color: #2d80b3;">로그인</button>
                    </form>
                </div>
            </div>
        </div>
    </section>
</main>
<%--<%@ include file="../layout/prescript.jsp" %>--%>
</body>
</html>
