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

document.addEventListener("DOMContentLoaded", function () {
console.log("DOMContentLoaded 발생");

// 탭 내비게이션 이벤트 리스너
document.querySelectorAll('.nav-link').forEach(link => {
 link.addEventListener('click', function (e) {
   e.preventDefault();
   let step = parseInt(this.getAttribute('data-step'));
   goToStep(step);
 });
});

// 이전/다음/제출 버튼 이벤트 리스너
document.getElementById('prevBtn').addEventListener('click', prevStep);
document.getElementById('nextBtn').addEventListener('click', nextStep);

// 업무 추가 버튼
let addTaskBtn = document.getElementById('addTaskBtn');
if (addTaskBtn) {
 addTaskBtn.addEventListener('click', function () {
   console.log("[Click] addTaskBtn 클릭됨");
   let task = {
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
   console.log("업무 추가됨:", task);
   updateTaskList();
 });
}

// 폼 제출 시 업무 목록 JSON으로 변환
let projectForm = document.getElementById('projectForm');
projectForm.addEventListener('submit', function (e) {
 document.getElementById('taskListJson').value = JSON.stringify(taskList);
});

// 초기 버튼 상태 설정
goToStep(currentStep);
});

function goToStep(step) {
	  if (step < 1 || step > totalSteps) return;
	  currentStep = step;

	  for (let i = 1; i <= totalSteps; i++) {
	    const stepDiv = document.getElementById('step' + i);
	    const tabLink = document.querySelector(`.nav-link[data-step="${i}"]`);

	    if (stepDiv) {
	      if (i === step) {
	        stepDiv.classList.add('active');
	        stepDiv.style.display = 'block';
	      } else {
	        stepDiv.classList.remove('active');
	        stepDiv.style.display = 'none';
	      }
	    }

	    if (tabLink) {
	      if (i === step) {
	        tabLink.classList.add('active');
	      } else {
	        tabLink.classList.remove('active');
	      }
	    }
	  }

	  updateButtonState();

	  if (step === totalSteps) {
	    updateConfirmation();
	  }
	}


function nextStep() {
if (currentStep < totalSteps) {
 goToStep(currentStep + 1);
}
}

function prevStep() {
if (currentStep > 1) {
 goToStep(currentStep - 1);
}
}

function updateButtonState() {
	let prevBtn = document.getElementById('prevBtn');
	let nextBtn = document.getElementById('nextBtn');
	let submitBtn = document.getElementById('submitBtn');

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
	let taskListUl = document.getElementById('taskList');
taskListUl.innerHTML = '';

if (taskList.length === 0) {
	let li = document.createElement('li');
 li.className = 'list-group-item text-muted';
 li.innerText = '등록된 업무가 없습니다.';
 taskListUl.appendChild(li);
 return;
}

taskList.forEach((task, index) => {
	let li = document.createElement('li');
 li.className = 'list-group-item';
 li.innerHTML = `
   <div class="d-flex justify-content-between align-items-center">
     <div>
       <strong>${task.taskNm}</strong> - ${task.chargerEmpNm}
       (${task.taskBeginDt || '날짜 미지정'} ~ ${task.taskEndDt || '날짜 미지정'})
     </div>
     <button type="button" class="btn btn-sm btn-outline-danger delete-task" data-index="${index}">
       <i class="fas fa-trash"></i>
     </button>
   </div>
 `;
 taskListUl.appendChild(li);
});

document.querySelectorAll('.delete-task').forEach(btn => {
 btn.addEventListener('click', function () {
	 let index = parseInt(this.getAttribute('data-index'));
   taskList.splice(index, 1);
   updateTaskList();
 });
});
}

function updateConfirmation() {
document.getElementById('confirmPrjctNm').textContent = document.querySelector('[name="prjctNm"]').value || '미입력';
let ctgryText = document.querySelector('[name="ctgryNo"] option:checked')?.textContent || '미선택';
document.getElementById('confirmCtgry').textContent = ctgryText;
document.getElementById('confirmPrjctCn').textContent = document.querySelector('[name="prjctCn"]').value || '미입력';
let begin = document.querySelector('[name="prjctBeginDate"]').value || '미지정';
let end = document.querySelector('[name="prjctEndDate"]').value || '미지정';
document.getElementById('confirmPeriod').textContent = `${begin} ~ ${end}`;
document.getElementById('confirmPrjctSttus').textContent = document.querySelector('[name="prjctSttus"] option:checked')?.textContent || '미선택';
document.getElementById('confirmPrjctGrad').textContent = document.querySelector('[name="prjctGrad"] option:checked')?.textContent || '미선택';

let amount = document.querySelector('[name="prjctRcvordAmount"]').value || '0';
document.getElementById('confirmAmount').textContent = `${amount} 원`;
document.getElementById('confirmAdres').textContent = document.getElementById('fullAddress').value || '미입력';
document.getElementById('confirmUrl').textContent = document.querySelector('[name="prjctUrl"]').value || '미입력';
document.getElementById('confirmMemberList').textContent = '조직도 연동 후 구현 예정';

let confirmTaskList = document.getElementById('confirmTaskList');
confirmTaskList.innerHTML = '';

if (taskList.length === 0) {
 confirmTaskList.textContent = '등록된 업무가 없습니다.';
} else {
 taskList.forEach(task => {
	 let div = document.createElement('div');
   div.className = 'mb-2';
   div.innerHTML = `
     <strong>${task.taskNm}</strong> - ${task.chargerEmpNm}
     (${task.taskBeginDt || '날짜 미지정'} ~ ${task.taskEndDt || '날짜 미지정'})
     ${task.taskCn ? '<br><small class="text-muted">' + task.taskCn + '</small>' : ''}
   `;
   confirmTaskList.appendChild(div);
 });
}

console.log("최종 확인 데이터 업데이트 완료");
}

</script>
</body>
</html>
