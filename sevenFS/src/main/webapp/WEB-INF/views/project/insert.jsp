<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="title" value="프로젝트 생성" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>${title}</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<c:import url="../layout/prestyle.jsp" />
</head>
<body>
	<c:import url="../layout/sidebar.jsp" />
	<main class="main-wrapper">
		<c:import url="../layout/header.jsp" />

		<section class="section">
			<div class="container-fluid">
				<h2 class="mb-4">프로젝트 생성</h2>

				<form id="projectForm" action="/project/insert" method="post"
					enctype="multipart/form-data">
					<div class="card">
						<div class="card-body">
							<ul class="nav nav-tabs" id="formTabs">
								<li class="nav-item"><a class="nav-link active"
									data-step="1" href="#">기본정보</a></li>
								<li class="nav-item"><a class="nav-link" data-step="2"
									href="#">인원등록</a></li>
								<li class="nav-item"><a class="nav-link" data-step="3"
									href="#">업무관리</a></li>
								<li class="nav-item"><a class="nav-link" data-step="4"
									href="#">세부정보</a></li>
								<li class="nav-item"><a class="nav-link" data-step="5"
									href="#">최종확인</a></li>
							</ul>

							<div class="tab-content mt-4">
								<div class="tab-pane active" id="step1">
									<c:import url="step1Basic.jsp" />
								</div>
								<div class="tab-pane" id="step2">
									<c:import url="step2Members.jsp" />
								</div>
								<div class="tab-pane" id="step3">
									<c:import url="step3Tasks.jsp" />
									<input type="hidden" name="taskListJson" id="taskListJson" />
								</div>
								<div class="tab-pane" id="step4">
									<c:import url="step4Details.jsp" />
								</div>
								<div class="tab-pane" id="step5">
									<c:import url="step5Confirm.jsp" />
								</div>
							</div>

							<div class="mt-4 d-flex justify-content-between">
								<button type="button" id="prevBtn" class="btn btn-secondary"
									disabled>이전</button>
								<button type="button" id="nextBtn" class="btn btn-primary">다음</button>
								<button type="submit" id="submitBtn"
									class="btn btn-success d-none">프로젝트 생성</button>
							</div>
						</div>
					</div>
				</form>
			</div>
		</section>
		<c:import url="../layout/footer.jsp" />
	</main>
	<c:import url="../layout/prescript.jsp" />
<script>
console.log("[script.js] 시작됨");

//======================= 전역 변수 =======================
let currentStep = 1;
const totalSteps = 5;
const taskList = [];
let currentTarget = null;

const selectedMembers = {
responsibleManager: [],
participants: [],
observers: []
};

//======================= 초기 실행 =======================
document.addEventListener("DOMContentLoaded", function () {
console.log("DOMContentLoaded 발생");

// 탭 이동 이벤트
document.querySelectorAll('.nav-link').forEach(link => {
  link.addEventListener('click', function (e) {
    e.preventDefault();
    goToStep(parseInt(this.getAttribute('data-step')));
  });
});

document.getElementById('prevBtn').addEventListener('click', prevStep);
document.getElementById('nextBtn').addEventListener('click', nextStep);

// 업무 추가 버튼
const addTaskBtn = document.getElementById('addTaskBtn');
if (addTaskBtn) {
  addTaskBtn.addEventListener('click', function () {
    const task = {
      taskNm: document.getElementById('taskNm').value,
      chargerEmpNm: document.getElementById('chargerEmpNm').value,
      chargerEmpno: document.getElementById('chargerEmpno').value,
      taskBeginDt: document.getElementById('taskBeginDt').value,
      taskEndDt: document.getElementById('taskEndDt').value,
      taskPriort: document.getElementById('taskPriort').value,
      taskGrad: document.getElementById('taskGrad').value,
      taskCn: document.getElementById('taskCn').value,
      parentTaskNm: document.getElementById('parentTaskNm').value || null
    };

    if (!task.taskNm || !task.chargerEmpNm) {
      alert('업무명과 담당자를 입력해주세요.');
      return;
    }

    taskList.push(task);
    updateTaskList();

    // 입력 초기화
    ['taskNm', 'chargerEmpNm', 'chargerEmpno', 'taskBeginDt', 'taskEndDt', 'taskCn', 'parentTaskNm'].forEach(id => {
      document.getElementById(id).value = '';
    });
    document.getElementById('taskPriort').selectedIndex = 0;
    document.getElementById('taskGrad').selectedIndex = 0;
  });
}

// form submit 시 업무 목록 포함
// 업무 목록을 만들어서 전송 폼에 넣어둔다.
const projectForm = document.getElementById('projectForm');
if (projectForm) {
  projectForm.addEventListener('submit', function () {
    const taskListJson = document.getElementById('taskListJson');
    if (taskListJson) {
      taskListJson.value = JSON.stringify(taskList);
    }
  });
}

// 조직도 선택 대상 지정
document.querySelectorAll('.open-org-chart').forEach(btn => {
  btn.addEventListener('click', function () {
    currentTarget = this.dataset.target;
    document.querySelectorAll('.open-org-chart').forEach(b => {
      b.classList.remove('btn-primary');
      b.classList.add('btn-outline-secondary');
    });
    this.classList.remove('btn-outline-secondary');
    this.classList.add('btn-primary');
  });
});

goToStep(currentStep);
loadOrgTree();
loadMemberButtons();
});

