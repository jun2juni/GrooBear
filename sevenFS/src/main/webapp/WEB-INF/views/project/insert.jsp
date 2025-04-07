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
let totalSteps = 5;
let taskList = [];
let taskCounter =1;
let selectedParentTaskId = null;
let currentTarget = null;

const selectedMembers = {
responsibleManager: [],
participants: [],
observers: []
};

//======================= 초기 실행 =======================
document.addEventListener("DOMContentLoaded", function () {
console.log("DOMContentLoaded 발생");

// 테이블 디자인 개선
const membersTable = document.getElementById('selectedMembersTable');
if (membersTable) {
  // 테이블에 클래스 추가
  membersTable.classList.add('table-hover', 'shadow-sm');
  
  // 테이블 헤더 스타일 개선
  const thead = membersTable.querySelector('thead');
  if (thead) {
    thead.classList.add('table-dark');
  }
  
  // 빈 행 스타일 개선
  const emptyRow = membersTable.querySelector('.empty-row');
  if (emptyRow) {
    emptyRow.querySelector('td').innerHTML = '<div class="alert alert-light m-0 text-center"><i class="fas fa-users-slash me-2"></i>선택된 인원이 없습니다.</div>';
  }
}



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
document.getElementById('addTaskBtn').addEventListener('click', function () {
  const taskNmValue = document.getElementById('taskNm').value.trim();
  const parentTaskNmValue = document.getElementById('parentTaskNm').value.trim();
  const chargerEmpNmValue = document.getElementById('chargerEmpNm').value.trim();
  const chargerEmpnoValue = document.getElementById('chargerEmpno').value;
  
  if (!taskNmValue) {
    alert('업무명을 입력해주세요.');
    return;
  }
  
  if (!chargerEmpNmValue) {
    alert('담당자를 선택해주세요.');
    return;
  }
  
  // parentTaskNm이 있으면 해당 부모 업무의 인덱스 찾기
  let parentIndex = null;
  if (parentTaskNmValue) {
    parentIndex = taskList.findIndex(t => t.taskNm === parentTaskNmValue);
  }
  
  const task = {
    id: `task-${taskList.length + 1}`,
    taskNm: taskNmValue,
    chargerEmpNm: chargerEmpNmValue,
    chargerEmpno: chargerEmpnoValue,
    taskBeginDt: document.getElementById('taskBeginDt').value,
    taskEndDt: document.getElementById('taskEndDt').value,
    taskPriort: document.getElementById('taskPriort').value,
    taskGrad: document.getElementById('taskGrad').value,
    taskCn: document.getElementById('taskCn').value,
    parentTaskNm: parentTaskNmValue || null,
    parentIndex: parentIndex
  };

  taskList.push(task);
  updateTaskList();
  resetTaskForm();
});


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
  const tabLink = document.querySelector(`a[data-step="\${i}"]`);

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
  
  // 계층적 구조로 업무 표시
  renderTaskHierarchy(taskListUl);
}

// 업무를 계층적으로 표시하는 함수
function renderTaskHierarchy(container) {
  // 최상위 업무(부모가 없는 업무)만 먼저 처리
  const topLevelTasks = taskList.filter(task => !task.parentTaskNm);
  
  topLevelTasks.forEach((task, idx) => {
    // 1. 상위 업무 렌더링
    const taskIndex = taskList.indexOf(task);
    const li = createTaskListItem(task, taskIndex, false);
    container.appendChild(li);
    
    // 2. 해당 상위 업무의 하위 업무 찾기
    const childTasks = taskList.filter(t => t.parentTaskNm === task.taskNm);
    
    // 3. 하위 업무 렌더링
    childTasks.forEach(childTask => {
      const childIndex = taskList.indexOf(childTask);
      const childLi = createTaskListItem(childTask, childIndex, true);
      container.appendChild(childLi);
    });
  });
}

//업무 목록 아이템 생성 함수
function createTaskListItem(task, index, isSubTask) {
  const li = document.createElement('li');
  li.className = 'list-group-item';
  
  // 하위 업무 스타일 적용
  if (isSubTask) {
    li.style.paddingLeft = '30px';
    li.style.borderLeft = '3px solid #0d6efd';
    li.style.backgroundColor = '#f8f9fa'; 
  }
  
  // 담당자 역할에 따른 뱃지 클래스 결정
  let badgeClass = 'bg-secondary';
  
  // 책임자, 참여자, 참조자 구분
  for (const role in selectedMembers) {
    const found = selectedMembers[role].some(m => m.name === task.chargerEmpNm);
    if (found) {
      if (role === 'responsibleManager') badgeClass = 'bg-danger';
      else if (role === 'participants') badgeClass = 'bg-primary';
      break;
    }
  }
  
  // 중요도에 따른 라벨
  let priorityBadge = '';
  if (task.taskPriort) {
    switch(task.taskPriort) {
      case '00': priorityBadge = '<span class="badge bg-success me-1">낮음</span>'; break;
      case '01': priorityBadge = '<span class="badge bg-info me-1">보통</span>'; break;
      case '02': priorityBadge = '<span class="badge bg-warning me-1">높음</span>'; break;
      case '03': priorityBadge = '<span class="badge bg-danger me-1">긴급</span>'; break;
    }
  }
  
  // 하위 업무 아이콘 표시 (ㄴ 대신 시각적 요소로 대체)
  let taskPrefix = '';
  if (isSubTask) {
    taskPrefix = '<i class="fas fa-level-up-alt fa-rotate-90 text-primary me-2"></i>';
  }
  
  li.innerHTML = `
	    <div class="d-flex justify-content-between align-items-start">
	      <div>
	        <div class="d-flex align-items-center">
	          \${taskPrefix}<strong>\${task.taskNm}</strong>
	          \${isSubTask ? '<span class="badge bg-light text-dark ms-2">하위업무</span>' : ''}
	        </div>
	        <div class="mt-1">
	          <span class="badge \${badgeClass} me-1">\${task.chargerEmpNm}</span>
	          \${priorityBadge}
	          <span class="text-muted small">
	            \${task.taskGrad ? ' 등급: ' + task.taskGrad : ''}
	          </span>
	        </div>
	        \${task.taskCn ? '<div class="text-muted small mt-1">' + task.taskCn + '</div>' : ''}
	      </div>
	      <div>
	        \${isSubTask ? 
	          '<div class="badge bg-primary text-white p-2 mb-2 rounded-pill shadow-sm"><i class="fas fa-tasks me-1"></i>하위업무</div>' : 
	          `<button class="btn btn-sm btn-outline-secondary mb-1" onclick="prepareSubTask(\${index})">하위 업무</button>`
	        }
	        <br/>
	        <button class="btn btn-sm btn-outline-danger" onclick="removeTask(\${index})">삭제</button>
	      </div>
	    </div>`;
  
  // 업무 클릭 시 폼에 채우기 (버튼 누를 때는 제외)
  li.addEventListener('click', function(e) {
    if (e.target.tagName === 'BUTTON') return;
    fillTaskForm(index);
  });
  
  return li;
}

// 폼에 업무 정보를 채우는 함수
function fillTaskForm(index) {
	  const task = taskList[index];
	  if (!task) return;
	  
	  document.getElementById('taskNm').value = task.taskNm;
	  document.getElementById('chargerEmpNm').value = task.chargerEmpNm;
	  document.getElementById('chargerEmpno').value = task.chargerEmpno;
	  document.getElementById('taskBeginDt').value = task.taskBeginDt;
	  document.getElementById('taskEndDt').value = task.taskEndDt;
	  document.getElementById('taskCn').value = task.taskCn;
	  document.getElementById('parentTaskNm').value = task.parentTaskNm || '';
	  
	  // Select 요소 설정
	  const taskPriort = document.getElementById('taskPriort');
	  const taskGrad = document.getElementById('taskGrad');
	  
	  if (task.taskPriort && taskPriort) {
	    for (let i = 0; i < taskPriort.options.length; i++) {
	      if (taskPriort.options[i].value === task.taskPriort) {
	        taskPriort.selectedIndex = i;
	        break;
	      }
	    }
	  }
	  
	  if (task.taskGrad && taskGrad) {
	    for (let i = 0; i < taskGrad.options.length; i++) {
	      if (taskGrad.options[i].value === task.taskGrad) {
	        taskGrad.selectedIndex = i;
	        break;
	      }
	    }
	  }
	}


//업무 폼 초기화 함수
function resetTaskForm() {
  const formFields = ['taskNm', 'chargerEmpNm', 'chargerEmpno', 'taskBeginDt', 'taskEndDt', 'taskCn', 'parentTaskNm'];
  formFields.forEach(id => {
    const element = document.getElementById(id);
    if (element) element.value = '';
  });
  
  const selects = ['taskPriort', 'taskGrad'];
  selects.forEach(id => {
    const element = document.getElementById(id);
    if (element) element.selectedIndex = 0;
  });
  
  // 기존 코드에서 사용하던 변수가 있다면 초기화
  if (typeof selectedParentTaskId !== 'undefined') {
    selectedParentTaskId = null;
  }
}



//======================= 하위 업무 준비 =======================
function prepareSubTask(index) {
  const task = taskList[index];
  const parentTaskInput = document.getElementById('parentTaskNm');
  if (parentTaskInput) {
    parentTaskInput.value = task.taskNm;
    // 업무명은 비워두지 않고 그대로 유지 
  }
}


//======================= 업무 삭제 =======================
function removeTask(index) {
taskList.splice(index, 1);
updateTaskList();
}


// 업무 리스트 클릭시 폼 채우기
function fillTaskForm(index) {
  const task = taskList[index];
  document.getElementById('taskNm').value = task.taskNm;
  document.getElementById('chargerEmpNm').value = task.chargerEmpNm;
  document.getElementById('chargerEmpno').value = task.chargerEmpno;
  document.getElementById('taskBeginDt').value = task.taskBeginDt;
  document.getElementById('taskEndDt').value = task.taskEndDt;
  document.getElementById('taskCn').value = task.taskCn;
  document.getElementById('taskPriort').value = task.taskPriort;
  document.getElementById('taskGrad').value = task.taskGrad;
  document.getElementById('parentTaskNm').value = task.parentTaskNm;
  selectedParentTaskId = task.parentIndex;
}



//======================= 인원 버튼 생성 =======================
function loadMemberButtons() {
  const container = document.getElementById('memberSelectBtns');
  if (!container) return;
  
  container.innerHTML = ''; // 초기화

  const roleColors = {
    responsibleManager: 'btn-danger',
    participants: 'btn-primary',
    observers: 'btn-secondary'
  };
  
  const roleIcons = {
    responsibleManager: 'fas fa-user-tie',     // 책임자 아이콘
    participants: 'fas fa-user-check',         // 참여자 아이콘
    observers: 'fas fa-user-clock'             // 참조자 아이콘
  };
  
  const roleNames = {
    responsibleManager: '책임자',
    participants: '참여자', 
    observers: '참조자'
  };
  
  // 역할별 섹션 생성
  for (const role in selectedMembers) {
    const members = selectedMembers[role];
    
    if (members.length > 0) {
      // 역할별 그룹 헤더 생성
      const groupHeader = document.createElement('div');
      groupHeader.className = 'w-100 mb-2 mt-2';
      groupHeader.innerHTML = `
        <span class="badge \${roleColors[role]} py-1 px-2">
          <i class="\${roleIcons[role]} me-1"></i> \${roleNames[role]}
        </span>
      `;
      container.appendChild(groupHeader);
      
      // 역할별 버튼 그룹 생성
      const buttonGroup = document.createElement('div');
      buttonGroup.className = 'd-flex flex-wrap gap-1 mb-3';
      
      // 각 멤버별 버튼 생성
      members.forEach(member => {
        if (!member || typeof member !== 'object') {
          console.warn("잘못된 멤버 데이터:", member);
          return;
        }
        
        const displayName = member.name || '이름 없음';
        
        // 새로운 카드 스타일 버튼
        const btn = document.createElement('button');
        btn.type = 'button';
        btn.className = `btn btn-outline-${roleColors[role].replace('btn-', '')} rounded-3 text-start shadow-sm m-1`;
        btn.style.minWidth = '120px';
        btn.style.fontSize = '0.85rem';
        btn.style.borderWidth = '1px';
        
        btn.innerHTML = `
          <i class="\${roleIcons[role]} me-1"></i> \${displayName}
          <div class="text-muted small">\${member.position || ''}</div>
        `;
        
        // 버튼 클릭 시 담당자로 설정
        btn.addEventListener('click', () => {
          const chargerInput = document.getElementById('chargerEmpNm');
          const chargerIdInput = document.getElementById('chargerEmpno');
          
          if (chargerInput) chargerInput.value = displayName;
          if (chargerIdInput) chargerIdInput.value = member.id || '';
          
          // 선택된 버튼 하이라이트
          document.querySelectorAll('#memberSelectBtns button').forEach(b => {
            b.classList.remove('active');
            b.style.borderWidth = '1px';
          });
          btn.classList.add('active');
          btn.style.borderWidth = '2px';
        });
        
        buttonGroup.appendChild(btn);
      });
      
      container.appendChild(buttonGroup);
    }
  }

  // 인원이 없을 경우 안내 메시지 추가
  if (container.children.length === 0) {
    const emptyMsg = document.createElement('div');
    emptyMsg.className = 'alert alert-info mt-2 small';
    emptyMsg.innerHTML = '<i class="fas fa-info-circle me-2"></i>인원 등록 탭에서 멤버를 추가하세요.';
    container.appendChild(emptyMsg);
  }
}

// 파일 이름만 리스트에 보여주는 곳
document.addEventListener("DOMContentLoaded", () => {
  const fileInput = document.getElementById('uploadTaskFiles');
  const fileNameList = document.getElementById('fileNameList');

  if (fileInput && fileNameList) {
    fileInput.addEventListener('change', function () {
      fileNameList.innerHTML = '';

      const files = Array.from(this.files);
      const maxFiles = 5;

      if (files.length > maxFiles) {
        alert(`최대 \${maxFiles}개까지 업로드할 수 있습니다.`);
        fileInput.value = ''; // 초기화
        return;
      }

      files.forEach(file => {
        const li = document.createElement('li');
        li.className = 'list-group-item';
        li.textContent = file.name;
        fileNameList.appendChild(li);
      });
    });
  }
});


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
      }).on('ready.jstree', function(){
    	  //jstree가 로드된 후 컨테이너 스타일 설정
    	  const jstreeContainer = document.getElementById('jstree');
    	  if(jstreeContainer){
    		  jstreeContainer.style.maxHeight = '500px';
    		  jstreeContainer.style.overflow = 'auto';
    	  }
    	  
    	  // 조직도 전체 컨테이너에도 스타일 적용
    	    const orgCard = document.querySelector('.col-md-4 .card');
    	    if (orgCard) {
    	      orgCard.style.maxHeight = '600px';
    	      orgCard.style.overflow = 'auto';
    	    }
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

          // 프로젝트 참여 인원 목록
          const row = document.createElement("tr");
          row.dataset.empId = emp.id;
          row.dataset.role = currentTarget;
          
          // 역할별 배경색 설정
          let roleClass = '';
          let roleIcon = '';
          if (currentTarget === 'responsibleManager') {
            roleClass = 'table-danger';
            roleIcon = 'fas fa-user-tie';
          } else if (currentTarget === 'participants') {
            roleClass = 'table-primary';
            roleIcon = 'fas fa-user-check';
          } else {
            roleClass = 'table-secondary'; 
            roleIcon = 'fas fa-user-clock';
          }

          // 행에 배경색 클래스 추가
          row.className = roleClass;
          
          // 하이픈 포맷 적용
          let formattedPhone = emp.phone;
          const onlyNums = formattedPhone.replace(/[^0-9]/g, '');

          if (onlyNums.length === 11) {
            formattedPhone = onlyNums.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
          } else if (onlyNums.length === 10) {
            if (onlyNums.startsWith('02')) {
              formattedPhone = onlyNums.replace(/(\d{2})(\d{4})(\d{4})/, '$1-$2-$3');
            } else {
              formattedPhone = onlyNums.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
            }
          }

          emp.phone = formattedPhone; // <- 업데이트

          // 직원 목록 테이블화
          row.innerHTML = `
        	  <td class="text-center">
        	    <span class="badge \${currentTarget === 'responsibleManager' ? 'bg-danger' : 
        	                        currentTarget === 'participants' ? 'bg-primary' : 
        	                        'bg-secondary'} p-2">
        	      <i class="\${roleIcon} me-1"></i> \${roleDisplayName}
        	    </span>
        	  </td>
        	  <td class="text-center"><strong>\${emp.name || '이름없음'}</strong></td>
        	  <td class="text-center">\${emp.dept || '부서없음'}</td>
        	  <td class="text-center">\${emp.position || '직급없음'}</td>
        	  <td class="text-center"><i class="fas fa-phone-alt me-1 text-muted"></i>\${emp.phone || '연락처없음'}</td>
        	  <td class="text-center"><i class="fas fa-envelope me-1 text-muted"></i>\${emp.email || '이메일없음'}</td>
        	  <td class="text-center">
        	    <button type="button" class="btn btn-sm btn-outline-danger remove-member">
        	      <i class="fas fa-times"></i>
        	    </button>
        	  </td>
        	`;
          tableBody.appendChild(row);

          
          //직원 목록에서 삭제하는 기능
          row.querySelector(".remove-member").addEventListener("click", function () {
            row.remove();
            selectedMembers[currentTarget] = selectedMembers[currentTarget].filter(p => p.id !== emp.id);

            const targetInput = document.getElementById(currentTarget);
            const targetEmpnoInput = document.getElementById(currentTarget + "Empno");

            if (targetInput) {
                // 삭제 후 남은 멤버가 있으면 이름 목록 표시, 없으면 빈 문자열
                if (selectedMembers[currentTarget].length > 0) {
                  targetInput.value = selectedMembers[currentTarget].map(p => p.name).join(', ');
                } else {
                  targetInput.value = ''; // 완전히 비우기
                }
              }
              
              if (targetEmpnoInput) {
                // 삭제 후 남은 멤버가 있으면 ID 목록 표시, 없으면 빈 문자열
                if (selectedMembers[currentTarget].length > 0) {
                  targetEmpnoInput.value = selectedMembers[currentTarget].map(p => p.id).join(',');
                } else {
                  targetEmpnoInput.value = ''; // 완전히 비우기
                }
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
