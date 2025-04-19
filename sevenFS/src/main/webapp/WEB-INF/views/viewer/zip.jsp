<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>PDF 미리보기</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      background-color: #1a1a1a;
      color: #fff;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      flex-direction: column;
    }
    
    .pdf-container {
      background-color: #2a2a2a;
      padding: 20px;
      border-radius: 12px;
      box-shadow: 0 8px 24px rgba(0, 0, 0, 0.4);
      max-width: 90%;
      width: 80vw;
      height: 80vh;
      text-align: center;
    }
    
    .pdf-frame {
      width: 100%;
      height: 100%;
      border: none;
      border-radius: 8px;
      background-color: #fff;
    }
    
    .pdf-title {
      margin-top: 12px;
      font-size: 16px;
      color: #aaa;
    }
  </style>
</head>
<body>
<div class="pdf-container">
<%--  <iframe class="pdf-frame" src="/upload/${pdfFile}"></iframe>--%>
  <div class="pdf-title">
    ${pdf}
  </div>
  <div class="pdf-title">
    ${pdfFile}
  </div>
</div>
</body>
</html>
