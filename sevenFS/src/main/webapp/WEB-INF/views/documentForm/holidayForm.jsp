<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <title>연차신청서 양식</title> -->
<style>
	.s_frm_title {
	    font-size: 1em;
	    font-weight: bold;
	    padding: 5px 0;
	}
	
	.s_div_container {
		overflow: auto;
	}
	
	#s_eap_draft_info tr th {
		width: 100px;
	}
	
	#s_eap_draft_info tr th, #s_eap_draft_info tr td,
	#s_eap_draft tr th, #s_eap_draft tr td,
	.s_eap_draft_app tr th, .s_eap_draft_app tr td
	 {
		padding: 5px;
		border: 1px solid;
		font-size: .9em;
	}
	
	#s_eap_draft td, .s_eap_draft_app td {
		width: 100px;
		text-align: center;
	}
	
	#s_eap_draft_info tr th,
	#s_eap_draft tr th,
	.s_eap_draft_app tr th {
		background-color: gainsboro;
		text-align: center;
		
	}
	
	#s_eap_draft tr th,
	.s_eap_draft_app tr th {
		width: 50px;
	}
</style>
</head>
<body>

	<div class="s_div_container" style="height: 800px;">
		<div style="text-align: center; font-size: 2em; font-weight: bold; padding: 20px;">연차신청서</div>
			<div style="padding: 50px 10px 20px; clear: both;">
				<div style="display: inline-block; font-size: 1.2em; font-weight: bold;"  >제목 : </div> 
				<input type="text" class="form-control" style="display: inline-block; width: 583px; margin-left: 5px;" readonly/>
			</div>
			
			<div style="border: 1px solid lightgray; margin: 10px;"></div>
				<div style="margin: 0 10px;">
					<div class="row align-items-start" style="padding: 10px 0;">
						<div class="col-auto">
							<div class="form-check mr-5" style="display: inline-block;">
								<input class="form-check-input" type="radio" name="holiCode" id="flexRadioDefault2" value="B">
								<label class="form-check-label" for="flexRadioDefault2">오전반차</label>
							</div>
							<div class="form-check mr-5" style="display: inline-block;">
								<input class="form-check-input" type="radio" name="holiCode" id="flexRadioDefault2" value="B">
								<label class="form-check-label" for="flexRadioDefault2">오후반차</label>
							</div>
							<div class="s_frm_title mb-2"><b>유형</b></div>
							<div class="form-check mr-5" style="display: inline-block;">
								<input class="form-check-input" type="radio" name="holiCode" id="flexRadioDefault1" checked value="A"> 
								<label class="form-check-label"	for="flexRadioDefault1">연차</label>
							</div>
							<div class="form-check mr-5" style="display: inline-block;">
								<input class="form-check-input" type="radio" name="holiCode" id="flexRadioDefault3" value="C">
								<label class="form-check-label" for="flexRadioDefault3">병가</label>
							</div>
							<div class="form-check mr-5" style="display: inline-block;">
								<input class="form-check-input" type="radio" name="holiCode" id="flexRadioDefault4" value="D">
								<label class="form-check-label" for="flexRadioDefault4">공가</label>
							</div>
						</div>
						
						<!--연차기간 선택 시작-->
					<div class="col ms-4">
						<div class="s_frm_title mb-2"><b>신청기간</b></div>
						<!-- <div style="margin: 5px 0;">
							사용 가능한 휴가일수는 <span id="s_ho_use">${checkHo }</span>일 입니다.
						</div> -->
						<div>
							<input type="text" placeholder="신청 시작 기간을 선택해주세요"
								class="form-control s_ho_start d-inline-block"
								style="width: 250px; cursor: context-menu;"
								id="s_ho_start" required="required" onchange="dateCnt();" name="holiStartArr" readonly/>
						</div>
						<div>
							<input type="text" placeholder="신청 종료 기간을 선택해주세요"
								class="form-control s_ho_end d-inline-block mt-2"
								style="width: 250px; cursor: context-menu;"
								id="s_ho_end" required="required" onchange="dateCnt();" name="holiEndArr" readonly/>
							<div class="d-inline-block" >
								(총 <span id="s_date_cal">0</span>일)
							</div>
						</div>
					</div>	
						<!--연차기간 선택 끝-->
				</div>

				<div style="padding: 10px 0;">
					<div class="s_frm_title mb-2"> 내용</div>
					<textarea class="form-control s_scroll"
						style="resize: none; height: 150px;" id="s_ho_co" name="atrzCn" 
						required="required" rows="2" cols="20" wrap="hard" readonly></textarea>
				</div>
				<div style="padding: 10px 0;">
					<div class="s_frm_title">파일첨부</div>
					<div id="s_file_upload">
						<input type="file" name="uploadFile" id="eap_file_path" multiple readonly/>
					</div>
					<input type="hidden" name="fileUrl" id="fileUrl">
				</div>
			</div>
		</div>
</body>
</html>