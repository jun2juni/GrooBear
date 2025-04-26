// ====================== 유틸 ======================
function openTaskModal(taskNo) {
  const modal = new bootstrap.Modal(document.getElementById('taskDetailModal'), {
	focus: false
  });
  const contentEl = document.getElementById('taskDetailContent');
  contentEl.innerHTML = '로딩 중...';

  fetch(`/projectTask/detail?taskNo=${taskNo}`)
    .then(res => res.text())
    .then(html => {
      contentEl.innerHTML = html;
	  
      modal.show();
	    
	    
        const taskNoInput = document.getElementById("taskNo")?.value;
        if (taskNoInput) {
          window.loadTaskAnswer();
        }
    });
}

// 공통: taskNo 가져오기
function getTaskNo() {
    return document.getElementById("taskNo")?.value || null;
}

// 공통: 댓글 유효성 체크
function isValidComment(content) {
    return content && content.trim().length > 0;
}

// 날짜 포맷 함수가 없을 경우 예외 처리용 (있다면 주석처리 가능)
function formatDate(dateString) {
    const date = new Date(dateString);
    return date.toLocaleString("ko-KR");
}

// ====================== 댓글 등록 ======================

window.submitTaskComment = function () {
    console.log("업무 댓글 등록 실행");
	
    const taskNo = getTaskNo();
    const answerCn = $("#answerCn").val().trim();

    if (!taskNo) return console.error("❌ taskNo가 비어있음");
    if (!isValidComment(answerCn)) {
        alert("댓글 내용을 입력해주세요.");
        return $("#answerCn").focus();
    }

    $.post("/task/answer", {
        taskNo,
        answerCn,
        parentAnswerNo: 0,
        answerDepth: 0
    })
        .done(() => {
            console.log("✅ 댓글 등록 성공");
            $("#answerCn").val("");
            window.loadTaskAnswer();
        })
        .fail(xhr => {
            console.error("❌ 댓글 등록 실패:", xhr.responseText);
        });
};

// ====================== 댓글 불러오기 (트리 기반) ======================
window.loadTaskAnswer = function () {
    const taskNo = getTaskNo();
    if (!taskNo) return;

    $.get("/task/answer", { taskNo })
        .done(data => {
            const tree = buildCommentTree(data);
            const html = renderCommentTree(tree);
            $("#answerContent").html(html);
        })
        .fail(xhr => {
            console.error("❌ 댓글 불러오기 실패:", xhr.responseText);
        });
};

// 트리 구조 생성
function buildCommentTree(data) {
    const map = new Map();
    const roots = [];

    data.forEach(comment => {
        comment.children = [];
        map.set(comment.taskAnswerSn, comment);
    });

    data.forEach(comment => {
        if (comment.parentAnswerNo && map.has(comment.parentAnswerNo)) {
            map.get(comment.parentAnswerNo).children.push(comment);
        } else {
            roots.unshift(comment);
        }
    });

    return roots;
}

// 트리 기반 재귀 렌더링
function renderCommentTree(comments, depth = 0) {
    return comments.map(comment => {
        comment.answerDepth = depth;
        const html = renderCommentCard(comment);
		
		comment.children.reverse();
		
        const childrenHtml = renderCommentTree(comment.children, depth + 1);
        return html + childrenHtml;
    }).join("");
}