//======================= 탭 이동 함수 =======================
function goToStep(step) {
if (step < 1 || step > totalSteps) return;
currentStep = step;

for (let i = 1; i <= totalSteps; i++) {
  const stepDiv = document.getElementById('step' + i);
  const tabLink = document.querySelector(`a[data-step="${i}"]`);

  if (stepDiv) {
    stepDiv.style.display = (i === step) ? 'block' : 'none';
    stepDiv.classList.toggle('active', i === step);
  }
  if (tabLink) {
    tabLink.classList.toggle('active', i === step);
  }
}

updateButtonState();

// step 3으로 이동할 때 멤버 버튼 업데이트 
if (step === 3) {
  loadMemberButtons();
}

if (step === totalSteps) updateConfirmation();
}

function nextStep() {
if (currentStep < totalSteps) goToStep(currentStep + 1);
}

function prevStep() {
if (currentStep > 1) goToStep(currentStep - 1);
}

function updateButtonState() {
const prevBtn = document.getElementById('prevBtn');
const nextBtn = document.getElementById('nextBtn');
const submitBtn = document.getElementById('submitBtn');

if (!prevBtn || !nextBtn || !submitBtn) return;

prevBtn.disabled = (currentStep === 1);
if (currentStep === totalSteps) {
  nextBtn.classList.add('d-none');
  submitBtn.classList.remove('d-none');
} else {
  nextBtn.classList.remove('d-none');
  submitBtn.classList.add('d-none');
}
}

//======================= 업무 리스트 갱신 =======================
function updateTaskList() {
const taskListUl = document.getElementById('taskList');
if (!taskListUl) return;

taskListUl.innerHTML = '';

if (taskList.length === 0) {
  const li = document.createElement('li');
  li.className = 'list-group-item text-muted';
  li.innerText = '등록된 업무가 없습니다.';
  taskListUl.appendChild(li);
  return;
}

taskList.forEach((task, index) => {
  const li = document.createElement('li');
  li.className = 'list-group-item';
  li.innerHTML = `
    <div class="d-flex justify-content-between align-items-start">
      <div>
        <strong>${task.taskNm}</strong><br/>
        담당자: ${task.chargerEmpNm}<br/>
        기간: ${task.taskBeginDt || '미정'} ~ ${task.taskEndDt || '미정'}<br/>
        중요도: ${task.taskPriort || '-'}, 등급: ${task.taskGrad || '-'}<br/>
        ${task.parentTaskNm ? '상위 업무: ' + task.parentTaskNm + '<br/>' : ''}
        <span class="text-muted">${task.taskCn || '-'}</span>
      </div>
      <div>
        <button class="btn btn-sm btn-outline-secondary mb-1" onclick="prepareSubTask(${index})">하위 업무 추가</button><br/>
        <button class="btn btn-sm btn-outline-danger" onclick="removeTask(${index})">삭제</button>
      </div>
    </div>`;
  taskListUl.appendChild(li);
});
}

//======================= 하위 업무 준비 =======================
function prepareSubTask(index) {
const task = taskList[index];
const parentTaskInput = document.getElementById('parentTaskNm');
if (parentTaskInput) {
  parentTaskInput.value = task.taskNm;
}
}

//======================= 업무 삭제 =======================
function removeTask(index) {
taskList.splice(index, 1);
updateTaskList();
}

