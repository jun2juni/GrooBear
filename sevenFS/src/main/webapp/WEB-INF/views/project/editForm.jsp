<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="title" value="프로젝트 수정" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>${title}</title>
  <c:import url="../layout/prestyle.jsp" />
</head>
<body>
  <c:import url="../layout/sidebar.jsp" />
  <main class="main-wrapper">
    <c:import url="../layout/header.jsp" />
    <section class="section">
      <div class="container-fluid">
		<form id="projectForm" action="/project/update" method="post" enctype="multipart/form-data">
          <input type="hidden" name="prjctNo" value="${project.prjctNo}" />
          <div class="row">
            <div class="col-md-8">
              <div class="card p-4 shadow-sm">
                <h4 class="fw-bold mb-4"><i class="fas fa-edit me-2 text-primary"></i>프로젝트 수정</h4>

                <!-- 1. 기본 정보 -->
                <h5 class="fw-semibold mb-2">1. 기본 정보</h5>
                
               <div class="row g-3 align-items-end">
				  <div class="col-md-6">
				    <label class="form-label fw-semibold">프로젝트명<span class="text-danger">*</span></label>
				    <input type="text" name="prjctNm" class="form-control" value="${project.prjctNm}" required />
				  </div>
				  <div class="col-md-6">
				    <label class="form-label fw-semibold">사업 분류 <span class="text-danger">*</span></label>
				    <select name="ctgryNo" class="form-select" required>
				      <option value="">사업 분류를 선택하세요</option>
				      <option value="1" ${project.ctgryNo == 1 ? 'selected' : ''}>국가지원사업</option>
				      <option value="2" ${project.ctgryNo == 2 ? 'selected' : ''}>법인자체사업</option>
				      <option value="3" ${project.ctgryNo == 3 ? 'selected' : ''}>산학협력사업</option>
				      <option value="4" ${project.ctgryNo == 4 ? 'selected' : ''}>민간수주사업</option>
				      <option value="5" ${project.ctgryNo == 5 ? 'selected' : ''}>해외협력사업</option>
				    </select>
				  </div>
				  <!-- 프로젝트 설명 (내용) -->
					<div class="mb-3">
					  <label class="form-label fw-semibold">프로젝트 설명 <span class="text-danger">*</span></label>
					  <textarea name="prjctCn" class="form-control" rows="4" required>${project.prjctCn}</textarea>
					</div>
				  
				  
				</div>

                <!-- 2. 참여 인원 -->
                <h5 class="fw-semibold mb-2 mt-4">2. 참여 인원</h5>
                <div class="btn-group mb-3" role="group">
                  <button type="button" class="btn btn-outline-danger open-org-chart" data-target="responsibleManager">책임자</button>
                  <button type="button" class="btn btn-outline-primary open-org-chart" data-target="participants">참여자</button>
                  <button type="button" class="btn btn-outline-secondary open-org-chart" data-target="observers">참조자</button>
                </div>
                <div class="table-responsive">
                  <table class="table table-bordered table-hover" id="selectedMembersTable">
                    <thead>
                      <tr class="table-light text-center">
                        <th>역할</th>
                        <th>이름</th>
                        <th>부서명</th>
                        <th>직급</th>
                        <th>연락처</th>
                        <th>이메일</th>
                        <th>삭제</th>
                      </tr>
                    </thead>
                    <tbody>
						<c:forEach var="emp" items="${project.projectEmpVOList}">
						  <tr data-empno="${emp.prtcpntEmpno}">
						    <td class="text-center">
							<c:choose>
							  <c:when test="${emp.prtcpntRole eq '00'}">책임자</c:when>
							  <c:when test="${emp.prtcpntRole eq '01'}">참여자</c:when>
							  <c:when test="${emp.prtcpntRole eq '02'}">참조자</c:when>
							  <c:otherwise>알 수 없음</c:otherwise>
							</c:choose>
						    </td>
						    <td>${emp.emplNm}</td>
						    <td>${emp.deptNm}</td>
						    <td>${emp.posNm}</td>
						    <td>${emp.telno}</td>
						    <td>${emp.email}</td>
						    <td class="text-center">
						      <button type="button" class="btn btn-sm btn-outline-danger" onclick="this.closest('tr').remove()">삭제</button>
						    </td>
						  </tr>
						</c:forEach>

                    </tbody>
                  </table>
                </div>

                <!-- 3. 세부 정보 -->
                <h5 class="fw-semibold mb-2 mt-4">3. 세부 정보</h5>
                <div class="row g-3">
                  <div class="col-md-3">
                    <label class="form-label fw-semibold">시작일<span class="text-danger">*</span></label>
                    <input type="date" name="prjctBeginDate" class="form-control" value="${project.prjctBeginDateFormatted}" />
                  </div>
                  <div class="col-md-3">
                    <label class="form-label fw-semibold">종료일<span class="text-danger">*</span></label>
                    <input type="date" name="prjctEndDate" class="form-control" value="${project.prjctEndDateFormatted}" />
                  </div>
                  
		          <div class="col-md-3">
		            <div class="mb-4">
		              <label class="form-label fw-semibold">프로젝트 상태 <span class="text-danger">*</span></label>
		              <select name="prjctSttus" class="form-select" required>
		                <option value="">선택하세요</option>
		                <option value="00" selected>대기</option>
		                <option value="01">진행중</option>
		                <option value="02">완료</option>
		                <option value="03">취소</option>
		              </select>
		            </div>
		          </div>
		
		          <div class="col-md-3">
		            <div class="mb-4">
		              <label class="form-label fw-semibold">프로젝트 등급 <span class="text-danger">*</span></label>
		              <select name="prjctGrad" class="form-select" required>
		                <option value="">선택하세요</option>
		                <option value="A">A</option>
		                <option value="B">B</option>
		                <option value="C" selected>C</option>
		                <option value="D">D</option>
		                <option value="E">E</option>
		              </select>
		            </div>
		          </div>
                  
                  
                  <div class="col-md-6">
                    <label class="form-label fw-semibold">수주 금액</label>
                    <input type="number" name="prjctRcvordAmount" class="form-control" value="${project.prjctRcvordAmount}" />
                  </div>
                  <div class="col-md-6">
                    <label class="form-label fw-semibold">URL</label>
                    <input type="url" name="prjctUrl" class="form-control" value="${project.prjctUrl}" />
                  </div>
                  <div class="col-12">
                    <label class="form-label fw-semibold">주소</label>
                    <input type="text" name="prjctAdres" class="form-control" value="${project.prjctAdres}" />
                  </div>
                </div>
                <div class="mt-4 d-flex justify-content-between">
                  <a href="/project/tab?tab=list" class="btn btn-secondary">목록</a>
                  <button type="submit" class="btn btn-primary">수정 완료</button>
                </div>
              </div>
            </div>

		  <div class="col-md-4">
		    <div class="card border rounded-3 shadow-sm">
		      <div class="card-body p-4">
		        <h5 class="card-title fw-bold mb-4">
		          <i class="fas fa-sitemap text-primary me-2"></i>조직도
		        </h5>
		         <div class="">
		        	 <div class="mb-1">
		 		  	<c:import url="../organization/searchBar.jsp"></c:import>
		 		  	</div>
					<div class="card-style overflow-scroll" style="max-height: 90vh;" >
				  		<c:import url="../organization/orgList.jsp" />
					</div>
				  </div>
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

