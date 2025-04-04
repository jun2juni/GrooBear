<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="프로젝트 생성" />

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
  <meta http-equiv="X-UA-Compatible" content="ie=edge" />
  <title>${title}</title>
  <c:import url="../layout/prestyle.jsp" />
  <!-- 페이지 특화 스타일 -->
  <style>
   /* 프로젝트 생성 페이지 특화 스타일 */
.card-style input,
.card-style select,
.card-style textarea,
.card-style .form-control,
.card-style .input-style-1 input,
.card-style .select-style-1 select {
  text-align: left !important;
}

/* 테이블 셀 스타일 */
.card-style table td,
.card-style table th {
  text-align: left !important;
}

/* 폼 레이블 스타일 */
.card-style label {
  text-align: left !important;
  display: block;
}

/* 선택된 멤버 테이블 스타일 - 가운데 정렬로 변경 */
#selectedMembersTable th,
#selectedMembersTable td {
  text-align: center !important;
}

/* 가이드 영역 스타일 */
.guide-list li {
  text-align: left !important;
  margin-bottom: 8px;
  color: #555;
  padding-left: 20px;
}

.guide-list {
  padding-left: 20px;
}

/* 단계 스타일 */
.step {
  color: #888;
  font-size: 14px;
}

.step.active {
  color: #4361ee;
  font-weight: bold;
}

.form-step {
  transition: all 0.3s ease;
}

/* 확인 상세 정보 */
.confirmation-details h6 {
  color: #4361ee;
  padding-bottom: 5px;
  border-bottom: 1px solid #eee;
}

/* 입력 그룹 스타일 */
.input-group-text {
  background-color: #f9fafb;
  border-color: #e2e8f0;
}

/* 업무 트리 스타일 */
.task-tree {
  margin-bottom: 0;
}

.task-content {
  background-color: #fff;
  border-radius: 4px;
  border: 1px solid #ddd;
}

.main-task > .task-content {
  background-color: #f8f9fa;
  border-left: 3px solid #4361ee;
}

.sub-task > .task-content {
  background-color: #fff;
  border-left: 3px solid #6c757d;
}

.task-actions button {
  padding: 0.15rem 0.4rem;
  font-size: 0.7rem;
}

/* 조직도 영역 스타일 - 높이 증가 */
#orgChartArea {
  max-height: 600px; /* 500px에서 600px로 증가 */
  overflow-y: auto;
  border: 1px solid #ddd;
  border-radius: 4px;
  padding: 15px;
  background-color: #fff;
}

/* 프로젝트 멤버 버튼 스타일 */
.member-btn {
  margin-right: 5px;
  margin-bottom: 5px;
  min-width: 80px;
  display: inline-flex;
  justify-content: center;
  align-items: center;
  padding: 6px 12px;
  transition: all 0.2s ease;
}

.member-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}


/* 사이드바 스타일 수정 */
.sticky-sidebar {
  position: sticky;
  top: 100px;
  height: calc(100vh - 120px);
  overflow-y: auto;
}

/* 프로젝트 멤버 버튼 영역 */
#projectMemberButtons {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  padding: 10px;
  background-color: #f8f9fa;
  border-radius: 4px;
  min-height: 100px;
}

/* 진행 상태 표시 스타일 강화 */
.form-progress .progress {
  height: 12px;
  margin-bottom: 5px;
}

.form-progress .progress-bar {
  font-size: 10px;
  line-height: 12px;
  font-weight: bold;
}
  </style>
