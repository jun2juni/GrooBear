<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%-- 페이지 타이틀 설정 --%>
<c:set var="title" scope="application" value="비밀번호 수정" />
<sec:authentication property="principal.empVO" var="emp" />

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
                    <div class="auth-cover-wrapper bg-success-100">
                        <div class="auth-cover">
                            <div class="title text-center">
                                <h1 class="text-success mb-10">비밀번호 변경</h1>
                                <p class="text-medium">새 비밀번호를 입력해주세요</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 우측 폼 영역 -->
                <input type="hidden" id="hiddenEmplNo" value="${emp.emplNo}">
                <div class="col-lg-6">
                    <div class="signin-wrapper">
                        <div class="form-wrapper">
                                <div class="input-style-1 form-group">
                                    <label for="currentPassword" class="form-label">현재 비밀번호</label>
                                    <input type="password" name="currentPassword" class="form-control" id="currentPassword"
                                           placeholder="현재 비밀번호를 입력해주세요" required maxlength="30">
                                    <div class="invalid-feedback">현재 비밀번호를 입력해주세요.</div>
                                </div>

                                <div class="input-style-1 form-group">
                                    <label for="newPassword" class="form-label">새 비밀번호</label>
                                    <input type="password"  class="form-control" id="newPassword" 
                                    		 pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,16}$"
                                    		 oninput="inputNewPassword()"
                                           placeholder="새 비밀번호를 입력해주세요" required maxlength="16">
                                    <div class="invalid-feedback">새 비밀번호를 입력해주세요.</div>
                                    <p id="newPasswordMsg" style="color: red; font-weight: bold;"></p>
                                </div>

                                <div class="input-style-1 form-group">
                                    <label for="confirmPassword" class="form-label">새 비밀번호 확인</label>
                                    <input type="password" name="confirmPassword" class="form-control" id="confirmPassword"
                                          oninput="inputPassword()" placeholder="새 비밀번호를 다시 입력해주세요" required maxlength="30">
                                    <div class="invalid-feedback">비밀번호 확인이 일치하지 않습니다.</div>
                                    <p id="pwMsg" style="color: red; font-weight: bold;"></p>
                                </div>

                                <c:if test="${param.error == 'true'}">
                                    <div class="alert alert-danger text-center">
                                        <strong>비밀번호 변경에 실패했습니다.</strong>
                                    </div>
                                </c:if>

                                <button id="changePwButton" type="button" class="btn submit btn-success col-12 mb-2">비밀번호 변경</button>
                                <a href="/emplDetailHeader?emplNo=${emp.emplNo}" id="changePwCancle" type="button" class="btn submit btn-dark col-12">비밀번호 변경 취소</a>
                        </div>
                    </div>
                </div>
                <!-- end col -->
            </div>
        </div>
    </section>
</main>
<%@ include file="../layout/prescript.jsp" %>
<script type="text/javascript">
	
function inputNewPassword(){
	// 비밀번호 형식에 맞는지 확인하기
	let newPassword = $('#newPassword').val();
	const patternStr = $('#newPassword').attr('pattern');
	const pattern = new RegExp(patternStr);
	//console.log('newPassword : ' , newPassword);
	//console.log('pattern : ' , pattern);
	if(!pattern.test(newPassword)){
		$('#newPasswordMsg').text('8~16자의 영문 대소문자, 숫자 및 특수문자 사용').css('color', 'tomato');
		$('#changePwButton').prop('disabled', true);
	}else{
		$('#newPasswordMsg').text('사용 가능한 비밀번호 입니다.').css('color', 'green');
		$('#changePwButton').prop('disabled', false);
	}
	
}

function inputPassword(){
	// 현재 비밀번호
	let currentPassword = $('#currentPassword').val();
	// 새 비밀번호
	let newPassword = $('#newPassword').val();
	// 새 비밀번호 확인
	let confirmPassword = $('#confirmPassword').val();
	//console.log('바꿀 비번 : ' , newPassword);
	//console.log('입력중인 : ' , confirmPassword);

	if(confirmPassword === ''){
		$('#pwMsg').text('');
		return;
	}
	if(newPassword === confirmPassword){
		$('#pwMsg').text('비밀번호가 일치합니다.').css('color', 'green');
	}else{
		$('#pwMsg').text('비밀번호가 일치하지 않습니다.').css('color', 'tomato');
	}
}	

$(function(){
	// 현재 비밀번호
	let currentPassword = $('#currentPassword').val();
	
	//----- 비동기로 비밀번호 보내기
	$('#changePwButton').on('click', function(){
		// 현재 비밀번호
		let currentPassword = $('#currentPassword').val();
		// 새 비밀번호
		let newPassword = $('#newPassword').val();
		// 새 비밀번호 확인
		let confirmPassword = $('#confirmPassword').val();
		//console.log('바꿀 비번 : ' , newPassword);
		
		// 비밀번호 형식에 맞는지 확인하기
		const patternStr = $('#newPassword').attr('pattern');
		const pattern = new RegExp(patternStr);
		
		// 로그인된 사원번호
		const emplNo = $('#hiddenEmplNo').val();
		//console.log('입력중인 : ' , $('#confirmPassword').val());
	 	if(newPassword !== confirmPassword){
			swal({
				icon : 'error',
				text : '새 비밀번호가 일치하지 않습니다.'
			})
			return;
		} 
		const formData = new FormData();
		formData.append('currentPassword', $('#currentPassword').val());
		formData.append('confirmPassword', $('#confirmPassword').val());
		
		fetch('/auth/changePassword', {
			method : 'POST',
	        body : formData
		})
		.then(resp => resp.text())
		.then(res => {
			console.log('결과 확인 : ' , res);
			if(res === '성공'){
				swal({
					icon : 'success',
					text : '비밀번호가 변경되었습니다.'
				})
				.then(() => {
					location.href = '/emplDetailHeader?emplNo='+emplNo;
				})
			}
			else if(res === '실패'){
				swal({
					icon : 'error',
					text : '비밀번호 변경에 실패했습니다.'
				})
				.then(() => {
					$('#currentPassword').focus();
					$('#newPassword').val('');
					$('#confirmPassword').val('');
					$('#pwMsg').text('');
				})
			}
		}) 
	})
})
	
</script>

</body>
</html>