//변수 선언
let currentTarget = "participants"; // 기본값

// DOM 로드 시 초기화
document.addEventListener('DOMContentLoaded', function() {
  console.log("페이지 로드됨, 초기화 중...");
  
  // 날짜 필드 포맷팅
  formatDateFields();
  
  // 조직도 로드
  loadOrgTree();
  
  // 기존 행 스타일링
  styleExistingRows();
  
  // 폼 제출 이벤트 설정
  setupFormSubmission();
  
  // 버튼 이벤트 설정
  setupButtonEvents();
  
  console.log("초기화 완료");
});

// 날짜 필드 포맷팅
function formatDateFields() {
  const beginDateInput = document.querySelector('[name="prjctBeginDate"]');
  const endDateInput = document.querySelector('[name="prjctEndDate"]');
  
  if (beginDateInput && beginDateInput.value) {
    const beginDate = formatDateForInput(beginDateInput.value);
    beginDateInput.value = beginDate;
    console.log("시작일 포맷팅:", beginDate);
  }
  
  if (endDateInput && endDateInput.value) {
    const endDate = formatDateForInput(endDateInput.value);
    endDateInput.value = endDate;
    console.log("종료일 포맷팅:", endDate);
  }
}

// 날짜 문자열을 input date 형식으로 변환
function formatDateForInput(dateStr) {
  if (!dateStr) return '';
  
  // 숫자만 추출
  const digitsOnly = dateStr.replace(/\D/g, '');
  
  // YYYYMMDD 형식인 경우 (8자리)
  if (digitsOnly.length === 8) {
    return `\${digitsOnly.substring(0, 4)}-\${digitsOnly.substring(4, 6)}-\${digitsOnly.substring(6, 8)}`;
  }
  
  // 이미 YYYY-MM-DD 형식인 경우
  if (dateStr.includes('-') && dateStr.length === 10) {
    return dateStr;
  }
  
  return dateStr;
}

