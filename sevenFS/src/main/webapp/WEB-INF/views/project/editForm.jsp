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
  <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <style>
    input[readonly] {
      background-color: #f8f9fa;
    }
    .form-label {
      font-weight: 600;
    }
    .badge i {
      vertical-align: middle;
    }
    .table td, .table th {
      vertical-align: middle;
    }
  </style>
</head>
<body>
  <c:import url="../layout/sidebar.jsp" />
  <main class="main-wrapper">
    <c:import url="../layout/header.jsp" />
    <section class="section">
      <div class="container-fluid">
      <div class="card bg-white border-0 shadow-sm p-4">
        <form id="projectForm" action="/project/update" method="post" enctype="multipart/form-data">
          <input type="hidden" name="prjctNo" value="${project.prjctNo}" />

          <!-- 기본 정보 -->
          <div class="row mb-3">
            <div class="col-md-6">
              <label class="form-label">프로젝트명 <span class="text-danger">*</span></label>
              <input type="text" name="prjctNm" class="form-control" value="${project.prjctNm}" required />
            </div>
            <div class="col-md-6">
              <label class="form-label">사업 분류 <span class="text-danger">*</span></label>
              <select name="ctgryNo" class="form-select" required>
                <option value="">사업 분류 선택</option>
                <option value="1" ${project.ctgryNo == 1 ? 'selected' : ''}>국가지원사업</option>
                <option value="2" ${project.ctgryNo == 2 ? 'selected' : ''}>법인자체사업</option>
                <option value="3" ${project.ctgryNo == 3 ? 'selected' : ''}>산학협력사업</option>
                <option value="4" ${project.ctgryNo == 4 ? 'selected' : ''}>민간수주사업</option>
                <option value="5" ${project.ctgryNo == 5 ? 'selected' : ''}>해외협력사업</option>
              </select>
            </div>
          </div>

          <!-- 프로젝트 설명 -->
          <div class="mb-3">
            <label class="form-label">프로젝트 설명 <span class="text-danger">*</span></label>
            <textarea name="prjctCn" class="form-control" rows="4" required>${project.prjctCn}</textarea>
          </div>

          <!-- 세부 정보 -->
          <div class="row g-3 mb-4">
            <div class="col-md-3">
              <label class="form-label">시작일 <span class="text-danger">*</span></label>
              <input type="date" name="prjctBeginDate" class="form-control" value="${project.prjctBeginDateFormatted}" />
            </div>
            <div class="col-md-3">
              <label class="form-label">종료일 <span class="text-danger">*</span></label>
              <input type="date" name="prjctEndDate" class="form-control" value="${project.prjctEndDateFormatted}" />
            </div>
            <div class="col-md-3">
              <label class="form-label">상태 <span class="text-danger">*</span></label>
              <select name="prjctSttus" class="form-select" required>
                <option value="">선택</option>
                <option value="00" ${project.prjctSttus == '00' ? 'selected' : ''}>대기</option>
                <option value="01" ${project.prjctSttus == '01' ? 'selected' : ''}>진행중</option>
                <option value="02" ${project.prjctSttus == '02' ? 'selected' : ''}>완료</option>
                <option value="03" ${project.prjctSttus == '03' ? 'selected' : ''}>취소</option>
              </select>
            </div>
            <div class="col-md-3">
              <label class="form-label">등급 <span class="text-danger">*</span></label>
              <select name="prjctGrad" class="form-select" required>
                <option value="">선택</option>
                <option value="A" ${project.prjctGrad == 'A' ? 'selected' : ''}>A</option>
                <option value="B" ${project.prjctGrad == 'B' ? 'selected' : ''}>B</option>
                <option value="C" ${project.prjctGrad == 'C' ? 'selected' : ''}>C</option>
                <option value="D" ${project.prjctGrad == 'D' ? 'selected' : ''}>D</option>
                <option value="E" ${project.prjctGrad == 'E' ? 'selected' : ''}>E</option>
              </select>
            </div>
			<div class="col-md-6">
			  <label class="form-label">수주 금액</label>
			  <input type="text" id="prjctRcvordAmount" name="prjctRcvordAmount" class="form-control"
			         value="${project.prjctRcvordAmount}" placeholder="숫자만 입력하세요" />
			</div>

            <div class="col-md-6">
              <label class="form-label">URL</label>
              <input type="url" name="prjctUrl" class="form-control" value="${project.prjctUrl}" />
            </div>
          </div>

			<!-- 주소 -->
			<div class="mb-4">
			  <label class="form-label">프로젝트 주소</label>
			  <div class="d-flex flex-column gap-2">
			    <div class="input-group">
			      <input type="text" class="form-control" id="restaurantAdd1" placeholder="주소" value="${fn:contains(project.prjctAdres, ',') ? fn:substringBefore(project.prjctAdres, ',') : project.prjctAdres}" readonly>
			      <button type="button" class="btn btn-outline-secondary" onclick="openAddressSearch()">주소 검색</button>
			    </div>
			    <input type="text" class="form-control" id="addressDetail" placeholder="상세주소" value="${fn:contains(project.prjctAdres, ',') ? fn:substringAfter(project.prjctAdres, ', ') : ''}" />
			    <input type="hidden" name="prjctAdres" id="prjctAdres" value="${project.prjctAdres}" />
			  </div>
			</div>


          <!-- 참여자 테이블 include -->
          <jsp:include page="editFormMembers.jsp" />

          <div class="text-end mt-4">
            <a href="/project/tab?tab=list" class="btn btn-secondary">목록</a>
            <button type="submit" class="btn btn-primary">수정 완료</button>
          </div>
        </form>
      </div>
      </div>
      
      <!-- 조직도 모달 -->
<div class="modal fade" id="orgChartModal" tabindex="-1" aria-labelledby="orgChartModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
    
      <div class="modal-header">
        <h5 class="modal-title">
          <i class="fas fa-sitemap text-primary me-2"></i> 조직도
        </h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
      </div>
      
      <div class="modal-body p-4">
        <!--  검색창 먼저 -->
        <c:import url="../organization/searchBar.jsp" />
        
        <!-- 조직도 트리 -->
        <div class="card-style overflow-scroll mt-3" style="max-height: 75vh;">
          <c:import url="../organization/orgList.jsp" />
        </div>
      </div>
      
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
      
    </div>
  </div>
</div>

      
    </section>
    <c:import url="../layout/footer.jsp" />
  </main>
  <c:import url="../layout/prescript.jsp" />
  <script src="/js/project/editFormScript.js"></script>
</body>
</html>
