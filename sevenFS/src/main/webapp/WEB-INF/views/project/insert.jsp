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

  <style>
    .form-step {
      padding-bottom: 2rem;
    }
    .step-indicator {
      font-weight: bold;
      text-align: right;
      font-size: 0.95rem;
    }

.step-label {
  font-size: 0.9rem;
  color: #ccc;
  font-weight: 500;
  text-align: center;
  flex: 1;
}
.step-label.active {
  color: #000; /* 강조 */
  font-weight: bold;
}
#progressStepLabels {
  gap: 0.5rem;
}
    
  </style>
</head>
<body>
  <c:import url="../layout/sidebar.jsp" />
  <main class="main-wrapper">
    <c:import url="../layout/header.jsp" />

    <section class="section">
      <div class="container-fluid">

		<!-- 진행바 영역 -->
		<div class="mb-3">
		  <div class="progress" role="progressbar" aria-valuemin="0" aria-valuemax="100">
		    <div id="progressBar" class="progress-bar progress-bar-striped progress-bar-animated text-center fw-bold" style="width: 20%;">
		      1/5
		    </div>
		  </div>
		  <div class="d-flex justify-content-between mt-2" id="progressStepLabels">
		    <span class="step-label active">기본정보</span>
		    <span class="step-label">인원등록</span>
		    <span class="step-label">업무관리</span>
		    <span class="step-label">세부정보</span>
		    <span class="step-label">최종확인</span>
		  </div>
		</div>


        <form id="projectForm" action="/project/insert" method="post" enctype="multipart/form-data">
          <div class="card">
            <div class="card-body">
              <!-- 탭 제거하고 단계별 컨텐츠만 출력 -->
              <div class="tab-content mt-3">
                <div class="tab-pane active" id="step1">
                  <c:import url="step1Basic.jsp" />
                </div>
                <div class="tab-pane" id="step2">
                  <c:import url="step2Members.jsp" />
                </div>
                <div class="tab-pane" id="step3">
                  <c:import url="step3Tasks.jsp" />
                </div>
                <div class="tab-pane" id="step4">
                  <c:import url="step4Details.jsp" />
                </div>
                <div class="tab-pane" id="step5">
                  <c:import url="step5Confirm.jsp" />
                </div>
              </div>

              <!-- 이전/다음/생성 버튼 -->
<div class="row g-2 mt-4" id="stepButtons">
  <div class="col-4">
    <button type="button" id="prevBtn" class="btn btn-secondary w-100 py-3 fw-bold">이전</button>
  </div>
  <div class="col-4" id="nextOrSubmitWrapper">
    <button type="button" id="nextBtn" class="btn btn-primary w-100 py-3 fw-bold">다음</button>
    <button type="submit" id="submitBtn" class="btn btn-success w-100 py-3 fw-bold d-none">
      <i class="fas fa-check me-2"></i> 프로젝트 생성
    </button>
  </div>
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


//진행바 
function updateProgress() {
  const progressPercentage = (currentStep / totalSteps) * 100;
  const progressBar = document.getElementById('progressBar');
  const stepLabels = document.querySelectorAll('#progressStepLabels .step-label');

  if (progressBar) {
    progressBar.style.width = progressPercentage + '%';
    progressBar.setAttribute('aria-valuenow', progressPercentage);
    progressBar.textContent = `\${currentStep}/\${totalSteps}`;
  }

  // 단계별 텍스트 강조 처리
  stepLabels.forEach((label, index) => {
    if (index === currentStep - 1) {
      label.classList.add('active');
    } else {
      label.classList.remove('active');
    }
  });
}




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
  const taskNmValue = document.getElementById('taskNm').value;
  const chargerEmpNmValue = document.getElementById('chargerEmpNm').value;
  const chargerEmpnoValue = document.getElementById('chargerEmpno').value;
  const parentTaskNmValue = document.getElementById('parentTaskNm').value;
  
  const uploadInput = document.getElementById('uploadTaskFiles');
  
  // 파일 객체를 직접 배열로 복사
  const taskFiles = [];
  for (let i = 0; i < uploadInput.files.length; i++) {
    const file = uploadInput.files[i];
    console.log(`파일 ${i+1}:`, file.name, file.size);
    taskFiles.push(file);
  }
  
  console.log("선택된 파일 수:", taskFiles.length);
  
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
    id: taskList.length + 1,
    taskNm: taskNmValue,
    chargerEmpNm: chargerEmpNmValue,
    chargerEmpno: chargerEmpnoValue,
    taskBeginDt: document.getElementById('taskBeginDt').value,
    taskEndDt: document.getElementById('taskEndDt').value,
    priort: document.getElementById('priort').value,
    taskGrad: document.getElementById('taskGrad').value,
    taskCn: document.getElementById('taskCn').value,
    parentTaskNm: parentTaskNmValue || null,
    parentIndex: parentIndex,
    upperTaskNo: null,
    files: taskFiles
  };
  
  // 여기서 부모 task가 있으면 부모의 id(taskNo로 매핑될 예정) 넣기
  if(parentIndex !== null && taskList[parentIndex]){
    task.upperTaskNo = taskList[parentIndex].id; // 이건 프론트 기준 id
  }
  
  console.log("업무 추가 후 taskList", taskList);
  taskList.push(task);
  updateTaskList();
  resetTaskForm();
  
  console.log("업무 추가 및 폼 초기화 완료", task);
});

