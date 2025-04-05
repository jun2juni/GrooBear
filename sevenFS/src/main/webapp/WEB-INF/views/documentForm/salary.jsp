<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>급여명세서</title>
    <script>
        function calculateDeductions() {
            let salary = parseFloat(document.getElementById("salary").value) || 0;
            
            // 소득세 계산 (2025년 기준 누진세율 적용 - 간략화된 예제)
            let incomeTax = 0;
            if (salary <= 14000000) incomeTax = salary * 0.06;
            else if (salary <= 50000000) incomeTax = 14000000 * 0.06 + (salary - 14000000) * 0.15;
            else if (salary <= 88000000) incomeTax = 50000000 * 0.15 + (salary - 50000000) * 0.24;
            else if (salary <= 150000000) incomeTax = 88000000 * 0.24 + (salary - 88000000) * 0.35;
            else incomeTax = 150000000 * 0.35 + (salary - 150000000) * 0.38;
            
            let localTax = incomeTax * 0.1; // 지방소득세 (소득세의 10%)
            let pension = salary * 0.045; // 국민연금 (4.5%)
            let healthInsurance = salary * 0.03545; // 건강보험 (7.09%의 절반)
            let longTermCare = healthInsurance * 0.1281; // 장기요양보험 (건강보험의 12.81%)
            let employmentInsurance = salary * 0.009; // 고용보험 (0.9%)
            
            let totalDeductions = incomeTax + localTax + pension + healthInsurance + longTermCare + employmentInsurance;
            let netSalary = salary - totalDeductions;
            
            document.getElementById("incomeTax").innerText = incomeTax.toLocaleString();
            document.getElementById("localTax").innerText = localTax.toLocaleString();
            document.getElementById("pension").innerText = pension.toLocaleString();
            document.getElementById("healthInsurance").innerText = healthInsurance.toLocaleString();
            document.getElementById("longTermCare").innerText = longTermCare.toLocaleString();
            document.getElementById("employmentInsurance").innerText = employmentInsurance.toLocaleString();
            document.getElementById("netSalary").innerText = netSalary.toLocaleString();
        }
    </script>
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
