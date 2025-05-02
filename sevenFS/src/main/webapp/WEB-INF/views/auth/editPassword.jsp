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
    <style>
       body {
        background-color: #f4f6f9;
        font-family: 'Noto Sans KR', sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }

    .auth-container {
        display: flex;
        max-width: 900px; /* Reduced width */
        width: 100%;
        min-height: 60vh; /* Adjusted height */
    }

    .auth-left {
        flex: 1;
        background: linear-gradient(234deg, #cdefff 0%, #aee6f9 50%, #89c8e6 100%);
        display: flex;
        align-items: center;
        justify-content: center;
        color: #333;
        padding: 2rem;
    }

    .auth-left h1 {
        font-size: 2.5rem;
        margin-bottom: 1rem;
    }

    .auth-left p {
        font-size: 1.2rem;
    }

    .auth-right {
        flex: 1;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 3rem 2rem;
    }

    .auth-card {
        background-color: #fff;
        padding: 2rem;
        border-radius: 1rem;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        width: 100%;
        max-width: 450px; /* Reduced width */
        margin: 0 auto; /* Center the card */
    }

    .form-group label {
        font-weight: 500;
    }

    .form-control {
        border-radius: 0.5rem;
    }

    .btn {
        border-radius: 0.5rem;
        font-weight: 600;
        transition: all 0.3s ease;
    }

    .btn-success:hover {
        background-color: #28a745;
    }

    .btn-dark:hover {
        background-color: #333;
    }

    .btn + .btn {
        margin-left: 1rem;
    }

    #newPasswordMsg, #pwMsg {
        font-size: 0.875rem;
    }

    #changePwButton {
        background-color: #b3e5fc;
        border: none;
        color: #0d3c61;
        font-weight: bold;
        border-radius: 6px;
    }

    #changePwButton:hover {
        background-color: #a0daf5;
    }


    #passwordCancleBtn:hover {
        background-color: gray;
    }
    </style>
</head>
<body>

<main class="auth-container">
    <!-- 좌측 비주얼 영역 -->
    <div class="auth-left">
        <div>
            <h1>비밀번호 변경</h1>
            <p class="text-muted mt-3" style="font-size: 0.9rem;">
                * 영문 대소문자, 숫자, 특수문자 포함 8~16자<br>
                * 이전과 다른 비밀번호를 사용해주세요.
            </p>
        </div>
    </div>

    <!-- 우측 폼 영역 -->
    <div class="auth-right">
        <div class="auth-card">
            <input type="hidden" id="hiddenEmplNo" value="${emp.emplNo}">

            <div class="form-group mb-3">
                <label for="currentPassword">현재 비밀번호</label>
                <input type="password" id="currentPassword" class="form-control" placeholder="현재 비밀번호를 입력해주세요" required maxlength="30" />
                <div class="invalid-feedback">현재 비밀번호를 입력해주세요.</div>
            </div>

            <div class="form-group mb-3">
                <label for="newPassword">새 비밀번호</label>
                <input type="password" id="newPassword" class="form-control"
                       placeholder="새 비밀번호를 입력해주세요"
                       pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,16}$"
                       oninput="inputNewPassword()" maxlength="16" required />
                <div class="invalid-feedback">새 비밀번호를 입력해주세요.</div>
                <p id="newPasswordMsg" style="color: red; font-weight: bold;"></p>
            </div>

            <div class="form-group mb-4">
                <label for="confirmPassword">새 비밀번호 확인</label>
                <input type="password" id="confirmPassword" class="form-control"
                       placeholder="새 비밀번호를 다시 입력해주세요"
                       oninput="inputPassword()" maxlength="30" required />
                <div class="invalid-feedback">비밀번호 확인이 일치하지 않습니다.</div>
                <p id="pwMsg" style="color: red; font-weight: bold;"></p>
            </div>

            <c:if test="${param.error == 'true'}">
                <div class="alert alert-danger text-center">
                    <strong>비밀번호 변경에 실패했습니다.</strong>
                </div>
            </c:if>

            <div class="d-flex justify-content-between">
                <button type="button" id="changePwButton" class="btn btn-success w-100">변경</button>
                <button type="button" class="btn dark-btn-light w-100" id="passwordCancleBtn">취소</button>
            </div>
        </div>
    </div>
</main>
<%@ include file="../layout/prescript.jsp" %>
<script type="text/javascript">
	
function inputNewPassword(){
	// 비밀번호 형식에 맞는지 확인하기
	let newPassword = $('#newPassword').val();
	let confirmPassword = $('#confirmPassword').val();
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
/* 	// 비밀번호 형식에 맞는지 확인하기
	let newPassword = $('#newPassword').val();
	let confirmPassword = $('#confirmPassword').val(); */
	
	//----- 비동기로 비밀번호 보내기
	$('#changePwButton').on('click', function(){
		
		// 현재 비밀번호
		let currentPassword = $('#currentPassword').val();
		// 새 비밀번호
		let newPassword = $('#newPassword').val();
		// 새 비밀번호 확인
		let confirmPassword = $('#confirmPassword').val();
		//console.log('바꿀 비번 : ' , newPassword);
		if(newPassword == null || newPassword == '' && confirmPassword == null || confirmPassword == ''){
				swal({
					icon : 'warning',
					text : '변경할 비밀번호를 입력해주세요.',
					buttons : {
						confirm : {
							text : '확인',
							value : true
						}
					}
				});
			return ;
		}
		
		// 비밀번호 형식에 맞는지 확인하기
		const patternStr = $('#newPassword').attr('pattern');
		const pattern = new RegExp(patternStr);
		
		// 로그인된 사원번호
		const emplNo = $('#hiddenEmplNo').val();
		//console.log('입력중인 : ' , $('#confirmPassword').val());
	 	if(newPassword !== confirmPassword){
			swal({
				icon : 'error',
				text : '새 비밀번호가 일치하지 않습니다.',
				buttons : {
					confirm : {
						text : '확인',
						value : true
					}
				}
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
					text : '비밀번호가 변경되었습니다.',
					buttons : {
						confirm : {
							text : '확인',
							value : true
						}
					}
				})
				.then(() => {
					location.href = '/emplDetailHeader?emplNo='+emplNo;
				})
			}
			else if(res === '실패'){
				swal({
					icon : 'error',
					text : '비밀번호 변경에 실패했습니다.',
					buttons : {
						confirm : {
							text : '확인',
							value : true
						}
					}
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
	
	// 비밀번호 취소 눌렀을경우
	$('#passwordCancleBtn').on('click' , function(){
		const emplNo = $('#hiddenEmplNo').val();
		swal({
			text : '비밀번호 변경을 취소하시겠습니까?',
			icon : 'warning',
			buttons : {
				confirm : {
					text : '확인',
					value : true
				}
			}
		})
		.then(() => {
			location.href = '/emplDetailHeader?emplNo='+emplNo;
		})
	})
})
	
</script>

</body>
</html>
	