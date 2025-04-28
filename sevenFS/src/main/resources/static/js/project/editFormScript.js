let currentTarget = null;

const selectedMembers = [];



document.addEventListener('DOMContentLoaded', function () {
  console.log("🚀 editFormScript.js loaded");

  initAddressFields();
  formatDateFields();
  setupAmountInputFormat();
  setupFormSubmitWithValidation();
  setupOrgChartModalButtonHandler();
});

function initAddressFields() {
  const fullAddr = document.getElementById('prjctAdres')?.value || '';
  if (fullAddr.includes(',')) {
    const [addr1, addr2] = fullAddr.split(/,\s*/);
    document.getElementById('restaurantAdd1').value = addr1;
    document.getElementById('addressDetail').value = addr2;
  } else {
    document.getElementById('restaurantAdd1').value = fullAddr;
  }
}

function formatDateFields() {
  const beginDateInput = document.querySelector('[name="prjctBeginDate"]');
  const endDateInput = document.querySelector('[name="prjctEndDate"]');

  if (beginDateInput) beginDateInput.value = convertToInputDate(beginDateInput.value);
  if (endDateInput) endDateInput.value = convertToInputDate(endDateInput.value);
}

function convertToInputDate(val) {
  if (val && val.length === 8) {
    return `${val.slice(0, 4)}-${val.slice(4, 6)}-${val.slice(6, 8)}`;
  }
  return val;
}

function setupAmountInputFormat() {
  const amountInput = document.getElementById('prjctRcvordAmount');
  if (!amountInput) return;

  amountInput.addEventListener('input', function () {
    let value = this.value.replace(/[^0-9]/g, '');
    if (value) value = parseInt(value, 10).toLocaleString('ko-KR');
    this.value = value;
  });
}

function setupFormSubmitWithValidation() {
  const form = document.getElementById('projectForm');
  form.addEventListener('submit', function (e) {
    e.preventDefault();

    const requiredFields = ['prjctNo', 'ctgryNo', 'prjctNm', 'prjctCn', 'prjctSttus', 'prjctGrad', 'prjctBeginDate', 'prjctEndDate'];
    const missing = [];

    requiredFields.forEach(name => {
      const input = form.querySelector(`[name="${name}"]`) || form.querySelector(`input[type="hidden"][name="${name}"]`);
      if (!input || input.value.trim() === '') missing.push(name);
    });

    if (missing.length > 0) {
      console.warn("❗ 누락된 필드:", missing);
      swal("입력 오류", "모든 필수 항목을 입력해주세요.", "warning");
      return;
    }

    // 날짜 포맷 변경
    const begin = form.querySelector('[name="prjctBeginDate"]');
    const end = form.querySelector('[name="prjctEndDate"]');
    if (begin) {
      form.appendChild(createHiddenField('prjctBeginDate', begin.value.replace(/-/g, '')));
      begin.name = 'prjctBeginDateDisplay';
    }
    if (end) {
      form.appendChild(createHiddenField('prjctEndDate', end.value.replace(/-/g, '')));
      end.name = 'prjctEndDateDisplay';
    }

    // 수주금액 숫자만
    const amtInput = document.getElementById('prjctRcvordAmount');
    if (amtInput) amtInput.value = amtInput.value.replace(/[^0-9]/g, '');

    // 주소 병합
    const addr1 = document.getElementById('restaurantAdd1')?.value || '';
    const addr2 = document.getElementById('addressDetail')?.value || '';
    document.getElementById('prjctAdres').value = addr1 + (addr2 ? ', ' + addr2 : '');

    form.submit();
  });
}

function createHiddenField(name, value) {
  const input = document.createElement('input');
  input.type = 'hidden';
  input.name = name;
  input.value = value;
  return input;
}

function removeMember(button) {
  const row = button.closest('tr');
  if (row) row.remove();
  updateProjectEmpIndexes();
}

function setupOrgChartModalButtonHandler() {
  document.querySelectorAll(".open-org-chart").forEach(button => {
    button.addEventListener('click', function() {
      document.querySelectorAll('.open-org-chart').forEach(btn => btn.classList.remove('active'));
      this.classList.add('active');

      currentTarget = this.dataset.target; // 누를 때 기억
      console.log("선택한 역할:", currentTarget);
      
      const modalEl = document.getElementById("orgChartModal");
      const bsModal = bootstrap.Modal.getOrCreateInstance(modalEl);

      modalEl.removeAttribute("aria-hidden");
      bsModal.show();
    });
  });
}



// 주소 검색 함수 추가
function openAddressSearch() {
  new daum.Postcode({
    oncomplete: function(data) {
      document.getElementById('restaurantAdd1').value = data.address;
      document.getElementById('addressDetail').focus();
    }
  }).open();
}