//======================= 인원 버튼 생성 =======================
function loadMemberButtons() {
const container = document.getElementById('memberSelectBtns');
if (!container) return;

console.log("멤버 버튼 로딩 - 선택된 인원:", selectedMembers);

container.innerHTML = ''; // 초기화

const roleColors = {
  responsibleManager: 'btn-danger',
  participants: 'btn-primary',
  observers: 'btn-secondary'
};

const roleNames = {
  responsibleManager: '책임자',
  participants: '참여자', 
  observers: '참조자'
};

// 디버깅 로그
console.log("선택된 멤버 데이터:", JSON.stringify(selectedMembers));

// 각 역할별 인원 버튼 생성
for (const role in selectedMembers) {
  const members = selectedMembers[role];
  
  members.forEach(member => {
    if (!member || typeof member !== 'object') {
      console.warn("잘못된 멤버 데이터:", member);
      return;
    }
    
    // 디버깅 로그
    console.log(`멤버 데이터(${role}):`, member);
    
    const btn = document.createElement('button');
    btn.type = 'button';
    btn.className = `btn ${roleColors[role]} btn-sm m-1`;
    
    // 이름이 undefined인 경우 처리
    const displayName = member.name || '이름 없음';
    const roleName = roleNames[role] || '역할 없음';
    
    btn.textContent = `${displayName} (${roleName})`;
    
    // 버튼 클릭 시 담당자로 설정
    btn.addEventListener('click', () => {
      const chargerInput = document.getElementById('chargerEmpNm');
      const chargerIdInput = document.getElementById('chargerEmpno');
      const parentTaskInput = document.getElementById('parentTaskNm');
      
      if (chargerInput) chargerInput.value = displayName;
      if (chargerIdInput) chargerIdInput.value = member.id || '';
      if (parentTaskInput) parentTaskInput.value = '';
    });
    
    container.appendChild(btn);
  });
}

// 인원이 없을 경우 안내 메시지 추가
if (container.children.length === 0) {
  const emptyMsg = document.createElement('div');
  emptyMsg.className = 'alert alert-info mt-2 small';
  emptyMsg.textContent = '인원 등록 탭에서 멤버를 추가하세요.';
  container.appendChild(emptyMsg);
}
}

//======================= 조직도 로딩 =======================
function loadOrgTree() {
  const treeContainer = document.getElementById('jstree');
  if (!treeContainer) {
    console.warn("jstree 요소가 존재하지 않습니다.");
    return;
  }

  console.log("조직도 데이터 로딩 시작");

  fetch("/organization")
    .then(resp => {
      if (!resp.ok) throw new Error(`조직도 데이터 로딩 실패: ${resp.status} ${resp.statusText}`);
      return resp.json();
    })
    .then(res => {
      console.log("조직도 데이터 수신 성공", res);
      console.log("직급 리스트", res.posList);

      const json = [];
      const deptMap = {};
      const posMap = {};

      // 부서명 매핑
      res.deptList.forEach(dept => {
        deptMap[dept.cmmnCode] = dept.cmmnCodeNm;
        json.push({
          id: dept.cmmnCode,
          parent: dept.upperCmmnCode || '#',
          text: dept.cmmnCodeNm,
          icon: "/assets/images/organization/depIcon.svg",
          deptYn: true
        });
      });

      // 직급명 매핑
      res.posList.forEach(pos => {
        posMap[pos.cmmnCode] = pos.cmmnCodeNm;
      });

      // 사원 정보 매핑
      res.empList.forEach(emp => {
        json.push({
          id: emp.emplNo,
          parent: emp.deptCode,
          text: emp.emplNm,
          icon: "/assets/images/organization/employeeImg.svg",
          deptYn: false,
          dept: deptMap[emp.deptCode] || '-',
          position: posMap[emp.clsfCode] || '-',
          phone: emp.telno || '-',
          email: emp.email || '-'
        });
      });

      // 기존 트리 제거 후 새로 생성
      $('#jstree').jstree('destroy');
      $('#jstree').jstree({
        core: {
          data: json,
          check_callback: true,
          themes: { responsive: false }
        },
        plugins: ["search"]
      });

      // 트리에서 노드 선택 시 이벤트
      $('#jstree').on("select_node.jstree", function (e, data) {
        const node = data.node;
        if (!node.original.deptYn) {
          const emp = {
            id: node.id,
            name: node.text,
            dept: node.original.dept || '-',
            position: node.original.position || '-',
            phone: node.original.phone || '-',
            email: node.original.email || '-'
          };

          console.log("선택된 직원 객체:", emp);

          if (!currentTarget) {
            console.warn("현재 선택된 타겟이 없습니다.");
            return;
          }

          const tableBody = document.querySelector("#selectedMembersTable tbody");
          if (!tableBody) return;

          const exists = Array.from(tableBody.children).some(row =>
            row.dataset.empId === emp.id && row.dataset.role === currentTarget
          );
          if (exists) return;

          const emptyRow = tableBody.querySelector('.empty-row');
          if (emptyRow) emptyRow.remove();

          let roleDisplayName = currentTarget === 'responsibleManager' ? '책임자' :
                                currentTarget === 'participants' ? '참여자' : '참조자';

          // 여기에 값이 찍혀야 하는데 왜!!! 
          const row = document.createElement("tr");
          row.dataset.empId = emp.id;
          row.dataset.role = currentTarget;
          row.innerHTML = `
            <td>${roleDisplayName}</td>
            <td>${emp.name || '이름없음'}</td>
            <td>${emp.dept || '부서없음'}</td>
            <td>${emp.position || '직급없음'}</td>
            <td>${emp.phone || '연락처없음'}</td>
            <td>${emp.email || '이메일없음'}</td>
            <td><button type="button" class="btn btn-sm btn-outline-danger remove-member">삭제</button></td>
          `;
          tableBody.appendChild(row);

          row.querySelector(".remove-member").addEventListener("click", function () {
            row.remove();
            selectedMembers[currentTarget] = selectedMembers[currentTarget].filter(p => p.id !== emp.id);

            const targetInput = document.getElementById(currentTarget);
            const targetEmpnoInput = document.getElementById(currentTarget + "Empno");

            if (targetInput) {
              targetInput.value = selectedMembers[currentTarget].map(p => p.name).join(', ');
            }
            if (targetEmpnoInput) {
              targetEmpnoInput.value = selectedMembers[currentTarget].map(p => p.id).join(',');
            }

            loadMemberButtons();
          });

          selectedMembers[currentTarget].push(emp);

          const targetInput = document.getElementById(currentTarget);
          const targetEmpnoInput = document.getElementById(currentTarget + "Empno");

          if (targetInput) {
            targetInput.value = selectedMembers[currentTarget].map(p => p.name).join(', ');
          }
          if (targetEmpnoInput) {
            targetEmpnoInput.value = selectedMembers[currentTarget].map(p => p.id).join(',');
          }

          loadMemberButtons();
        }
      });
    })
    .catch(error => {
      console.error("조직도 로딩 오류:", error);
    });
}

