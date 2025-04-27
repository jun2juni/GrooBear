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
<div class="s_div_container" style="height: 800px;">
	<div style="text-align: center; font-size: 2em; font-weight: bold; padding: 20px;">급여명세서</div>
	<div id="salaryDetail">
		<div style="padding: 50px 10px 20px; clear: both;">
				<div class="row salary-header text-center">
					<div class="col-6">지급 항목</div>
					<div class="col-6">공제 항목</div>
				</div>
		</div>

		<div style="border: 1px solid lightgray; margin: 10px;"></div>
		
		<div id="salTable">
			<div class="row" >
				<!-- 지급 항목 -->
				<div class="col-md-6" >
					<table class="table table-bordered">
					<tbody>
						<tr>
							<th scope="row" class="text-center align-middle" style="width: 40%;">기본급</th>
							<fmt:formatNumber value="${atrzVO.salaryVO.baseSalary}" pattern="#,###원" var="baseSalary" />
							<td class="text-end salEnd" id="baseSalary" style="padding-right: 20px;">${baseSalary}</td>
						</tr>
						<tr>
							<th scope="row" class="text-center align-middle" style="width: 40%;">식대</th>
							<fmt:formatNumber value="${atrzVO.salaryVO.mealAllowance}" pattern="#,###원" var="mealAllowance" />
							<td class="text-end salEnd" id="mealAllowance" style="padding-right: 20px;" >${mealAllowance}</td>
						</tr>
						<tr>
							<th scope="row" class="bg-light text-center align-middle">총 지급액</th>
							<fmt:formatNumber value="${atrzVO.salaryVO.totalDed}" pattern="#,###원" var="totalDed" />
							<td class="bg-light text-end fw-bold" id="totalDed" style="padding-right: 20px;">${totalDed}</td>
						</tr>
						<tr>
							<th scope="row" class="bg-light text-center align-middle">실 지급액</th>
							<fmt:formatNumber value="${atrzVO.salaryVO.netPay}" pattern="#,###원" var="netPay" />
							<td class="bg-light text-end fw-bold" id="netPay" style="padding-right: 20px;">${netPay}</td>
						</tr>
					</tbody>
					</table>
				</div>
			
				<!-- 공제 항목 -->
				<div class="col-md-6">
					<table class="table table-bordered">
					<tbody>
						<tr>
							<th scope="row" class="text-center align-middle" style="width: 40%;">소득세</th>
							<fmt:formatNumber value="${atrzVO.salaryVO.incomeTax}" pattern="#,###원" var="incomeTax" />
							<td class="text-end salEnd" id="incomeTax" style="padding-right: 20px;" >${incomeTax}</td>
						</tr>
						<tr>
							<th scope="row" class="text-center align-middle">지방소득세</th>
							<fmt:formatNumber value="100000" pattern="#,###" var="mealAllowance" />
							<fmt:formatNumber value="${atrzVO.salaryVO.localTax}" pattern="#,###원" var="localTax" />
							<td class="text-end salEnd" id="localTax" style="padding-right: 20px;" >${localTax}</td>
						</tr>
						<tr>
							<th scope="row" class="text-center align-middle">국민연금</th>
							<fmt:formatNumber value="${atrzVO.salaryVO.pension}" pattern="#,###원" var="pension" />
							<td class="text-end salEnd" id="pension" style="padding-right: 20px;" >${pension}</td>
						</tr>
						<tr>
							<th scope="row" class="text-center align-middle">건강보험</th>
							<fmt:formatNumber value="${atrzVO.salaryVO.healthIns}" pattern="#,###원" var="healthIns" />
							<td class="text-end salEnd" id="healthIns" style="padding-right: 20px;" >${healthIns}</td>
						</tr>
						<tr>
							<th scope="row" class="text-center align-middle">장기요양보험</th>
							<fmt:formatNumber value="${atrzVO.salaryVO.careIns}" pattern="#,###원" var="careIns" />
							<td class="text-end salEnd" id="careIns" style="padding-right: 20px;" >${careIns}</td>
						</tr>
						<tr>
							<th scope="row" class="text-center align-middle">고용보험</th>
							<fmt:formatNumber value="${atrzVO.salaryVO.employmentIns}" pattern="#,###원" var="employmentIns" />
							<td class="text-end salEnd" id="employmentIns" style="padding-right: 20px;" >${employmentIns}</td>
						</tr>
						<tr>
							<th scope="row" class="text-center align-middle bg-light">총 공제액</th>
							<fmt:formatNumber value="${atrzVO.salaryVO.totalPay}" pattern="#,###원" var="totalPay" />
							<td class="bg-light text-end fw-bold" id="totalPay" style="padding-right: 20px;">${totalPay}</td>
						</tr>
					</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>

	
</body>
</html>