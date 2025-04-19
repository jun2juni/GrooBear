<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>PDF 미리보기</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      background-color: #1a1a1a;
      color: #fff;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    
    .container {
      padding: 20px;
      max-width: 500px;
      margin: auto;
    }
    
    .pdf-image {
      width: 100%;
      margin-bottom: 20px;
      border-radius: 8px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.3);
    }
    
    #loader {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(26, 26, 26, 0.9);
      z-index: 9999;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    
    .spinner {
      border: 6px solid #f3f3f3;
      border-top: 6px solid #00bcd4;
      border-radius: 50%;
      width: 60px;
      height: 60px;
      animation: spin 1s linear infinite;
    }
    
    @keyframes spin {
      0% { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
    }
  </style>
</head>
<body>

<div id="loader">
  <div class="spinner"></div>
</div>

<div class="container" id="pdf-container" style="display:none;">
<%--  <c:forEach var="img" items="${images}">--%>
<%--    --%>
<%--  </c:forEach>--%>
</div>

<script>
  window.addEventListener('load', () => {
    const loader = document.getElementById('loader');
    const pdfContainer = document.getElementById('pdf-container');
    
    // 비동기로 데이터 가져오기
    <%----%>
    fetch("/viewer/pdf/image?pdfPath=" + "${pdf}")
        .then(res => {
          return res.json();
        })
        .then(result => {
          result.forEach((pdf) => {
            pdfContainer.innerHTML += `<img class="pdf-image" src="data:image/png;base64,\${pdf}" alt="PDF Page" />`;
            
          })
        }).finally(() => {
          loader.style.display = 'none';
          pdfContainer.style.display = 'block';
        })
  });
</script>

</body>
</html>