// 선택된 인원 추가 함수
function addSelectedMembers(members) {
  const tableBody = document.querySelector("#selectedMembersTable tbody");
  if (!tableBody) return;

  // empty-row 삭제
  const emptyRow = tableBody.querySelector('.empty-row');
  if (emptyRow) emptyRow.remove();

  members.forEach(emp => {
    // 중복 체크 (같은 직원+같은 역할은 추가 금지)
    const exists = Array.from(tableBody.children).some(row =>
      row.dataset.empId === emp.emplNo && row.dataset.role === emp.role
    );
    if (exists) return; // 이미 추가된 경우 무시

    // 새 행 추가
    const row = document.createElement("tr");
    row.dataset.empId = emp.emplNo;
    row.dataset.role = emp.role;

    let roleName = '';
    let badgeClass = '';
    let iconClass = '';

    if (emp.role === 'responsibleManager') {
      roleName = '책임자';
      badgeClass = 'bg-danger';
      iconClass = 'fas fa-user-tie';
    } else if (emp.role === 'participants') {
      roleName = '참여자';
      badgeClass = 'bg-primary';
      iconClass = 'fas fa-user-check';
    } else {
      roleName = '참조자';
      badgeClass = 'bg-secondary';
      iconClass = 'fas fa-user-clock';
    }

    // 전화번호 포맷
    const formattedPhone = formatPhone(emp.telno);

    row.innerHTML = `
      <td class="text-center">
        <span class="badge ${badgeClass} p-2">
          <i class="${iconClass} me-1"></i> ${roleName}
        </span>
      </td>
      <td class="text-center"><strong>${emp.emplNm || '-'}</strong></td>
      <td class="text-start ps-2">${emp.deptNm || '-'}</td>
      <td class="text-center">${emp.posNm || '-'}</td>
      <td class="text-center">
        <i class="fas fa-phone-alt me-1 text-muted"></i>${formattedPhone}
      </td>
      <td class="text-start ps-2">
        <i class="fas fa-envelope me-1 text-muted"></i>${emp.email || '-'}</td>
      <td class="text-center">
        <button type="button" class="btn btn-sm btn-outline-danger remove-member">
          <i class="fas fa-times"></i>
        </button>
      </td>
    `;

    // 삭제 버튼 이벤트
    row.querySelector(".remove-member").addEventListener("click", function () {
      row.remove();
      updateProjectEmpIndexes();
    });

    tableBody.appendChild(row);
  });

  updateProjectEmpIndexes();
}

// ✅ 조직도 로딩 함수
// 조직도 로딩 (수정 버전)
function loadOrgTree() {
  const treeContainer = document.getElementById('jstree');
  if (!treeContainer) {
    console.warn("jstree 요소가 존재하지 않습니다.");
    return;
  }

  console.log("🚀 editForm 조직도 로딩 시작");

  // 기존 부서 정보 가져오기
  fetch("/organization")
    .then(resp => {
      if (!resp.ok) throw new Error(`조직도 데이터 로딩 실패: ${resp.status}`);
      return resp.json();
    })
    .then(res => {
      console.log("부서 데이터 수신 성공");
      
      // 상세 사원 정보 가져오기
      return fetch("/organization/detail")
        .then(resp => {
          if (!resp.ok) throw new Error(`사원 상세 데이터 로딩 실패: ${resp.status}`);
          return resp.json();
        })
        .then(empDetailList => {
          console.log("사원 상세 데이터 수신 성공");
          return { orgData: res, empDetailList: empDetailList };
        });
    })
    .then(data => {
      const { orgData, empDetailList } = data;
      const json = [];
      const deptMap = {};
      
      // 부서명 매핑
      orgData.deptList.forEach(dept => {
        deptMap[dept.cmmnCode] = dept.cmmnCodeNm;
        json.push({
          id: dept.cmmnCode,
          parent: dept.upperCmmnCode || '#',
          text: dept.cmmnCodeNm,
          icon: "/assets/images/organization/depIcon.svg",
          deptYn: true
        });
      });

      // 사원별 상세 정보 매핑을 위한 맵 생성
      const empDetailMap = {};
      empDetailList.forEach(emp => {
        empDetailMap[emp.emplNo] = emp;
      });

      // 사원 정보 추가
      orgData.empList.forEach(emp => {
        // 상세 정보 가져오기
        const empDetail = empDetailMap[emp.emplNo] || {};
        
        json.push({
          id: emp.emplNo,
          parent: emp.deptCode,
          text: emp.emplNm,
          icon: "/assets/images/organization/employeeImg.svg",
          deptYn: false,
          dept: empDetail.deptNm || deptMap[emp.deptCode] || '-',
          position: empDetail.posNm || '-',
          phone: empDetail.telno || emp.telno || '-',
          email: empDetail.email || emp.email || '-'
        });
      });

      $('#jstree').jstree('destroy');
      $('#jstree').jstree({
        core: {
          data: json,
          check_callback: true,
          themes: { responsive: false }
        },
        plugins: ["search"]
      });

      // 트리 로딩 후 클릭 이벤트 연결
      $('#jstree').off('select_node.jstree').on('select_node.jstree', function (e, data) {
        if (!data.node.original) return;
        
        if (data.node.original.deptYn) {
          console.log("부서를 클릭했습니다. 무시합니다.");
          return;
        }
        
        clickEmp(data);
      });
    })
    .catch(error => {
      console.error("조직도 로딩 오류:", error);
    });
}


