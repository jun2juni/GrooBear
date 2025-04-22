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
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<style>
    #likeIcon {
    transition: transform 0.2s;
	}
	#likeIcon.liked {
	    transform: scale(1.2);
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
        <div class="card-style p-4">

          <form action="/bbs/bbsUpdate" method="get">
            <input type="hidden" name="bbsSn" value="${bbsVO.bbsSn}">
            <input type="hidden" name="bbsCtgryNo" value="${bbsVO.bbsCtgryNo}">

            <!-- 게시글 본문 -->
            <div class="mb-4">
              <h3 class="mb-3 text-dark fw-bold">${bbsVO.bbscttSj}</h3><br>
              <div class="text-muted mb-3" style="text-align: right;">
                <small>
                  작성자: ${bbsVO.emplNm} · 작성일: ${fn:substring(bbsVO.bbscttCreatDt, 0, 10)}
                </small>
              </div><br>
              <div class="mb-3">
                <c:out value="${bbsVO.bbscttCn}" escapeXml="false" />
              </div><br><br>

              <!-- 첨부파일 -->
              <div class="mb-3">
                <h6 class="text-secondary fw-bold">📎 첨부파일</h6>
                <c:if test="${not empty bbsVO.files}">
                  <div class="d-flex flex-wrap gap-3 mt-2">
                    <c:forEach var="file" items="${bbsVO.files}">
                      <c:set var="ext" value="${fn:toLowerCase(fn:substringAfter(file.fileNm, '.'))}" />
                      <c:choose>
                        <c:when test="${ext == 'jpg' || ext == 'jpeg' || ext == 'png' || ext == 'gif' || ext == 'bmp'}">
                          <div class="border rounded p-3 bg-light d-inline-flex flex-column align-items-center" style="max-width: 450px;">
							    <a href="http://localhost/download?fileName=${file.fileStrePath}">
							    <img src="/upload/${file.fileStrePath}" 
							         alt="${file.fileNm}" 
							         style="max-width: 300px; max-height: 300px; object-fit: cover;"
							          />
								</a>
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
                <i id="likeIcon" class="bi bi-hand-thumbs-up fs-3 text-warning" onclick="toggleLike()" style="cursor: pointer;"></i>
				<span id="likeCount">${bbsVO.likeCnt}</span>
              </div>
            </div>

            <!-- 하단 버튼 -->
            <div class="d-flex justify-content-between">
              <a href="/bbs/bbsList?bbsCtgryNo=${bbsVO.bbsCtgryNo}" class="btn btn-outline-secondary">← 목록</a>

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
	const bbsSn = "${bbsVO.bbsSn}";
	const bbsCtgryNo = "${bbsVO.bbsCtgryNo}";

	function toggleLike() {
	    $.post("/bbs/like/toggle", {
	        bbsSn: bbsSn,
	        bbsCtgryNo: bbsCtgryNo
	    }, function (res) {
	        const $icon = $("#likeIcon");
	        const $count = $("#likeCount");

	        if (res.liked) {
	            // 좋아요 누른 상태
	            $icon
	                .removeClass("bi-hand-thumbs-up text-warning")
	                .addClass("bi-hand-thumbs-up-fill text-warning");
	        } else {
	            // 좋아요 취소 상태
	            $icon
	                .removeClass("bi-hand-thumbs-up-fill text-warning")
	                .addClass("bi-hand-thumbs-up text-warning");
	        }

	        $count.text(res.likeCount);
	    }).fail(function (xhr) {
	        console.error("좋아요 처리 실패:", xhr.responseText);
	    });
	}

	$(document).ready(function () {
	    $.get("/bbs/like/exists", {
	        bbsSn: bbsSn,
	        bbsCtgryNo: bbsCtgryNo
	    }, function (liked) {
	        const $icon = $("#likeIcon");
	        if (liked) {
	            $icon
	                .removeClass("bi-hand-thumbs-up text-secondary")
	                .addClass("bi-hand-thumbs-up-fill text-warning");
	        }
	    });
	});
	
	

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
	            bbsSn: "${bbsVO.bbsSn}",
	            bbsCtgryNo: "${bbsVO.bbsCtgryNo}",
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
		    type: "GET",
		    url: "/bbs/answer",
		    data: {
		        bbsSn: "${bbsVO.bbsSn}",
		        bbsCtgryNo: "${bbsVO.bbsCtgryNo}"
		    },
	        
	        success: function(data) {
	        	
	        	console.log("댓글 목록 불러오기 성공");
	        	
	            let html = "";

	            data.forEach(function(answer) {
	                const formattedDate = formatDate(answer.answerCreatDt);
	                const marginLeft = (answer.answerDepth != null ? answer.answerDepth : 0) * 20;
	                const depth = answer.answerDepth != null ? answer.answerDepth : 0;

	                html += `
	                    <div class="card shadow-sm border-0 rounded mb-3 ${depth > 0 ? 'bg-light-subtle' : ''}" style="margin-left: \${marginLeft}px;">
	                      <div class="card-body pb-2">
	                        <!-- 작성자 & 날짜 -->
	                        <div class="d-flex justify-content-between align-items-center mb-2">
	                          <div class="d-flex align-items-center gap-2">
	                            <span class="fw-semibold \${depth === 0 ? 'text-primary' : 'text-dark'}">\${answer.emplNm}</span>
	                            \${depth > 0 ? '<span class="badge text-bg-secondary">답글</span>' : ''}
	                          </div>
	                          <small class="text-muted">\${formattedDate}</small>
	                        </div>

	                        <!-- 댓글 본문 -->
	                        <p class="card-text text-dark lh-sm mb-3" id="answerCn-\${answer.answerNo}" data-content="\${answer.answerCn}">
	                          \${answer.answerCn}
	                        </p>

	                        <!-- 버튼 영역 -->
	                        <div class="d-flex justify-content-between align-items-center">
	                        <!-- 답글 버튼 (댓글일 때만 표시) -->
	                          <div>
	                            \${depth === 0 ? `
	                              <button class="btn btn-sm btn-outline-secondary"
	                                      onclick="showReplyForm(\${answer.answerNo}, \${depth})">
	                                <i class="bi bi-reply"></i> 답글
	                              </button>
	                            ` : ''}
	                          </div>
	                          <!-- 드롭다운 (수정/삭제) -->
	                          <div>
	                            <div class="dropdown">
	                              <button class="btn btn-sm btn-outline-light text-dark" type="button"
	                                      id="dropdownMenu-\${answer.answerNo}" data-bs-toggle="dropdown" aria-expanded="false">
	                                <i class="bi bi-three-dots-vertical"></i>
	                              </button>
	                              <ul class="dropdown-menu" aria-labelledby="dropdownMenu-\${answer.answerNo}">
	                                \${answer.emplNo === loginUserEmplNo ? `
	                                  <li><a class="dropdown-item" href="#" onclick="editAnswer(\${answer.answerNo})">
	                                    <i class="bi bi-pencil-square me-2"></i> 수정</a></li>
	                                  <li><a class="dropdown-item text-danger" href="#" onclick="deleteAnswer(\${answer.answerNo})">
	                                    <i class="bi bi-trash me-2"></i> 삭제</a></li>
	                                ` : loginUserEmplNo === '20250000' ? `
	                                  <li><a class="dropdown-item text-danger" href="#" onclick="deleteAnswer(\${answer.answerNo})">
	                                    <i class="bi bi-trash me-2"></i> 삭제</a></li>
	                                ` : ''}
	                              </ul>
	                            </div>
	                          </div>

	                          
	                        </div>

	                        <!-- 답글 입력 영역 -->
	                        <div id="replyForm-\${answer.answerNo}" class="mt-3"></div>
	                      </div>
	                    </div>
	                  `;


	              
	            });

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
	
	function showReplyForm(parentAnswerNo, parentDepth) {
		  if ($(`#replyForm-\${parentAnswerNo}`).children().length > 0) return;

		  const html = `
		    <div class="mt-2">
		      <textarea class="form-control mb-2" id="replyContent-\${parentAnswerNo}" rows="2" placeholder="답글을 입력하세요."></textarea>
		      <div class="d-flex justify-content-end">
		        <button class="btn btn-sm btn-primary me-2" onclick="submitReply(\${parentAnswerNo}, \${parentDepth + 1})">등록</button>
		        <button class="btn btn-sm btn-secondary" onclick="\$('#replyForm-\${parentAnswerNo}').empty()">취소</button>
		      </div>
		    </div>
		  `;

		  $(`#replyForm-\${parentAnswerNo}`).html(html);
		}

	
	function submitReply(parentAnswerNo, depth) {
		  const content = $(`#replyContent-\${parentAnswerNo}`).val().trim();
		  if (!content) {
		    alert("답글을 입력해주세요.");
		    return;
		  }

		  $.ajax({
		    type: "POST",
		    url: "/bbs/answer",
		    data: {
		      bbsSn: ${bbsVO.bbsSn},
		      bbsCtgryNo: ${bbsVO.bbsCtgryNo},
		      answerCn: content,
		      parentAnswerNo: parentAnswerNo,
		      answerDepth: depth
		    },
		    success: function () {
		      loadAnswer(); // 다시 불러오기
		    },
		    error: function (xhr) {
		      alert("답글 등록 실패: " + xhr.responseText);
		    }
		  });
		}

	
	// 댓글 수정
	function editAnswer(answerNo) {
	  const currentText = $(`#answerCn-\${answerNo}`).data("content");

	  Swal.fire({
	    title: '댓글 수정',
	    input: 'textarea',
	    inputLabel: '수정할 댓글 내용을 입력하세요.',
	    inputValue: currentText,
	    inputAttributes: {
	      'aria-label': '댓글 내용'
	    },
	    showCancelButton: true,
	    confirmButtonText: '수정',
	    cancelButtonText: '취소',
	    inputValidator: (value) => {
	      if (!value || !value.trim()) {
	        return '댓글 내용은 비워둘 수 없습니다.';
	      }
	    }
	  }).then((result) => {
	    if (result.isConfirmed) {
	      const newText = result.value.trim();

	      $.ajax({
	        type: "POST",
	        url: "/bbs/answer/update",
	        data: {
	          answerNo: answerNo,
	          answerCn: newText
	        },
	        success: function () {
	          Swal.fire({
	            icon: 'success',
	            title: '수정 완료',
	            text: '댓글이 수정되었습니다.',
	            confirmButtonText: '확인'
	          }).then(() => loadAnswer());
	        },
	        error: function (xhr) {
	          Swal.fire({
	            icon: 'error',
	            title: '수정 실패',
	            text: xhr.responseText || '알 수 없는 오류가 발생했습니다.',
	            confirmButtonText: '확인'
	          });
	        }
	      });
	    }
	  });
	}

	// 댓글 삭제
	function deleteAnswer(answerNo) {
	  Swal.fire({
	    title: '댓글을 삭제하시겠습니까?',
	    text: '삭제된 댓글은 복구할 수 없습니다.',
	    icon: 'warning',
	    showCancelButton: true,
	    confirmButtonColor: '#d33',
	    cancelButtonColor: '#3085d6',
	    confirmButtonText: '삭제',
	    cancelButtonText: '취소'
	  }).then((result) => {
	    if (result.isConfirmed) {
	      $.ajax({
	        type: "POST",
	        url: "/bbs/answer/delete",
	        data: { answerNo: answerNo },
	        success: function () {
	          Swal.fire({
	            icon: 'success',
	            title: '삭제 완료',
	            text: '댓글이 삭제되었습니다.',
	            confirmButtonText: '확인'
	          }).then(() => loadAnswer());
	        },
	        error: function (xhr) {
	          Swal.fire({
	            icon: 'error',
	            title: '삭제 실패',
	            text: xhr.responseText || '알 수 없는 오류가 발생했습니다.',
	            confirmButtonText: '확인'
	          });
	        }
	      });
	    }
	  });
	}


	function bbsDelete(bbsSn) {
	    Swal.fire({
	        title: '정말 삭제하시겠습니까?',
	        text: "이 작업은 되돌릴 수 없습니다.",
	        icon: 'warning',
	        showCancelButton: true,
	        confirmButtonColor: '#3085d6',
	        cancelButtonColor: '#d33',
	        confirmButtonText: '삭제',
	        cancelButtonText: '취소'
	    }).then((result) => {
	        if (result.isConfirmed) {
	            $.ajax({
	                url: "/bbs/bbsDelete",
	                type: "POST",
	                data: { bbsSn: bbsSn },
	                success: function (res) {
	                    Swal.fire({
	                        title: '삭제 완료',
	                        text: '게시물이 삭제되었습니다.',
	                        icon: 'success',
	                        confirmButtonText: '확인'
	                    }).then(() => {
	                        window.location.href = "/bbs/bbsList?bbsCtgryNo=" + bbsCtgryNo;
	                    });
	                },
	                error: function (xhr) {
	                    Swal.fire({
	                        title: '삭제 실패',
	                        text: xhr.responseText || '알 수 없는 오류가 발생했습니다.',
	                        icon: 'error',
	                        confirmButtonText: '확인'
	                    });
	                }
	            });
	        }
	    });
	}




</script>

		
</body>
</html>