// 버튼 이벤트 설정
function setupButtonEvents() {
  // 역할 버튼 이벤트
  document.querySelectorAll('.open-org-chart').forEach(btn => {
    btn.addEventListener('click', function () {
      currentTarget = this.dataset.target;
      console.log("현재 대상 변경:", currentTarget);
      
      document.querySelectorAll('.open-org-chart').forEach(b => {
        b.classList.remove('btn-primary', 'btn-danger', 'btn-secondary', 'active');
        b.classList.add('btn-outline-primary');
      });
      
      this.classList.remove('btn-outline-primary');
      this.classList.add('active');
      
      if (currentTarget === 'responsibleManager') this.classList.add('btn-danger');
      else if (currentTarget === 'participants') this.classList.add('btn-primary');
      else if (currentTarget === 'observers') this.classList.add('btn-secondary');
    });
  });
  
  // 기본 버튼 활성화
  const defaultBtn = document.querySelector('.open-org-chart[data-target="participants"]');
  if (defaultBtn) {
    defaultBtn.click();
  }
}

// 조직도 로딩 함수
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
      console.log("조직도 데이터 수신 성공");

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
      if (res.posList && res.posList.length > 0) {
        res.posList.forEach(pos => {
          posMap[pos.cmmnCode] = pos.cmmnCodeNm;
        });
      }

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
        // jstree가 로드된 후 스타일 설정
        const jstreeContainer = document.getElementById('jstree');
        if(jstreeContainer){
          jstreeContainer.style.maxHeight = '500px';
          jstreeContainer.style.overflow = 'auto';
        }
      });

      // 트리에서 노드 선택 시 이벤트
      $('#jstree').on("select_node.jstree", function (e, data) {
        if (data.node.original.deptYn) {
          // 부서 노드 클릭
          if (typeof clickDept === "function") {
            clickDept(data);
          }
        } else {
          // 사원 노드 클릭
          if (typeof clickEmp === "function") {
            clickEmp(data);
          }
        }
      });
    })
    .catch(error => {
      console.error("조직도 로딩 오류:", error);
    });
}

// 사원 클릭 시 참여자 테이블에 추가
function clickEmp(data) {
  const node = data.node;
  if (!node || node.original.deptYn === true) return;

  console.log("선택된 사원:", node.text);

  // 조직도에서는 id로 사원번호를 전달합니다
  const empno = node.id;
  
  // 중복 방지
  if (document.querySelector(`#selectedMembersTable tbody tr[data-empno="\${empno}"]`)) {
    console.log("이미 선택된 사원입니다:", empno);
    return;
  }

  // 직원 객체 생성
  const emp = {
    id: node.id,
    name: node.text,
    dept: node.original.dept || '-',
    position: node.original.position || '-',
    phone: node.original.phone || '-',
    email: node.original.email || '-'
  };

  let roleLabel = "";
  let badgeClass = "";
  let roleIcon = "";

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

  // 빈 테이블 행 제거
  const tbody = document.querySelector("#selectedMembersTable tbody");
  const emptyRow = tbody.querySelector(".empty-row");
  if (emptyRow) emptyRow.remove();

  // 전화번호 포맷팅
  let formattedPhone = emp.phone;
  if (formattedPhone && formattedPhone !== '-') {
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
  }
  
  // 새 행 추가
  const tr = document.createElement("tr");
  tr.setAttribute("data-empno", empno);
  tr.setAttribute("data-role", currentTarget);
  
  // 행에 클래스 추가
  if (currentTarget === 'responsibleManager') {
    tr.className = 'table-danger';
  } else if (currentTarget === 'participants') {
    tr.className = 'table-primary';
  } else {
    tr.className = 'table-secondary';
  }
  
  tr.innerHTML = `
    <td class="text-center">
      <span class="badge \${badgeClass} p-2">
        <i class="\${roleIcon} me-1"></i> \${roleLabel}
      </span>
    </td>
    <td class="text-center"><strong>\${emp.name}</strong></td>
    <td class="text-center">\${emp.dept}</td>
    <td class="text-center">\${emp.position}</td>
    <td class="text-center"><i class="fas fa-phone-alt me-1 text-muted"></i>\${formattedPhone}</td>
    <td class="text-start ps-3"><i class="fas fa-envelope me-1 text-muted"></i>\${emp.email}</td>
    <td class="text-center">
      <button type="button" class="btn btn-sm btn-outline-danger" onclick="removeParticipant(this)">
        <i class="fas fa-times"></i>
      </button>
    </td>
    <input type="hidden" name="projectEmpVOList[0].prtcpntEmpno" value="\${empno}">
    <input type="hidden" name="projectEmpVOList[0].prtcpntRole" value="\${currentTarget}">
    <input type="hidden" name="projectEmpVOList[0].prjctAuthor" value="0000">
    <input type="hidden" name="projectEmpVOList[0].evlManEmpno" value="\${empno}">
    <input type="hidden" name="projectEmpVOList[0].evlCn" value="프로젝트 참여">
    <input type="hidden" name="projectEmpVOList[0].evlGrad" value="1">
    <input type="hidden" name="projectEmpVOList[0].secsnYn" value="N">
  `;
  
  tbody.appendChild(tr);
  
  // 인덱스 업데이트
  updateProjectEmpIndexes();
}

