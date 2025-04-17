<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="title" scope="application" value="게시글 상세" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>${title}</title>
<c:import url="../layout/prestyle.jsp" />
<script>
    const loginUserEmplNo = "${myEmpInfo.emplNo}";
</script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

</head>
<c:if test="${not empty errorMessage}">
    <script>
        alert("${errorMessage}");
    </script>
</c:if>
<style>
    
    
    
    
</style>
<body>
	<c:import url="../layout/sidebar.jsp" />
	<main class="main-wrapper">
		<c:import url="../layout/header.jsp" />

		<section class="section">
  <div class="container-fluid">
    <div class="row">
      <div class="col-12">
        <div class="card-style p-4">

          <form action="/bbs/bbsUpdate" method="get">
            <input type="hidden" name="bbsSn" value="${bbsVO.bbsSn}">
            <input type="hidden" name="bbsCtgryNo" value="${bbsVO.bbsCtgryNo}">

            <!-- 게시글 본문 -->
            <div class="mb-4">
              <h3 class="mb-3 text-dark fw-bold">${bbsVO.bbscttSj}</h3>
              <div class="text-muted mb-3">
                <small>
                  작성자: ${bbsVO.emplNm} · 작성일: ${fn:substring(bbsVO.bbscttCreatDt, 0, 10)}
                </small>
              </div>
              <div class="mb-3">
                <p class="text-body">${bbsVO.bbscttCn}</p>
              </div>

              <!-- 첨부파일 -->
              <div class="mb-3">
                <h6 class="text-secondary fw-bold">📎 첨부파일</h6>
                <c:if test="${not empty bbsVO.files}">
                  <div class="d-flex flex-wrap gap-3 mt-2">
                    <c:forEach var="file" items="${bbsVO.files}">
                      <c:set var="ext" value="${fn:toLowerCase(fn:substringAfter(file.fileNm, '.'))}" />
                      <c:choose>
                        <c:when test="${ext == 'jpg' || ext == 'jpeg' || ext == 'png' || ext == 'gif' || ext == 'bmp'}">
                          <div class="border rounded p-3 bg-light d-inline-flex flex-column align-items-center" style="max-width: 200px;">
							    <img src="/upload/${file.fileStrePath}" 
							         alt="${file.fileNm}" 
							         style="max-width: 150px; max-height: 150px; object-fit: cover;" />
							
							    <div class="mt-2 text-truncate w-100 text-center" style="max-width: 180px;" title="${file.fileNm}">
							        ${file.fileNm}
							    </div>
							</div>
                        </c:when>
                        <c:otherwise>
                          <div class="border p-2 rounded bg-light">
                            <a href="http://localhost/download?fileName=${file.fileStrePath}" class="text-decoration-none text-primary">
                              <i class="bi bi-file-earmark-text"></i> ${file.fileNm}
                            </a>
                          </div>
                        </c:otherwise>
                      </c:choose>
                    </c:forEach>
                  </div>
                </c:if>
                <c:if test="${empty bbsVO.files}">
                  <p class="text-muted">첨부파일이 없습니다.</p>
                </c:if>
              </div>

              <!-- 좋아요 버튼 -->
              <div class="d-flex align-items-center gap-2 mt-4">
                <i id="likeIcon" class="bi bi-hand-thumbs-up fs-3 text-secondary" onclick="toggleLike()" style="cursor: pointer;"></i>
				<span id="likeCount">${bbsVO.likeCnt}</span>
              </div>
            </div>

            <!-- 하단 버튼 -->
            <div class="d-flex justify-content-between">
              <a href="javascript:history.back();" class="btn btn-outline-secondary">← 목록</a>

              <c:if test="${myEmpInfo.emplNo == bbsVO.emplNo || myEmpInfo.emplNo == '20250000'}">
                <div class="d-flex gap-2">
                  <button type="submit" class="btn btn-outline-warning">수정</button>
                  <button type="button" class="btn btn-outline-danger" onclick="bbsDelete(${bbsVO.bbsSn})">삭제</button>
                </div>
              </c:if>
            </div>
          </form>

          <!-- 댓글 영역 -->
          <div class="card-style mt-5">
            <h5 class="text-primary mb-3">💬 댓글</h5>
            <div>
              <textarea id="answerCn" rows="3" class="form-control" placeholder="댓글을 입력하세요."></textarea>
              <div class="d-flex justify-content-end mt-2">
                <button type="button" class="btn btn-primary btn-sm" onclick="submitComment()">댓글 등록</button>
              </div>
            </div>

            <div id="answerContent" class="mt-4">
              <%-- AJAX로 댓글 목록 들어올 영역 --%>
            </div>
          </div>

        </div>
      </div>
    </div>
  </div>
