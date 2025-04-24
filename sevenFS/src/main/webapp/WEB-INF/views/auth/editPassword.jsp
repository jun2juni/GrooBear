<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- 페이지 타이틀 설정 --%>
<c:set var="title" scope="application" value="비밀번호 수정" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>${title}</title>
    <%@ include file="../layout/prestyle.jsp" %>
</head>
<body>
<main id="userContainer" class="main-wrapper">
    <section class="section">
        <div class="container-fluid">
            <div class="row g-0 auth-row">
                <!-- 좌측 영역 -->
                <div class="col-lg-6">
                    <div class="auth-cover-wrapper bg-primary-100">
                        <div class="auth-cover">
                            <div class="title text-center">
                                <h1 class="text-primary mb-10">비밀번호 수정</h1>
                                <p class="text-medium">새 비밀번호를 입력해주세요</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 우측 폼 영역 -->
                <div class="col-lg-6">
                    <div class="signin-wrapper">
                        <div class="form-wrapper">
                            <form action="/auth/change-password" method="post" class="needs-validation" novalidate>
                                <div class="input-style-1 form-group">
                                    <label for="currentPassword" class="form-label">현재 비밀번호</label>
                                    <input type="password" name="currentPassword" class="form-control" id="currentPassword"
                                           placeholder="현재 비밀번호를 입력해주세요" required maxlength="30">
                                    <div class="invalid-feedback">현재 비밀번호를 입력해주세요.</div>
                                </div>

                                <div class="input-style-1 form-group">
                                    <label for="newPassword" class="form-label">새 비밀번호</label>
                                    <input type="password" name="newPassword" class="form-control" id="newPassword"
                                           placeholder="새 비밀번호를 입력해주세요" required maxlength="30">
                                    <div class="invalid-feedback">새 비밀번호를 입력해주세요.</div>
                                </div>

                                <div class="input-style-1 form-group">
                                    <label for="confirmPassword" class="form-label">새 비밀번호 확인</label>
                                    <input type="password" name="confirmPassword" class="form-control" id="confirmPassword"
                                           placeholder="새 비밀번호를 다시 입력해주세요" required maxlength="30">
                                    <div class="invalid-feedback">비밀번호 확인이 일치하지 않습니다.</div>
                                </div>

                                <c:if test="${param.error == 'true'}">
                                    <div class="alert alert-danger text-center">
                                        <strong>비밀번호 변경에 실패했습니다.</strong>
                                    </div>
                                </c:if>

                                <button type="submit" class="btn submit btn-primary col-12">비밀번호 변경</button>
                            </form>
                        </div>
                    </div>
                </div>
                <!-- end col -->
            </div>
        </div>
    </section>
</main>
<%-- <%@ include file="../layout/prescript.jsp" %> --%>
</body>
</html>
