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
</head>
<style>
    img {
        width: 100px;
        height: 100px;
    }
    
    .board-detail {
        max-width: 100%;
        margin: 20px auto;
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 8px;
        background-color: #f9f9f9;
    }
    .board-detail div {
        padding: 10px 0;
        border-bottom: 1px solid #ddd;
    }
    .board-detail div:last-child {
        border-bottom: none;
    }
    .board-detail p {
        margin: 5px 0;
        font-weight: bold;
    }
</style>
<body>
	<c:import url="../layout/sidebar.jsp" />
	<main class="main-wrapper">
		<c:import url="../layout/header.jsp" />

		<section class="section">
			<div class="container-fluid">

				<div class="row">
					<div class="col-12">
						<div class="card-style">
							<h2 class="text-primary text-center">게시글 상세</h2>
							<p>${bbsVO.bbsSn} 번</p><br>
							<form action="/bbs/bbsUpdate" method="get">
								<input type="hidden" name="bbsSn" value="${bbsVO.bbsSn}">
								<input type="hidden" value="${bbsVO.bbsCtgryNo}" name="bbsCtgryNo">
								<div class="board-detail">
									<div>제목<p>${bbsVO.bbscttSj}</p></div><br>
									<div>내용<p>${bbsVO.bbscttCn}</p></div><br>
									<div>작성자<p>${bbsVO.emplNm}</p></div><br>
									<div>작성일<p>${fn:substring(bbsVO.bbscttCreatDt, 0, 10)}</p></div><br>
									<c:set var="Efile" value="${bbsVO.files}" />
									<div>파일
										<c:if test="${not empty Efile}">
											<c:forEach var="file" items="${bbsVO.files}">
												<a href="http://localhost/download?fileName=test/34e5c6bb8bd34d62a8eae92ef506005e_carnation-g75dae9d9b_1280.jpg" target="_blank">${file.fileStreNm}</a>
											</c:forEach>
										</c:if>
										<c:if test="${empty Efile}">
											<p>파일없음</p>
										</c:if>
									</div><br>
									<button class="btn btn-outline-secondary" type="button" id="likeBtn" onclick="toggleLike()"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star" viewBox="0 0 16 16">
  <path d="M2.866 14.85c-.078.444.36.791.746.593l4.39-2.256 4.389 2.256c.386.198.824-.149.746-.592l-.83-4.73 3.522-3.356c.33-.314.16-.888-.282-.95l-4.898-.696L8.465.792a.513.513 0 0 0-.927 0L5.354 5.12l-4.898.696c-.441.062-.612.636-.283.95l3.523 3.356-.83 4.73zm4.905-2.767-3.686 1.894.694-3.957a.56.56 0 0 0-.163-.505L1.71 6.745l4.052-.576a.53.53 0 0 0 .393-.288L8 2.223l1.847 3.658a.53.53 0 0 0 .393.288l4.052.575-2.906 2.77a.56.56 0 0 0-.163.506l.694 3.957-3.686-1.894a.5.5 0 0 0-.461 0z"/>
</svg></button>
									<span id="likeCount">${bbsVO.likeCnt}</span>
								</div>
								<div class="position-relative">
									<div class="position-absolute bottom-0 start-0">
										<a href="/bbs/bbsList?bbsCtgryNo=${bbsVO.bbsCtgryNo}" class="btn btn-outline-secondary">목록으로 돌아가기</a>
									</div>
									<div class="d-grid gap-2 d-md-flex justify-content-md-end">
										<button type="submit" class="btn btn-outline-warning">수정</button>&nbsp;
										<button type="button" class="btn btn-outline-danger"
											onclick="bbsDelete(${bbsVO.bbsSn})">삭제</button>&nbsp;
									</div>
								</div>
							</form>
							<!-- 댓글 영역 -->
								<div class="card-style mt-4">
								    <h5 class="text-primary">💬 댓글</h5>
								
								    <!-- 댓글 입력창 -->
								    <div class="mt-3">
								        <textarea id="answerCn" rows="3" class="form-control" placeholder="댓글을 입력하세요." ></textarea>
								        <div class="d-flex justify-content-end mt-2">
								            <button type="button" class="btn btn-primary" onclick="submitComment()">댓글 등록</button>
								        </div>
								    </div>
								
								    <!-- 댓글 리스트 출력 영역 -->
								    <div id="answerContent" class="mt-4">
								        <%-- AJAX로 댓글 목록이 여기 들어올 예정 --%>
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
	            $("#likeBtn").addClass("text-danger");
	        } else {
	            $("#likeBtn").removeClass("text-danger");
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
	                if (answer.emplNo === loginUserEmplNo) {
	                    html += `
	                        <div class="mt-2 d-flex justify-content-end">
	                            <button class="btn btn btn-outline-warning me-2"
	                                    onclick="editAnswer(` + answer.answerNo + `)">수정</button>
	                            <button class="btn btn btn-outline-danger me-2"
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
		const currentText = $(`#answerCn-${answerNo}`).text();
		const newText = prompt("댓글을 수정하세요", currentText);

		if (newText && newText.trim()) {
			$.ajax({
				type: "POST",
				url: "/bbs/answer/update",
				data: {
					answerNo: answerNo,
					answerCn: newText
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




	</script>

		
</body>
</html>