// ====================== 댓글 카드 렌더 ======================
function renderCommentCard(answer) {
    const depth = answer.answerDepth ?? 0;
    const marginLeft = depth * 20;
    const formattedDate = formatDate(answer.answerCreatDt);

    return `
        <div class="card shadow-sm border-0 rounded mb-3 ${depth > 0 ? 'bg-light-subtle' : ''}" style="margin-left: ${marginLeft}px;">
            <div class="card-body pb-2">
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <div class="d-flex align-items-center gap-2">
                        <span class="fw-semibold ${depth === 0 ? 'text-primary' : 'text-dark'}">${answer.answerWritngEmpNm}</span>
                        ${depth > 0 ? '<span class="badge text-bg-secondary">답글</span>' : ''}
                    </div>
                    <small class="text-muted">${formattedDate}</small>
                </div>

                <p class="card-text text-dark lh-sm mb-3" id="answerCn-${answer.taskAnswerSn}" data-content="${answer.answerCn}">
                    ${answer.answerCn}
                </p>

                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        ${depth === 0 ? `<button class="btn btn-sm btn-outline-secondary" onclick="showReplyForm(${answer.taskAnswerSn}, ${depth})">
                            <i class="bi bi-reply"></i> 답글
                        </button>` : ''}
                    </div>
                    <div class="dropdown">
					${answer.answerWritngEmpno === loginUserEmplNo ? `
                        <button class="btn btn-sm btn-outline-light text-dark" type="button"
                                id="dropdownMenu-${answer.taskAnswerSn}" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-three-dots-vertical"></i>
                        </button>
                        
                        <ul class="dropdown-menu" aria-labelledby="dropdownMenu-${answer.taskAnswerSn}">
                                <li><a class="dropdown-item" href="#" onclick="editTaskAnswer(${answer.taskAnswerSn})"><i class="bi bi-pencil-square me-2"></i> 수정</a></li>
                                <li><a class="dropdown-item text-danger" href="#" onclick="deleteTaskAnswer(${answer.taskAnswerSn})"><i class="bi bi-trash me-2"></i> 삭제</a></li>
                        </ul>
                    ` : ''}
                    </div>
                </div>

                <div id="replyForm-${answer.taskAnswerSn}" class="mt-3"></div>
            </div>
        </div>`;
}

// ====================== 답글 입력창 표시 ======================

window.showReplyForm = function (parentAnswerSn, parentDepth) {
    const container = $(`#replyForm-${parentAnswerSn}`);
    if (container.children().length > 0) return;

    const html = `
        <div class="mt-2">
            <textarea class="form-control mb-2" id="replyContent-${parentAnswerSn}" rows="2" placeholder="답글을 입력하세요."></textarea>
            <div class="d-flex justify-content-end">
                <button class="btn btn-sm btn-primary me-2" onclick="submitReply(${parentAnswerSn}, ${parentDepth + 1})">등록</button>
                <button class="btn btn-sm btn-secondary" onclick="$('#replyForm-${parentAnswerSn}').empty()">취소</button>
            </div>
        </div>
    `;
    container.html(html);
};

// ====================== 답글 등록 ======================

window.submitReply = function (parentAnswerSn, depth) {
    const taskNo = getTaskNo();
    const content = $(`#replyContent-${parentAnswerSn}`).val().trim();

    if (!isValidComment(content)) {
        return alert("답글을 입력해주세요.");
    }

    $.post("/task/answer", {
        taskNo,
        answerCn: content,
        parentAnswerNo: parentAnswerSn,
        answerDepth: depth
    })
        .done(() => window.loadTaskAnswer())
        .fail(xhr => alert("답글 등록 실패: " + xhr.responseText));
};

// ====================== 댓글 수정 ======================

window.editTaskAnswer = function (taskAnswerSn) {
    const currentText = $(`#answerCn-${taskAnswerSn}`).data("content");

    Swal.fire({
        title: '댓글 수정',
        input: 'textarea',
        inputValue: currentText,
		target: document.body,
		allowOutsideClick: false,
        showCancelButton: true,
        confirmButtonText: '수정',
        cancelButtonText: '취소',
        inputValidator: (value) => {
            if (!isValidComment(value)) return '댓글 내용은 비워둘 수 없습니다.';
        }
    }).then((result) => {
        if (result.isConfirmed) {
            $.post("/task/answer/update", {
                taskAnswerSn,
                answerCn: result.value.trim()
            })	
                .done(() => {
                    Swal.fire('수정 완료', '댓글이 수정되었습니다.', 'success')
                        .then(() => window.loadTaskAnswer());
                })
                .fail(xhr => {
                    Swal.fire('수정 실패', xhr.responseText || '오류 발생', 'error');
                });
        }
    });
};

// ====================== 댓글 삭제 ======================

window.deleteTaskAnswer = function (taskAnswerSn) {
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
            $.post("/task/answer/delete", { taskAnswerSn })
                .done(() => {
                    Swal.fire('삭제 완료', '댓글이 삭제되었습니다.', 'success')
                        .then(() => window.loadTaskAnswer());
                })
                .fail(xhr => {
                    Swal.fire('삭제 실패', xhr.responseText || '오류 발생', 'error');
                });
        }
    });
};
