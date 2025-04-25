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

function updateProjectEmpIndexes() {
  const table = document.getElementById("selectedMembersTable");
  const rows = table.querySelectorAll("tbody tr:not(.empty-row)");

  let idx = { "00": 0, "01": 0, "02": 0 };

  rows.forEach(row => {
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
    const tbody = table.querySelector("tbody");
    const tr = document.createElement("tr");
    tr.className = "empty-row";
    tr.innerHTML = `<td colspan="7" class="text-center text-muted py-4">
      <i class="fas fa-info-circle me-1"></i> 선택된 인원이 없습니다. 조직도에서 프로젝트 참여자를 선택해주세요.
    </td>`;
    tbody.appendChild(tr);
  }
}

function setupOrgChartModalButtonHandler() {
  document.querySelectorAll(".open-org-chart").forEach(button => {
    button.addEventListener("click", function () {
      const modalEl = document.getElementById("orgChartModal");
      const bsModal = bootstrap.Modal.getOrCreateInstance(modalEl);

      // 강제로 aria-hidden 제거 (Bootstrap 버그 우회)
      modalEl.removeAttribute("aria-hidden");
      bsModal.show();
    });
  });
}
