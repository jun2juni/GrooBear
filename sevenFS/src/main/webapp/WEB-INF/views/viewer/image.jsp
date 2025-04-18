<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>이미지 미리보기</title>
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

      .image-container {
          background-color: #2a2a2a;
          padding: 20px;
          border-radius: 12px;
          box-shadow: 0 8px 24px rgba(0, 0, 0, 0.4);
          max-width: 90%;
          text-align: center;
      }

      .image-container img {
          max-width: 100%;
          height: auto;
          border-radius: 8px;
          object-fit: contain;
          background-color: #eee;
          transition: transform 0.3s ease;
      }

      .image-container img:hover {
          transform: scale(1.02);
      }

      .image-title {
          margin-top: 12px;
          font-size: 16px;
          color: #aaa;
      }
  </style>
</head>
<body>
<div class="image-container">
  <img src="/upload/${image}" alt="미리보기 이미지">
  <div class="image-title">
	${image}
  </div>
</div>
</body>
</html>