// ✅ 사원 클릭 시
function clickEmp(data) {
  console.log("사원 클릭됨:", data);

  if (!currentTarget) {
    swal("선택 오류", "먼저 책임자/참여자/참조자 중 선택해주세요.", "warning");
    return;
  }

  const node = data.node;
  if (!node || node.original.deptYn === true) return; // 부서 클릭 무시

  const emp = {
    id: node.id,
    name: node.text,
    dept: node.original.deptNm || '-',
    position: node.original.posNm || '-',
    phone: formatPhone(node.original.telno || '-'),
    email: node.original.email || '-'
  };

  const tbody = document.querySelector("#selectedMembersTable tbody");
  const emptyRow = tbody.querySelector(".empty-row");
  if (emptyRow) emptyRow.remove();

  const tr = document.createElement("tr");
  tr.setAttribute("data-empno", emp.id);
  tr.setAttribute("data-role", currentTarget);

  let roleLabel = '';
  let badgeClass = '';
  let roleIcon = '';

  if (currentTarget === "responsibleManager") {
    roleLabel = "책임자";
    badgeClass = "bg-danger";
    roleIcon = "fas fa-user-tie";
  } else if (currentTarget === "participants") {
    roleLabel = "참여자";
    badgeClass = "bg-primary";
    roleIcon = "fas fa-user-check";
  } else {
    roleLabel = "참조자";
    badgeClass = "bg-secondary";
    roleIcon = "fas fa-user-clock";
  }

  tr.innerHTML = `
    <td class="text-center">
      <span class="badge ${badgeClass} p-2">
        <i class="${roleIcon} me-1"></i> ${roleLabel}
      </span>
    </td>
    <td class="text-center"><strong>${emp.name}</strong></td>
    <td class="text-start ps-2">${emp.dept}</td>
    <td class="text-center">${emp.position}</td>
    <td class="text-center"><i class="fas fa-phone-alt me-1 text-muted"></i>${emp.phone}</td>
    <td class="text-start ps-2"><i class="fas fa-envelope me-1 text-muted"></i>${emp.email}</td>
    <td class="text-center">
      <button type="button" class="btn btn-sm btn-outline-danger" onclick="removeParticipant(this)">
        <i class="fas fa-times"></i>
      </button>
    </td>
    <input type="hidden" name="projectEmpVOList[0].prtcpntEmpno" value="${emp.id}">
    <input type="hidden" name="projectEmpVOList[0].prtcpntRole" value="${currentTarget}">
    <input type="hidden" name="projectEmpVOList[0].prjctAuthor" value="0000">
    <input type="hidden" name="projectEmpVOList[0].evlManEmpno" value="${emp.id}">
    <input type="hidden" name="projectEmpVOList[0].evlCn" value="프로젝트 참여">
    <input type="hidden" name="projectEmpVOList[0].evlGrad" value="1">
    <input type="hidden" name="projectEmpVOList[0].secsnYn" value="N">
  `;

  tbody.appendChild(tr);

  updateProjectEmpIndexes();
}


// ✅ 전화번호 포맷 함수
function formatPhone(phone) {
  if (!phone) return '-';
  const onlyNums = phone.replace(/[^0-9]/g, '');
  if (onlyNums.length === 11) {
    return onlyNums.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
  } else if (onlyNums.length === 10) {
    if (onlyNums.startsWith('02')) {
      return onlyNums.replace(/(\d{2})(\d{4})(\d{4})/, '$1-$2-$3');
    } else {
      return onlyNums.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
    }
  }
  return phone;
}

// ✅ 참여자 삭제 버튼 클릭 시
function removeParticipant(button) {
  const row = button.closest('tr');
  row.remove();

  const tbody = document.querySelector("#selectedMembersTable tbody");
  if (tbody.children.length === 0) {
    const emptyRow = document.createElement('tr');
    emptyRow.className = 'empty-row';
    emptyRow.innerHTML = `
      <td colspan="7" class="text-center text-muted py-4">
        <i class="fas fa-info-circle me-1"></i> 선택된 인원이 없습니다. 조직도에서 프로젝트 참여자를 선택해주세요.
      </td>
    `;
    tbody.appendChild(emptyRow);
  }

  updateProjectEmpIndexes();
}

// ✅ 인덱스 재조정
function updateProjectEmpIndexes() {
  const participants = document.querySelectorAll('#selectedMembersTable tbody tr:not(.empty-row)');
  participants.forEach((row, index) => {
    const hiddenInputs = row.querySelectorAll('input[type="hidden"]');
    hiddenInputs.forEach(input => {
      if (input.name.includes('projectEmpVOList')) {
        input.name = input.name.replace(/projectEmpVOList\[\d+\]/, `projectEmpVOList[${index}]`);
      }
    });
  });
}
