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
        <div style="text-align: center; font-size: 1.8em; font-weight: bold; padding: 10px;">퇴사신청서</div>
    
        <!-- 인적사항 -->
        <div style="margin-top: 20px;">
            <table style="width: 100%; border: 1px solid #000; border-collapse: collapse;">
                <tr>
                    <th style="width: 20%; border: 1px solid #000; padding: 8px;">성명</th>
                    <td style="width: 30%; border: 1px solid #000; padding: 8px;">${empVO.emplNm}</td>
                    <th style="width: 20%; border: 1px solid #000; padding: 8px;">사번</th>
                    <td style="width: 30%; border: 1px solid #000; padding: 8px;">${empVO.emplId}</td>
                </tr>
                <tr>
                    <th style="border: 1px solid #000; padding: 8px;">부서</th>
                    <td style="border: 1px solid #000; padding: 8px;">${empVO.deptNm}</td>
                    <th style="border: 1px solid #000; padding: 8px;">직위</th>
                    <td style="border: 1px solid #000; padding: 8px;">${empVO.position}</td>
                </tr>
            </table>
        </div>
    
        <!-- 퇴사정보 -->
        <div style="margin-top: 20px;">
            <table style="width: 100%; border: 1px solid #000; border-collapse: collapse;">
                <tr>
                    <th style="width: 20%; border: 1px solid #000; padding: 8px;">퇴사예정일</th>
                    <td style="width: 80%; border: 1px solid #000; padding: 8px;">${empVO.resignDate}</td>
                </tr>
                <tr>
                    <th style="border: 1px solid #000; padding: 8px;">퇴사사유</th>
                    <td style="border: 1px solid #000; padding: 8px;">${empVO.resignReason}</td>
                </tr>
                <tr>
                    <th style="border: 1px solid #000; padding: 8px;">인수인계 여부</th>
                    <td style="border: 1px solid #000; padding: 8px;">${empVO.handoverStatus}</td>
                </tr>
            </table>
        </div>
    
        <!-- 확인 문구 -->
        <div style="text-align: center; margin-top: 30px;">
            위와 같이 퇴사를 신청합니다.
        </div>
    
        <!-- 서명 및 날짜 -->
        <div style="text-align: right; margin-top: 40px; margin-right: 30px;">
            <div>작성일 : ${currentDate}</div>
            <div style="margin-top: 20px;">
                신청인 : ${empVO.emplNm} (서명)
            </div>
        </div>
    </div>
</body>
</html>