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
    .form-step { display: none; }
    .form-step.active { display: block; }
</style>
</head>
<body>
  <c:import url="../layout/sidebar.jsp" />
  <main class="main-wrapper">
    <c:import url="../layout/header.jsp" />

    <section class="section">
      <div class="container-fluid">
        <h2 class="mb-4">프로젝트 생성</h2>

        <form id="projectForm" action="/project/insert" method="post" enctype="multipart/form-data">

          <ul class="nav nav-tabs" id="formTabs">
            <li class="nav-item"><a class="nav-link active" data-step="1" href="#">기본정보</a></li>
            <li class="nav-item"><a class="nav-link" data-step="2" href="#">인원등록</a></li>
            <li class="nav-item"><a class="nav-link" data-step="3" href="#">업무관리</a></li>
            <li class="nav-item"><a class="nav-link" data-step="4" href="#">세부정보</a></li>
            <li class="nav-item"><a class="nav-link" data-step="5" href="#">최종확인</a></li>
          </ul>


          <div class="mt-4">
            <div class="form-step active" id="step1"><c:import url="step1Basic.jsp" /></div>
            <div class="form-step" id="step2"><c:import url="step2Members.jsp" /></div>
            <div class="form-step" id="step3"><c:import url="step3Tasks.jsp" /></div>
            <div class="form-step" id="step4"><c:import url="step4Details.jsp" /></div>
            <div class="form-step" id="step5"><c:import url="step5Confirm.jsp" /></div>
          </div>


          <div class="mt-4 d-flex justify-content-between">
            <button type="button" id="prevBtn" class="btn btn-secondary" disabled>이전</button>
            <button type="button" id="nextBtn" class="btn btn-primary">다음</button>
            <button type="submit" id="submitBtn" class="btn btn-success d-none">프로젝트 생성</button>
          </div>
        </form>
      </div>
    </section>

    <c:import url="../layout/footer.jsp" />
  </main>
  <c:import url="../layout/prescript.jsp" />

<script>
  let currentStep = 1;
  const totalSteps = 5;

  const updateStepView = () => {
    for (let i = 1; i <= totalSteps; i++) {
      document.getElementById('step' + i).classList.remove('active');
    }
    document.getElementById('step' + currentStep).classList.add('active');

    document.getElementById('prevBtn').disabled = currentStep === 1;
    document.getElementById('nextBtn').classList.toggle('d-none', currentStep === totalSteps);
    document.getElementById('submitBtn').classList.toggle('d-none', currentStep !== totalSteps);
  };

  document.getElementById('nextBtn').addEventListener('click', () => {
    if (currentStep < totalSteps) {
      currentStep++;
      if (currentStep === 5) updateConfirmation();
      updateStepView();
    }
  });

  document.getElementById('prevBtn').addEventListener('click', () => {
    if (currentStep > 1) {
      currentStep--;
      updateStepView();
    }
  });

  // 업무 추가
  const taskList = [];
  document.getElementById('addTaskBtn')?.addEventListener('click', () => {
    const taskNm = document.getElementById('taskNm').value;
    const chargerEmpNm = document.getElementById('chargerEmpNm').value;
    const chargerEmpno = document.getElementById('chargerEmpno').value;
    const taskBeginDt = document.getElementById('taskBeginDt').value;
    const taskEndDt = document.getElementById('taskEndDt').value;
    const taskPriort = document.getElementById('taskPriort').value;
    const taskGrad = document.getElementById('taskGrad').value;
    const taskCn = document.getElementById('taskCn').value;

    if (!taskNm || !chargerEmpNm) {
      alert('업무명과 담당자를 입력하세요.');
      return;
    }

    const task = { taskNm, chargerEmpNm, chargerEmpno, taskBeginDt, taskEndDt, taskPriort, taskGrad, taskCn };
    taskList.push(task);
    updateTaskList();
  });

  const updateTaskList = () => {
    const taskListUl = document.getElementById('taskList');
    taskListUl.innerHTML = '';
    if (taskList.length === 0) {
      taskListUl.innerHTML = '<li class="list-group-item text-muted">등록된 업무가 없습니다.</li>';
      return;
    }

    taskList.forEach((task, i) => {
      const li = document.createElement('li');
      li.className = 'list-group-item';
      li.innerHTML = `<strong>${task.taskNm}</strong> - ${task.chargerEmpNm} (${task.taskBeginDt} ~ ${task.taskEndDt})`;
      taskListUl.appendChild(li);
    });
  };

  const updateConfirmation = () => {
    document.getElementById('confirmPrjctNm').textContent = document.querySelector('[name="prjctNm"]').value;
    document.getElementById('confirmCtgry').textContent = document.querySelector('[name="ctgryNo"] option:checked')?.textContent;
    document.getElementById('confirmPrjctCn').textContent = document.querySelector('[name="prjctCn"]').value;

    const begin = document.querySelector('[name="prjctBeginDate"]').value;
    const end = document.querySelector('[name="prjctEndDate"]').value;
    document.getElementById('confirmPeriod').textContent = `${begin} ~ ${end}`;

    document.getElementById('confirmPrjctSttus').textContent = document.querySelector('[name="prjctSttus"] option:checked')?.textContent;
    document.getElementById('confirmPrjctGrad').textContent = document.querySelector('[name="prjctGrad"] option:checked')?.textContent;

    document.getElementById('confirmAmount').textContent = document.querySelector('[name="prjctRcvordAmount"]').value + ' 원';
    document.getElementById('confirmAdres').textContent = document.getElementById('fullAddress').value;
    document.getElementById('confirmUrl').textContent = document.querySelector('[name="prjctUrl"]').value;

    document.getElementById('confirmMemberList').textContent = '조직도 연동 후 구현 예정';

    const confirmTaskList = document.getElementById('confirmTaskList');
    if (taskList.length === 0) {
      confirmTaskList.textContent = '등록된 업무가 없습니다.';
    } else {
      confirmTaskList.innerHTML = '';
      taskList.forEach(task => {
        const div = document.createElement('div');
        div.innerHTML = `<strong>${task.taskNm}</strong> - ${task.chargerEmpNm} (${task.taskBeginDt} ~ ${task.taskEndDt})`;
        confirmTaskList.appendChild(div);
      });
    }
  };
</script>
</body>
</html>
