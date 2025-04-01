<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="메인" />

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
 	<meta name="viewport"
		  content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"/>
	<meta http-equiv="X-UA-Compatible" content="ie=edge" />
	<title>${title}</title>
  <%@ include file="../layout/prestyle.jsp" %>
</head>
<style>
/* 제목, 내용 글씨 크기 */
.s_frm_title {
	font-size: 1em;
	font-weight: bold;
	padding: 5px 0;
}
/* 버튼 작게만들기 */
.approvalBtn {
	color: white;
	--bs-btn-padding-y: .25rem;
	--bs-btn-padding-x: .5rem;
	--bs-btn-font-size: .75rem;
}
/* 버튼 공간 마진 */
#approvalBtn {
	margin: 10px;
}
</style>
<body>
<%@ include file="../layout/sidebar.jsp" %>
<main class="main-wrapper">
  <%@ include file="../layout/header.jsp" %>
	<section class="section">
		<div class="container-fluid">
			<!-- 여기서 작업 시작 -->
			<div class="row">
					<div class="col-sm-12 mb-3 mb-sm-0">
						<!-- 결재요청 | 임시저장 | 결재선지정 | 취소  -->
						<div class="col card-body" id="approvalBtn">
							<span><a id="s_eap_app" href="#" type="submit" onclick="document.getElementById('draftInsert').submit();"
								class="btn btn-default approvalBtn"
								style="background-color: #365CF5;">결재요청</a></span>
							<!-- 임시저장시 어떻게 쿼리가 날라갈지랑, 어떻게 화면전환될것인가??? 데이터 저장은 어떻게 해? -->
							<span><a id="s_eap_stor" href="#" class="btn btn-default approvalBtn"
								style="background-color: #00C1F8;">임시저장</a></span> 
							<span><a id="s_appLine_btn" href="#" data-bs-toggle="modal" data-bs-target="#atrzLineModal"
								class="btn btn-default approvalBtn" style="background-color: #F7C800;">결재선 지정</a></span> 
							<span><a id="s_cancel_btn" class="btn btn-default approvalBtn"
								style="background-color: #D50100;" href="/atrz/home"
								onclick="eapHome()">취소</a></span>
						</div>
	<!-- 모달창 인포트 -->
	<c:import url="../documentForm/approvalLineModal.jsp" />
						<form action="/atrz/draft/insert" method="post" id="draftInsert">
						<div class="card">
							<div class="card-body" id="draftForm">
								<!-- 여기다가 작성해주세요(준희) -->
								<!-- 양식이름 -->
								<div
									style="text-align: center; font-size: 1.8em; font-weight: bold; padding: 20px;">기안서</div>
								<!-- 여기다가 작성해주세요(준희) -->
								<div id="drafterInfo"
									style="float: left; width: 230px; margin: 0 30px;">
									<table border="1" id="s_eap_draft_info">
										<tbody>
											<tr>
												<th>기안자</th>
												<td></td>
											</tr>
											<tr>
												<th>기안부서</th>
												<td></td>
											</tr>
											<tr>
												<th>기안일</th>
												<td></td>
											</tr>
											<tr>
												<th>문서번호</th>
												<td id="s_dfNo"></td>
											</tr>
										</tbody>
									</table>
								</div>
								<div id="drafterPeo"
									style="float: left; width: 130px; margin-right: 10px;">
									<table border="1" id="s_eap_draft">
										<tbody>
											<tr>
												<th rowspan="2">신청</th>
												<td></td>
											</tr>
											<tr>
												<td></td>
											</tr>
										</tbody>
									</table>
								</div>
								<!-- 제목 -->
								<div style="padding: 50px 10px 20px; clear: both;">
									<div
										style="display: inline-block; font-size: 1.2em; font-weight: bold;">제목:</div>
									<input type="text" class="form-control"
										style="display: inline-block; width: 90%; margin-left: 5px;"
										id="s_dr_tt" required="required" name="title" />
								</div>
								<div style="border: 1px solid lightgray; margin: 10px;"></div>
								<div style="margin: 0 10px;">

									<div style="padding: 10px 0;">
										<!-- 							<div style="display: inline-block; font-size: 1.2em; font-weight: bold;" class="">상세내용</div> -->
										<div class="">상세내용</div>
										<!-- 							여기에 ckeditor사용하면 될듯 -->
										<textarea class="form-control s_scroll"
											style="resize: none; height: 250px;" id="s_dr_co"
											required="required" rows="2" cols="20" wrap="hard" name="content"></textarea>
									</div>



									<div style="padding: 10px 0;">
										<div class="s_frm_title">파일첨부</div>
										<div id="s_file_upload">
											<input type="file" id="eap_file_path">
										</div>
										<input type="hidden" name="fileUrl" id="fileUrl">
									</div>
								</div>

								<!-- 여기다가 작성해주세요(준희) -->


							</div>
						</div>
						</form>
					</div>
				</div>
			<!-- 여기서 작업 끝 -->
			
		 
		</div>
	</section>
  <%@ include file="../layout/footer.jsp" %>
</main>
<%@ include file="../layout/prescript.jsp" %>
</body>
</html>
