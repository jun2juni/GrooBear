<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>업무 등록</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
  <h2>업무 등록</h2>
  <form id="taskForm" enctype="multipart/form-data">
    <input type="text" name="taskName" placeholder="업무명" required />
    <textarea name="taskDescription" placeholder="업무 설명"></textarea>

    <label>상위 업무:</label>
    <select name="parentTaskId">
      <option value="">(없음)</option>
      <c:forEach items="${parentTasks}" var="pt">
        <option value="${pt.taskNo}">${pt.taskNm}</option>
      </c:forEach>
    </select>

    <label>담당자:</label>
    <input type="text" name="chargerEmpno" placeholder="사원번호" />

    <!-- 첨부파일 -->
    <file-upload
      label="업무 파일"
      name="uploadFile"
      max-files="5"
      contextPath="${pageContext.request.contextPath}"
    ></file-upload>

    <button type="submit">등록</button>
  </form>

  <ul id="taskList"></ul>

  <script>
  $(function() {
    $('#taskForm').submit(function(e) {
      e.preventDefault();
      const formData = new FormData(this);
      $.ajax({
        url: '<c:url value="/project/${prjctNo}/task"/>',
        type: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function(res) {
          const task = res.data;
          $('#taskList').append(`<li>${task.taskNm}</li>`);
          alert("등록 성공");
        },
        error: function() {
          alert("등록 실패");
        }
      });
    });
  });
  </script>
</body>
</html>
