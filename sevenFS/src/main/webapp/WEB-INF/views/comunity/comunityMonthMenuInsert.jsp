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
	<meta
			name="viewport"
			content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"
	/>
	<meta http-equiv="X-UA-Compatible" content="ie=edge" />
	<title>${title}</title>
	<c:import url="../layout/prestyle.jsp" />
</head>
<style>
    .col-sm-12 img {
        width: 100px;
        height: 100px;
    }
    /* ck-editor 내부의 편집 가능하지만 최초 미니멈 사이즈 높이   */
	.ck-editor__editable {
	    min-height: 300px;
	}
</style>
<body>
<c:import url="../layout/sidebar.jsp" />
<main class="main-wrapper">
	<c:import url="../layout/header.jsp" />
	
	<section class="section">
		<div class="container-fluid">
			<section class="section">
			<div class="container-fluid">

				<div class="row">
					<div class="col-12">
						<div class="card-style">
							<h2 class="text-primary text-center">식단표 등록</h2>
							<form action="/comunity/comunityMonthMenuInsert" method="post" name="newMenuInsert"
								enctype="multipart/form-data" class="mb-4">
								<!-- 게시글 제목 -->
								<div class="col-12 mb-3">
									<label class="form-label">제목</label> 
									<input style="max-width: 1400px;" type="text" name="bbscttSj" class="form-control" placeholder="제목을 입력해 주세요." required>
								</div>
								
								<!-- 작성자 번호 -->
								<input type="hidden" name="emplNo" value="${myEmpInfo.emplNo}">
								<!-- 게시글 내용 (CKEditor) -->
								<div class="col-sm-12">
									<label class="form-label">내용</label>
									<div id="descriptionTemp"></div>
									<textarea id="content" name="bbscttCn" rows="3" cols="30" class="form-control" hidden></textarea>
								</div><br>

								<!-- 작성자 이름 -->
								<div class="mb-3">
									<input type="hidden" name="emplNm" class="form-control" value="${myEmpInfo.emplNm}" readonly>
								</div>

								<!-- 파일 업로드 -->
								<file-upload
									label="메뉴 이미지"
									name="uploadFile"
									max-files="5"
									contextPath="${pageContext.request.contextPath}"
								></file-upload>
								
								<!-- 상단 고정 여부 -->
								<div class="mb-3">
									<label class="form-label">상단 고정 여부</label>
									<select name="upendFixingYn" class="form-control">
										<option value="N">고정 안함</option>
										<option value="Y">고정</option>
									</select>
								</div>
								
								<!-- 카테고리 번호 지정 -->
								<input type="hidden" value="${bbsVO.bbsCtgryNo}" name="bbsCtgryNo">

								<!-- 게시글 추가 버튼 -->
								<button type="submit" class="btn btn-primary">추가</button>
								<a href="/bbs/bbsList?bbsCtgryNo=${bbsVO.bbsCtgryNo}" class="btn btn-secondary">취소</a>
							</form>
						</div>
					</div>
				</div>
			</div>

		</section>
		</div>
	</section>
	<c:import url="../layout/footer.jsp" />
</main>
<c:import url="../layout/prescript.jsp" />
<script type="text/javascript">
	//ckeditor5
	//<div id="descriptionTemp"></div>
	//editor : CKEditor객체를 말함
	ClassicEditor.create(document.querySelector("#descriptionTemp"),{ckfinder:{uploadUrl:"/bbs/upload"}})
				 .then(editor=>{window.editor=editor;})
				 .catch(err=>{console.error(err.stack);});

$(function(){
	$(".ck-blurred").keydown(function(){
		 console.log("str : ", window.editor.getData());
		 $("#content").val(window.editor.getData());
	 })
	$(".ck-blurred").on("focusout",function(){
		 $("#content").val(window.editor.getData());
	 })
});

</script>
</body>
</html>