</section>

		<c:import url="../layout/footer.jsp" />
	</main>

	<c:import url="../layout/prescript.jsp" />
	<!-- 삭제 폼 -->
	<script>
	
	// 좋아용
	const bbsSn = ${bbsVO.bbsSn};
	const bbsCtgryNo = ${bbsVO.bbsCtgryNo};

	function toggleLike() {
	    $.post("/bbs/like/toggle", {
	        bbsSn: bbsSn,
	        bbsCtgryNo: bbsCtgryNo
	    }, function (res) {
	        if (res.liked) {
	            $("#likeBtn").addClass("text-warning");
	        } else {
	            $("#likeBtn").removeClass("text-warning");
	        }
	        $("#likeCount").text(res.likeCount);
	    }).fail(function (xhr) {
	        console.error("좋아요 처리 실패:", xhr.responseText);
	    });
	}

	// 페이지 진입 시 현재 좋아요 상태 확인해서 버튼 상태 적용
	$(document).ready(function () {
	    $.get("/bbs/like/exists", {
	        bbsSn: bbsSn,
	        bbsCtgryNo: bbsCtgryNo
	    }, function (liked) {
	        if (liked) {
	            $("#likeBtn").addClass("text-danger");
	        }
	    });
	});
	
	
	

    
	// 댓글 등록
	function submitComment() {
		console.log("댓굴 등록 실행");
	    const answerCn = $("#answerCn").val().trim();  // 앞뒤 공백 제거
	
	    if (!answerCn) {
	        alert("댓글 내용을 입력해주세요.");
	        $("#answerCn").focus();
	        return;
	    }
	
	    $.ajax({
	        type: "POST",
	        url: "/bbs/answer",
	        data: {
	            bbsSn: ${bbsVO.bbsSn},
	            bbsCtgryNo: ${bbsVO.bbsCtgryNo},
	            answerCn: answerCn,
	        },
	        success: function(response) {
	            console.log("댓글 등록 성공");
	            $("#answerCn").val(""); // 입력창 비우기
	            loadAnswer(); // 댓글 목록 새로고침
	        },
	        error: function(xhr) {
	            console.error("댓글 등록 실패:", xhr.responseText);
	        }
	    });
	}
	
	// 댓글 목록 불러오기
	function loadAnswer() {
	    $.ajax({
	        url: "/bbs/answer",
	        type: "GET",
	        data: {
	            bbsSn: ${bbsVO.bbsSn},
	            bbsCtgryNo: ${bbsVO.bbsCtgryNo}
	        },
	        
	        success: function(data) {
	            console.log("댓글 데이터:", data);
	            let html = "";
	            data.forEach(function(answer) {
	                console.log("각 댓글:", answer); // 실제 데이터 확인
	                const formattedDate = formatDate(answer.answerCreatDt); // ← 여기서 먼저 포맷
	                html += `
	                    <div class="card mb-3">
	                        <div class="card-body">
	                            <div class="d-flex justify-content-between align-items-center mb-2">
	                                <h6 class="mb-0 fw-bold text-primary">` + answer.emplNm + `</h6>
	                                <small class="text-muted">` + formatDate(answer.answerCreatDt) + `</small>
	                            </div>
	                            <p class="card-text" id="answerCn-` + answer.answerNo + `">` + answer.answerCn + `</p>
	                `;

	                // 댓글 작성자일 때만 버튼 보여주기 
	                if (answer.emplNo == loginUserEmplNo) {
					    // 내가 쓴 댓글이면 수정 + 삭제
					    html += `
					        <div class="mt-2 d-flex justify-content-end">
					            <button class="btn btn-outline-warning me-2"
					                    onclick="editAnswer(` + answer.answerNo + `)">수정</button>
					            <button class="btn btn-outline-danger me-2"
					                    onclick="deleteAnswer(` + answer.answerNo + `)">삭제</button>
					        </div>
					    `;
					} else if (loginUserEmplNo == '20250000') {
					    // 관리자지만 내가 쓴 댓글은 아님 → 삭제만
					    html += `
					        <div class="mt-2 d-flex justify-content-end">
					            <button class="btn btn-outline-danger me-2"
					                    onclick="deleteAnswer(` + answer.answerNo + `)">삭제</button>
					        </div>
					    `;
					}


	                html += `
	                        </div>
	                    </div>
	                `;



	                console.log("서버에서 온 날짜:", answer.answerCreatDt);
	                console.log("포맷한 날짜:", formatDate(answer.answerCreatDt));
	            });
	            
	            console.log("최종 HTML:", html);
	            $("#answerContent").html(html);
	        }
,
	        error: function(xhr) {
	            console.error("댓글 불러오기 실패:", xhr.responseText);
	        }
	    });
	}
	
	$(document).ready(function() {
	    loadAnswer();  // 페이지 들어오면 바로 댓글 가져오게
	});
	
	
	// 댓글 수정
	function editAnswer(answerNo) {
	    const currentText = $(`#answerCn-${answerNo}`).data("content");  // or use .text() or .html() if 안 쓰면
	    const newText = prompt("댓글을 수정하세요", currentText);
	
	    if (newText && newText.trim()) {
	        $.ajax({
	            type: "POST",
	            url: "/bbs/answer/update",
	            data: {
	                answerNo: answerNo,
	                answerCn: newText.trim()
	            },
	            success: function () {
	                alert("댓글이 수정되었습니다.");
	                loadAnswer();
	            },
	            error: function (xhr) {
	                alert("댓글 수정 실패: " + xhr.responseText);
	            }
	        });
	    }
	}


	
	// 댓글 삭제
	function deleteAnswer(answerNo) {
		if (confirm("댓글을 삭제하시겠습니까?")) {
			$.ajax({
				type: "POST",
				url: "/bbs/answer/delete",
				data: { answerNo: answerNo },
				success: function () {
					alert("댓글이 삭제되었습니다.");
					loadAnswer();
				},
				error: function (xhr) {
					alert("댓글 삭제 실패: " + xhr.responseText);
				}
			});
		}
	}

	function bbsDelete(bbsSn) {
	    if (confirm("정말 삭제하시겠습니까?")) {
	        $.ajax({
	            url: "/bbs/bbsDelete",
	            type: "POST",
	            data: { bbsSn: bbsSn },
	            success: function (res) {
	                window.location.href = "/bbs/bbsList?bbsCtgryNo=" + bbsCtgryNo;
	            },
	            error: function (xhr) {
	                alert("삭제 실패: " + xhr.responseText);
	            }
	        });
	    }
	}



	</script>

		
</body>
</html>