// 삭제 버튼 클릭 시 참여자 제거
function removeParticipant(button) {
  const row = button.closest('tr');
  const empno = row.getAttribute('data-empno');
  console.log("사원을 테이블에서 제거합니다:", empno);
  row.remove();
  
  // 테이블이 비었는지 확인
  const tbody = document.querySelector("#selectedMembersTable tbody");
  if (tbody.children.length === 0) {
    const emptyRow = document.createElement('tr');
    emptyRow.className = 'empty-row';
    emptyRow.innerHTML = `
      <td colspan="7" class="text-center text-muted py-4">
        <i class="fas fa-info-circle me-1"></i> 선택된 인원이 없습니다. 
        조직도에서 프로젝트 참여자를 선택해주세요.
      </td>
    `;
    tbody.appendChild(emptyRow);
  }
  
  // 인덱스 재조정
  updateProjectEmpIndexes();
}

// 인덱스 업데이트 함수
function updateProjectEmpIndexes() {
  const participants = document.querySelectorAll('#selectedMembersTable tbody tr:not(.empty-row)');
  participants.forEach((row, index) => {
    const hiddenInputs = row.querySelectorAll('input[type="hidden"]');
    hiddenInputs.forEach(input => {
      if (input.name.includes('projectEmpVOList')) {
        // projectEmpVOList[숫자].필드명 형식을 projectEmpVOList[index].필드명으로 변경
        input.name = input.name.replace(/projectEmpVOList\[\d+\]/, `projectEmpVOList[\${index}]`);
      }
    });
  });
}

