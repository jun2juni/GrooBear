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
  <meta
    name="viewport"
    content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"
  />
  <meta http-equiv="X-UA-Compatible" content="ie=edge" />
  <title>${title}</title>
  <c:import url="../layout/prestyle.jsp" />
  <!-- Bootstrap 5.3 CSS (직접 추가, 디자인 통일용) -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- jQuery UI CSS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/jquery-ui@1.13.2/dist/themes/base/jquery-ui.min.css">
  <!-- FontAwesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
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
              ${projectVO}
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
                        <input type="date" name="prjct_begin_date"  id="beginDate" required>
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
                      <button type="button" class="btn btn-primary next-step">
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
                              </tr>
                            </thead>
                            <tbody>
                              <!-- 선택된 인원 목록이 여기에 표시됩니다 -->
                              <tr class="empty-row">
                                <td colspan="6" class="text-center text-muted">선택된 인원이 없습니다.</td>
                              </tr>
                            </tbody>
                          </table>
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

                <!-- 페이지 3: 업무 관리 -->
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
                          <div class="col-md-6">
                            <div class="input-style-1 mb-2">
                              <label>시작일 <span class="text-danger">*</span></label>
                              <input type="date" id="taskBeginDt" >
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
                      <button type="button" class="btn btn-light prev-step">
                        <i class="fas fa-arrow-left me-1"></i> 이전 단계
                      </button>
                      <button type="button" class="btn btn-primary next-step">
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
                      <button type="button" class="btn btn-light prev-step">
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
            <div class="card-style mb-30 sticky-top" style="top: 80px;">
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
                    <li>각 역할별로 최소 1명 이상의 인원을 지정해주세요.</li>
                  </ul>
                </div>
                <div class="current-guide" id="guide-step3" style="display: none;">
                  <h5 class="mb-3"><i class="fas fa-tasks me-2 text-primary"></i>업무 관리 안내</h5>
                  <ul class="guide-list">
                    <li>주요 업무를 먼저 등록한 후 하위 업무를 추가해주세요.</li>
                    <li>업무 제목은 구체적으로 작성하는 것이 좋습니다.</li>
                    <li>담당자는 조직도에서 선택할 수 있습니다.</li>
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
                
                <!-- 조직도 표시 영역 (담당자 선택 시 표시) -->
                <div id="orgChartArea" style="display: none;">
                  <h5 class="mb-3"><i class="fas fa-sitemap me-2 text-primary"></i>조직도</h5>
                  <div id="orgChartContent" class="p-3 border rounded">
                    <!-- 조직도가 여기에 표시됩니다 (실제 환경에서는 메서드 호출을 통해 구현) -->
                    <div class="text-center">
                      <p class="mb-3 text-muted">여기에 조직도가 표시됩니다.</p>
                      <small class="text-muted">실제 환경에서는 조직도 메서드를 연결해주세요.</small>
                    </div>
                    
                    <!-- 임시 조직도 - 실제 환경에서는 제거되어야 함 -->
                    <div class="demo-org-chart mt-3">
                      <ul class="list-group">
                        <li class="list-group-item">
                          <div class="d-flex justify-content-between align-items-center">
                            <div>
                              <i class="fas fa-building me-2"></i> 경영지원팀
                            </div>
                            <button class="btn btn-sm btn-light org-expand-btn">
                              <i class="fas fa-plus"></i>
                            </button>
                          </div>
                          <ul class="list-group mt-2 org-members" style="display: none;">
                            <li class="list-group-item">
                              <div class="d-flex justify-content-between align-items-center">
                                <div>
                                  <span class="badge bg-primary me-2">팀장</span> 홍길동
                                </div>
                                <button class="btn btn-sm btn-primary select-member" 
                                  data-id="1001" data-name="홍길동" data-dept="경영지원팀" data-position="팀장" 
                                  data-tel="010-1234-5678" data-email="hong@example.com">선택</button>
                              </div>
                            </li>
                            <li class="list-group-item">
                              <div class="d-flex justify-content-between align-items-center">
                                <div>
                                  <span class="badge bg-secondary me-2">대리</span> 김영희
                                </div>
                                <button class="btn btn-sm btn-primary select-member"
                                  data-id="1002" data-name="김영희" data-dept="경영지원팀" data-position="대리" 
                                  data-tel="010-2345-6789" data-email="kim@example.com">선택</button>
                              </div>
                            </li>
                          </ul>
                        </li>
                        <li class="list-group-item">
                          <div class="d-flex justify-content-between align-items-center">
                            <div>
                              <i class="fas fa-laptop-code me-2"></i> 개발팀
                            </div>
                            <button class="btn btn-sm btn-light org-expand-btn">
                              <i class="fas fa-plus"></i>
                            </button>
                          </div>
                          <ul class="list-group mt-2 org-members" style="display: none;">
                            <li class="list-group-item">
                              <div class="d-flex justify-content-between align-items-center">
                                <div>
                                  <span class="badge bg-primary me-2">팀장</span> 이철수
                                </div>
                                <button class="btn btn-sm btn-primary select-member"
                                  data-id="2001" data-name="이철수" data-dept="개발팀" data-position="팀장" 
                                  data-tel="010-3456-7890" data-email="lee@example.com">선택</button>
                              </div>
                            </li>
                            <li class="list-group-item">
                              <div class="d-flex justify-content-between align-items-center">
                                <div>
                                  <span class="badge bg-secondary me-2">선임</span> 박지민
                                </div>
                                <button class="btn btn-sm btn-primary select-member"
                                  data-id="2002" data-name="박지민" data-dept="개발팀" data-position="선임" 
                                  data-tel="010-4567-8901" data-email="park@example.com">선택</button>
                              </div>
                            </li>
                          </ul>
                        </li>
                      </ul>
                    </div>
                    
                    <div class="text-center mt-3">
                      <button type="button" id="closeOrgChart" class="btn btn-secondary">
                        <i class="fas fa-times me-1"></i> 닫기
                      </button>
                    </div>
                  </div>
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
  
  <!-- Bootstrap 5.3 JS (직접 추가, 디자인 통일용) -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  <!-- jQuery (부트스트랩 모달 등을 위해 추가) -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <!-- jQuery UI JS -->
  <script src="https://cdn.jsdelivr.net/npm/jquery-ui@1.13.2/dist/jquery-ui.min.js"></script>
  <!-- 다음 주소 API -->
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  
  <script>
    $(document).ready(function() {
      let currentStep = 1;
      const totalSteps = 5;
      let mainTasks = [];
      let subTasks = [];
      let taskCounter = 1;
      let selectedMembers = {
        responsible: null,
        participants: [],
        observers: []
      };
      let currentOrgTarget = null;
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
      
      // 최종 확인 정보 업데이트
      function updateConfirmation() {
        const projectName = $("input[name='prjct_nm']").val() || "-";
        const projectCategory = $("select[name='ctgry'] option:selected").text() || "-";
        const projectDesc = $("textarea[name='prjct_cn']").val() || "-";
        const beginDate = $("input[name='prjct_begin_date']").val() || "-";
        const endDate = $("input[name='prjct_end_date']").val() || "-";
        const statusText = $("select[name='prjct_sttus'] option:selected").text() || "-";
        const grade = $("select[name='prjct_grad']").val() || "-";
        const amount = $("input[name='prjct_rcvord_amount']").val() || "-";
        const address = $("input[name='prjct_adres']").val() || "-";
        const url = $("input[name='prjct_url']").val() || "-";
        
        // 기본 정보 업데이트
        $("#confirm-project-name").text(projectName);
        $("#confirm-project-category").text(projectCategory);
        $("#confirm-project-desc").text(projectDesc);
        $("#confirm-project-period").text(beginDate + " ~ " + endDate);
        $("#confirm-project-status").text(statusText);
        $("#confirm-project-grade").text(grade);
        
        // 추가 정보 업데이트
        $("#confirm-amount").text(amount + " 원");
        $("#confirm-address").text(address);
        $("#confirm-url").text(url);
        
        // 참여자 정보 업데이트
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
            if (task.subTasks.length > 0) {
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
      }
      
      // 멤버 선택 처리 함수
      function selectMember(member, targetType) {
        switch(targetType) {
          case 'responsibleManager':
            selectedMembers.responsible = member;
            $("#responsibleManager").val(member.name);
            $("#responsibleManagerEmpno").val(member.id);
            break;
          case 'participants':
            // 중복 체크
            if (!selectedMembers.participants.some(p => p.id === member.id)) {
              selectedMembers.participants.push(member);
              updateParticipantsField();
            }
            break;
          case 'observers':
            if (!selectedMembers.observers.some(o => o.id === member.id)) {
              selectedMembers.observers.push(member);
              updateObserversField();
            }
            break;
          case 'charger':
            $("#chargerName").val(member.name);
            $("#chargerEmpno").val(member.id);
            break;
        }
        
        // 멤버 테이블 업데이트
        updateMembersTable();
        
        // 조직도 숨기기
        hideOrgChart();
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
      
      // 멤버 테이블 업데이트
      function updateMembersTable() {
        const tableBody = $("#selectedMembersTable tbody");
        tableBody.empty();
        
        let hasMembers = false;
        
        // 책임자
        if (selectedMembers.responsible) {
          hasMembers = true;
          const row = $('<tr></tr>');
          row.append($('<td></td>').append($('<span class="badge bg-danger"></span>').text('책임자')));
          row.append($('<td></td>').text(selectedMembers.responsible.name));
          row.append($('<td></td>').text(selectedMembers.responsible.dept));
          row.append($('<td></td>').text(selectedMembers.responsible.position));
          row.append($('<td></td>').text(selectedMembers.responsible.tel));
          row.append($('<td></td>').text(selectedMembers.responsible.email));
          tableBody.append(row);
        }
        
        // 참여자
        selectedMembers.participants.forEach(member => {
          hasMembers = true;
          const row = $('<tr></tr>');
          row.append($('<td></td>').append($('<span class="badge bg-primary"></span>').text('참여자')));
          row.append($('<td></td>').text(member.name));
          row.append($('<td></td>').text(member.dept));
          row.append($('<td></td>').text(member.position));
          row.append($('<td></td>').text(member.tel));
          row.append($('<td></td>').text(member.email));
          tableBody.append(row);
        });
        
        // 참조자
        selectedMembers.observers.forEach(member => {
          hasMembers = true;
          const row = $('<tr></tr>');
          row.append($('<td></td>').append($('<span class="badge bg-secondary"></span>').text('참조자')));
          row.append($('<td></td>').text(member.name));
          row.append($('<td></td>').text(member.dept));
          row.append($('<td></td>').text(member.position));
          row.append($('<td></td>').text(member.tel));
          row.append($('<td></td>').text(member.email));
          tableBody.append(row);
        });
        
        // 멤버가 없을 경우 안내 메시지 추가
        if (!hasMembers) {
          const emptyRow = $('<tr class="empty-row"></tr>');
          emptyRow.append($('<td colspan="6" class="text-center text-muted"></td>').text('선택된 인원이 없습니다.'));
          tableBody.append(emptyRow);
        }
      }
      
      // 조직도 표시 함수
      function showOrgChart(targetType) {
        currentOrgTarget = targetType;
        
        // 가이드 내용 숨기기
        $('.current-guide').hide();
        
        // 조직도 영역 표시
        $('#orgChartArea').show();
      }
      
      // 조직도 닫기 함수
      function hideOrgChart() {
        // 현재 단계의 가이드 내용 표시
        $('#guide-step' + currentStep).show();
        
        // 조직도 영역 숨기기
        $('#orgChartArea').hide();
        
        currentOrgTarget = null;
      }
      
      // 파일 정보 가져오기
      function getFileInfo(fileInput) {
        if (fileInput && fileInput.files && fileInput.files.length > 0) {
          return Array.from(fileInput.files);
        }
        return null;
      }
      
      // 초기화 - 상위 업무 입력란 숨김
      $("#upperTaskNo").closest(".col-md-12").hide();
      
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
        }
        
        // 최종 단계일 경우 확인 정보 업데이트
        if (currentStep === 5) {
          updateConfirmation();
        }
      });
      
      // 이전 단계로 이동
      $('.prev-step').click(function() {
        if (currentStep > 1) {
          // 현재 단계 숨기기
          $('#step' + currentStep).hide();
          $('#guide-step' + currentStep).hide();
          
          // 이전 단계 표시
          currentStep--;
          $('#step' + currentStep).show();
          $('#guide-step' + currentStep).show();
          
          // 진행 상태 업데이트
          updateProgress();
        }
      });
      
      // 금액 입력 시 자동 천단위 콤마 추가
	  document.getElementById("amountInput").addEventListener("input", function () {
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
        showOrgChart(target);
      });
      
      // 조직도 닫기 버튼 클릭 이벤트
      $("#closeOrgChart").click(function() {
        hideOrgChart();
      });
      
      // 조직도 확장 버튼 클릭 이벤트 (임시 조직도용)
      $(".org-expand-btn").click(function() {
        const icon = $(this).find("i");
        const members = $(this).closest(".list-group-item").find(".org-members");
        
        if (members.is(":visible")) {
          icon.removeClass("fa-minus").addClass("fa-plus");
          members.slideUp();
        } else {
          icon.removeClass("fa-plus").addClass("fa-minus");
          members.slideDown();
        }
      });
      
      // 멤버 선택 버튼 클릭 이벤트 (임시 조직도용)
      $(document).on("click", ".select-member", function() {
        const member = {
          id: $(this).data("id"),
          name: $(this).data("name"),
          dept: $(this).data("dept"),
          position: $(this).data("position"),
          tel: $(this).data("tel"),
          email: $(this).data("email")
        };
        
        selectMember(member, currentOrgTarget);
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
      
      // 폼 제출 이벤트 (DB 연결 없이 테스트)
      $("#projectForm").submit(function(e) {
        e.preventDefault();
        
        // 폼 데이터 수집
        const formData = {
          prjct_nm: $("input[name='prjct_nm']").val(),
          ctgry: $("select[name='ctgry']").val(),
          prjct_cn: $("textarea[name='prjct_cn']").val(),
          prjct_begin_date: $("input[name='prjct_begin_date']").val(),
          prjct_end_date: $("input[name='prjct_end_date']").val(),
          prjct_sttus: $("select[name='prjct_sttus']").val(),
          prjct_grad: $("select[name='prjct_grad']").val(),
          prjct_url: $("input[name='prjct_url']").val(),
          prjct_rcvord_amount: $("input[name='prjct_rcvord_amount']").val().replace(/,/g, ''), // 콤마 제거
          prjct_adres: $("input[name='prjct_adres']").val(),
          members: selectedMembers,
          tasks: mainTasks,
          subTasks: subTasks
        };
        
        // 콘솔에 데이터 출력 (테스트용)
        console.log("===== 프로젝트 생성 데이터 =====");
        console.log(formData);
        console.log("=============================");
        
        // 모달로 데이터 표시 (테스트용)
        let dataPreview = `
          <div class="modal" id="dataPreviewModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title">제출 데이터 미리보기 (테스트용)</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                  <pre class="bg-light p-3" style="max-height: 400px; overflow-y: auto;">${JSON.stringify(formData, null, 2)}</pre>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-primary" data-bs-dismiss="modal">확인</button>
                </div>
              </div>
            </div>
          </div>
        `;
        
        // 기존 모달이 있으면 제거
        $("#dataPreviewModal").remove();
        
        // 모달 추가 및 표시
        $("body").append(dataPreview);
        const modal = new bootstrap.Modal(document.getElementById('dataPreviewModal'));
        modal.show();
        
        alert("프로젝트가 성공적으로 생성되었습니다! (테스트 모드)");
        
        // 실제 서버 연동 시 아래 코드 사용
        /*
        // 필요한 데이터를 hidden 필드로 추가
        if ($("#projectData").length) {
          $("#projectData").val(JSON.stringify({
            members: selectedMembers,
            tasks: mainTasks,
            subTasks: subTasks
          }));
        } else {
          $(this).append(`<input type="hidden" id="projectData" name="projectData" value='${JSON.stringify({
            members: selectedMembers,
            tasks: mainTasks,
            subTasks: subTasks
          })}'>`);
        }
        
        // 서버로 폼 제출
        this.submit();
        */
      });
    });
  </script>
  
  <style>
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
    
    .guide-list {
      padding-left: 20px;
    }
    
    .guide-list li {
      margin-bottom: 8px;
      color: #555;
    }
    
    .confirmation-details h6 {
      color: #4361ee;
      padding-bottom: 5px;
      border-bottom: 1px solid #eee;
    }
    
    .input-group-text {
      background-color: #f9fafb;
      border-color: #e2e8f0;
    }
    
    /* 데모 조직도 스타일 */
    .demo-org-chart .list-group-item {
      border-left: 3px solid #4361ee;
    }
    
    .org-members {
      margin-left: 20px;
    }
    
    .org-members .list-group-item {
      border-left: 3px solid #eee;
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
  </style>