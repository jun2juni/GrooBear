<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="title" scope="application" value="게시글 수정" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>${title}</title>
    <script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
		integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ=="
		crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <c:import url="../layout/prestyle.jsp" />
</head>
<style>
    .col-sm-12 img {
        width: 100px;
        height: 100px;
    }
    .ck-editor__editable {
	    min-height: 300px;
	}
</style>
<c:if test="${not empty errorMessage}">
    <script>
        alert("${errorMessage}");
    </script>
</c:if>
<body>
    <c:import url="../layout/sidebar.jsp" />
    <main class="main-wrapper">
        <c:import url="../layout/header.jsp" />
        
        <section class="section">
            <div class="container-fluid">
                <!-- 파일 수정이 되게 하되, 파일이 없다면 새로 추가하는 로직 필요 -->
                <div class="row">
                    <div class="col-12">
                        <div class="card-style">
                            <form action="/bbs/bbsUpdate" method="post" enctype="multipart/form-data">
                            	<input type="hidden" name="emplNo" value="${myEmpInfo.emplNo}">
                                <input type="hidden" name="bbsSn" value="${bbsVO.bbsSn}">
                                <input type="hidden" value="${bbsVO.bbsCtgryNo}" name="bbsCtgryNo">
                                <div>
                                    제목
                                    <input style="max-width: 500px;" type="text" name="bbscttSj" value="${bbsVO.bbscttSj}" class="form-control" />
                                </div>
                                <br>
                                <div class="col-sm-12">
                                    내용
                                    <div id="descriptionTemp">${bbsVO.bbscttCn}</div>
                                    <textarea id="content" name="bbscttCn" rows="3" cols="30" class="form-control" hidden>${bbsVO.bbscttCn}</textarea>
                                </div>
                                <br>
                                <div>
                                    <input type="hidden" name="emplName" value="${bbsVO.emplNm}" class="form-control" readonly/>
                                </div>
                                <br>
                                <div>
                                    파일
                                    <c:choose>
    								<c:when test="${not empty bbsVO.files}">
										<file-upload
												label="첨부파일"
												name="updateFile"
												max-files="5"	
												contextPath="${pageContext.request.contextPath}"
												uploaded-file="${bbsVO.files}"
												atch-file-no="${bbsVO.atchFileNo}"
										></file-upload>
									</c:when>
									<c:otherwise>
								        <!-- 파일이 없을 때 기본 UI -->
								        <file-upload
								            label="파일 추가"
								            name="updateFile"
								            max-files="5"
								            contextPath="${pageContext.request.contextPath}"
								            atch-file-no="${bbsVO.atchFileNo}">
								        </file-upload>
								    </c:otherwise>
									</c:choose>
                                </div>
                                <br>
                                <!-- 상단 고정 여부 -->
								<div class="mb-3 form-check">
  <input type="checkbox" class="form-check-input" id="upendFixingYn" name="upendFixingYn" value="Y"
         <c:if test="${bbsVO.upendFixingYn eq 'Y'}">checked</c:if>>
  <label class="form-check-label" for="upendFixingYn">상단 고정</label>
</div>

								<br>
                                <div>
                                    <a href="javascript:history.back();" class="btn btn-outline-secondary">취소</a>&nbsp;
                                    <button type="submit" class="btn btn-outline-warning">확인</button> 
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <c:import url="../layout/footer.jsp" />
    </main>

    <c:import url="../layout/prescript.jsp" />
    
    <script type="text/javascript">
	  //ckeditor5
	  // <div id="descriptionTemp"></div>
	  // editor : CKEditor 객체를 말함
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
	    // 텍스트만 추출하여 유효성 검사용
	    function cleanText(html) {
	      return html
	        .replace(/<p><br\s*\/?><\/p>/gi, '') // 빈 p 태그 제거
	        .replace(/<[^>]*>/g, '')             // 모든 태그 제거
	        .replace(/&nbsp;/gi, '')             // &nbsp 제거
	        .replace(/\u200B/g, '')              // zero-width space 제거
	        .replace(/\s+/g, '')                 // 기타 공백 제거
	        .trim();
	    }
	
	    // 저장용: 앞뒤 불필요한 빈 단락 제거 (공백 p, br, &nbsp)
	    function cleanHtml(html) {
	      return html
	        .replace(/^(?:\s*<p>(&nbsp;|<br\s*\/?>|\s)*<\/p>\s*)+/gi, '') // 앞쪽
	        .replace(/(?:\s*<p>(&nbsp;|<br\s*\/?>|\s)*<\/p>\s*)+$/gi, '') // 뒤쪽
	        .trim();
	    }
	
	    function updateContent() {
	      const rawHtml = window.editor.getData();
	      const cleanedText = cleanText(rawHtml);   // 텍스트만 추출 (검사용)
	      const cleanedHtml = cleanHtml(rawHtml);   // 저장할 HTML
	
	      if (cleanedText === "") {
	        console.warn("실제 내용 없음 (공백만 존재)");
	        // 필요 시 alert 띄우기
	        // Swal.fire({ icon: 'warning', title: '내용 없음', text: '본문을 입력해 주세요.' });
	      }
	
	      $("#content").val(cleanedHtml); // 최종 저장할 HTML
	      console.log("저장될 내용 (HTML):", cleanedHtml);
	      console.log("실제 텍스트만:", cleanedText);
	    }
	
	    $(".ck-blurred").on("input", updateContent);
	    $(".ck-blurred").on("focusout", updateContent);
	  });
	
	  // 제출 버튼 클릭 시
	  $("#submitBtn").on("click", function (e) {
	    const rawHtml = window.editor.getData();
	    const cleanedText = cleanText(rawHtml);
	    const cleanedHtml = cleanHtml(rawHtml);
	
	    if (cleanedText === '') {
	      e.preventDefault(); // 전송 막기
	      Swal.fire({
	        icon: 'warning',
	        title: '내용 없음',
	        text: '본문을 입력해주세요!'
	      });
	      return;
	    }
	
	    $("#content").val(cleanedHtml); // 앞뒤 공백 제거된 HTML 저장
	    $("#yourForm").submit();
	  });
	</script>

</body>
</html>
