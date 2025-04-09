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
</style>
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
                            <h2 class="text-primary text-center">게시글 수정</h2>
                            <form action="/bbs/bbsUpdate" method="post" enctype="multipart/form-data">
                            	<input type="hidden" name="emplNo" value="${myEmpInfo.emplNo}">
                                <input type="hidden" name="bbsSn" value="${bbsVO.bbsSn}">
                                <input type="hidden" value="${bbsVO.bbsCtgryNo}" name="bbsCtgryNo">
                                <div>
                                    제목
                                    <input type="text" name="bbscttSj" value="${bbsVO.bbscttSj}" class="form-control" />
                                </div>
                                <br>
                                <div class="col-sm-12">
                                    내용
                                    <div id="descriptionTemp">${bbsVO.bbscttCn}</div>
                                    <textarea id="content" name="bbscttCn" rows="3" cols="30" class="form-control" hidden>${bbsVO.bbscttCn}</textarea>
                                </div>
                                <br>
                                <div>
                                    작성자
                                    <input type="text" name="emplName" value="${myEmpInfo.emplNm}" class="form-control" readonly/>
                                </div>
                                <br>
                                <div>
                                    파일
                                    <c:choose>
    								<c:when test="${not empty bbsVO.files}">
                                        <c:forEach var="file" items="${bbsVO.files}">
											<file-upload
													label="${file.fileStreNm}"
													name="updateFile"
													max-files="5"	
													contextPath="${pageContext.request.contextPath}"
													uploaded-file="${file}"
													atch-file-no="${bbsVO.atchFileNo}"
											></file-upload>
										</c:forEach>
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
								<div class="mb-3">
									<label class="form-label">상단 고정 여부</label>
									<select name="upendFixingYn" class="form-control">
										<option value="Y">고정</option>
										<option value="N">고정 안함</option>
									</select>
								</div>
								<br>
                                <div>
                                    <button type="submit" class="btn btn-warning">확인</button> &nbsp;
                                    <a href="/bbs/bbsDetail?bbsSn=${bbsVO.bbsSn}" class="btn btn-secondary">취소</a>
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
        // CKEditor5 적용
        ClassicEditor.create(document.querySelector("#descriptionTemp"), {
            ckfinder: { uploadUrl: "/bbs/image/upload" }
        })
        .then(editor => { window.editor = editor; })
        .catch(err => { console.error(err.stack); });
        
        $(function(){
            $(".ck-blurred").keydown(function(){
                 $("#content").val(window.editor.getData());
            });
            $(".ck-blurred").on("focusout", function(){
                 $("#content").val(window.editor.getData());
            });
        });
    </script>
</body>
</html>