</head>
<body>
  <c:import url="../layout/sidebar.jsp" />
  <main class="main-wrapper">
    <c:import url="../layout/header.jsp" />

    <section class="section">
      <div class="container-fluid">
        
        <div class="row">
          <!-- 왼쪽 폼 영역 -->
          <div class="col-lg-8">
            <div class="card-style mb-30">
              
              <!-- 진행 상태 표시 -->
              <div class="form-progress mb-30">
                <div class="progress">
                  <div class="progress-bar progress-bar-striped progress-bar-animated" id="progressBar" role="progressbar" style="width: 20%;" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">1/5</div>
                </div>
                <div class="step-labels d-flex justify-content-between mt-2">
                  <span class="step active">기본 정보</span>
                  <span class="step">인원 등록</span>
                  <span class="step">업무 관리</span>
                  <span class="step">세부 정보</span>
                  <span class="step">최종 확인</span>
                </div>
              </div>
              
              <form id="projectForm" action="/project/insert" method="post" enctype="multipart/form-data">
                <!-- 페이지 1: 기본 정보 -->
                <div class="form-step" id="step1">
                  <div class="row">
                    <div class="col-12">
                      <div class="input-style-1">
                        <label>프로젝트 명 <span class="text-danger">*</span></label>
                        <input type="text" name="prjct_nm" placeholder="프로젝트 명" class="bg-transparent" required>
                      </div>
                    </div>
                    <div class="col-md-12">
                      <div class="select-style-1">
                        <label>사업 분류<span class="text-danger">*</span></label>
                        <div class="select-position">
                          <select name="ctgry" required>
                            <option value="">선택하세요</option>
                            <option value="00">국가지원사업</option>
                            <option value="01">법인자체사업</option>
                            <option value="02">산학협력사업</option>
                            <option value="03">민간수주사업</option>
                            <option value="04">해외협력사업</option>
                          </select>
                        </div>
                      </div>
                    </div>
                    <div class="col-12">
                      <div class="input-style-1">
                        <label>프로젝트 내용 <span class="text-danger">*</span></label>
                        <textarea name="prjct_cn" placeholder="내용" rows="5" class="bg-transparent" required></textarea>
                      </div>
                    </div>
                    <div class="col-md-6">
                      <div class="input-style-1">
                        <label>사업 시작일 <span class="text-danger">*</span></label>
                        <input type="date" name="prjct_begin_date" id="beginDate" required>
                      </div>
                    </div>
                    <div class="col-md-6">
                      <div class="input-style-1">
                        <label>사업 종료일 <span class="text-danger">*</span></label>
                        <input type="date" name="prjct_end_date" required>
                      </div>
                    </div>
                    <div class="col-md-6">
                      <div class="select-style-1">
                        <label>프로젝트 상태 <span class="text-danger">*</span></label>
                        <div class="select-position">
                          <select name="prjct_sttus" required>
                            <option value="">선택하세요</option>
                            <option value="00">대기</option>
                            <option value="01">진행중</option>
                            <option value="02">완료</option>
                            <option value="03">취소</option>
                          </select>
                        </div>
                      </div>
                    </div>
                    <div class="col-md-6">
                      <div class="select-style-1">
                        <label>프로젝트 등급 <span class="text-danger">*</span></label>
                        <div class="select-position">
                          <select name="prjct_grad" required>
                            <option value="">선택하세요</option>
                            <option value="A">A</option>
                            <option value="B">B</option>
                            <option value="C">C</option>
                            <option value="D">D</option>
                            <option value="E">E</option>
                          </select>
                        </div>
                      </div>
                    </div>
                    <div class="col-12">
                      <div class="input-style-1">
                        <label>프로젝트 URL</label>
                        <input type="url" name="prjct_url" placeholder="https://example.com" class="bg-transparent">
                      </div>
                    </div>
                    <div class="col-12 mt-3 d-flex justify-content-end">
                      <button type="button" class="btn btn-primary" onclick="nextStep()">
                        다음 단계 <i class="fas fa-arrow-right ms-1"></i>
                      </button>
                    </div>
                  </div>
                </div>
                
                <!-- 페이지 2: 인원 등록 -->
                <div class="form-step" id="step2" style="display: none;">
                  <div class="row">
                    <div class="col-12 mb-4">
                      <div class="card border p-3">
                        <h6 class="mb-3">프로젝트 참여자</h6>
                        <div class="row g-3">
                          <div class="col-md-12">
                            <div class="input-style-1 mb-2">
                              <label>책임자 <span class="text-danger">*</span></label> 
                              <div class="input-group">
                                <input type="text" id="responsibleManager" class="bg-transparent" placeholder="책임자 명" readonly>
                                <input type="hidden" id="responsibleManagerEmpno" name="responsibleManagerEmpno">
                                <button type="button" class="btn btn-outline-secondary open-org-chart" data-target="responsibleManager">
                                  <i class="fas fa-search me-1"></i> 조직도
                                </button>
                              </div>
                            </div>
                          </div>
                          <div class="col-md-12">
                            <div class="input-style-1 mb-2">
                              <label>참여자 <span class="text-danger">*</span></label>
                              <div class="input-group">
                                <input type="text" id="participants" class="bg-transparent" placeholder="참여자 명" readonly>
                                <input type="hidden" id="participantsEmpno" name="participantsEmpno">
                                <button type="button" class="btn btn-outline-secondary open-org-chart" data-target="participants">
                                  <i class="fas fa-search me-1"></i> 조직도
                                </button>
                              </div>
                            </div>
                          </div>
                          <div class="col-md-12">
                            <div class="input-style-1 mb-2">
                              <label>참조자</label>
                              <div class="input-group">
                                <input type="text" id="observers" class="bg-transparent" placeholder="참조자 명" readonly>
                                <input type="hidden" id="observersEmpno" name="observersEmpno">
                                <button type="button" class="btn btn-outline-secondary open-org-chart" data-target="observers">
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
                              <tr>
                                <th>역할</th>
                                <th>이름</th>
                                <th>부서</th>
                                <th>직위</th>
                                <th>연락처</th>
                                <th>이메일</th>
                                <th>작업</th>
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
                    
                    <div class="col-12 mt-4 d-flex justify-content-between">
                      <button type="button" class="btn btn-light" onclick="prevStep()">
                        <i class="fas fa-arrow-left me-1"></i> 이전 단계
                      </button>
                      <button type="button" class="btn btn-primary" onclick="nextStep()">
                        다음 단계 <i class="fas fa-arrow-right ms-1"></i>
                      </button>
                    </div>
                  </div>
                </div>

				<!-- 페이지 3: 업무 관리-->
				<div class="form-step" id="step3" style="display: none;">
				  <div class="row">
				    <div class="col-12 mb-4">
				      <div class="card border p-3">
				        <h6 class="mb-3">프로젝트 업무 추가</h6>
				        <div class="row g-3">
				          <div class="col-md-12">
				            <div class="input-style-1 mb-2">
				              <label>상위 업무</label>
				              <input type="text" id="upperTaskNo" class="bg-transparent" placeholder="상위 업무" readonly>
				              <input type="hidden" id="upperTaskId">
				            </div>
				          </div>
				          <div class="col-md-12">
				            <div class="input-style-1 mb-2">
				              <label>업무 제목 <span class="text-danger">*</span></label>
				              <input type="text" id="taskTitle" class="bg-transparent" placeholder="업무 제목을 입력하세요">
				            </div>
				          </div>
				          <div class="col-md-12">
				            <div class="input-style-1 mb-2">
				              <label>업무 담당자 <span class="text-danger">*</span></label>
				              <div class="input-group">
				                <input type="text" id="chargerName" class="bg-transparent" placeholder="담당자 선택" readonly>
				                <input type="hidden" id="chargerEmpno" name="chargerEmpno">
				                <button type="button" class="btn btn-outline-secondary open-org-chart" data-target="charger">
				                  <i class="fas fa-search me-1"></i> 조직도
				                </button>
				              </div>
				            </div>
				          </div>
				          <!-- 
				          프로젝트 멤버 버튼 영역 추가 (기술력 이슈로 대기)
				          <div class="col-md-12">
				            <div class="card border p-3 mb-3">
				              <label class="mb-2">프로젝트 멤버에서 선택:</label>
				              <div id="projectMemberButtons" class="d-flex flex-wrap gap-2">
				                여기에 버튼이 동적으로 추가
				              </div>
				            </div>
				          </div>
				           -->
				          <div class="col-md-6">
				            <div class="input-style-1 mb-2">
				              <label>시작일 <span class="text-danger">*</span></label>
				              <input type="date" id="taskBeginDt">
				            </div>
				          </div>
				          <div class="col-md-6">
				            <div class="input-style-1 mb-2">
				              <label>종료일 <span class="text-danger">*</span></label>
				              <input type="date" id="taskEndDt">
				            </div>
				          </div>
				          <div class="col-md-4">
				            <div class="select-style-1 mb-2">
				              <label>업무 중요도 <span class="text-danger">*</span></label>
				              <div class="select-position">
				                <select id="taskPriort">
				                  <option value="">선택하세요</option>
				                  <option value="00">낮음</option>
				                  <option value="01">보통</option>
				                  <option value="02">높음</option>
				                  <option value="03">긴급</option>
				                </select>
				              </div>
				            </div>
				          </div>
				          <div class="col-md-4">
				            <div class="select-style-1">
				              <label>업무 등급 <span class="text-danger">*</span></label>
				              <div class="select-position">
				                <select id="taskGrad">
				                  <option value="">선택하세요</option>
				                  <option value="A">A</option>
				                  <option value="B">B</option>
				                  <option value="C">C</option>
				                  <option value="D">D</option>
				                  <option value="E">E</option>
				                </select>
				              </div>
				            </div>
				          </div>
				          <div class="col-md-4">
				            <div class="input-style-1">
				              <label>첨부파일</label>
				              <input type="file" id="taskFile" class="form-control" multiple>
				            </div>
				          </div>
				          <div class="col-12 text-end">
				            <button type="button" id="resetTaskForm" class="btn btn-secondary me-2">
				              <i class="fas fa-undo me-1"></i> 초기화
				            </button>
				            <button type="button" id="addTask" class="btn btn-success">
				              <i class="fas fa-plus me-1"></i> 업무 추가
				            </button>
				          </div>
				        </div>
				      </div>
				    </div>
				    
				    <div class="col-12 mt-4 d-flex justify-content-between">
				      <button type="button" class="btn btn-light prev-step">
				        <i class="fas fa-arrow-left me-1"></i> 이전 단계
				      </button>
				      <button type="button" class="btn btn-primary next-step">
				        다음 단계 <i class="fas fa-arrow-right ms-1"></i>
				      </button>
				    </div>
				  </div>
				</div>
                
                <!-- 페이지 4: 세부 정보 -->
                <div class="form-step" id="step4" style="display: none;">
                  <div class="row">
                    <div class="col-6">
                      <div class="input-style-1">
                        <label>사업 수주 금액 &nbsp; 
                          <span class="badge text-bg-success">(단위: &nbsp; 원)</span>
                        </label>
                        <div class="d-flex align-items-center">
                          <!-- 왼쪽 입력 필드 -->
                          <input type="text" name="prjct_rcvord_amount" id="amountInput" 
                            placeholder="0" class="form-control text-end me-2"
                            style="background-color: white; width: 50%;">
                          
                          <!-- 오른쪽 금액 표시 (input 대신 span) -->
                          <span id="amountDisplay" class="form-control text-end bg-light px-3"
                            style="width: 50%; border: 1px solid #ced4da; border-radius: .375rem;">
                            0
                          </span>
                        </div>
                      </div>
                    </div>
                    <div class="col-12">
                      <div class="input-style-1">
                        <label>프로젝트 주소</label>
                        <div class="input-group mb-2">
                          <input type="text" id="postcode" placeholder="우편번호" class="bg-transparent" readonly>
                          <button type="button" id="searchAddressBtn" class="btn btn-outline-secondary">
                            <i class="fas fa-search me-1"></i> 주소 검색
                          </button>
                        </div>
                        <input type="text" id="address" name="address" placeholder="주소" class="bg-transparent mb-2" readonly>
                        <input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소" class="bg-transparent">
                        <input type="hidden" id="fullAddress" name="prjct_adres">
                      </div>
                    </div>
                    <div class="col-12 mt-4 d-flex justify-content-between">
                      <button type="button" class="btn btn-light" onclick="prevStep()">
                        <i class="fas fa-arrow-left me-1"></i> 이전 단계
                      </button>
                      <button type="button" class="btn btn-primary" onclick="nextStep()">
                        다음 단계 <i class="fas fa-arrow-right ms-1"></i>
                      </button>
                    </div>
                  </div>
                </div>
                
                
                <!-- 페이지 5: 최종 확인 -->
                <div class="form-step" id="step5" style="display: none;">
                  <div class="row">
                    <div class="col-12">
                      <div class="alert alert-info">
                        <i class="fas fa-info-circle me-2"></i> 입력하신 모든 정보를 확인한 후 제출해주세요.
                      </div>
                      
                      <div class="confirmation-details mt-4">
                        <h6 class="mb-3">1. 기본 정보</h6>
                        <table class="table table-bordered">
                          <tbody>
                            <tr>
                              <th style="width: 150px;">프로젝트 명</th>
                              <td id="confirm-project-name"></td>
                            </tr>
                            <tr>
                              <th>사업 분류</th>
                              <td id="confirm-project-category"></td>
                            </tr>
                            <tr>
                              <th>프로젝트 내용</th>
                              <td id="confirm-project-desc"></td>
                            </tr>
                            <tr>
                              <th>프로젝트 기간</th>
                              <td id="confirm-project-period"></td>
                            </tr>
                            <tr>
                              <th>프로젝트 상태</th>
                              <td id="confirm-project-status"></td>
                            </tr>
                            <tr>
                              <th>프로젝트 등급</th>
                              <td id="confirm-project-grade"></td>
                            </tr>
                          </tbody>
                        </table>
                        
                        <h6 class="mb-3 mt-4">2. 프로젝트 참여자</h6>
                        <div id="confirm-members-section">
                          <p class="text-muted">등록된 참여자가 없습니다.</p>
                        </div>
                        
                        <h6 class="mb-3 mt-4">3. 업무 정보</h6>
                        <div id="confirm-tasks-section">
                          <p class="text-muted">등록된 업무가 없습니다.</p>
                        </div>
                        
                        <h6 class="mb-3 mt-4">4. 추가 정보</h6>
                        <table class="table table-bordered">
                          <tbody>
                            <tr>
                              <th style="width: 150px;">사업 수주 금액</th>
                              <td id="confirm-amount"></td>
                            </tr>
                            <tr>
                              <th>프로젝트 주소</th>
                              <td id="confirm-address"></td>
                            </tr>
                            <tr>
                              <th>프로젝트 URL</th>
                              <td id="confirm-url"></td>
                            </tr>
                          </tbody>
                        </table>
                      </div>
                    </div>
                    <div class="col-12 mt-4 d-flex justify-content-between">
                      <button type="button" class="btn btn-light" onclick="prevStep()">
                        <i class="fas fa-arrow-left me-1"></i> 이전 단계
                      </button>
                      <button type="submit" class="btn btn-success">
                        <i class="fas fa-check me-1"></i> 프로젝트 생성
                      </button>
                    </div>
                  </div>
                </div>
              </form>
            </div>
          </div>
          
          <!-- 오른쪽 창 영역 -->
          <div class="col-lg-4">
            <div class="card-style mb-30 sticky-sidebar">
              <h6 class="mb-25">프로젝트 생성 가이드</h6>
              <div class="content-area" id="guideContent">
                <div class="current-guide" id="guide-step1">
                  <h5 class="mb-3"><i class="fas fa-info-circle me-2 text-primary"></i>기본 정보 입력 안내</h5>
                  <ul class="guide-list">
                    <li>프로젝트 명은 간결하고 명확하게 작성해주세요.</li>
                    <li>프로젝트 내용에는 목적, 기대효과 등을 포함해주세요.</li>
                    <li>프로젝트 시작일과 종료일을 정확히 설정해주세요.</li>
                    <li>프로젝트 상태는 현재 진행 상황에 맞게 선택해주세요.</li>
                    <li>프로젝트 등급은 중요도에 따라 A(가장 중요)~E 중에서 선택해주세요.</li>
                  </ul>
                </div>
                <div class="current-guide" id="guide-step2" style="display: none;">
                  <h5 class="mb-3"><i class="fas fa-users me-2 text-primary"></i>인원 등록 안내</h5>
                  <ul class="guide-list">
                    <li>조직도 버튼을 클릭하여 프로젝트 참여자를 선택해주세요.</li>
                    <li>책임자는 프로젝트의 전체 책임을 맡는 관리자입니다.</li>
                    <li>참여자는 실제 프로젝트에 참여하여 업무를 수행하는 인원입니다.</li>
                    <li>참조자는 프로젝트 정보를 참조할 수 있는 인원입니다.</li>
                    <li>중복 선택이 가능합니다. 삭제 버튼으로 제거할 수 있습니다.</li>
                  </ul>
                </div>
                <div class="current-guide" id="guide-step3" style="display: none;">
                  <h5 class="mb-3"><i class="fas fa-tasks me-2 text-primary"></i>업무 관리 안내</h5>
                  <ul class="guide-list">
                    <li>주요 업무를 먼저 등록한 후 하위 업무를 추가해주세요.</li>
                    <li>업무 제목은 구체적으로 작성하는 것이 좋습니다.</li>
                    <li>담당자는 조직도에서 선택하거나, 이미 등록된 프로젝트 멤버 중에서 선택할 수 있습니다.</li>
                    <li>업무 일정을 설정할 때는 프로젝트 기간 내에서 설정해주세요.</li>
                    <li>중요도와 등급을 적절히 설정하여 업무 우선순위를 관리해주세요.</li>
                    <li>파일 첨부는 필요한 경우에만 추가하세요.</li>
                  </ul>
                  
                  <!-- 업무 목록 표시 영역 (오른쪽으로 이동) -->
                  <div class="mt-4 task-list-area">
                    <h5 class="mb-3"><i class="fas fa-clipboard-list me-2 text-primary"></i>등록된 업무 목록</h5>
                    <div id="taskListContainer" class="p-2 border rounded bg-light" style="max-height: 300px; overflow-y: auto;">
                      <ul class="task-tree list-unstyled mb-0">
                        <!-- 업무 목록이 여기에 표시됩니다 -->
                        <li class="text-center text-muted py-3">등록된 업무가 없습니다.</li>
                      </ul>
                    </div>
                  </div>
                </div>
                <div class="current-guide" id="guide-step4" style="display: none;">
                  <h5 class="mb-3"><i class="fas fa-file-invoice-dollar me-2 text-primary"></i>세부 정보 안내</h5>
                  <ul class="guide-list">
                    <li>사업 수주 금액은 숫자만 입력하세요. 자동으로 천 단위 구분 기호가 표시됩니다.</li>
                    <li>주소 검색 버튼을 통해 정확한 주소를 입력해주세요.</li>
                    <li>상세 주소는 건물명, 동/호수 등을 포함하여 입력해주세요.</li>
                  </ul>
                </div>
                <div class="current-guide" id="guide-step5" style="display: none;">
                  <h5 class="mb-3"><i class="fas fa-check-circle me-2 text-primary"></i>최종 확인 안내</h5>
                  <ul class="guide-list">
                    <li>입력한 모든 정보를 꼼꼼히 확인해주세요.</li>
                    <li>필수 항목이 모두 입력되었는지 확인해주세요.</li>
                    <li>정보에 오류가 있다면 이전 단계로 돌아가 수정할 수 있습니다.</li>
                    <li>모든 정보가 정확하다면 '프로젝트 생성' 버튼을 클릭하여 완료해주세요.</li>
                  </ul>
                </div>
                
                <!-- 조직도 영역 -->
				<div id="orgChartArea" style="display: none;">
                  <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="mb-0"><i class="fas fa-sitemap me-2 text-primary"></i>조직도</h5>
                    <button id="closeOrgChart" class="btn btn-sm btn-outline-secondary">
                      <i class="fas fa-times"></i> 닫기
                    </button>
                  </div>
                  <c:import url="../organization/orgList.jsp" />
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <c:import url="../layout/footer.jsp" />
  </main>
  
  <c:import url="../layout/prescript.jsp" />
  
  <script>
