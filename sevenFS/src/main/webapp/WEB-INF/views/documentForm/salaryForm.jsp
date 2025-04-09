<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <title>연차신청서 양식</title> -->
<style>
.s_div_container {
    overflow: auto;
}
.salary-table {
    max-width: 900px;
    margin: 30px auto;
    border: 1px solid #dee2e6;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 0 10px rgba(0,0,0,0.05);
}
.salary-header {
    background-color: #f8f9fa;
    font-weight: bold;
}
.table-section {
    padding: 20px;
}
	
	
</style>
</head>
<body>

	<div class="s_div_container salary-table" style="height: 800px;">
		<div style="text-align: center; font-size: 2em; font-weight: bold; padding: 20px;">급여명세서</div>
			<div class="row salary-header text-center">
				<div class="col-6">지급 항목</div>
				<div class="col-6">공제 항목</div>
			</div>
			<div class="row table-section">
				<!-- 좌측: 지급 항목 -->
				<div class="col-6">
				<div class="mb-2">
					<label>기본급</label>
					<input type="number" class="form-control" id="baseSalary" placeholder="기본급 입력">
				</div>
				<div class="mb-2">
					<label>식대</label>
					<input type="number" class="form-control" id="mealAllowance" placeholder="식대 입력">
				</div>
				<div class="mt-3 fw-bold">
					총 지급액: <span id="totalPay">0</span> 원
				</div>
				</div>
			
				<!-- 우측: 공제 항목 -->
				<div class="col-6">
				<ul class="list-group">
					<li class="list-group-item">소득세: <span id="incomeTax">0</span> 원</li>
					<li class="list-group-item">지방소득세: <span id="localTax">0</span> 원</li>
					<li class="list-group-item">국민연금: <span id="pension">0</span> 원</li>
					<li class="list-group-item">건강보험: <span id="healthInsurance">0</span> 원</li>
					<li class="list-group-item">장기요양보험: <span id="longTermCare">0</span> 원</li>
					<li class="list-group-item">고용보험: <span id="employmentInsurance">0</span> 원</li>
					<li class="list-group-item fw-bold">총 공제액: <span id="totalDeductions">0</span> 원</li>
				</ul>
				</div>
			</div>
		</div>
</body>
</html>