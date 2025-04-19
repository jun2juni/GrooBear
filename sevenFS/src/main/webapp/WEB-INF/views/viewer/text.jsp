<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>텍스트 미리보기</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      background-color: #1e1e1e;
      color: #fff;
      font-family: 'Consolas', 'Courier New', monospace;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      flex-direction: column;
    }
    
    .text-preview-container {
      background-color: #2d2d2d;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
      max-width: 90%;
      width: 800px;
    }
    
    textarea {
      width: 100%;
      height: 500px;
      resize: none;
      background-color: #1e1e1e;
      color: #dcdcdc;
      border: 1px solid #444;
      border-radius: 6px;
      font-size: 14px;
      line-height: 1.6;
      padding: 12px;
      box-sizing: border-box;
      overflow: auto;
      white-space: pre-wrap;
      word-break: break-word;
    }
    
    .filename {
      margin-bottom: 10px;
      color: #999;
      font-size: 14px;
      text-align: left;
    }
  </style>
</head>
<body>
<div class="text-preview-container">
  <div class="filename">${fileName}</div>
  <textarea readonly>${text}</textarea>
</div>
</body>
</html>