//전역 변수로 정의
  let currentStep = 1;
  let currentOrgTarget = null;

//단계 이동 함수
  function nextStep() {
    console.log("다음 단계 함수 호출, 현재 단계:", currentStep);
    if (currentStep < 5) {
      // 현재 단계 숨기기
      $('#step' + currentStep).hide();
      $('#guide-step' + currentStep).hide();
      
      // 다음 단계 표시
      currentStep++;
      $('#step' + currentStep).show();
      $('#guide-step' + currentStep).show();
      
      // 진행 상태 업데이트 - 직접 값을 계산하여 적용
      const progressPercentage = (currentStep / 5) * 100;
      $('#progressBar').css('width', progressPercentage + '%');
      $('#progressBar').attr('aria-valuenow', progressPercentage);
      $('#progressBar').text(currentStep + '/5');
      
      // 단계 라벨 업데이트
      $('.step').removeClass('active');
      for (let i = 1; i <= currentStep; i++) {
        $('.step:nth-child(' + i + ')').addClass('active');
      }
      
      // 3단계로 넘어갈 때 프로젝트 멤버 버튼 업데이트
      if(currentStep === 3) {
        console.log("3단계로 이동: 프로젝트 멤버 버튼 업데이트 호출");
        updateProjectMemberButtons();
      }
      
      // 최종 단계일 경우 확인 정보 업데이트
      if (currentStep === 5) {
        console.log("5단계로 이동: 최종 확인 정보 업데이트 호출");
        updateConfirmation();
      }
    }
  }

  function prevStep() {
    console.log("이전 단계 함수 호출, 현재 단계:", currentStep);
    if (currentStep > 1) {
      // 현재 단계 숨기기
      $('#step' + currentStep).hide();
      $('#guide-step' + currentStep).hide();
      
      // 이전 단계 표시
      currentStep--;
      $('#step' + currentStep).show();
      $('#guide-step' + currentStep).show();
      
      // 진행 상태 업데이트 - 직접 값을 계산하여 적용
      const progressPercentage = (currentStep / 5) * 100;
      $('#progressBar').css('width', progressPercentage + '%');
      $('#progressBar').attr('aria-valuenow', progressPercentage);
      $('#progressBar').text(currentStep + '/5');
      
      // 단계 라벨 업데이트
      $('.step').removeClass('active');
      for (let i = 1; i <= currentStep; i++) {
        $('.step:nth-child(' + i + ')').addClass('active');
      }
    }
  }
    
