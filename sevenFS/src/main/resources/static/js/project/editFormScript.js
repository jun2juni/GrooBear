let currentTarget = null;

const selectedMembers = [];



document.addEventListener('DOMContentLoaded', function () {
  console.log("🚀 editFormScript.js loaded");

  initAddressFields();
  formatDateFields();
  setupAmountInputFormat();
  setupFormSubmitWithValidation();
  setupOrgChartModalButtonHandler();
  
   const rows = document.querySelectorAll('#selectedMembersTable tbody tr.server-member');

    rows.forEach(row => {
      const member = {
        emplNo: row.dataset.empId,
        role: convertRoleKey(row.dataset.role),
        emplNm: row.dataset.name,
        deptNm: row.dataset.dept,
        posNm: row.dataset.pos,
        telno: row.dataset.telno,
        email: row.dataset.email
      };
      addSelectedMembers([member]);
      row.remove(); // 기존 tr 삭제
    });
  });
  
  // 역할코드 ➔ 역할명 변환
  function convertRoleKey(roleCode) {
    if (roleCode === '00') return 'responsibleManager';
    if (roleCode === '01') return 'participants';
    return 'observers';
  }  

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
	
	console.log(" 폼 안에 emp_no들:", 
	  [...form.querySelectorAll('input[name="emp_no[]"]')].map(input => ({ name: input.name, value: input.value }))
	);

	console.log(" 폼 안에 emp_role들:", 
	  [...form.querySelectorAll('input[name="emp_role[]"]')].map(input => ({ name: input.name, value: input.value }))
	);


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

      // 모달 열 때 loadOrgTree() 호출
      loadOrgTree(); 
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


function sortMembersByRole() {
  const tableBody = document.querySelector("#selectedMembersTable tbody");
  if (!tableBody) return;

  const rows = Array.from(tableBody.children);

  rows.sort((a, b) => {
    const roleOrder = {
      responsibleManager: 0,
      participants: 1,
      observers: 2
    };

    const roleA = a.dataset.role;
    const roleB = b.dataset.role;

    return (roleOrder[roleA] ?? 99) - (roleOrder[roleB] ?? 99);
  });

  // 정렬된 순서대로 다시 붙이기
  rows.forEach(row => tableBody.appendChild(row));
}



// 선택된 인원 추가 함수
function addSelectedMembers(members) {
  const tableBody = document.querySelector("#selectedMembersTable tbody");
  if (!tableBody) return;

  // empty-row 삭제
  const emptyRow = tableBody.querySelector('.empty-row');
  if (emptyRow) emptyRow.remove();

  members.forEach(emp => {
    const empId = emp.emplNo;
    const role = emp.role;

	if (isAlreadyRegistered(empId, role)) {
	  setTimeout(() => {
	    swal("등록된 인원입니다", "이미 해당 역할로 등록된 사원입니다.", "warning");
	  }, 0);
	  return;
	}


    const row = document.createElement('tr');
    row.dataset.empId = empId;
    row.dataset.role = role;

    let roleName = '';
    let badgeClass = '';
    let iconClass = '';

    if (role === 'responsibleManager') {
      roleName = '책임자';
      badgeClass = 'bg-danger';
      iconClass = 'fas fa-user-tie';
      row.classList.add('table-danger');
    } else if (role === 'participants') {
      roleName = '참여자';
      badgeClass = 'bg-primary';
      iconClass = 'fas fa-user-check';
      row.classList.add('table-primary');
    } else {
      roleName = '참조자';
      badgeClass = 'bg-secondary';
      iconClass = 'fas fa-user-clock';
      row.classList.add('table-secondary');
    }

    const formattedPhone = formatPhone(emp.telno);

    row.innerHTML = `
      <td class="text-center">
        <input type="hidden" name="emp_no[]" value="${empId}">
        <input type="hidden" name="emp_role[]" value="${role}">
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
        <button type="button" class="btn btn-sm btn-outline-danger remove-member" onclick="removeParticipant(this, event)">
          <i class="fas fa-times"></i>
        </button>
      </td>
    `;

    tableBody.appendChild(row);
  });

  updateProjectEmpIndexes();
  sortMembersByRole();
}