// form submit 시 업무 목록 포함
// 업무 목록을 만들어서 전송 폼에 넣어둔다.
// form submit 시 업무 목록 포함
const projectForm = document.getElementById('projectForm');
if (projectForm) {
  projectForm.addEventListener('submit', function (e) {
    e.preventDefault(); // 폼 기본 제출 막기

    const formData = new FormData(projectForm); // 기존 form의 input 값 포함

    // 불필요한 필드 제거 (파일 필드는 직접 추가할 것이므로)
    formData.delete('uploadFiles');

    // 업무 목록 및 파일 추가
    taskList.forEach(({ id, chargerEmpNm, files, ...rest }, index) => {
      // 기본 필드 추가
      Object.entries(rest).forEach(([key, value]) => {
        formData.append(`taskList[\${index}].\${key}`, value);
      });

      // 파일 업로드 처리
      if (files && files.length > 0) {
        console.log(`업무 \${index}의 파일 개수:`, files.length);
        
        files.forEach((file, fileIndex) => {
          console.log(`파일 \${fileIndex} 정보:`, file.name, file.size);
          
          // 실제 File 객체인지 확인
          if (file instanceof File && file.size > 0) {
        	  formData.append(`uploadFiles_task_\${index}`, file);
          }
        });
      }
    });

    // 참여자 정보
    let empIndex = 0;
    for (const role in selectedMembers) {
      const roleCode = {
        responsibleManager: '00',
        participants: '01',
        observers: '02'
      }[role];

      selectedMembers[role].forEach(member => {
        formData.append(`projectEmpVOList[\${empIndex}].prtcpntEmpno`, member.id);
        formData.append(`projectEmpVOList[\${empIndex}].prtcpntRole`, roleCode);
        empIndex++;
      });
    }

    // 서버 전송
    fetch('/project/insert', {
      method: 'POST',
      body: formData
    })
    .then(res => {
      if (res.ok) {
        alert('등록 성공');
        location.href = "/project/tab";
      } else {
        return res.text().then(text => {
          console.error('등록 실패 응답:', text);
          alert('등록 실패');
        });
      }
    })
    .catch(err => {
      console.error("에러 발생:", err);
      alert("에러 발생: " + err.message);
    });
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


//프로젝트 날짜 검증
validateDates('[name="prjctBeginDate"]', '[name="prjctEndDate"]');
// 업무 날짜 검증
validateDates('#taskBeginDt', '#taskEndDt', '업무 종료일은 시작일 이후로 설정해야 합니다.');


goToStep(currentStep);
loadOrgTree();
loadMemberButtons();
});

//======================= 탭 이동 함수 =======================
function goToStep(step) {
  if (step < 1 || step > totalSteps) return;
  currentStep = step;

  // 기존 탭 내용 처리
for (let i = 1; i <= totalSteps; i++) {
  const stepDiv = document.getElementById('step' + i);
  if (stepDiv) {
	  if (i === step) {
	        stepDiv.classList.add('active');
	      } else {
	        stepDiv.classList.remove('active');
	      }
  }
}
console.log("goToStep 시작:", currentStep);

  updateButtonState();
  updateProgress(); // 진행바 업데이트
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
  if (task.priort) {
    switch(task.priort) {
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

	        </div>
	        <div class="mt-1">
	          <span class="badge \${badgeClass} me-1">\${task.chargerEmpNm}</span>
	          \${priorityBadge}
	          <span class="text-muted small">
	            \${task.taskGrad ? ' 등급: ' + task.taskGrad : ''}
	          </span>
	        </div>
	       
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
	  const priort = document.getElementById('priort');
	  const taskGrad = document.getElementById('taskGrad');
	  
	  if (task.priort && priort) {
	    for (let i = 0; i < priort.options.length; i++) {
	      if (priort.options[i].value === task.priort) {
	        priort.selectedIndex = i;
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


// 파일 입력란 초기화 함수 분리
function resetFileInput() {
  const oldFileInput = document.getElementById('uploadTaskFiles');
  const fileNameList = document.getElementById('fileNameList');

  if (oldFileInput) {
    console.log("파일 입력 필드 초기화 전:", oldFileInput.files.length);
    oldFileInput.value = '';
    console.log("파일 입력 필드 초기화 후:", oldFileInput.files.length);
    
    if (fileNameList) {
      fileNameList.innerHTML = '';
    }
  }
}

// 업무 폼 초기화 함수 수정
function resetTaskForm() {
  const formFields = ['taskNm', 'chargerEmpNm', 'chargerEmpno', 'taskBeginDt', 'taskEndDt', 'taskCn', 'parentTaskNm'];
  formFields.forEach(id => {
    const element = document.getElementById(id);
    if (element) element.value = '';
  });

  ['priort', 'taskGrad'].forEach(id => {
    const sel = document.getElementById(id);
    if (sel) sel.selectedIndex = 0;
  });

  // 파일 입력란 초기화 함수 호출
  resetFileInput();

  selectedParentTaskId = null;
  
  console.log('폼 초기화 완료');
}

//======================= 하위 업무 준비 =======================
function prepareSubTask(index) {
  // 404 오류 방지를 위해 AJAX 요청 제거
  
  // 선택한 업무 정보 가져오기
  const task = taskList[index];
  if (!task) return;
  
  resetTaskForm(); 
  
  // 상위 업무명 필드에 선택한 업무명 설정
  const parentTaskInput = document.getElementById('parentTaskNm');
  if (parentTaskInput) {
    parentTaskInput.value = task.taskNm;
  }
  
  // 업무명 필드 초기화 및 포커스
  const taskNmInput = document.getElementById('taskNm');
  if (taskNmInput) {
    taskNmInput.value = '';
    taskNmInput.focus();
  }
  
  // 스크롤을 폼 영역으로 이동
  const formCard = document.querySelector('.form-step .card');
  if (formCard) {
    formCard.scrollIntoView({ behavior: 'smooth' });
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
  document.getElementById('priort').value = task.priort;
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
  
  let hasMembers = false; // 전체 멤버 존재 여부 체크

  // 역할별 섹션 생성
  for (const role in selectedMembers) {
    const members = selectedMembers[role];

    if (members.length > 0) {
    	hasMembers = true;
    	  // 역할별 구분선 + 그룹 헤더
    	  const groupWrapper = document.createElement('div');
    	  groupWrapper.className = 'pt-3 mt-3 border-top border-secondary-subtle';

    	  // 역할 헤더
    	  const groupHeader = document.createElement('div');
    	  groupHeader.className = 'w-100 mb-2';
    	  groupHeader.innerHTML = `
    	    <span class="badge \${roleColors[role]} py-1 px-2">
    	      <i class="\${roleIcons[role]} me-1"></i> \${roleNames[role]}
    	    </span>
    	  `;
    	  groupWrapper.appendChild(groupHeader);

    	  // 버튼 그룹
    	  const buttonGroup = document.createElement('div');
    	  buttonGroup.className = 'd-flex flex-wrap gap-2';

    	  members.forEach(member => {
    	    if (!member || typeof member !== 'object') {
    	      console.warn("잘못된 멤버 데이터:", member);
    	      return;
    	    }

    	    const displayName = member.name || '이름 없음';

    	    const btn = document.createElement('button');
    	    btn.type = 'button';
    	    btn.className = `btn btn-outline-\${roleColors[role].replace('btn-', '')} rounded-3 text-start shadow-sm`;
    	    btn.style.minWidth = '120px';
    	    btn.style.fontSize = '0.85rem';
    	    btn.style.borderWidth = '1px';

    	    btn.innerHTML = `
    	      <i class="\${roleIcons[role]} me-1"></i> \${displayName}
    	      <div class="text-muted small">\${member.position || ''}</div>
    	    `;

    	    btn.addEventListener('click', () => {
    	      const chargerInput = document.getElementById('chargerEmpNm');
    	      const chargerIdInput = document.getElementById('chargerEmpno');

    	      if (chargerInput) chargerInput.value = displayName;
    	      if (chargerIdInput) chargerIdInput.value = member.id || '';

    	      document.querySelectorAll('#memberSelectBtns button').forEach(b => {
    	        b.classList.remove('active');
    	        b.style.borderWidth = '1px';
    	      });
    	      btn.classList.add('active');
    	      btn.style.borderWidth = '2px';
    	    });

    	    buttonGroup.appendChild(btn);
    	  });

    	  groupWrapper.appendChild(buttonGroup);
    	  container.appendChild(groupWrapper);
    	}
  }
  
  // 인원이 없을 경우 안내 메시지 추가
  if (!hasMembers) {
    const emptyMsg = document.createElement('div');
    emptyMsg.className = 'alert alert-info mt-2 small';
    emptyMsg.innerHTML = '<i class="fas fa-info-circle me-2"></i>인원 등록 탭에서 멤버를 추가하세요.';
    container.appendChild(emptyMsg);
  }
}



// 파일 이름만 리스트에 보여주는 곳
/* document.addEventListener("DOMContentLoaded", () => {
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
}); */

//파일 입력 필드에 변경 이벤트 리스너 추가 (파일추가 시 나오는 리스트)
document.getElementById('uploadTaskFiles').addEventListener('change', function(e) {
  const fileList = e.target.files;
  const fileNameList = document.getElementById('fileNameList');
  
  // 기존 목록 초기화
  fileNameList.innerHTML = '';
  
  // 파일이 없으면 메시지 표시
  if (fileList.length === 0) {
    fileNameList.innerHTML = '<li class="list-group-item text-muted">선택된 파일이 없습니다.</li>';
    return;
  }
  
  // 각 파일에 대한 목록 항목 생성
  for (let i = 0; i < fileList.length; i++) {
    const file = fileList[i];
    const li = document.createElement('li');
    li.className = 'list-group-item d-flex justify-content-between align-items-center';
    
    // 파일 이름과 아이콘 영역
    const fileInfo = document.createElement('div');
    fileInfo.innerHTML = `<i class="fas fa-file-alt me-2 text-primary"></i><span>\${file.name}</span>`;
    
    // 삭제 버튼
    const deleteBtn = document.createElement('button');
    deleteBtn.className = 'btn btn-sm btn-outline-danger';
    deleteBtn.innerHTML = '<i class="fas fa-times"></i>';
    deleteBtn.setAttribute('type', 'button');
    deleteBtn.onclick = function() {
      li.remove();
    };
    
    // 항목에 요소 추가
    li.appendChild(fileInfo);
    li.appendChild(deleteBtn);
    fileNameList.appendChild(li);
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
      if (!resp.ok) throw new Error(`조직도 데이터 로딩 실패: \${resp.status} \${resp.statusText}`);
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
    	      orgCard.style.maxHeight = '800px';
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
		  <td class="text-start ps-2">\${emp.dept || '부서없음'}</td>
		  <td class="text-center">\${emp.position || '직급없음'}</td>
		  <td class="text-center"><i class="fas fa-phone-alt me-1 text-muted"></i>\${emp.phone || '연락처없음'}</td>
		  <td class="text-start ps-2"><i class="fas fa-envelope me-1 text-muted"></i>\${emp.email || '이메일없음'}</td>
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
            
            const role = row.dataset.role; // <-- 삭제된 대상의 실제 역할을 여기서 가져옴
            
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

// 계층 구조 정렬을 위한 함수(최종확인에서 업무 목록을 계층형으로 보여주기 위함)
function getTaskHierarchySortedList(taskList) {
  const result = [];

  const parentTasks = taskList.filter(t => !t.parentTaskNm);
  parentTasks.forEach(parent => {
	  result.push(parent);
	  
  const children = taskList.filter(t => t.parentTaskNm === parent.taskNm);
  	result.push(...children);
  });
  return result;
  }


//===============세부 정보========================

	// 금액입력 시 자동 천단위 콤마 추가
	document.getElementById("amountInput").addEventListener("input", function(){
		  //숫자만 입력하도록 필터링 
		  let rawValue = this.value.replace(/[^0-9]/g, "");
		  
		  // amountInput에는 숫자만 유지
		  this.value = rawValue;
		  
		  // 천 단위 콤마 추가한 값 표시
		  document.getElementById("amountDisplay").textContent = 
			  rawValue ? Number(rawValue).toLocaleString('ko-KR') + "원": "0 원";
	});
	
// 주소 API 
function updateFullAddress() {
  const main = document.getElementById('restaurantAdd1').value.trim();
  const detail = document.getElementById('addressDetail').value.trim();
  const full = [main, detail].filter(Boolean).join(' ');

  // form 안의 hidden input을 직접 업데이트
  const prjctAdresInput = document.getElementById('prjctAdres');
  if (prjctAdresInput) {
    prjctAdresInput.value = full;
  }

  // 주소 확인란 업데이트
  const confirmAdresElement = document.getElementById('confirmAdres');
  if (confirmAdresElement) {
    confirmAdresElement.textContent = full || '미입력';
  }
  
  

  console.log("업데이트된 전체 주소:", full);
}
document.getElementById('restaurantAdd1').addEventListener('blur', updateFullAddress);
document.getElementById('addressDetail').addEventListener('blur', updateFullAddress);


//======================= 프로젝트 요약 갱신 =======================
function updateConfirmation() {
document.getElementById('confirmPrjctNm').textContent = '';
  // 1. 기본 정보 설정
    const prjctNm = document.querySelector('[name="prjctNm"]')?.value.trim() || '미입력';
    document.getElementById('confirmPrjctNm').textContent = prjctNm;
    console.log("prjctNm : ", prjctNm);
  
  document.getElementById('confirmCtgry').textContent = document.querySelector('[name="ctgryNo"] option:checked')?.textContent || '미선택';
  document.getElementById('confirmPrjctCn').textContent = document.querySelector('[name="prjctCn"]').value || '미입력';
  
  // 1-1. 기간 정보 수정
  const beginDate = document.querySelector('[name="prjctBeginDate"]').value || '미정';
  const endDate = document.querySelector('[name="prjctEndDate"]').value || '미정';
  document.getElementById('confirmPeriod').textContent = `\${beginDate} ~ \${endDate}`;
  
  document.getElementById('confirmPrjctSttus').textContent = document.querySelector('[name="prjctSttus"] option:checked')?.textContent || '미선택';
  document.getElementById('confirmPrjctGrad').textContent = document.querySelector('[name="prjctGrad"] option:checked')?.textContent || '미선택';
  
  // 4. 수주금액 수정
  const amount = document.querySelector('[name="prjctRcvordAmount"]').value || '0';
  document.getElementById('confirmAmount').textContent = `\${numberWithCommas(amount)} 원`;
  
  // 5. 주소 수정
  const prjctAdres = document.getElementById('prjctAdres')?.value || '미입력';
  const confirmAdresElement = document.getElementById('confirmAdres');
  if (confirmAdresElement) {
    confirmAdresElement.textContent = prjctAdres;
  }

  console.log(" 최종 주소 확인:", prjctAdres);
  
  
  console.log("fullAddress:", document.getElementById('fullAddress')?.value);
  console.log("prjctAdres:", document.querySelector('[name="prjctAdres"]')?.value);

  //6. url
  const prjctUrl = document.querySelector('[name="prjctUrl"]');
  let urlValue = prjctUrl?.value.trim() || '미입력';

  // URL에 프로토콜이 없으면 https:// 추가
  if (urlValue !== '미입력' && !urlValue.startsWith('https://') && !urlValue.startsWith('http://')) {
      urlValue = 'https://' + urlValue;
      // 실제 폼 제출 시 사용될 값도 업데이트
      prjctUrl.value = urlValue;
  }

  document.getElementById('confirmUrl').textContent = urlValue;

  // 2. 참여 인원 정보 개선
  const confirmMemberList = document.getElementById('confirmMemberList');
  /*   if (confirmMemberList) {
    confirmMemberList.innerHTML = '';   */
    
 /*    // 역할별로 구분하여 표시
    const roles = [
      { key: 'responsibleManager', label: '책임자', icon: 'fas fa-user-tie' },
      { key: 'participants', label: '참여자', icon: 'fas fa-user-check' },
      { key: 'observers', label: '참조자', icon: 'fas fa-user-clock' }
    ];
    
    roles.forEach(role => {
      if (selectedMembers[role.key].length > 0) {
        const roleDiv = document.createElement('div');
        roleDiv.className = 'mb-2';
        roleDiv.innerHTML = `
          <strong><i class="\${role.icon} me-2"></i>\${role.label}:</strong> 
          \${selectedMembers[role.key].map(p => p.name).join(', ')}
        `;
        confirmMemberList.appendChild(roleDiv);
      }
    });
    
    // 선택된 인원이 없는 경우
    if (confirmMemberList.children.length === 0) {
      confirmMemberList.textContent = '선택된 인원이 없습니다.';
    }
  }
 */
  // 3. 업무 목록 요약 개선
  
   const confirmResponsible = document.getElementById('confirmResponsible');
   const confirmParticipants = document.getElementById('confirmParticipants');
   const confirmObservers = document.getElementById('confirmObservers');

   if (confirmResponsible) {
	   confirmResponsible.innerHTML = selectedMembers.responsibleManager
	     .map(p => `
	       <button type="button" class="btn btn-outline-danger rounded-3 text-start shadow-sm"
	               style="min-width: 120px; font-size: 0.85rem; border-width: 1px;">
	         <i class="fas fa-user-tie me-1" aria-hidden="true"></i> \${p.name}
	         <div class="text-muted small">\${p.position || ''}</div>
	       </button>
	     `).join('');
	 }

	 if (confirmParticipants) {
	   confirmParticipants.innerHTML = selectedMembers.participants
	     .map(p => `
	       <button type="button" class="btn btn-outline-primary rounded-3 text-start shadow-sm"
	               style="min-width: 120px; font-size: 0.85rem; border-width: 1px;">
	         <i class="fas fa-user-check me-1" aria-hidden="true"></i> \${p.name}
	         <div class="text-muted small">\${p.position || ''}</div>
	       </button>
	     `).join('');
	 }

	 if (confirmObservers) {
	   confirmObservers.innerHTML = selectedMembers.observers
	     .map(p => `
	       <button type="button" class="btn btn-outline-secondary rounded-3 text-start shadow-sm"
	               style="min-width: 120px; font-size: 0.85rem; border-width: 1px;">
	         <i class="fas fa-user-clock me-1" aria-hidden="true"></i> \${p.name}
	         <div class="text-muted small">\${p.position || ''}</div>
	       </button>
	     `).join('');
	 }

  
// 최종확인의 업무 테이블 
 const confirmTaskList = document.getElementById('confirmTaskList'); 

 if (confirmTaskList) {
   confirmTaskList.innerHTML = '';

   if (taskList.length === 0) {
     const emptyMsg = document.createElement('div');
     emptyMsg.className = 'text-center text-muted py-3';
     emptyMsg.textContent = '등록된 업무가 없습니다.';
     confirmTaskList.appendChild(emptyMsg);
   } else {
     const table = document.createElement('table');
     table.className = 'table table-sm table-bordered';

     // 헤더 구성
     const thead = document.createElement('thead');
     const headerRow = document.createElement('tr');
     headerRow.className = 'table-light';

     const headers = ['업무명', '담당자', '기간', '중요도', '등급'];
     headers.forEach(text => {
       const th = document.createElement('th');
       th.textContent = text;
       th.style.textAlign = 'center';
       headerRow.appendChild(th);
     });

     thead.appendChild(headerRow);
     table.appendChild(thead);

     const tbody = document.createElement('tbody');
     const sortedTaskList = getTaskHierarchySortedList(taskList); // 계층 정렬된 리스트

     sortedTaskList.forEach(task => {
       const tr = document.createElement('tr');

       if (task.parentTaskNo) {
         tr.classList.add('table-light');
       }

       // 1. 업무명 셀
       const nameCell = document.createElement('td');
       const indent = task.depth ? 15 + task.depth * 20 : 15;

       nameCell.innerHTML = `
         <div style="margin-left:\${indent}px;">
           \${task.upperTaskNo ? '<i class="fas fa-level-up-alt fa-rotate-90 me-2 text-primary"></i>' : ''}
           <strong>\${task.taskNm || ''}</strong>
         </div>
       `;
       tr.appendChild(nameCell);

       // 2. 담당자 셀
       const chargerCell = document.createElement('td');
       chargerCell.style.textAlign = 'center';

       let badgeClass = 'bg-secondary';

       // 역할에 따라 뱃지 색상 지정
       if (typeof selectedMembers !== 'undefined') {
         for (const role in selectedMembers) {
           const found = selectedMembers[role].some(m => m.name === task.chargerEmpNm);
           if (found) {
             if (role === 'responsibleManager') badgeClass = 'bg-danger';
             else if (role === 'participants') badgeClass = 'bg-primary';
             else if (role === 'observers') badgeClass = 'bg-secondary';
             break;
           }
         }
       }

       const chargerBadge = document.createElement('span');
       chargerBadge.className = `badge \${badgeClass}`;
       chargerBadge.textContent = task.chargerEmpNm || '-';
       chargerCell.appendChild(chargerBadge);
       tr.appendChild(chargerCell);

       // 3. 기간 셀
       const periodCell = document.createElement('td');
       periodCell.style.textAlign = 'center';
       periodCell.textContent = `\${task.taskBeginDt || '미정'} ~ \${task.taskEndDt || '미정'}`;
       tr.appendChild(periodCell);

       // 4. 중요도
       const priorityCell = document.createElement('td');
       priorityCell.style.textAlign = 'center';

       let priorityBadge = '';
       switch(task.priort) {
         case '00': priorityBadge = '<span class="badge bg-success me-1">낮음</span>'; break;
         case '01': priorityBadge = '<span class="badge bg-info me-1">보통</span>'; break;
         case '02': priorityBadge = '<span class="badge bg-warning me-1">높음</span>'; break;
         case '03': priorityBadge = '<span class="badge bg-danger me-1">긴급</span>'; break;
         default: priorityBadge = '-';
       }
       priorityCell.innerHTML = priorityBadge;
       tr.appendChild(priorityCell);

       // 5. 등급
       const gradeCell = document.createElement('td');
       gradeCell.style.textAlign = 'center';

       if (task.taskGrad) {
         gradeCell.innerHTML = `<span class="badge bg-warning text-dark">\${task.taskGrad}</span>`;
       } else {
         gradeCell.textContent = '-';
       }

       tr.appendChild(gradeCell);

       tbody.appendChild(tr);
     });

     table.appendChild(tbody);
     confirmTaskList.appendChild(table);
   }
 }

}// 최종확인의 닫힘

// 숫자에 천 단위 쉼표 추가 함수
function numberWithCommas(x) {
  return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}



//======================유효성 검사 ==============================
	// 날짜 유효성 검증 (시작일-종료일 비교)
function validateDates(startDateSelector, endDateSelector, customMessage) {
  const startDateInput = document.querySelector(startDateSelector);
  const endDateInput = document.querySelector(endDateSelector);
  
  if(!startDateInput || !endDateInput) return; // 요소가 없으면 종료
  
  const errorMessage = customMessage || '종료일은 시작일 이후로 설정해야 합니다.';
  
  // 종료일 변경 시 시작일과 비교
  endDateInput.addEventListener('change', function() {
    if(startDateInput.value && endDateInput.value) {
      if(new Date(endDateInput.value) < new Date(startDateInput.value)) {
        alert(errorMessage);
        endDateInput.value = '';
      }
    }
  });
  
  // 시작일 변경 시 종료일과 비교
  startDateInput.addEventListener('change', function() {
    if(startDateInput.value && endDateInput.value) {
      if(new Date(endDateInput.value) < new Date(startDateInput.value)) {
        alert('시작일은 종료일 이전으로 설정해야 합니다.');
        startDateInput.value = '';
      }
    }
  });
}



</script>
</body>
</html>
