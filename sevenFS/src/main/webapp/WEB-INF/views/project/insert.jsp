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

//전역 변수 및 초기화
let currentStep = 1;
const totalSteps = 5;
const taskList = [];
let currentTarget = null; // 조직도 선택 대상

const selectedMembers = {
responsibleManager: [],
participants: [],
observers: []
};

document.addEventListener("DOMContentLoaded", function () {
console.log("DOMContentLoaded 발생");

// 탭 내비게이션 이벤트 리스너
document.querySelectorAll('.nav-link').forEach(link => {
 link.addEventListener('click', function (e) {
   e.preventDefault();
   const step = parseInt(this.getAttribute('data-step'));
   goToStep(step);
 });
});

document.getElementById('prevBtn').addEventListener('click', prevStep);
document.getElementById('nextBtn').addEventListener('click', nextStep);

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
     taskCn: document.getElementById('taskCn').value
   };
   if (!task.taskNm || !task.chargerEmpNm) {
     alert('업무명과 담당자를 입력하세요.');
     return;
   }
   taskList.push(task);
   updateTaskList();
 });
}

const projectForm = document.getElementById('projectForm');
projectForm.addEventListener('submit', function () {
 document.getElementById('taskListJson').value = JSON.stringify(taskList);
});

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
});

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

prevBtn.disabled = (currentStep === 1);
if (currentStep === totalSteps) {
 nextBtn.classList.add('d-none');
 submitBtn.classList.remove('d-none');
} else {
 nextBtn.classList.remove('d-none');
 submitBtn.classList.add('d-none');
}
}

function updateTaskList() {
const taskListUl = document.getElementById('taskList');
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
 li.innerHTML = `<strong>${task.taskNm}</strong> - ${task.chargerEmpNm} (${task.taskBeginDt || '미정'} ~ ${task.taskEndDt || '미정'})`;
 taskListUl.appendChild(li);
});
}

function updateConfirmation() {
document.getElementById('confirmPrjctNm').textContent = document.querySelector('[name="prjctNm"]').value || '미입력';
document.getElementById('confirmCtgry').textContent = document.querySelector('[name="ctgryNo"] option:checked')?.textContent || '미선택';
document.getElementById('confirmPrjctCn').textContent = document.querySelector('[name="prjctCn"]').value || '미입력';
document.getElementById('confirmPeriod').textContent = `${document.querySelector('[name="prjctBeginDate"]').value} ~ ${document.querySelector('[name="prjctEndDate"]').value}`;
document.getElementById('confirmPrjctSttus').textContent = document.querySelector('[name="prjctSttus"] option:checked')?.textContent || '미선택';
document.getElementById('confirmPrjctGrad').textContent = document.querySelector('[name="prjctGrad"] option:checked')?.textContent || '미선택';
document.getElementById('confirmAmount').textContent = `${document.querySelector('[name="prjctRcvordAmount"]').value || '0'} 원`;
document.getElementById('confirmAdres').textContent = document.getElementById('fullAddress').value || '미입력';
document.getElementById('confirmUrl').textContent = document.querySelector('[name="prjctUrl"]').value || '미입력';

const confirmTaskList = document.getElementById('confirmTaskList');
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
document.getElementById('confirmMemberList').textContent = memberInfo.join(' | ') || '선택된 인원이 없습니다.';
}

function loadOrgTree() {
fetch("/organization")
 .then(resp => resp.json())
 .then(res => {
   const json = [];
   res.deptList.forEach(dep => {
     json.push({ id: dep.cmmnCode, parent: dep.upperCmmnCode, text: dep.cmmnCodeNm, deptYn: true });
   });
   res.empList.forEach(emp => {
     json.push({ id: emp.emplNo, parent: emp.deptCode, text: emp.emplNm, deptYn: false });
   });

   $('#jstree').jstree({ core: { data: json, check_callback: true }, plugins: ["search"] });

   $('#jstree').on("select_node.jstree", function (e, data) {
     if (data.node.original.deptYn === false) {
       const emp = {
         name: data.node.text,
         id: data.node.id,
         dept: data.node.original.deptName || '-',
         position: data.node.original.position || '-',
         phone: data.node.original.phone || '-',
         email: data.node.original.email || '-'
       };
	console.log("emp", emp);
       const tableBody = document.querySelector("#selectedMembersTable tbody");
       const exists = Array.from(tableBody.children).some(row => row.dataset.empId === emp.id && row.dataset.role === currentTarget);
       if (exists) return;

       const row = document.createElement("tr");
       row.dataset.empId = emp.id;
       row.dataset.role = currentTarget;
       row.innerHTML = `
         <td>${currentTarget}</td>
         <td>${emp.name}</td>
         <td>${emp.dept}</td>
         <td>${emp.position}</td>
         <td>${emp.phone}</td>
         <td>${emp.email}</td>
         <td><button type="button" class="btn btn-sm btn-outline-danger remove-member">삭제</button></td>
       `;
       tableBody.appendChild(row);

       row.querySelector(".remove-member").addEventListener("click", function () {
         row.remove();
         const list = selectedMembers[currentTarget];
         selectedMembers[currentTarget] = list.filter(p => p.id !== emp.id);
         document.getElementById(currentTarget).value = selectedMembers[currentTarget].map(p => p.name).join(', ');
         document.getElementById(currentTarget + "Empno").value = selectedMembers[currentTarget].map(p => p.id).join(',');
       });

       if (!selectedMembers[currentTarget].some(p => p.id === emp.id)) {
         selectedMembers[currentTarget].push(emp);
         document.getElementById(currentTarget).value = selectedMembers[currentTarget].map(p => p.name).join(', ');
         document.getElementById(currentTarget + "Empno").value = selectedMembers[currentTarget].map(p => p.id).join(',');
       }
     }
   });
 });
}

</script>
</body>
</html>
