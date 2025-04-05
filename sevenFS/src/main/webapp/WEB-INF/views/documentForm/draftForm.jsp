<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="card">
    <div class="card-body" id="draftForm">
        <!-- 기안서 제목 -->
        <div style="text-align: center; font-size: 1.8em; font-weight: bold; padding: 20px;">
            기안서
        </div>
        <!-- 제목 입력 -->
        <div style="padding: 50px 10px 20px; clear: both;">
            <div style="display: inline-block; font-size: 1.2em; font-weight: bold;">제목:</div>
            <input type="text" class="form-control" style="display: inline-block; width: 90%; margin-left: 5px;" id="s_dr_tt" required>
        </div>

        <div style="border: 1px solid lightgray; margin: 10px;"></div>

        <div style="margin: 0 10px;">
            <!-- 상세 내용 -->
            <div style="padding: 10px 0;">
                <div>상세내용</div>
                <textarea class="form-control s_scroll" style="resize: none; height: 250px;" id="s_dr_co" required></textarea>
            </div>
        </div>
    </div>
</div>


</body>
</html>