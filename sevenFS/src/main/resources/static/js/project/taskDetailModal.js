// taskDetailModal.js

// 댓글 등록 함수
function submitTaskComment() {
  const taskNo = document.getElementById('taskNo')?.value;
  const answerCn = document.getElementById('answerCn')?.value.trim();

  if (!answerCn) {
    swal("입력 오류", "피드백 내용을 입력해주세요.", "warning");
    return;
  }


  $.ajax({
    url: '/projectTask/comment/insert',
    type: 'POST',
    contentType: 'application/json',
    data: JSON.stringify({
      taskNo: taskNo,
      answerCn: answerCn
    }),
    success: function(response) {
		if (response.success) {
		  swal("등록 완료", "피드백이 등록되었습니다.", "success");
		  loadTaskComments(taskNo);
		  document.getElementById('answerCn').value = '';
		} else {
		  swal("등록 실패", response.message, "error");
		}

    },
	error: function(xhr, status, error) {
	  console.error('피드백 등록 오류:', error);
	  swal("오류", "피드백 등록 중 오류가 발생했습니다.", "error");
	}
  });
}

// 댓글 목록 불러오기 함수
function loadTaskComments(taskNo) {
  $.ajax({
    url: '/projectTask/comment/list',
    type: 'GET',
    data: { taskNo: taskNo },
    success: function(response) {
      $('#answerContent').html(response);
    },
    error: function(xhr, status, error) {
      console.error('댓글 목록 불러오기 오류:', error);
    }
  });
}

// 업무 수정 페이지 이동 함수
function goToTaskEdit(taskNo) {
  location.href = '/projectTask/editForm?taskNo=' + taskNo;
}

// 모달 열릴 때마다 숨겨진 값 읽어오기 (필요하면 추가 사용)
function getLoginUserEmplNo() {
  return document.getElementById('loginUserEmplNo')?.value;
}

function getCurrentTaskNo() {
  return document.getElementById('currentTaskNo')?.value;
}

// 추가: 주소 검색 버튼
function openAddressSearch() {
  new daum.Postcode({
    oncomplete: function(data) {
      document.getElementById('restaurantAdd1').value = data.address;
      document.getElementById('addressDetail').focus();
    }
  }).open();
}

// 추가: 참여 인원 추가 (복수 선택)
function addSelectedMembers(selectedMembers) {
  const tableBody = document.querySelector('#selectedMembersTable tbody');

  selectedMembers.forEach(member => {
    // 중복 체크
    if (tableBody.querySelector(`tr[data-empno="${member.emplNo}"]`)) return;

    const row = document.createElement('tr');
    row.setAttribute('data-empno', member.emplNo);
    row.setAttribute('data-role', member.role);

    let roleLabel = '', badgeClass = '', roleIcon = '';
    if (member.role === '00') {
      roleLabel = '책임자'; badgeClass = 'bg-danger'; roleIcon = 'fas fa-user-tie';
    } else if (member.role === '01') {
      roleLabel = '참여자'; badgeClass = 'bg-primary'; roleIcon = 'fas fa-user-check';
    } else {
      roleLabel = '참조자'; badgeClass = 'bg-secondary'; roleIcon = 'fas fa-user-clock';
    }

    row.innerHTML = `
      <td class="text-center align-middle">
        <span class="badge ${badgeClass} p-2">
          <i class="${roleIcon} me-1"></i> ${roleLabel}
        </span>
      </td>
      <td class="text-center align-middle"><strong>${member.emplNm}</strong></td>
      <td class="text-center align-middle">${member.deptNm}</td>
      <td class="text-center align-middle">${member.posNm}</td>
      <td class="text-center align-middle"><i class="fas fa-phone-alt me-1 text-muted"></i> ${member.telno}</td>
      <td class="text-start align-middle ps-3"><i class="fas fa-envelope me-1 text-muted"></i> ${member.email}</td>
      <td class="text-center align-middle">
        <input type="hidden" name="" value="${member.emplNo}" />
        <button type="button" class="btn btn-sm btn-outline-danger" onclick="this.closest('tr').remove(); updateProjectEmpIndexes();">
          <i class="fas fa-times"></i>
        </button>
      </td>
    `;
    tableBody.appendChild(row);
  });

  updateProjectEmpIndexes();
}

// 역할별 정렬 강화
function updateProjectEmpIndexes() {
  const table = document.getElementById("selectedMembersTable");
  const rows = Array.from(table.querySelectorAll("tbody tr:not(.empty-row)"));

  rows.sort((a, b) => a.getAttribute('data-role').localeCompare(b.getAttribute('data-role')));

  const tbody = table.querySelector("tbody");
  tbody.innerHTML = "";
  let idx = { "00": 0, "01": 0, "02": 0 };

  rows.forEach(row => {
    tbody.appendChild(row);

    const role = row.getAttribute("data-role");
    const empno = row.getAttribute("data-empno");

    row.querySelectorAll('input[type="hidden"]').forEach(el => el.remove());

    const input = document.createElement("input");
    input.type = "hidden";
    if (role === "00") input.name = `responsibleManager[${idx[role]}]`;
    else if (role === "01") input.name = `participants[${idx[role]}]`;
    else if (role === "02") input.name = `observers[${idx[role]}]`;
    input.value = empno;
    row.appendChild(input);

    idx[role]++;
  });

  if (rows.length === 0) {
    const tr = document.createElement("tr");
    tr.className = "empty-row";
    tr.innerHTML = `<td colspan="7" class="text-center text-muted py-4">
      <i class="fas fa-info-circle me-1"></i> 선택된 인원이 없습니다. 조직도에서 프로젝트 참여자를 선택해주세요.
    </td>`;
    tbody.appendChild(tr);
  }
}