// 기존 행 스타일링
function styleExistingRows() {
  const rows = document.querySelectorAll('#selectedMembersTable tbody tr');
  if (rows.length === 0) return;
  
  console.log("기존 행 스타일링:", rows.length);
  
  rows.forEach(row => {
    const roleCell = row.querySelector('td:first-child');
    if (!roleCell) return;
    
    const roleText = roleCell.textContent.trim();
    let roleClass, badgeClass, roleIcon, roleLabel;
    
    // 역할에 따른 스타일 결정
    if (roleText.includes('책임자')) {
      roleClass = 'table-danger';
      badgeClass = 'bg-danger';
      roleIcon = 'fas fa-user-tie';
      roleLabel = '책임자';
    } else if (roleText.includes('참여자')) {
      roleClass = 'table-primary';
      badgeClass = 'bg-primary';
      roleIcon = 'fas fa-user-check';
      roleLabel = '참여자';
    } else {
      roleClass = 'table-secondary';
      badgeClass = 'bg-secondary';
      roleIcon = 'fas fa-user-clock';
      roleLabel = '참조자';
    }
    
    // 행 클래스 설정
    row.className = roleClass;
    
    // 역할 셀 스타일링
    roleCell.className = "text-center";
    roleCell.innerHTML = `
      <span class="badge \${badgeClass} p-2">
        <i class="\${roleIcon} me-1"></i> \${roleLabel}
      </span>
    `;
    
    // 이름 셀 스타일링
    const nameCell = row.querySelector('td:nth-child(2)');
    if (nameCell) {
      nameCell.className = "text-center";
      nameCell.innerHTML = `<strong>\${nameCell.textContent.trim()}</strong>`;
    }
    
    // 부서명 셀 스타일링
    const deptCell = row.querySelector('td:nth-child(3)');
    if (deptCell) {
      deptCell.className = "text-center";
    }
    
    // 직급 셀 스타일링
    const positionCell = row.querySelector('td:nth-child(4)');
    if (positionCell) {
      positionCell.className = "text-center";
    }
    
    // 전화번호 셀 스타일링
    const phoneCell = row.querySelector('td:nth-child(5)');
    if (phoneCell) {
      let phoneText = phoneCell.textContent.trim();
      
      // 전화번호 하이픈 처리
      const onlyNums = phoneText.replace(/[^0-9]/g, '');
      if (onlyNums.length === 11) {
        phoneText = onlyNums.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
      } else if (onlyNums.length === 10) {
        if (onlyNums.startsWith('02')) {
          phoneText = onlyNums.replace(/(\d{2})(\d{4})(\d{4})/, '$1-$2-$3');
        } else {
          phoneText = onlyNums.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
        }
      }
      
      phoneCell.className = "text-center";
      phoneCell.innerHTML = `<i class="fas fa-phone-alt me-1 text-muted"></i>\${phoneText}`;
    }
    
    // 이메일 셀 스타일링
    const emailCell = row.querySelector('td:nth-child(6)');
    if (emailCell) {
      emailCell.className = "text-start ps-3";
      emailCell.innerHTML = `<i class="fas fa-envelope me-1 text-muted"></i>\${emailCell.textContent.trim()}`;
    }
    
    // 삭제 버튼 스타일링
    const deleteCell = row.querySelector('td:nth-child(7)');
    if (deleteCell) {
      const btn = deleteCell.querySelector('button');
      if (btn) {
        btn.className = "btn btn-sm btn-outline-danger";
        btn.innerHTML = '<i class="fas fa-times"></i>';
        btn.setAttribute('onclick', 'removeParticipant(this)');
      }
      deleteCell.className = "text-center";
    }
  });
}