function isAlreadyRegistered(empId, role) {
  const tableBody = document.querySelector("#selectedMembersTable tbody");
  if (!tableBody) return false;

  return Array.from(tableBody.children).some(row =>
    row.dataset.empId === empId && row.dataset.role === role
  );
}



//  조직도 로딩 함수
function loadOrgTree() {
  const treeContainer = document.getElementById('jstree');
  if (!treeContainer) {
    console.warn("jstree 요소가 없습니다.");
    return;
  }

  console.log(" 조직도 데이터 로딩 시작");

  fetch("/organization/detail")
    .then(resp => {
      if (!resp.ok) throw new Error(`조직도 데이터 로딩 실패: ${resp.status}`);
      return resp.json();
    })
    .then(res => {
      const deptList = res.deptList; // 부서
      const empList = res.empList;   // 사원

      console.log("부서 리스트:", deptList);
      console.log("사원 리스트:", empList);

      const json = [];

      deptList.forEach(dept => {
        json.push({
          id: dept.cmmnCode,
          parent: dept.upperCmmnCode || "#",
          text: dept.cmmnCodeNm,
          icon: "/assets/images/organization/department.svg",
          deptYn: true,
          original: {
            id: dept.cmmnCode,
            parent: dept.upperCmmnCode || "#",
            text: dept.cmmnCodeNm,
            deptYn: true
          }
        });
      });

      empList.forEach(emp => {
        json.push({
          id: emp.emplNo,
          parent: emp.deptCode || "#",
          text: emp.emplNm,
          icon: "/assets/images/organization/employeeImg.svg",
          deptYn: false,
          original: {
            id: emp.emplNo,
            parent: emp.deptCode || "#",
            text: emp.emplNm,
            deptYn: false,
            deptNm: emp.deptNm || '-',
            posNm: emp.posNm || '-',
            telno: emp.telno || '-',
            email: emp.email || '-'
          }
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

      $('#jstree').on('select_node.jstree', function (e, data) {
        const node = data.node;
        if (!node || node.original?.deptYn) return;
        if (typeof clickEmp === 'function') {
          clickEmp(node.original);
        }
      });

    })
    .catch(error => {
      console.error(" 조직도 로딩 실패:", error);
    });
}




// 사원 클릭 시
function clickEmp(node) {
  if (!node || node.deptYn === true) return;

  console.log(" 선택된 사원:", node);

  if (!currentTarget) {
    swal("선택 오류", "먼저 책임자/참여자/참조자 버튼을 눌러주세요.", "warning");
    return;
  }

  const emp = node.original; // 🔥 핵심: node.original에서 데이터 가져오기

  const newEmp = {
    emplNo: emp.id,        // 사번
    emplNm: emp.text,      // 이름
    deptNm: emp.deptNm || '-', // 부서명
    posNm: emp.posNm || '-',   // 직급
    telno: emp.telno || '-',   // 전화번호
    email: emp.email || '-',   // 이메일
    role: currentTarget
  };

  addSelectedMembers([newEmp]);
}




//  전화번호 포맷 함수
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

// 참여자 삭제 버튼 클릭 시
function removeParticipant(button, event) {
  event.preventDefault();
  const row = button.closest('tr');
  if (row) {
    row.remove();
    updateProjectEmpIndexes();
	
  }
}





//  인덱스 재조정
function updateProjectEmpIndexes() {
  const participants = document.querySelectorAll('#selectedMembersTable tbody tr:not(.empty-row)');
  participants.forEach((row, index) => {
    const empNoInput = row.querySelector('input.emp-no');
    const roleInput = row.querySelector('input.emp-role');
    if (empNoInput) empNoInput.name = `projectEmpVOList[${index}].emplNo`;
    if (roleInput) roleInput.name = `projectEmpVOList[${index}].role`;
  });
}

