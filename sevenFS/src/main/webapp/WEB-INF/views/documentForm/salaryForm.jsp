<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <title>급여명세서</title> -->
</head>
<body>
    <div style="width: 500px; margin: 20px auto; padding: 20px; border: 1px solid #ccc;">
        <h2 style="text-align: center;">급여명세서</h2>
        <label>월 급여 (원): </label>
        <input type="number" id="salary" oninput="calculateDeductions()" placeholder="월급 입력">
        <hr>
        <p>소득세: <span id="incomeTax">0</span> 원</p>
        <p>지방소득세: <span id="localTax">0</span> 원</p>
        <p>국민연금: <span id="pension">0</span> 원</p>
        <p>건강보험료: <span id="healthInsurance">0</span> 원</p>
        <p>장기요양보험: <span id="longTermCare">0</span> 원</p>
        <p>고용보험: <span id="employmentInsurance">0</span> 원</p>
        <hr>
        <h3>실수령액: <span id="netSalary">0</span> 원</h3>
    </div>
</body>
</html>