// 폼 제출 시 날짜 형식 변환 추가
function setupFormSubmission() {
  const form = document.querySelector('form');
  if (!form) return;
  
  form.addEventListener('submit', function(e) {
    e.preventDefault();
    
 // PRJCT_CN 필드 확인 및 기본값 설정
    const prjctCnInput = document.querySelector('[name="prjctCn"]');
    if (!prjctCnInput || !prjctCnInput.value.trim()) {
      // PRJCT_CN이 없거나 비어있으면 기본값 추가
      const hiddenPrjctCn = document.createElement('input');
      hiddenPrjctCn.type = 'hidden';
      hiddenPrjctCn.name = 'prjctCn';
      hiddenPrjctCn.value = '프로젝트 내용 없음'; // 기본값 설정
      form.appendChild(hiddenPrjctCn);
      console.log("프로젝트 내용 기본값 설정");
    }
    
    // 전송할 데이터 확인 (콘솔 로그)
    const formDataForLog = new FormData(form);
    console.log("전송 전 데이터:");
    for (let [key, value] of formDataForLog.entries()) {
      console.log(`\${key}: \${value}`);
    }
    
    // 날짜 형식 변환 (YYYY-MM-DD → YYYYMMDD)
    const beginDateInput = document.querySelector('[name="prjctBeginDate"]');
    const endDateInput = document.querySelector('[name="prjctEndDate"]');
    
    if (beginDateInput && beginDateInput.value) {
      // 하이픈 제거
      const formattedBeginDate = beginDateInput.value.replace(/-/g, '');
      console.log("변환된 시작일:", formattedBeginDate);
      
      // 히든 필드로 원래 형식 전송
      const hiddenBeginDate = document.createElement('input');
      hiddenBeginDate.type = 'hidden';
      hiddenBeginDate.name = 'prjctBeginDate';
      hiddenBeginDate.value = formattedBeginDate;
      form.appendChild(hiddenBeginDate);
      
      // 원래 필드 이름 변경 (충돌 방지)
      beginDateInput.name = 'prjctBeginDateDisplay';
    }
    
    if (endDateInput && endDateInput.value) {
      // 하이픈 제거
      const formattedEndDate = endDateInput.value.replace(/-/g, '');
      console.log("변환된 종료일:", formattedEndDate);
      
      // 히든 필드로 원래 형식 전송
      const hiddenEndDate = document.createElement('input');
      hiddenEndDate.type = 'hidden';
      hiddenEndDate.name = 'prjctEndDate';
      hiddenEndDate.value = formattedEndDate;
      form.appendChild(hiddenEndDate);
      
      // 원래 필드 이름 변경 (충돌 방지)
      endDateInput.name = 'prjctEndDateDisplay';
    }
    
    // 프로젝트 번호 확인
    const prjctNo = document.querySelector('input[name="prjctNo"]').value;
    if (!prjctNo) {
      alert('프로젝트 번호가 없습니다.');
      return false;
    }
    
    // 참여자 정보 수집
    const empNos = [];
    const empRoles = [];
    
    const participants = document.querySelectorAll('#selectedMembersTable tbody tr:not(.empty-row)');
    if (participants.length === 0) {
      alert('최소 한 명 이상의 참여자를 선택해주세요.');
      return false;
    }
    
    participants.forEach(row => {
      const empNoInput = row.querySelector('input[name$=".prtcpntEmpno"]');
      const roleInput = row.querySelector('input[name$=".prtcpntRole"]');
      
      if (empNoInput && roleInput) {
        empNos.push(empNoInput.value);
        
        // 역할 코드 변환
        let roleCode = '01'; // 기본값: 참여자
        const roleValue = roleInput.value;
        if (roleValue === 'responsibleManager') roleCode = '00';
        else if (roleValue === 'observers') roleCode = '02';
        
        empRoles.push(roleCode);
      }
    });
    
    // FormData 생성 및 데이터 추가
    const formData = new FormData(form);
    
    // 기존 필드 제거 후 재추가
    formData.delete('emp_no');
    formData.delete('emp_role');
    
    empNos.forEach(empNo => formData.append('emp_no', empNo));
    empRoles.forEach(role => formData.append('emp_role', role));
    
    // 최종 전송 데이터 확인
    console.log("최종 전송 데이터:");
    for (let [key, value] of formData.entries()) {
      console.log(`\${key}: \${value}`);
    }
    
 // 모든 필수 필드 확인
    const requiredFields = ['prjctNo', 'ctgryNo', 'prjctNm', 'prjctCn', 'prjctSttus', 'prjctGrad'];
    const missingFields = [];

    requiredFields.forEach(fieldName => {
      const field = document.querySelector(`[name="${fieldName}"]`);
      if (!field || !field.value.trim()) {
        missingFields.push(fieldName);
        
        // 기본값 설정 (가능한 경우)
        if (fieldName === 'prjctCn') {
          const hiddenField = document.createElement('input');
          hiddenField.type = 'hidden';
          hiddenField.name = fieldName;
          hiddenField.value = '프로젝트 내용 없음';
          form.appendChild(hiddenField);
          console.log(`필드 '\${fieldName}'에 기본값 설정`);
        }
      }
    });

    if (missingFields.length > 0) {
      console.warn("누락된 필수 필드:", missingFields);
    }
    
    
    // AJAX 요청 전송
    console.log("프로젝트 수정 요청 전송...");
    fetch('/project/update', {
      method: 'POST',
      body: formData
    })
    .then(response => {
      console.log("서버 응답 상태:", response.status);
      
      // 응답 본문 확인 (성공/실패 상관없이)
      return response.text().then(text => {
        try {
          // JSON 응답인지 확인
          const json = JSON.parse(text);
          console.log("서버 응답 (JSON):", json);
          return { ok: response.ok, data: json, text: text };
        } catch (e) {
          // 일반 텍스트 응답
          console.log("서버 응답 (텍스트):", text);
          return { ok: response.ok, text: text };
        }
      });
    })
    .then(result => {
      if (result.ok) {
        console.log("프로젝트 수정 성공!");
        window.location.href = `/project/projectDetail?prjctNo=\${prjctNo}`;
      } else {
        console.error("응답 본문:", result.text);
        throw new Error('프로젝트 수정 실패');
      }
    })
    .catch(error => {
      console.error('오류 발생:', error);
      alert('프로젝트 수정 중 오류가 발생했습니다. 콘솔을 확인하세요.');
    });
  });
}

</script>

</body>
</html>
