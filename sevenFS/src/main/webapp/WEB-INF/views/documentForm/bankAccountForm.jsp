<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <title>급여통장변경신청서</title> -->
</head>
<body>
    <div class="s_div_container" style="height: 800px;">
		<div style="text-align: center; font-size: 2em; font-weight: bold; padding: 20px;">급여통장변경 신청서</div>
        <div style="padding: 10px 10px 10px; clear: both;">
            <div style="display: inline-block; font-size: 1.2em; font-weight: bold;"  >제목 : </div> 
            <input type="text" class="form-control" style="display: inline-block; width: 583px; margin-left: 5px;" readonly/>
        </div>
			
        <div style="border: 1px solid lightgray; margin: 10px;"></div>
            <div style="margin: 0 10px;">
                <div class="row align-items-start" style="padding: 10px 0;">
                    <div class="col-auto">
                    </div>
                </div>
            <div>
                <div class="row mb-3">
                    <div class="col-md-3">
                        <label class="form-label">이름</label>
                        <input type="text" class="form-control" name="emplNm" id="emplNm" disabled>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">사번</label>
                        <input type="text" class="form-control" name="emplNo" id="emplNo" disabled>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">기존 은행명</label>
                        <input type="text" class="form-control" name="oldBank" id="oldBank" disabled>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">기존 계좌번호</label>
                        <input type="text" class="form-control" name="oldAccNo" id="oldAccNo" disabled>
                    </div>
                </div>
                <hr>
                <h6>기존 계좌 정보</h6>
                <!-- 기존 은행명 + 기존 계좌번호 -->
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">기존 은행명</label>
                        <input type="text" class="form-control" name="old_bank_name" readonly>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">기존 계좌번호</label>
                        <input type="text" class="form-control" name="old_account_num" readonly>
                    </div>
                </div>
                <hr>
                <h6>변경할 계좌 정보</h6>
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">새로운 은행명</label>
                        <input type="text" class="form-control" name="new_bank_name" readonly>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">새로운 계좌번호</label>
                        <input type="text" class="form-control" name="new_account_num" readonly>
                    </div>
                </div>
                </div>
                <div class="mb-3">
                    <label class="form-label">변경 사유</label>
                    <textarea class="form-control" name="reason" rows="3" readonly style="height: 145px;"></textarea>
                </div>
            </div>
        </div>
	</div>
</body>
</html>