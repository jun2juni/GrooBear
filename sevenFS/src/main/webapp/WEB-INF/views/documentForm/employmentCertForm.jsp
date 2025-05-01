<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <div class="s_div_container" style="height: 600px; padding: 20px;">
        <div style="text-align: center; font-size: 1.8em; font-weight: bold; padding: 10px;">재직증명서</div>
    
        <!-- 인적사항 -->
        <div style="margin-top: 20px;">
            <table style="width: 100%; border: 1px solid #000; border-collapse: collapse;">
                <tr>
                    <th style="width: 20%; border: 1px solid #000; padding: 8px;">성명 (한글)</th>
                    <td style="width: 30%; border: 1px solid #000; padding: 8px;">${empVO.emplNm}</td>
                    <th style="width: 20%; border: 1px solid #000; padding: 8px;">주민등록번호</th>
                    <td style="width: 30%; border: 1px solid #000; padding: 8px;">${empVO.regNo}</td>
                </tr>
                <tr>
                    <th style="border: 1px solid #000; padding: 8px;">주소</th>
                    <td colspan="3" style="border: 1px solid #000; padding: 8px;">${empVO.address}</td>
                </tr>
            </table>
        </div>
    
        <!-- 재직사항 및 제출용도 -->
        <div style="margin-top: 20px;">
            <table style="width: 100%; border: 1px solid #000; border-collapse: collapse;">
                <tr>
                    <th style="width: 20%; border: 1px solid #000; padding: 8px;">근무부서</th>
                    <td style="width: 30%; border: 1px solid #000; padding: 8px;">${empVO.deptNm}</td>
                    <th style="width: 20%; border: 1px solid #000; padding: 8px;">직위</th>
                    <td style="width: 30%; border: 1px solid #000; padding: 8px;">${empVO.position}</td>
                </tr>
                <tr>
                    <th style="border: 1px solid #000; padding: 8px;">재직기간</th>
                    <td colspan="3" style="border: 1px solid #000; padding: 8px;">
                        ${empVO.startDate} ~ ${empVO.endDate}
                    </td>
                </tr>
                <tr>
                    <th style="border: 1px solid #000; padding: 8px;">제출용도</th>
                    <td colspan="3" style="border: 1px solid #000; padding: 8px;">${empVO.purpose}</td>
                </tr>
            </table>
        </div>
    
        <!-- 확인 문구 -->
        <div style="text-align: center; margin-top: 30px;">
            위의 기재사항이 사실과 다름없음을 증명합니다.
        </div>
    
        <!-- 날짜 및 회사 정보 -->
        <div style="text-align: center; margin-top: 30px;">
            <div style="margin-bottom: 20px;">${currentDate} (예: 2025년 05월 01일)</div>
            <div style="line-height: 1.8;">
                회사명 : ${company.name}<br />
                대표자 : ${company.ceo} (인)<br />
                사업자등록번호 : ${company.bizNo}<br />
                주소 : ${company.address}<br />
                전화 : ${company.tel}
            </div>
        </div>
    </div>
</body>
</html>