//2단계에서 등록된 멤버를 3단계 버튼으로 표시
  function updateProjectMemberButtons() {
    console.log("프로젝트 멤버 버튼 업데이트 시작");
    const buttonContainer = $('#projectMemberButtons');
    buttonContainer.empty();
    
    // 디버깅을 위한 로그 추가
    console.log("책임자:", selectedMembers.responsibles);
    console.log("참여자:", selectedMembers.participants);
    console.log("참조자:", selectedMembers.observers);
    
    let hasMembers = false;
    
    // 책임자 버튼 추가
    selectedMembers.responsibles.forEach(member => {
      hasMembers = true;
      const btn = $('<button type="button" class="btn btn-danger member-btn mb-2 me-2"></button>')
        .text(member.name)
        .data('member', member)
        .click(function() {
          const member = $(this).data('member');
          $("#chargerName").val(member.name);
          $("#chargerEmpno").val(member.id);
          console.log("책임자 선택:", member.name, member.id);
        });
      buttonContainer.append(btn);
    });
    
    // 참여자 버튼 추가
    selectedMembers.participants.forEach(member => {
      hasMembers = true;
      const btn = $('<button type="button" class="btn btn-primary member-btn mb-2 me-2"></button>')
        .text(member.name)
        .data('member', member)
        .click(function() {
          const member = $(this).data('member');
          $("#chargerName").val(member.name);
          $("#chargerEmpno").val(member.id);
          console.log("참여자 선택:", member.name, member.id);
        });
      buttonContainer.append(btn);
    });
    
    // 참조자 버튼 추가
    selectedMembers.observers.forEach(member => {
      hasMembers = true;
      const btn = $('<button type="button" class="btn btn-secondary member-btn mb-2 me-2"></button>')
        .text(member.name)
        .data('member', member)
        .click(function() {
          const member = $(this).data('member');
          $("#chargerName").val(member.name);
          $("#chargerEmpno").val(member.id);
          console.log("참조자 선택:", member.name, member.id);
        });
      buttonContainer.append(btn);
    });
    
    // 버튼이 없는 경우
    if (!hasMembers) {
      buttonContainer.append('<div class="alert alert-light">등록된 프로젝트 멤버가 없습니다. 이전 단계에서 멤버를 추가하세요.</div>');
    }
    
    console.log("프로젝트 멤버 버튼 업데이트 완료");
  }
    
 // 조직도 관련 전역 함수 정의
    window.showOrgChart = function(targetType) {
      console.log("조직도 열기, 타겟:", targetType);
      currentOrgTarget = targetType;
      
      // 가이드 내용 숨기기
      $('.current-guide').hide();
      
      // 조직도 영역 표시
      $('#orgChartArea').show();
    };

    // 조직도 닫기 함수
    window.hideOrgChart = function() {
      console.log("조직도 닫기");
      // 현재 단계의 가이드 내용 표시
      $('#guide-step' + currentStep).show();
      
      // 조직도 영역 숨기기
      $('#orgChartArea').hide();
      
      currentOrgTarget = null;
    };

    // 조직도 관련 함수 - 전역 함수로 정의
    window.clickEmp = function(data) {
      console.log("선택된 사원:", data);
      const member = {
        id: data.node.id,
        name: data.node.text,
        dept: data.node.parent,  // 여기서는 부모 노드 ID를 사용, 실제로는 부서명이 나오도록 해야 함
        position: "직위",  // 실제 데이터에서 가져와야 함
        tel: "연락처",     // 실제 데이터에서 가져와야 함
        email: "이메일"    // 실제 데이터에서 가져와야 함
      };
      
      // 현재 targetType에 따라 선택 처리
      if (currentOrgTarget) {
        selectMember(member, currentOrgTarget);
      }
    };

    // 부서 클릭 시 처리 (필요한 경우)
    window.clickDept = function(data) {
      console.log("부서 선택:", data.node.text);
    };

    // 검색 기능
    window.fSch = function() {
      $('#jstree').jstree(true).search($("#schName").val());
    };

    // 엔터키 검색
    window.fSchEnder = function(e) {
      if (e.code === "Enter") {
        $('#jstree').jstree(true).search($("#schName").val());
      }
    };

    // 전체 열기/닫기
    window.openTree = function() {
      let bTreeOpen = $('#allBtn').html() === "전체";
      if(bTreeOpen){
        // 열기
        $("#jstree").jstree("open_all");
        $('#allBtn').html("닫기");
      } else {
        // 닫기
        $("#jstree").jstree("close_all");
        $('#allBtn').html("전체");
      }
    };
    
    // 조직도 관련 함수 - 전역 함수로 정의
    function clickEmp(data) {
      console.log("선택된 사원:", data);
      const member = {
        id: data.node.id,
        name: data.node.text,
        dept: data.node.parent,  // 여기서는 부모 노드 ID를 사용, 실제로는 부서명이 나오도록 해야 함
        position: "직위",  // 실제 데이터에서 가져와야 함
        tel: "연락처",     // 실제 데이터에서 가져와야 함
        email: "이메일"    // 실제 데이터에서 가져와야 함
      };
      
      // 현재 targetType에 따라 선택 처리
      if (currentOrgTarget) {
        selectMember(member, currentOrgTarget);
      }
    }
    
    // 부서 클릭 시 처리 (필요한 경우)
    function clickDept(data) {
      console.log("부서 선택:", data.node.text);
    }
    
    // 검색 기능
    function fSch() {
      $('#jstree').jstree(true).search($("#schName").val());
    }
    
    // 엔터키 검색
    function fSchEnder(e) {
      if (e.code === "Enter") {
        $('#jstree').jstree(true).search($("#schName").val());
      }
    }
    
    // 전체 열기/닫기
    function openTree() {
      let bTreeOpen = $('#allBtn').html() === "전체";
      if(bTreeOpen){
        // 열기
        $("#jstree").jstree("open_all");
        $('#allBtn').html("닫기");
      } else {
        // 닫기
        $("#jstree").jstree("close_all");
        $('#allBtn').html("전체");
      }
    }
    
    $(document).ready(function() {
    	  let totalSteps = 5;
    	  let mainTasks = [];
    	  let subTasks = [];
    	  let taskCounter = 1;
    	  let selectedMembers = {
    	    responsibles: [], // Changed from single responsible to array of responsibles
    	    participants: [],
    	    observers: []
    	  };
    	  let isSubTaskMode = false;
    	  
    	  // 우선순위에 따른 배지 클래스 맵핑 객체
    	  const priorityClassMap = {
    	    "00": "bg-info",
    	    "01": "bg-success", 
    	    "02": "bg-warning",
    	    "03": "bg-danger"
    	  };
    	  
    	  // 전체 주소 업데이트 함수
    	  function updateFullAddress() {
    	    const address = $("#address").val();
    	    const detailAddress = $("#detailAddress").val();
    	    let fullAddress = address;
    	    
    	    if (detailAddress) {
    	      fullAddress += " " + detailAddress;
    	    }
    	    
    	    $("#fullAddress").val(fullAddress);
    	  }
    	  
    	  // 진행바 업데이트
    	  function updateProgress() {
    	    const progressPercentage = (currentStep / totalSteps) * 100;
    	    $('#progressBar').css('width', progressPercentage + '%');
    	    $('#progressBar').attr('aria-valuenow', progressPercentage);
    	    $('#progressBar').text(currentStep + '/' + totalSteps);
    	    
    	    // 단계 라벨 업데이트
    	    $('.step').removeClass('active');
    	    for (let i = 1; i <= currentStep; i++) {
    	      $('.step:nth-child(' + i + ')').addClass('active');
    	    }
    	  }
    	  
    	  // 업무 트리 업데이트 함수
    	  function updateTaskTree() {
    	    const taskTreeContainer = $(".task-tree");
    	    taskTreeContainer.empty();
    	    
    	    if (mainTasks.length === 0) {
    	      taskTreeContainer.append('<li class="text-center text-muted py-3">등록된 업무가 없습니다.</li>');
    	      return;
    	    }
    	    
    	    mainTasks.forEach(function(task, index) {
    	      // 메인 업무 항목
    	      const mainTaskItem = $('<li class="main-task mb-2"></li>');
    	      
    	      // 메인 업무 내용 영역
    	      const mainTaskContent = $('<div class="task-content p-2"></div>');
    	      
    	      // 제목과 액션 버튼
    	      const mainTaskHeader = $('<div class="d-flex justify-content-between align-items-start"></div>');
    	      
    	      // 메인 업무 제목
    	      const mainTaskTitle = $('<div class="fw-bold"></div>').text(task.title);
    	      
    	      // 액션 버튼 영역
    	      const mainTaskActions = $('<div class="task-actions ms-2"></div>');
    	      
    	      // 하위 업무 추가 버튼
    	      const addSubtaskBtn = $('<button type="button" class="btn btn-sm btn-outline-primary add-subtask me-1" data-task-id="' + task.id + '" data-task-title="' + task.title + '"><i class="fas fa-plus-circle"></i></button>');
    	      
    	      // 삭제 버튼
    	      const deleteTaskBtn = $('<button type="button" class="btn btn-sm btn-outline-danger delete-task" data-task-id="' + task.id + '"><i class="fas fa-trash"></i></button>');
    	      
    	      // 버튼 추가
    	      mainTaskActions.append(addSubtaskBtn).append(deleteTaskBtn);
    	      
    	      // 헤더 완성
    	      mainTaskHeader.append(mainTaskTitle).append(mainTaskActions);
    	      
    	      // 담당자 정보
    	      const chargerInfo = $('<div class="text-muted small"></div>').html('<i class="fas fa-user me-1"></i> ' + (task.chargerName || '-'));
    	      
    	      // 메인 업무 영역 완성
    	      mainTaskContent.append(mainTaskHeader).append(chargerInfo);
    	      mainTaskItem.append(mainTaskContent);
    	      
    	      // 하위 업무가 있는 경우
    	      if (task.subTasks && task.subTasks.length > 0) {
    	        const subTasksList = $('<ul class="list-unstyled ms-3 mt-1"></ul>');
    	        
    	        task.subTasks.forEach(function(subTask) {
    	          // 하위 업무 항목
    	          const subTaskItem = $('<li class="sub-task mt-1"></li>');
    	          
    	          // 하위 업무 내용 영역
    	          const subTaskContent = $('<div class="task-content p-2 border-start border-2 ps-2"></div>');
    	          
    	          // 제목과 액션 버튼
    	          const subTaskHeader = $('<div class="d-flex justify-content-between align-items-start"></div>');
    	          
    	          // 하위 업무 제목
    	          const subTaskTitle = $('<div class=""></div>').html('<i class="fas fa-level-down-alt me-1 text-secondary"></i> ' + subTask.title);
    	          
    	          // 삭제 버튼
    	          const deleteSubTaskBtn = $('<button type="button" class="btn btn-sm btn-outline-danger delete-subtask ms-2" data-subtask-id="' + subTask.id + '"><i class="fas fa-trash"></i></button>');
    	          
    	          // 헤더 완성
    	          subTaskHeader.append(subTaskTitle).append(deleteSubTaskBtn);
    	          
    	          // 담당자 정보
    	          const subChargerInfo = $('<div class="text-muted small"></div>').html('<i class="fas fa-user me-1"></i> ' + (subTask.chargerName || '-'));
    	          
    	          // 하위 업무 영역 완성
    	          subTaskContent.append(subTaskHeader).append(subChargerInfo);
    	          subTaskItem.append(subTaskContent);
    	          
    	          // 하위 업무 항목 추가
    	          subTasksList.append(subTaskItem);
    	        });
    	        
    	        // 하위 업무 목록 추가
    	        mainTaskItem.append(subTasksList);
    	      }
    	      
    	      // 메인 업무 항목을 트리에 추가
    	      taskTreeContainer.append(mainTaskItem);
    	    });
    	    
    	    // 삭제 버튼 이벤트
    	    $(".delete-task").click(function() {
    	      const taskId = $(this).data("task-id");
    	      deleteTask(taskId);
    	    });
    	    
    	    // 하위 업무 추가 버튼 이벤트
    	    $(".add-subtask").click(function() {
    	      const taskId = $(this).data("task-id");
    	      const taskTitle = $(this).data("task-title");
    	      prepareSubTaskForm(taskId, taskTitle);
    	    });
    	    
    	    // 하위 업무 삭제 버튼 이벤트
    	    $(".delete-subtask").click(function() {
    	      const subTaskId = $(this).data("subtask-id");
    	      deleteSubTask(subTaskId);
    	    });
    	  }
    	  
    	  // 업무 삭제 함수
    	  function deleteTask(taskId) {
    	    if (!confirm("업무를 삭제하시겠습니까? 하위 업무도 함께 삭제됩니다.")) {
    	      return;
    	    }
    	    
    	    // 배열에서 업무 제거
    	    mainTasks = mainTasks.filter(task => task.id !== taskId);
    	    
    	    // 하위 업무도 제거
    	    subTasks = subTasks.filter(subTask => subTask.parentId !== taskId);
    	    
    	    // 업무 트리 업데이트
    	    updateTaskTree();
    	  }
    	  
    	  // 하위 업무 삭제 함수
    	  function deleteSubTask(subTaskId) {
    	    if (!confirm("하위 업무를 삭제하시겠습니까?")) {
    	      return;
    	    }
    	    
    	    // 부모 업무에서 하위 업무 제거
    	    let parentId = null;
    	    for (let i = 0; i < subTasks.length; i++) {
    	      if (subTasks[i].id === subTaskId) {
    	        parentId = subTasks[i].parentId;
    	        break;
    	      }
    	    }
    	    
    	    if (parentId) {
    	      for (let i = 0; i < mainTasks.length; i++) {
    	        if (mainTasks[i].id === parentId) {
    	          mainTasks[i].subTasks = mainTasks[i].subTasks.filter(subTask => subTask.id !== subTaskId);
    	          break;
    	        }
    	      }
    	    }
    	    
    	    // 배열에서 하위 업무 제거
    	    subTasks = subTasks.filter(subTask => subTask.id !== subTaskId);
    	    
    	    // 업무 트리 업데이트
    	    updateTaskTree();
    	  }
    	  
    	  // 하위 업무 폼 준비 함수
    	  function prepareSubTaskForm(parentTaskId, parentTaskTitle) {
    	    // 상위 업무 정보 설정
    	    $("#upperTaskId").val(parentTaskId);
    	    $("#upperTaskNo").val(parentTaskTitle);
    	    
    	    // 폼 필드 초기화
    	    $("#taskTitle").val("");
    	    $("#chargerName").val("");
    	    $("#chargerEmpno").val("");
    	    $("#taskBeginDt").val("");
    	    $("#taskEndDt").val("");
    	    $("#taskPriort").val("");
    	    $("#taskGrad").val("");
    	    $("#taskFile").val("");
    	    
    	    // 하위 업무 모드 활성화
    	    isSubTaskMode = true;
    	    
    	    // 업무 추가 버튼 텍스트 변경
    	    $("#addTask").html('<i class="fas fa-plus me-1"></i> 하위 업무 추가');
    	    
    	    // 사용자가 쉽게 알 수 있도록 시각적 표시
    	    $("#upperTaskNo").closest(".input-style-1").addClass("bg-light");
    	    
    	    // 상위 업무 입력란 표시
    	    $("#upperTaskNo").closest(".col-md-12").show();
    	  }
    	  
    	  // 업무 폼 초기화 함수
    	  function resetTaskForm() {
    	    // 필드 초기화
    	    $("#upperTaskId").val("");
    	    $("#upperTaskNo").val("");
    	    $("#taskTitle").val("");
    	    $("#chargerName").val("");
    	    $("#chargerEmpno").val("");
    	    $("#taskBeginDt").val("");
    	    $("#taskEndDt").val("");
    	    $("#taskPriort").val("");
    	    $("#taskGrad").val("");
    	    $("#taskFile").val("");
    	    
    	    // 하위 업무 모드 비활성화
    	    isSubTaskMode = false;
    	    
    	    // 업무 추가 버튼 텍스트 복원
    	    $("#addTask").html('<i class="fas fa-plus me-1"></i> 업무 추가');
    	    
    	    // 시각적 표시 제거
    	    $("#upperTaskNo").closest(".input-style-1").removeClass("bg-light");
    	    
    	    // 상위 업무 입력란 숨김
    	    $("#upperTaskNo").closest(".col-md-12").hide();
    	  }

    	// 최종 확인 정보 업데이트 함수 디버깅 강화
    	  function updateConfirmation() {
    	    console.log("[디버깅] 최종 확인 정보 업데이트 시작");
    	    
    	    try {
    	      // 기본 정보 가져오기 - 직접 DOM에서 값을 가져옴
    	      const projectName = $("input[name='prjct_nm']").val();
    	      console.log("[디버깅] 프로젝트 명:", projectName);
    	      
    	      const projectCategory = $("select[name='ctgry'] option:selected").text();
    	      console.log("[디버깅] 프로젝트 분류:", projectCategory);
    	      
    	      const projectDesc = $("textarea[name='prjct_cn']").val();
    	      console.log("[디버깅] 프로젝트 내용:", projectDesc ? (projectDesc.substring(0, 30) + "...") : "-");
    	      
    	      const beginDate = $("input[name='prjct_begin_date']").val();
    	      const endDate = $("input[name='prjct_end_date']").val();
    	      console.log("[디버깅] 프로젝트 기간:", beginDate, "~", endDate);
    	      
    	      const statusText = $("select[name='prjct_sttus'] option:selected").text();
    	      console.log("[디버깅] 프로젝트 상태:", statusText);
    	      
    	      const grade = $("select[name='prjct_grad']").val();
    	      console.log("[디버깅] 프로젝트 등급:", grade);
    	      
    	      // 사업 수주 금액은 천 단위 콤마가 있는 표시값을 사용
    	      const amountInput = $("#amountInput").val();
    	      const amountDisplay = $("#amountDisplay").text();
    	      console.log("[디버깅] 사업 수주 금액 (입력값):", amountInput);
    	      console.log("[디버깅] 사업 수주 금액 (표시값):", amountDisplay);
    	      const amount = amountDisplay || "0";
    	      
    	      // 주소 정보 가져오기
    	      const address = $("#address").val();
    	      const detailAddress = $("#detailAddress").val();
    	      const fullAddress = $("#fullAddress").val();
    	      console.log("[디버깅] 주소:", address);
    	      console.log("[디버깅] 상세주소:", detailAddress);
    	      console.log("[디버깅] 전체주소:", fullAddress);
    	      
    	      let finalAddress = "-";
    	      if (fullAddress) {
    	        finalAddress = fullAddress;
    	      } else if (address) {
    	        finalAddress = address;
    	        if (detailAddress) {
    	          finalAddress += " " + detailAddress;
    	        }
    	      }
    	      
    	      const url = $("input[name='prjct_url']").val();
    	      console.log("[디버깅] URL:", url);
    	      
    	      // 기본 정보 업데이트
    	      $("#confirm-project-name").text(projectName || "-");
    	      $("#confirm-project-category").text(projectCategory || "-");
    	      $("#confirm-project-desc").text(projectDesc || "-");
    	      $("#confirm-project-period").text((beginDate || "-") + " ~ " + (endDate || "-"));
    	      $("#confirm-project-status").text(statusText || "-");
    	      $("#confirm-project-grade").text(grade || "-");
    	      
    	      // 추가 정보 업데이트
    	      $("#confirm-amount").text(amount + " 원");
    	      $("#confirm-address").text(finalAddress);
    	      $("#confirm-url").text(url || "-");
    	      
    	      // 참여자 정보 업데이트
    	      console.log("[디버깅] 책임자:", selectedMembers.responsible);
    	      console.log("[디버깅] 참여자 수:", selectedMembers.participants.length);
    	      console.log("[디버깅] 참조자 수:", selectedMembers.observers.length);
    	      
    	      if (selectedMembers.responsible || selectedMembers.participants.length > 0 || selectedMembers.observers.length > 0) {
    	        const membersTable = $('<table></table>').addClass('table table-sm table-bordered');
    	        
    	        // 테이블 헤더
    	        const thead = $('<thead></thead>');
    	        const headerRow = $('<tr></tr>');
    	        headerRow.append($('<th></th>').text('역할'));
    	        headerRow.append($('<th></th>').text('이름'));
    	        headerRow.append($('<th></th>').text('부서'));
    	        headerRow.append($('<th></th>').text('직위'));
    	        headerRow.append($('<th></th>').text('연락처'));
    	        thead.append(headerRow);
    	        membersTable.append(thead);
    	        
    	        // 테이블 본문
    	        const tbody = $('<tbody></tbody>');
    	        
    	        // 책임자
    	        if (selectedMembers.responsible) {
    	          const row = $('<tr></tr>');
    	          row.append($('<td></td>').append($('<span class="badge bg-danger"></span>').text('책임자')));
    	          row.append($('<td></td>').text(selectedMembers.responsible.name));
    	          row.append($('<td></td>').text(selectedMembers.responsible.dept));
    	          row.append($('<td></td>').text(selectedMembers.responsible.position));
    	          row.append($('<td></td>').text(selectedMembers.responsible.tel));
    	          tbody.append(row);
    	        }
    	        
    	        // 참여자
    	        selectedMembers.participants.forEach(member => {
    	          const row = $('<tr></tr>');
    	          row.append($('<td></td>').append($('<span class="badge bg-primary"></span>').text('참여자')));
    	          row.append($('<td></td>').text(member.name));
    	          row.append($('<td></td>').text(member.dept));
    	          row.append($('<td></td>').text(member.position));
    	          row.append($('<td></td>').text(member.tel));
    	          tbody.append(row);
    	        });
    	        
    	        // 참조자
    	        selectedMembers.observers.forEach(member => {
    	          const row = $('<tr></tr>');
    	          row.append($('<td></td>').append($('<span class="badge bg-secondary"></span>').text('참조자')));
    	          row.append($('<td></td>').text(member.name));
    	          row.append($('<td></td>').text(member.dept));
    	          row.append($('<td></td>').text(member.position));
    	          row.append($('<td></td>').text(member.tel));
    	          tbody.append(row);
    	        });
    	        
    	        membersTable.append(tbody);
    	        $("#confirm-members-section").empty().append(membersTable);
    	      } else {
    	        $("#confirm-members-section").html("<p class='text-muted'>등록된 참여자가 없습니다.</p>");
    	      }
    	      
    	      // 업무 정보 업데이트
    	      console.log("[디버깅] 업무 수:", mainTasks.length);
    	      if (mainTasks.length > 0) {
    	        // 테이블 생성
    	        const table = $('<table></table>').addClass('table table-sm table-bordered');
    	        
    	        // 테이블 헤더
    	        const thead = $('<thead></thead>');
    	        const headerRow = $('<tr></tr>');
    	        headerRow.append($('<th></th>').text('업무 제목'));
    	        headerRow.append($('<th></th>').text('담당자'));
    	        headerRow.append($('<th></th>').text('기간'));
    	        headerRow.append($('<th></th>').text('중요도'));
    	        headerRow.append($('<th></th>').text('등급'));
    	        headerRow.append($('<th></th>').text('파일'));
    	        thead.append(headerRow);
    	        table.append(thead);
    	        
    	        // 테이블 본문
    	        const tbody = $('<tbody></tbody>');
    	        
    	        // 주요 업무 추가
    	        mainTasks.forEach(task => {
    	          const row = $('<tr></tr>');
    	          row.append($('<td></td>').text(task.title));
    	          row.append($('<td></td>').text(task.chargerName || '-'));
    	          row.append($('<td></td>').text(task.beginDt + ' ~ ' + task.endDt));
    	          row.append($('<td></td>').text(task.priortText));
    	          row.append($('<td></td>').text(task.grad));
    	          
    	          // 파일명 표시
    	          const fileCell = $('<td></td>');
    	          if (task.files && task.files.length > 0) {
    	            const fileCount = task.files.length;
    	            const fileName = task.files[0].name;
    	            
    	            if (fileCount === 1) {
    	              fileCell.text(fileName);
    	            } else {
    	              fileCell.text(fileName + ' 외 ' + (fileCount - 1) + '개');
    	            }
    	          } else {
    	            fileCell.text('-');
    	          }
    	          row.append(fileCell);
    	          
    	          tbody.append(row);
    	          
    	          // 하위 업무 추가
    	          if (task.subTasks && task.subTasks.length > 0) {
    	            task.subTasks.forEach(subTask => {
    	              const subRow = $('<tr></tr>');
    	              
    	              // 제목 셀 (들여쓰기)
    	              const titleCell = $('<td></td>').addClass('ps-4');
    	              titleCell.append($('<i></i>').addClass('fas fa-long-arrow-alt-right me-2'));
    	              titleCell.append(document.createTextNode(subTask.title));
    	              subRow.append(titleCell);
    	              
    	              subRow.append($('<td></td>').text(subTask.chargerName || '-'));
    	              subRow.append($('<td></td>').text(subTask.beginDt + ' ~ ' + subTask.endDt));
    	              subRow.append($('<td></td>').text(subTask.priortText));
    	              subRow.append($('<td></td>').text(subTask.grad));
    	              
    	              // 파일명 표시
    	              const subFileCell = $('<td></td>');
    	              if (subTask.files && subTask.files.length > 0) {
    	                const fileCount = subTask.files.length;
    	                const fileName = subTask.files[0].name;
    	                
    	                if (fileCount === 1) {
    	                  subFileCell.text(fileName);
    	                } else {
    	                  subFileCell.text(fileName + ' 외 ' + (fileCount - 1) + '개');
    	                }
    	              } else {
    	                subFileCell.text('-');
    	              }
    	              subRow.append(subFileCell);
    	              
    	              tbody.append(subRow);
    	            });
    	          }
    	        });
    	        
    	        table.append(tbody);
    	        $("#confirm-tasks-section").empty().append(table);
    	      } else {
    	        $("#confirm-tasks-section").html("<p class='text-muted'>등록된 업무가 없습니다.</p>");
    	      }
    	      
    	      console.log("[디버깅] 최종 확인 정보 업데이트 완료");
    	    } catch (error) {
    	      console.error("[디버깅] 최종 확인 정보 업데이트 오류:", error);
    	    }
    	  }
    	  
    	  // 책임자 필드 업데이트
    	  function updateResponsiblesField() {
    	    if (selectedMembers.responsibles.length > 0) {
    	      const names = selectedMembers.responsibles.map(r => r.name).join(", ");
    	      const ids = selectedMembers.responsibles.map(r => r.id).join(",");
    	      $("#responsibleManager").val(names);
    	      $("#responsibleManagerEmpno").val(ids);
    	    } else {
    	      $("#responsibleManager").val("");
    	      $("#responsibleManagerEmpno").val("");
    	    }
    	  }
    	  
    	  // 참여자 필드 업데이트
    	  function updateParticipantsField() {
    	    if (selectedMembers.participants.length > 0) {
    	      const names = selectedMembers.participants.map(p => p.name).join(", ");
    	      const ids = selectedMembers.participants.map(p => p.id).join(",");
    	      $("#participants").val(names);
    	      $("#participantsEmpno").val(ids);
    	    } else {
    	      $("#participants").val("");
    	      $("#participantsEmpno").val("");
    	    }
    	  }
    	  
    	  // 참조자 필드 업데이트
    	  function updateObserversField() {
    	    if (selectedMembers.observers.length > 0) {
    	      const names = selectedMembers.observers.map(o => o.name).join(", ");
    	      const ids = selectedMembers.observers.map(o => o.id).join(",");
    	      $("#observers").val(names);
    	      $("#observersEmpno").val(ids);
    	    } else {
    	      $("#observers").val("");
    	      $("#observersEmpno").val("");
    	    }
    	  }
    	  
    	// 이 함수는 3단계로 이동할 때 호출됩니다
    	function updateProjectMemberButtons() {
    	  console.log("프로젝트 멤버 버튼 업데이트 시작");
    	  const buttonContainer = $('#projectMemberButtons');
    	  buttonContainer.empty();
    	  
    	  let hasMembers = false;
    	  
    	  // 책임자 버튼 추가
    	  if (selectedMembers.responsible) {
    	    hasMembers = true;
    	    console.log("책임자 추가:", selectedMembers.responsible.name);
    	    
    	    const btn = $('<button type="button" class="btn btn-danger member-btn mb-2 me-2"></button>')
    	      .text(selectedMembers.responsible.name)
    	      .data('member', selectedMembers.responsible)
    	      .click(function() {
    	        const member = $(this).data('member');
    	        $("#chargerName").val(member.name);
    	        $("#chargerEmpno").val(member.id);
    	      });
    	    buttonContainer.append(btn);
    	  }
    	  
    	  // 참여자 버튼 추가
    	  selectedMembers.participants.forEach(member => {
    	    hasMembers = true;
    	    console.log("참여자 추가:", member.name);
    	    
    	    const btn = $('<button type="button" class="btn btn-primary member-btn mb-2 me-2"></button>')
    	      .text(member.name)
    	      .data('member', member)
    	      .click(function() {
    	        const member = $(this).data('member');
    	        $("#chargerName").val(member.name);
    	        $("#chargerEmpno").val(member.id);
    	      });
    	    buttonContainer.append(btn);
    	  });
    	  
    	  // 참조자 버튼 추가
    	  selectedMembers.observers.forEach(member => {
    	    hasMembers = true;
    	    console.log("참조자 추가:", member.name);
    	    
    	    const btn = $('<button type="button" class="btn btn-secondary member-btn mb-2 me-2"></button>')
    	      .text(member.name)
    	      .data('member', member)
    	      .click(function() {
    	        const member = $(this).data('member');
    	        $("#chargerName").val(member.name);
    	        $("#chargerEmpno").val(member.id);
    	      });
    	    buttonContainer.append(btn);
    	  });
    	  
    	  // 버튼이 없는 경우
    	  if (!hasMembers) {
    	    buttonContainer.append('<div class="alert alert-light">등록된 프로젝트 멤버가 없습니다. 이전 단계에서 멤버를 추가하세요.</div>');
    	  }
    	  
    	  console.log("프로젝트 멤버 버튼 업데이트 완료");
    	}
    	  
    	  // 멤버 테이블 업데이트
    	  function updateMembersTable() {
    	    const tableBody = $("#selectedMembersTable tbody");
    	    tableBody.empty();
    	    
    	    let hasMembers = false;
    	    
    	    // 책임자
    	    selectedMembers.responsibles.forEach((responsible, index) => {
    	      hasMembers = true;
    	      
    	      const row = $('<tr data-id="' + responsible.id + '" data-role="responsible" data-index="' + index + '"></tr>');
    	      row.append($('<td></td>').append($('<span class="badge bg-danger"></span>').text('책임자')));
    	      row.append($('<td></td>').text(responsible.name));
    	      row.append($('<td></td>').text(responsible.dept));
    	      row.append($('<td></td>').text(responsible.position));
    	      row.append($('<td></td>').text(responsible.tel));
    	      row.append($('<td></td>').text(responsible.email));
    	      
    	      // 삭제 버튼 추가
    	      const deleteButton = $('<button type="button" class="btn btn-sm btn-outline-danger">삭제</button>');
    	      deleteButton.click(function() {
    	        selectedMembers.responsibles.splice(index, 1);
    	        updateResponsiblesField();
    	        updateMembersTable();
    	      });
    	      
    	      row.append($('<td></td>').append(deleteButton));
    	      tableBody.append(row);
    	    });
    	    
    	    // 참여자
    	    selectedMembers.participants.forEach((member, index) => {
    	      hasMembers = true;
    	      
    	      const row = $('<tr data-id="' + member.id + '" data-role="participant" data-index="' + index + '"></tr>');
    	      row.append($('<td></td>').append($('<span class="badge bg-primary"></span>').text('참여자')));
    	      row.append($('<td></td>').text(member.name));
    	      row.append($('<td></td>').text(member.dept));
    	      row.append($('<td></td>').text(member.position));
    	      row.append($('<td></td>').text(member.tel));
    	      row.append($('<td></td>').text(member.email));
    	      
    	      // 삭제 버튼 추가
    	      const deleteButton = $('<button type="button" class="btn btn-sm btn-outline-danger">삭제</button>');
    	      deleteButton.click(function() {
    	        selectedMembers.participants.splice(index, 1);
    	        updateParticipantsField();
    	        updateMembersTable();
    	      });
    	      
    	      row.append($('<td></td>').append(deleteButton));
    	      tableBody.append(row);
    	    });
    	    
    	    // 참조자
    	    selectedMembers.observers.forEach((member, index) => {
    	      hasMembers = true;
    	      
    	      const row = $('<tr data-id="' + member.id + '" data-role="observer" data-index="' + index + '"></tr>');
    	      row.append($('<td></td>').append($('<span class="badge bg-secondary"></span>').text('참조자')));
    	      row.append($('<td></td>').text(member.name));
    	      row.append($('<td></td>').text(member.dept));
    	      row.append($('<td></td>').text(member.position));
    	      row.append($('<td></td>').text(member.tel));
    	      row.append($('<td></td>').text(member.email));
    	      
    	      // 삭제 버튼 추가
    	      const deleteButton = $('<button type="button" class="btn btn-sm btn-outline-danger">삭제</button>');
    	      deleteButton.click(function() {
    	        selectedMembers.observers.splice(index, 1);
    	        updateObserversField();
    	        updateMembersTable();
    	      });
    	      
    	      row.append($('<td></td>').append(deleteButton));
    	      tableBody.append(row);
    	    });
    	    
    	    // 멤버가 없을 경우 안내 메시지 추가
    	    if (!hasMembers) {
    	      const emptyRow = $('<tr class="empty-row"></tr>');
    	      emptyRow.append($('<td colspan="7" class="text-center text-muted"></td>').text('선택된 인원이 없습니다.'));
    	      tableBody.append(emptyRow);
    	    }
    	  }
    	  
    	  // 멤버 선택 처리 함수
    	  window.selectMember = function(member, targetType) {
    	    console.log("선택된 멤버:", member, "타입:", targetType);
    	    
    	    switch(targetType) {
    	      case 'responsibleManager':
    	        // 책임자를 배열에 추가 (중복 허용)
    	        selectedMembers.responsibles.push(member);
    	        updateResponsiblesField();
    	        break;
    	        
    	      case 'participants':
    	        // 참여자는 중복 추가 허용
    	        selectedMembers.participants.push(member);
    	        updateParticipantsField();
    	        break;
    	        
    	      case 'observers':
    	        // 참조자는 중복 추가 허용
    	        selectedMembers.observers.push(member);
    	        updateObserversField();
    	        break;
    	        
    	      case 'charger':
    	        // 담당자 필드에 값 설정
    	        $("#chargerName").val(member.name);
    	        $("#chargerEmpno").val(member.id);
    	        break;
    	    }
    	    
    	    // 멤버 테이블 업데이트
    	    updateMembersTable();
    	    
    	    // 조직도 숨기기
    	    hideOrgChart();
    	  };
    	  
    	  // 파일 정보 가져오기
    	  function getFileInfo(fileInput) {
    	    if (fileInput && fileInput.files && fileInput.files.length > 0) {
    	      return Array.from(fileInput.files);
    	    }
    	    return null;
    	  }
    	  
    	  // 초기화 - 상위 업무 입력란 숨김
    	  $("#upperTaskNo").closest(".col-md-12").hide();
    	  
    	  // 다음/이전 단계로 이동 - click 이벤트 위임 방식 적용
    	  $(document).on('click', '.next-step', function() {
    	    nextStep();
    	  });
    	  
    	  $(document).on('click', '.prev-step', function() {
    	    prevStep();
    	  });
    	  
    	// 다음 단계로 이동
    	  $('.next-step').click(function() {
    	    if (currentStep < totalSteps) {
    	      // 현재 단계 숨기기
    	      $('#step' + currentStep).hide();
    	      $('#guide-step' + currentStep).hide();
    	      
    	      // 다음 단계 표시
    	      currentStep++;
    	      $('#step' + currentStep).show();
    	      $('#guide-step' + currentStep).show();
    	      
    	      // 진행 상태 업데이트
    	      updateProgress();
    	      
    	      // 3단계로 넘어갈 때 프로젝트 멤버 버튼 업데이트
    	      if (currentStep === 3) {
    	        console.log("3단계로 이동: 프로젝트 멤버 버튼 업데이트 호출");
    	        updateProjectMemberButtons();
    	      }
    	      
    	      // 최종 단계일 경우 확인 정보 업데이트
    	      if (currentStep === 5) {
    	        console.log("5단계로 이동: 최종 확인 정보 업데이트 호출");
    	        updateConfirmation();
    	      }
    	    }
    	  });
    	  
    	  // 금액 입력 시 자동 천단위 콤마 추가
    	  document.getElementById("amountInput").addEventListener("input", function() {
    	    // 숫자만 입력 가능하도록 필터링
    	    let rawValue = this.value.replace(/[^0-9]/g, "");
    	    
    	    // amountInput에는 숫자만 유지
    	    this.value = rawValue;
    	    
    	    // 천 단위 콤마 추가한 값 표시
    	    document.getElementById("amountDisplay").textContent = 
    	      rawValue ? Number(rawValue).toLocaleString('ko-KR') : "0";
    	  });
    	  
    	  // 기본 날짜 설정
    	  document.getElementById('beginDate').value = new Date().toISOString().substring(0,10);
    	  document.getElementById('taskBeginDt').value = new Date().toISOString().substring(0,10);
    	  
    	  // 다음 주소 API 연동
    	  $("#searchAddressBtn").click(function() {
    	    new daum.Postcode({
    	      oncomplete: function(data) {
    	        $("#postcode").val(data.zonecode);
    	        $("#address").val(data.address);
    	        
    	        // 상세주소 필드로 포커스 이동
    	        $("#detailAddress").focus();
    	        
    	        // 전체 주소 업데이트
    	        updateFullAddress();
    	      }
    	    }).open();
    	  });
    	  
    	  // 상세주소 입력 시 전체 주소 업데이트
    	  $("#detailAddress").on("input", function() {
    	    updateFullAddress();
    	  });
    	  
    	  // 조직도 버튼 클릭 이벤트
    	  $(".open-org-chart").click(function() {
    	    const target = $(this).data("target");
    	    console.log("조직도 버튼 클릭:", target);
    	    showOrgChart(target);
    	  });
    	  
    	  // 조직도 닫기 버튼 클릭 이벤트
    	  $("#closeOrgChart").click(function() {
    	    hideOrgChart();
    	  });
    	  
    	  // 업무 폼 초기화 버튼
    	  $("#resetTaskForm").click(function() {
    	    resetTaskForm();
    	  });
    	  
    	  // 업무 추가 버튼 클릭 이벤트
    	  $("#addTask").click(function() {
    	    const title = $("#taskTitle").val();
    	    const chargerName = $("#chargerName").val();
    	    const chargerEmpno = $("#chargerEmpno").val();
    	    const beginDt = $("#taskBeginDt").val();
    	    const endDt = $("#taskEndDt").val();
    	    const priort = $("#taskPriort").val();
    	    const priortText = $("#taskPriort option:selected").text();
    	    const grad = $("#taskGrad").val();
    	    const files = getFileInfo(document.getElementById('taskFile'));
    	    
    	    if (!title || !beginDt || !endDt || !priort || !grad || !chargerName) {
    	      alert("필수 항목을 모두 입력해주세요.");
    	      return;
    	    }
    	    
    	    // 하위 업무 모드인 경우
    	    if (isSubTaskMode) {
    	      const parentTaskId = $("#upperTaskId").val();
    	      
    	      if (!parentTaskId) {
    	        alert("상위 업무가 선택되지 않았습니다.");
    	        return;
    	      }
    	      
    	      const subTaskId = "subtask-" + taskCounter++;
    	      const subTask = {
    	        id: subTaskId,
    	        parentId: parentTaskId,
    	        title: title,
    	        chargerName: chargerName,
    	        chargerEmpno: chargerEmpno,
    	        beginDt: beginDt,
    	        endDt: endDt,
    	        priort: priort,
    	        priortText: priortText,
    	        grad: grad,
    	        files: files
    	      };
    	      
    	      subTasks.push(subTask);
    	      
    	      // 부모 업무에 하위 업무 추가
    	      for (let i = 0; i < mainTasks.length; i++) {
    	        if (mainTasks[i].id === parentTaskId) {
    	          if (!mainTasks[i].subTasks) {
    	            mainTasks[i].subTasks = [];
    	          }
    	          mainTasks[i].subTasks.push(subTask);
    	          break;
    	        }
    	      }
    	      
    	      // 업무 폼 초기화 및 하위 업무 모드 종료
    	      resetTaskForm();
    	    }
    	    // 상위 업무 모드인 경우
    	    else {
    	      const taskId = "task-" + taskCounter++;
    	      const task = {
    	        id: taskId,
    	        title: title,
    	        chargerName: chargerName,
    	        chargerEmpno: chargerEmpno,
    	        beginDt: beginDt,
    	        endDt: endDt,
    	        priort: priort,
    	        priortText: priortText,
    	        grad: grad,
    	        files: files,
    	        subTasks: []
    	      };
    	      
    	      mainTasks.push(task);
    	      
    	      // 입력 필드 초기화
    	      $("#taskTitle").val("");
    	      $("#chargerName").val("");
    	      $("#chargerEmpno").val("");
    	      $("#taskBeginDt").val("");
    	      $("#taskEndDt").val("");
    	      $("#taskPriort").val("");
    	      $("#taskGrad").val("");
    	      $("#taskFile").val("");
    	    }
    	    
    	    // 업무 트리 업데이트
    	    updateTaskTree();
    	  });
    	  
    	  // 폼 제출 이벤트 - 백엔드 연결 
    	  $("#projectForm").submit(function(e) {
    	    // 기본 제출 동작 방지 (데이터 가공을 위해)
    	    e.preventDefault();
    	    
    	    // 1. 프로젝트 참여자 처리
    	    // 기존 hidden 필드 제거
    	    $("input[name='emp_no']").remove();
    	    $("input[name='emp_role']").remove();
    	    $("input[name='emp_auth']").remove();
    	    
    	    // 책임자 정보 추가
    	    selectedMembers.responsibles.forEach(responsible => {
    	      addHiddenField("emp_no", responsible.id);
    	      addHiddenField("emp_role", "00"); // 책임자 역할 코드
    	      addHiddenField("emp_auth", "0011"); // 기본 권한
    	    });
    	    
    	    // 참여자 정보 추가
    	    selectedMembers.participants.forEach(participant => {
    	      addHiddenField("emp_no", participant.id);
    	      addHiddenField("emp_role", "01"); // 참여자 역할 코드
    	      addHiddenField("emp_auth", "0001"); // 기본 권한
    	    });
    	    
    	    // 참조자 정보 추가
    	    selectedMembers.observers.forEach(observer => {
    	      addHiddenField("emp_no", observer.id);
    	      addHiddenField("emp_role", "02"); // 참조자 역할 코드
    	      addHiddenField("emp_auth", "0001"); // 기본 권한
    	    });
    	    
    	    // 2. 업무(과제) 정보 처리
    	    // 기존 hidden 필드 제거
    	    $("input[name='task_name']").remove();
    	    $("input[name='task_content']").remove();
    	    $("input[name='task_priority']").remove();
    	    $("input[name='task_grad']").remove();
    	    $("input[name='task_charger']").remove();
    	    $("input[name='task_begin_dt']").remove();
    	    $("input[name='task_end_dt']").remove();
    	    $("input[name='task_progrsrt']").remove();
    	    $("input[name='task_sttus']").remove();
    	    $("input[name='parent_task_id']").remove();
    	    
    	    // 업무 ID 매핑 (클라이언트 ID -> 인덱스)
    	    const taskIdMap = {};
    	    let taskIndex = 0;
    	    
    	    // 상위 업무 추가
    	    mainTasks.forEach((task, index) => {
    	      taskIdMap[task.id] = "task-" + taskIndex;
    	      
    	      addHiddenField("task_name", task.title);
    	      addHiddenField("task_content", task.title); // 내용이 없으면 제목으로 대체
    	      addHiddenField("task_priority", task.priort);
    	      addHiddenField("task_grad", task.grad);
    	      addHiddenField("task_charger", task.chargerEmpno);
    	      addHiddenField("task_begin_dt", task.beginDt);
    	      addHiddenField("task_end_dt", task.endDt);
    	      addHiddenField("task_progrsrt", "0"); // 초기 진행률 0%
    	      addHiddenField("task_sttus", "0"); // 초기 상태 '대기'
    	      addHiddenField("parent_task_id", ""); // 상위 업무는 parent_task_id가 없음
    	      
    	      taskIndex++;
    	      
    	      // 하위 업무 추가
    	      if (task.subTasks && task.subTasks.length > 0) {
    	        task.subTasks.forEach(subTask => {
    	          addHiddenField("task_name", subTask.title);
    	          addHiddenField("task_content", subTask.title);
    	          addHiddenField("task_priority", subTask.priort);
    	          addHiddenField("task_grad", subTask.grad);
    	          addHiddenField("task_charger", subTask.chargerEmpno);
    	          addHiddenField("task_begin_dt", subTask.beginDt);
    	          addHiddenField("task_end_dt", subTask.endDt);
    	          addHiddenField("task_progrsrt", "0");
    	          addHiddenField("task_sttus", "0");
    	          addHiddenField("parent_task_id", taskIdMap[subTask.parentId]); // 상위 업무 ID 참조
    	          
    	          taskIndex++;
    	        });
    	      }
    	    });
    	    
    	    // 3. 금액 처리 - 콤마 제거
    	    const amount = $("#amountInput").val() ? $("#amountDisplay").text() : "-";
    	    $("input[name='prjct_rcvord_amount']").val(amount);
    	    
    	    // 4. 주소 처리
    	    updateFullAddress();
    	    
    	    // 로깅 (디버깅용)
    	    console.log("폼 제출 데이터 준비 완료");
    	    
    	    // 5. 폼 제출
    	    this.submit();
    	    
    	    // Hidden 필드 추가 헬퍼 함수
    	    function addHiddenField(name, value) {
    	      if (value === undefined || value === null) return;
    	      
    	      $("<input>").attr({
    	        type: "hidden",
    	        name: name,
    	        value: value
    	      }).appendTo("#projectForm");
    	    }
    	  });
    	});
  </script>
</body>
</html>