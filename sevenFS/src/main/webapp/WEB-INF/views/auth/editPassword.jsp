<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
      margin: 0;
      font-family: 'Segoe UI', sans-serif;
      background-color: #f5f7fa;
    }
    .pw-wrapper {
      display: flex;
      height: 100vh;
    }
    .pw-left {
      flex: 1.3;
      background: linear-gradient(to bottom right, rgba(60,246,10,0.49), rgba(19,129,248,0.68));
      color: white;
      display: flex;
      align-items: center;
      justify-content: center;
      flex-direction: column;
      padding: 60px;
    }
    .pw-left h1 {
      font-size: 2.8rem;
      margin-bottom: 20px;
    }
    .pw-left p {
      font-size: 1.2rem;
      max-width: 480px;
      text-align: center;
      line-height: 1.6;
      font-weight: 500;
    }
    .pw-right {
      flex: 1;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 60px;
      background-color: #ffffff;
    }
    .pw-form {
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
    .btn-cancel {
      background-color: #6c757d;
    }
    .btn-cancel:hover {
      background-color: #5a6268;
    }
    .alert-danger {
      background-color: #ffe6e6;
      color: #d63031;
      padding: 10px;
      border-radius: 8px;
      text-align: center;
      margin-bottom: 1rem;
    }
    .msg {
      font-size: 0.875rem;
      margin-top: -1rem;
      margin-bottom: 1rem;
      font-weight: 500;
    }
  </style>
</head>
<body>
<div class="pw-wrapper">
  <div class="pw-left">
    <h1 class="text-white">비밀번호 변경</h1>
    <p>* 영문 대소문자, 숫자, 특수문자 포함 8~16자<br>* 이전과 다른 비밀번호를 사용해주세요.</p>
  </div>
  <div class="pw-right">
    <form class="pw-form" novalidate>
      <input type="hidden" id="hiddenEmplNo" value="${emp.emplNo}" />
      <label for="currentPassword" class="form-label">현재 비밀번호</label>
      <input type="password" id="currentPassword" class="form-control" placeholder="현재 비밀번호를 입력해주세요" maxlength="30" required />
      <label for="newPassword" class="form-label">새 비밀번호</label>
      <input type="password" id="newPassword" class="form-control" placeholder="새 비밀번호를 입력해주세요"
             pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,16}$"
             oninput="inputNewPassword()" maxlength="16" required />
      <p id="newPasswordMsg" class="msg" style="color: tomato;"></p>
      <label for="confirmPassword" class="form-label">새 비밀번호 확인</label>
      <input type="password" id="confirmPassword" class="form-control" placeholder="새 비밀번호를 다시 입력해주세요"
             oninput="inputPassword()" maxlength="30" required />
      <p id="pwMsg" class="msg" style="color: tomato;"></p>
      <c:if test="${param.error == 'true'}">
        <div class="alert-danger">비밀번호 변경에 실패했습니다.</div>
      </c:if>
      <button type="button" class="btn mt-4 mb-3" id="changePwButton">비밀번호 변경</button>
      <button type="button" class="btn btn-cancel" id="passwordCancleBtn">취소</button>
    </form>
  </div>
</div>
<%@ include file="../layout/prescript.jsp" %>
<script type="text/javascript">
function inputNewPassword() {
  const newPassword = $('#newPassword').val();
  const patternStr = $('#newPassword').attr('pattern');
  const pattern = new RegExp(patternStr);
  if (!pattern.test(newPassword)) {
    $('#newPasswordMsg').text('8~16자의 영문 대소문자, 숫자 및 특수문자 사용').css('color', 'tomato');
    $('#changePwButton').prop('disabled', true);
  } else {
    $('#newPasswordMsg').text('사용 가능한 비밀번호입니다.').css('color', 'green');
    $('#changePwButton').prop('disabled', false);
  }
}

function inputPassword() {
  const newPassword = $('#newPassword').val();
  const confirmPassword = $('#confirmPassword').val();
  if (confirmPassword === '') {
    $('#pwMsg').text('');
    return;
  }
  if (newPassword === confirmPassword) {
    $('#pwMsg').text('비밀번호가 일치합니다.').css('color', 'green');
  } else {
    $('#pwMsg').text('비밀번호가 일치하지 않습니다.').css('color', 'tomato');
  }
}

$(function () {
  $('#changePwButton').on('click', function () {
    const currentPassword = $('#currentPassword').val();
    const newPassword = $('#newPassword').val();
    const confirmPassword = $('#confirmPassword').val();
    if (!newPassword || !confirmPassword) {
      swal({ icon: 'warning', text: '변경할 비밀번호를 입력해주세요.', buttons: { confirm: { text: '확인', value: true } } });
      return;
    }
    const patternStr = $('#newPassword').attr('pattern');
    const pattern = new RegExp(patternStr);
    if (!pattern.test(newPassword)) {
      swal({ icon: 'error', text: '비밀번호 형식이 올바르지 않습니다.', buttons: { confirm: { text: '확인', value: true } } });
      return;
    }
    if (newPassword !== confirmPassword) {
      swal({ icon: 'error', text: '새 비밀번호가 일치하지 않습니다.', buttons: { confirm: { text: '확인', value: true } } });
      return;
    }
    const emplNo = $('#hiddenEmplNo').val();
    const formData = new FormData();
    formData.append('currentPassword', currentPassword);
    formData.append('confirmPassword', confirmPassword);

    fetch('/auth/changePassword', {
      method: 'POST',
      body: formData
    })
    .then(resp => resp.text())
    .then(res => {
      if (res === '성공') {
        swal({ icon: 'success', text: '비밀번호가 변경되었습니다.', buttons: { confirm: { text: '확인', value: true } } })
          .then(() => location.href = '/emplDetailHeader?emplNo=' + emplNo);
      } else {
        swal({ icon: 'error', text: '비밀번호 변경에 실패했습니다.', buttons: { confirm: { text: '확인', value: true } } })
          .then(() => {
            $('#currentPassword').focus();
            $('#newPassword').val('');
            $('#confirmPassword').val('');
            $('#pwMsg').text('');
          });
      }
    });
  });

  $('#passwordCancleBtn').on('click', function () {
    const emplNo = $('#hiddenEmplNo').val();
    swal({ text: '비밀번호 변경을 취소하시겠습니까?', icon: 'warning', buttons: { confirm: { text: '확인', value: true } } })
      .then(() => location.href = '/emplDetailHeader?emplNo=' + emplNo);
  });
});
</script>
</body>
</html>