//======================= 프로젝트 요약 갱신 =======================
function updateConfirmation() {
const confirmFields = [
  { id: 'confirmPrjctNm', selector: '[name="prjctNm"]', defaultValue: '미입력' },
  { id: 'confirmCtgry', selector: '[name="ctgryNo"] option:checked', property: 'textContent', defaultValue: '미선택' },
  { id: 'confirmPrjctCn', selector: '[name="prjctCn"]', defaultValue: '미입력' },
  { id: 'confirmPrjctSttus', selector: '[name="prjctSttus"] option:checked', property: 'textContent', defaultValue: '미선택' },
  { id: 'confirmPrjctGrad', selector: '[name="prjctGrad"] option:checked', property: 'textContent', defaultValue: '미선택' },
  { id: 'confirmAmount', selector: '[name="prjctRcvordAmount"]', defaultValue: '0', formatter: value => `${value} 원` },
  { id: 'confirmAdres', selector: '#fullAddress', defaultValue: '미입력' },
  { id: 'confirmUrl', selector: '[name="prjctUrl"]', defaultValue: '미입력' }
];

confirmFields.forEach(field => {
  const element = document.getElementById(field.id);
  if (!element) return;
  
  const valueElement = document.querySelector(field.selector);
  if (!valueElement) {
    element.textContent = field.defaultValue;
    return;
  }
  
  let value = field.property ? valueElement[field.property] : valueElement.value;
  value = value || field.defaultValue;
  
  if (field.formatter) {
    value = field.formatter(value);
  }
  
  element.textContent = value;
});

// 기간 요약 설정
const periodElement = document.getElementById('confirmPeriod');
if (periodElement) {
  const beginDate = document.querySelector('[name="prjctBeginDate"]')?.value || '미정';
  const endDate = document.querySelector('[name="prjctEndDate"]')?.value || '미정';
  periodElement.textContent = `${beginDate} ~ ${endDate}`;
}

// 업무 목록 요약
const confirmTaskList = document.getElementById('confirmTaskList');
if (confirmTaskList) {
  confirmTaskList.innerHTML = '';
  
  if (taskList.length === 0) {
    confirmTaskList.textContent = '등록된 업무가 없습니다.';
  } else {
    taskList.forEach(task => {
      const div = document.createElement('div');
      div.className = 'mb-2';
      div.innerHTML = `<strong>${task.taskNm}</strong> - ${task.chargerEmpNm} (${task.taskBeginDt || '미정'} ~ ${task.taskEndDt || '미정'})`;
      confirmTaskList.appendChild(div);
    });
  }
}

// 선택된 인원 요약
const confirmMemberList = document.getElementById('confirmMemberList');
if (confirmMemberList) {
  const memberInfo = [];
  
  if (selectedMembers.responsibleManager.length > 0) {
    memberInfo.push("책임자: " + selectedMembers.responsibleManager.map(p => p.name).join(', '));
  }
  
  if (selectedMembers.participants.length > 0) {
    memberInfo.push("참여자: " + selectedMembers.participants.map(p => p.name).join(', '));
  }
  
  if (selectedMembers.observers.length > 0) {
    memberInfo.push("참조자: " + selectedMembers.observers.map(p => p.name).join(', '));
  }
  
  confirmMemberList.textContent = memberInfo.join(' | ') || '선택된 인원이 없습니다.';
}
}
</script>
</body>
</html>
