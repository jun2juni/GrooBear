<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>업무 등록</title>
</head>
<body>
  <h2>업무 등록</h2>
  <form id="taskForm" enctype="multipart/form-data">
    <input type="text" name="taskNm" placeholder="업무명" required />
    <textarea name="taskCn" placeholder="업무 설명"></textarea>

    <label>상위 업무:</label>
    <select name="upperTaskNo">
      <option value="">(없음)</option>
      <c:forEach items="${parentTasks}" var="pt">
        <option value="${pt.taskNo}">${pt.taskNm}</option>
      </c:forEach>
    </select>

    <label>담당자 사번:</label>
    <input type="text" name="chargerEmpno" required />

    <!-- 첨부파일 업로드 -->
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
    document.getElementById('taskForm').addEventListener('submit', async function (e) {
      e.preventDefault();

      const form = e.target;
      const formData = new FormData(form);

      try {
        const response = await fetch('/project/task/ajax/insert"/>', {
          method: 'POST',
          body: formData
        });

        if (!response.ok) throw new Error('서버 오류');

        const result = await response.json();
        const task = result.data;

        const taskItem = document.createElement('li');
        taskItem.textContent = task.taskNm;
        document.getElementById('taskList').appendChild(taskItem);

        alert('등록 성공!');
        form.reset(); // 폼 초기화

      } catch (error) {
        alert('등록 실패: ' + error.message);
      }
    });
  </script>
</body>
</html>
