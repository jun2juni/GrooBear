<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="row">
	<div class="col-md-8">
		<div class="form-step">
			<div class="row">
				<div class="col-12">
					<div class="card border p-3">
						<h6 class="mb-3">프로젝트 참여자</h6>
						<div class="row g-3">
							<div class="col-md-12">
								<div class="input-style-1 mb-2">
									<label>책임자 <span class="text-danger">*</span></label>
									<div class="input-group">
										<input type="text" id="responsibleManager" class="bg-transparent" placeholder="책임자 명" readonly /> 
											<input type="hidden" id="responsibleManagerEmpno" name="responsibleManagerEmpno" />
										<button type="button" class="btn btn-outline-secondary open-org-chart"
											data-target="responsibleManager">
											<i class="fas fa-search me-1"></i> 조직도
										</button>
									</div>
								</div>
							</div>
							<div class="col-md-12">
								<div class="input-style-1 mb-2">
									<label>참여자 <span class="text-danger">*</span></label>
									<div class="input-group">
										<input type="text" id="participants" class="bg-transparent" placeholder="참여자 명" readonly /> 
										<input type="hidden" id="participantsEmpno" name="participantsEmpno" />
										<button type="button" class="btn btn-outline-secondary open-org-chart"
											data-target="participants">
											<i class="fas fa-search me-1"></i> 조직도
										</button>
									</div>
								</div>
							</div>
							<div class="col-md-12">
								<div class="input-style-1 mb-2">
									<label>참조자</label>
									<div class="input-group">
										<input type="text" id="observers" class="bg-transparent" placeholder="참조자 명" readonly />
										<input type="hidden" id="observersEmpno" name="observersEmpno" />
										<button type="button" class="btn btn-outline-secondary open-org-chart"
											data-target="observers">
											<i class="fas fa-search me-1"></i> 조직도
										</button>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- 선택된 인원 리스트 -->
					<div class="mt-4">
						<h6 class="mb-3">선택된 프로젝트 참여자</h6>
						<div class="table-responsive">
							<table class="table table-bordered" id="selectedMembersTable">
								<thead>
									<tr align="center">
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
									<!-- 선택된 인원 목록이 여기에 표시됩니다 -->
									<tr class="empty-row">
										<td colspan="7" class="text-center text-muted">선택된 인원이 없습니다.</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<!-- step2Members.jsp 오른쪽 영역에 -->
<div class="col-md-4">
  <div class="card p-3 bg-light">
    <h6 class="mb-3 text-primary"><i class="fas fa-sitemap me-2"></i>조직도</h6>
    
    <!-- 조직도 컴포넌트 가져오기 -->
    <c:import url="../organization/orgList.jsp" />
  </div>
</div>

</div>

<!-- 
<script src="https://cdn.jsdelivr.net/npm/jstree@3.3.12/dist/jstree.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/jstree@3.3.12/dist/themes/default/style.min.css" rel="stylesheet" />
 -->
<!-- <script>
document.addEventListener("DOMContentLoaded", function () {
  function deptClick(e, data) {
    const node = data.node;
    if (node.original.deptYn === false) {
      // 사원 클릭
      const empName = node.text;
      const empNo = node.id;

      // 선택 대상 input에 값 넣기 (예: 참여자)
      document.getElementById('participants').value = empName;
      document.getElementById('participantsEmpno').value = empNo;

      // 필요 시 책임자 또는 참조자도 target에 따라 구분 가능
    }
  }

  fetch("/organization", {
    method: "get",
    headers: { "Content-Type": "application/json" }
  })
  .then(resp => resp.json())
  .then(res => {
    const json = [];
    res.deptList.forEach(dep => {
      json.push({
        id: dep.cmmnCode,
        parent: dep.upperCmmnCode,
        text: dep.cmmnCodeNm,
        icon: "/assets/images/organization/depIcon.svg",
        deptYn: true
      });
    });

    res.empList.forEach(emp => {
      json.push({
        id: emp.emplNo,
        parent: emp.deptCode,
        text: emp.emplNm,
        icon: "/assets/images/organization/employeeImg.svg",
        deptYn: false
      });
    });

    fnCreatejsTree(json);
  });

  function fnCreatejsTree(jsonData) {
    $("#jstree").jstree({
      plugins: ["search", "dnd"],
      core: {
        data: jsonData,
        check_callback: true
      }
    });
    $('#jstree').on("select_node.jstree", deptClick);
  }

  // 검색
  window.fSch = function () {
    $('#jstree').jstree(true).search($("#schName").val());
  };
  window.fSchEnder = function (e) {
    if (e.code === "Enter") {
      fSch();
    }
  };
  window.openTree = function () {
    const open = $('#allBtn').html() === "전체";
    if (open) {
      $("#jstree").jstree("open_all");
      $('#allBtn').html("닫기");
    } else {
      $("#jstree").jstree("close_all");
      $('#allBtn').html("전체");
    }
  };
});
</script>
 -->