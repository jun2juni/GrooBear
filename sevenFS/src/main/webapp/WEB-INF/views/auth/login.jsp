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
    <title>${title}</title>
    <%@ include file="../layout/prestyle.jsp" %>
</head>
<body>
<main id="userContainer" class="main-wrapper">
    <section class="section">
        <div class="container-fluid">
            <div class="row g-0 auth-row">
                <div class="col-lg-6">
                    <div class="auth-cover-wrapper bg-primary-100">
                        <div class="auth-cover">
                            <div class="title text-center">
                                <h1 class="text-primary mb-10">Welcome Back</h1>
                                <p class="text-medium">
                                    Sign in to your Existing account to continue
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end col -->
                <div class="col-lg-6">
                    <div class="signin-wrapper">
                        <div class="form-wrapper">
                            <form action="/auth/login" name="loginForm" class="needs-validation" novalidate  method="post">
                                <div class="input-style-1 form-group">
                                    <label for="username" class="form-label">username</label>
                                    <input type="text" name="username" class="form-control" id="username" placeholder="아이디를 입력해주세요" value="${username}" required maxlength="30">
                                    <div class="invalid-feedback">아이디를 입력해주세요.</div>
                                </div>
                                <div class="input-style-1 form-group">
                                    <label for="pw" class="form-label">password</label>
                                    <input type="password" name="password" class="form-control" id="pw" placeholder="비밀번호를 입력해주세요" required maxlength="30">
                                    <div class="invalid-feedback">비밀번호를 입력해주세요.</div>
                                </div>
                                
                                <div class="form-check form-switch toggle-switch mb-20">
                                    <input class="form-check-input" type="checkbox" name="remember-me" id="remember-me">
                                    <label class="form-check-label" for="remember-me">로그인 유지</label>
                                </div>
<%--                                --%>
<%--                                <div><label for="remember-me" style>로그인 유지</label>--%>
<%--                                    <input type="checkbox" id="remember-me" name="remember-me" /></div>--%>
                                
                                <c:if test="${param.error == 'true'}">
                                    <div class="alert alert-danger text-center">
                                        <strong>로그인 실패했습니다.</strong>
                                    </div>
                                </c:if>
                                
                                <button type="submit" tabindex="7" class="btn submit btn-primary col-12">로그인</button>
                            </form>
                        </div>
                    </div>
                </div>
                <!-- end col -->
            </div>
        </div>
    </section>
</main>
<%--<%@ include file="../layout/prescript.jsp" %>--%>
</body>
</html>
