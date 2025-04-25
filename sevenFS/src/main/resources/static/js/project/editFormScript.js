document.addEventListener('DOMContentLoaded', function () {
  console.log("🚀 editFormScript.js loaded");

  initAddressFields();
  formatDateFields();
  setupAmountInputFormat();
  setupFormSubmitWithValidation();

  // 부트스트랩 모달 수동 강제 초기화 처리
  const modalEl = document.getElementById('orgChartModal');
  if (modalEl && typeof bootstrap !== 'undefined') {
    bootstrap.Modal.getOrCreateInstance(modalEl);
  }
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

  if (beginDateInput) {
    beginDateInput.value = convertToInputDate(beginDateInput.value);
  }
  if (endDateInput) {
    endDateInput.value = convertToInputDate(endDateInput.value);
  }
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

  // 입력 시 천단위 콤마 표시
  amountInput.addEventListener('input', function () {
    let value = this.value.replace(/[^0-9]/g, '');
    if (value) {
      value = parseInt(value, 10).toLocaleString('ko-KR');
    }
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
      if (!input || input.value.trim() === '') {
        missing.push(name);
      }
    });

    if (missing.length > 0) {
      console.warn("❗ 누락된 필드:", missing);
      swal("입력 오류", "모든 필수 항목을 입력해주세요.", "warning");
      return;
    }

    // 날짜 → YYYYMMDD 포맷으로 히든 전달
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

    // 수주 금액 콤마, 역슬래시 제거
	const amtInput = document.getElementById('prjctRcvordAmount');
	if (amtInput) {
	  amtInput.value = amtInput.value.replace(/[^0-9]/g, '');  // 콤마 제거
	}


    // 주소 병합 처리
    const addr1 = document.getElementById('restaurantAdd1')?.value || '';
    const addr2 = document.getElementById('addressDetail')?.value || '';
    document.getElementById('prjctAdres').value = addr1 + (addr2 ? ', ' + addr2 : '');

    // 최종 제출
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

function removeMemberRow(button) {
  const tr = button.closest('tr');
  if (tr) {
    tr.remove();
    updateProjectEmpIndexes();
  }
}

function updateProjectEmpIndexes() {
  const table = document.getElementById('selectedMembersTable');
  const hiddenInputs = table.querySelectorAll('input.member-hidden-input');

  // 역할별로 인덱싱
  let responsibleIdx = 0;
  let participantIdx = 0;
  let observerIdx = 0;

  hiddenInputs.forEach(input => {
    const role = input.dataset.role; // '00' 책임자, '01' 참여자, 나머지 참조자

    if (role === '00') {
      input.name = `responsibleManager[${responsibleIdx++}]`;
    } else if (role === '01') {
      input.name = `participants[${participantIdx++}]`;
    } else {
      input.name = `observers[${observerIdx++}]`;
    }
  });
}