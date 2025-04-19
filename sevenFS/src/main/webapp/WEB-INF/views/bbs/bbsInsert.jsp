<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="title" scope="application" value="게시판 등록" />

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<meta
			name="viewport"
			content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"
	/>
	<meta http-equiv="X-UA-Compatible" content="ie=edge" />
	<title>게시판 등록</title>
	<c:import url="../layout/prestyle.jsp" />
</head>
<c:if test="${not empty errorMessage}">
    <script>
        alert("${errorMessage}");
    </script>
</c:if>
<style>
    .col-sm-12 img {
        width: 100px;
        height: 100px;
    }
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
							<form action="/bbs/bbsInsert" method="post" name="newProduct"
								enctype="multipart/form-data" class="mb-4">
								<!-- 게시글 제목 -->
								<div class="mb-3">
									<label class="form-label">제목</label> 
									<input style="max-width: 500px;" type="text" name="bbscttSj" class="form-control" placeholder="제목을 입력해 주세요." required>
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
								<a href="javascript:history.back();" class="btn btn-outline-secondary">취소</a>&nbsp;
								<button id="submitBtn" type="submit" class="btn btn-outline-primary">추가</button>
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
	ClassicEditor
	  .create(document.querySelector("#descriptionTemp"), {
	    ckfinder: {
	      uploadUrl: "/bbs/upload"
	    }
	  })
	  .then(editor => {
	    window.editor = editor;
	  })
	  .catch(err => {
	    console.error(err.stack);
	  });
	
	$(function () {
	  // 실제 내용만 추출해서 공백만 있는 경우 걸러냄
	  function cleanText(html) {
	    return html
	      .replace(/<[^>]*>/g, '')      // 태그 제거
	      .replace(/&nbsp;/g, '')       // &nbsp 제거
	      .replace(/\s+/g, '')          // 공백 문자 제거
	      .trim();
	  }
	
	  function updateContent() {
	    const rawHtml = window.editor.getData();
	    const clean = cleanText(rawHtml); // 텍스트 판단용
	    const htmlTrimmed = rawHtml.trim(); // 저장용
	
	    if (clean === "") {
	      console.warn("실제 내용 없음 (공백만 존재)");
	      // 필요 시 alert 띄우기
	      // Swal.fire({ icon: 'warning', title: '내용 없음', text: '본문을 입력해 주세요.' });
	    }
	
	    $("#content").val(htmlTrimmed); // 최종 저장할 HTML
	    console.log("저장될 내용 (HTML):", htmlTrimmed);
	    console.log("실제 텍스트만:", clean);
	  }
	
	  $(".ck-blurred").on("input", updateContent);
	  $(".ck-blurred").on("focusout", updateContent);
	});
	
	$("#submitBtn").on("click", function (e) {
		  const rawHtml = window.editor.getData();
		  const cleanedText = cleanText(rawHtml);

		  if (cleanedText === '') {
		    e.preventDefault(); // 전송 막기
		    Swal.fire({
		      icon: 'warning',
		      title: '내용 없음',
		      text: '본문을 입력해주세요!'
		    });
		    return;
		  }

		  $("#content").val(rawHtml.trim());
		  $("#yourForm").submit();
		});




</script>
</body>
</html>
