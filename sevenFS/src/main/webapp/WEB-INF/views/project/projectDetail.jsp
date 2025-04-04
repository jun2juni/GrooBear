<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="title" scope="application" value="프로젝트 상세" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>${title}</title>
  <c:import url="../layout/prestyle.jsp" />
  <style>
    .section-title {
      color: #4361ee;
      border-bottom: 2px solid #eee;
      padding-bottom: 8px;
      margin: 20px 0 15px 0;
      font-weight: 600;
    }
    
    .status-badge {
      padding: 6px 10px;
      border-radius: 4px;
      font-weight: 500;
    }
    
    .info-label {
      font-weight: 600;
      color: #555;
      min-width: 140px;
    }
    
    .member-badge {
      display: inline-block;
      margin-right: 5px;
      margin-bottom: 5px;
      padding: 5px 10px;
      border-radius: 4px;
    }
    
    .task-item {
      border-left: 3px solid #4361ee;
      padding: 10px 15px;
      background-color: #f8f9fa;
      border-radius: 4px;
      margin-bottom: 10px;
    }
    
    .sub-task-item {
      margin-left: 30px;
      border-left: 3px solid #6c757d;
      padding: 8px 15px;
      background-color: #fff;
      border-radius: 4px;
      margin-bottom: 8px;
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
          <!-- 메인 컨텐츠 영역 -->
          <div class="col-lg-8">
            <div class="card-style mb-30">
              <!-- 프로젝트 타이틀 및 상태 -->
              <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                  <h2 class="mb-1">${project.prjct_nm}</h2>
                  <div class="text-muted">프로젝트 ID: ${project.prjct_id}</div>
                </div>
                <div>
                  <!-- 상태에 따라 배지 색상 변경 -->
                  <c:choose>
                    <c:when test="${project.prjct_sttus eq '00'}">
                      <span class="status-badge bg-secondary">대기</span>
                    </c:when>
                    <c:when test="${project.prjct_sttus eq '01'}">
                      <span class="status-badge bg-success">진행중</span>
                    </c:when>
                    <c:when test="${project.prjct_sttus eq '02'}">
                      <span class="status-badge bg-primary">완료</span>
                    </c:when>
                    <c:when test="${project.prjct_sttus eq '03'}">
                      <span class="status-badge bg-danger">취소</span>
                    </c:when>
                    <c:otherwise>
                      <span class="status-badge bg-secondary">기타</span>
                    </c:otherwise>
                  </c:choose>
                  <span class="ms-2 badge bg-info">등급: ${project.prjct_grad}</span>
                </div>
              </div>
              
              <!-- 1. 기본 정보 섹션 -->
              <h4 class="section-title">기본 정보</h4>
              <div class="table-responsive">
                <table class="table table-bordered">
                  <tbody>
                    <tr>
                      <td class="info-label">프로젝트 분류</td>
                      <td>
                        <c:choose>
                          <c:when test="${project.ctgry eq '00'}">국가지원사업</c:when>
                          <c:when test="${project.ctgry eq '01'}">법인자체사업</c:when>
                          <c:when test="${project.ctgry eq '02'}">산학협력사업</c:when>
                          <c:when test="${project.ctgry eq '03'}">민간수주사업</c:when>
                          <c:when test="${project.ctgry eq '04'}">해외협력사업</c:when>
                          <c:otherwise>기타</c:otherwise>
                        </c:choose>
                      </td>
                    </tr>
                    <tr>
                      <td class="info-label">프로젝트 내용</td>
                      <td>${project.prjct_cn}</td>
                    </tr>
                    <tr>
                      <td class="info-label">프로젝트 기간</td>
                      <td>
                        <fmt:formatDate value="${project.prjct_begin_date}" pattern="yyyy-MM-dd" /> ~ 
                        <fmt:formatDate value="${project.prjct_end_date}" pattern="yyyy-MM-dd" />
                      </td>
                    </tr>
                    <tr>
                      <td class="info-label">사업 수주 금액</td>
                      <td><fmt:formatNumber value="${project.prjct_rcvord_amount}" pattern="#,###" /> 원</td>
                    </tr>
                    <c:if test="${not empty project.prjct_adres}">
                      <tr>
                        <td class="info-label">프로젝트 주소</td>
                        <td>${project.prjct_adres}</td>
                      </tr>
                    </c:if>
                    <c:if test="${not empty project.prjct_url}">
                      <tr>
                        <td class="info-label">프로젝트 URL</td>
                        <td><a href="${project.prjct_url}" target="_blank">${project.prjct_url}</a></td>
                      </tr>
                    </c:if>
                  </tbody>
                </table>
              </div>
              
              <!-- 2. 참여자 정보 -->
              <h4 class="section-title">프로젝트 참여자</h4>
              <c:choose>
                <c:when test="${not empty members}">
                  <div class="table-responsive">
                    <table class="table table-bordered">
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
                        <c:forEach items="${members}" var="member">
                          <tr>
                            <td>
                              <c:choose>
                                <c:when test="${member.role_cd eq '00'}">
                                  <span class="badge bg-danger">책임자</span>
                                </c:when>
                                <c:when test="${member.role_cd eq '01'}">
                                  <span class="badge bg-primary">참여자</span>
                                </c:when>
                                <c:when test="${member.role_cd eq '02'}">
                                  <span class="badge bg-secondary">참조자</span>
                                </c:when>
                                <c:otherwise>
                                  <span class="badge bg-light text-dark">기타</span>
                                </c:otherwise>
                              </c:choose>
                            </td>
                            <td>${member.emp_nm}</td>
                            <td>${member.dept_nm}</td>
                            <td>${member.jbps_nm}</td>
                            <td>${member.mbtlnum}</td>
                            <td>${member.email}</td>
                          </tr>
                        </c:forEach>
                      </tbody>
                    </table>
                  </div>
                </c:when>
                <c:otherwise>
                  <p class="text-muted">등록된 참여자가 없습니다.</p>
                </c:otherwise>
              </c:choose>
              
              <!-- 3. 업무 정보 -->
              <h4 class="section-title">업무 정보</h4>
              <c:choose>
                <c:when test="${not empty tasks}">
                  <div class="task-list mb-4">
                    <c:forEach items="${tasks}" var="task">
                      <c:if test="${empty task.parent_task_id}">
                        <!-- 상위 업무 -->
                        <div class="task-item">
                          <div class="d-flex justify-content-between align-items-start">
                            <div>
                              <h5 class="mb-1">${task.task_name}</h5>
                              <div class="text-muted small">
                                <span><i class="fas fa-user me-1"></i> ${task.charger_nm}</span>
                                <span class="ms-3"><i class="fas fa-calendar me-1"></i> 
                                  <fmt:formatDate value="${task.task_begin_dt}" pattern="yyyy-MM-dd" /> ~ 
                                  <fmt:formatDate value="${task.task_end_dt}" pattern="yyyy-MM-dd" />
                                </span>
                              </div>
                            </div>
                            <div>
                              <c:choose>
                                <c:when test="${task.task_priority eq '00'}">
                                  <span class="badge bg-info">낮음</span>
                                </c:when>
                                <c:when test="${task.task_priority eq '01'}">
                                  <span class="badge bg-success">보통</span>
                                </c:when>
                                <c:when test="${task.task_priority eq '02'}">
                                  <span class="badge bg-warning text-dark">높음</span>
                                </c:when>
                                <c:when test="${task.task_priority eq '03'}">
                                  <span class="badge bg-danger">긴급</span>
                                </c:when>
                              </c:choose>
                              <span class="badge bg-secondary ms-1">등급: ${task.task_grad}</span>
                            </div>
                          </div>
                          
                          <!-- 진행률 표시 -->
                          <div class="mt-2">
                            <div class="progress" style="height: 8px;">
                              <div class="progress-bar" role="progressbar" 
                                  style="width: ${task.task_progrsrt}%;" 
                                  aria-valuenow="${task.task_progrsrt}" 
                                  aria-valuemin="0" 
                                  aria-valuemax="100"></div>
                            </div>
                            <div class="d-flex justify-content-between mt-1">
                              <span class="small">${task.task_progrsrt}% 완료</span>
                              <span class="small">
                                <c:choose>
                                  <c:when test="${task.task_sttus eq '0'}">대기</c:when>
                                  <c:when test="${task.task_sttus eq '1'}">진행중</c:when>
                                  <c:when test="${task.task_sttus eq '2'}">완료</c:when>
                                  <c:when test="${task.task_sttus eq '3'}">지연</c:when>
                                  <c:otherwise>기타</c:otherwise>
                                </c:choose>
                              </span>
                            </div>
                          </div>
                          
                          <!-- 하위 업무 표시 -->
                          <c:forEach items="${tasks}" var="subTask">
                            <c:if test="${subTask.parent_task_id eq task.task_id}">
                              <div class="sub-task-item mt-2">
                                <div class="d-flex justify-content-between align-items-start">
                                  <div>
                                    <h6 class="mb-1">
                                      <i class="fas fa-level-down-alt me-2 text-secondary"></i> ${subTask.task_name}
                                    </h6>
                                    <div class="text-muted small">
                                      <span><i class="fas fa-user me-1"></i> ${subTask.charger_nm}</span>
                                      <span class="ms-3"><i class="fas fa-calendar me-1"></i> 
                                        <fmt:formatDate value="${subTask.task_begin_dt}" pattern="yyyy-MM-dd" /> ~ 
                                        <fmt:formatDate value="${subTask.task_end_dt}" pattern="yyyy-MM-dd" />
                                      </span>
                                    </div>
                                  </div>
                                  <div>
                                    <c:choose>
                                      <c:when test="${subTask.task_priority eq '00'}">
                                        <span class="badge bg-info">낮음</span>
                                      </c:when>
                                      <c:when test="${subTask.task_priority eq '01'}">
                                        <span class="badge bg-success">보통</span>
                                      </c:when>
                                      <c:when test="${subTask.task_priority eq '02'}">
                                        <span class="badge bg-warning text-dark">높음</span>
                                      </c:when>
                                      <c:when test="${subTask.task_priority eq '03'}">
                                        <span class="badge bg-danger">긴급</span>
                                      </c:when>
                                    </c:choose>
                                    <span class="badge bg-secondary ms-1">등급: ${subTask.task_grad}</span>
                                  </div>
                                </div>
                                
                                <!-- 진행률 표시 -->
                                <div class="mt-2">
                                  <div class="progress" style="height: 6px;">
                                    <div class="progress-bar" role="progressbar" 
                                        style="width: ${subTask.task_progrsrt}%;" 
                                        aria-valuenow="${subTask.task_progrsrt}" 
                                        aria-valuemin="0" 
                                        aria-valuemax="100"></div>
                                  </div>
                                  <div class="d-flex justify-content-between mt-1">
                                    <span class="small">${subTask.task_progrsrt}% 완료</span>
                                    <span class="small">
                                      <c:choose>
                                        <c:when test="${subTask.task_sttus eq '0'}">대기</c:when>
                                        <c:when test="${subTask.task_sttus eq '1'}">진행중</c:when>
                                        <c:when test="${subTask.task_sttus eq '2'}">완료</c:when>
                                        <c:when test="${subTask.task_sttus eq '3'}">지연</c:when>
                                        <c:otherwise>기타</c:otherwise>
                                      </c:choose>
                                    </span>
                                  </div>
                                </div>
                              </div>
                            </c:if>
                          </c:forEach>
                        </div>
                      </c:if>
                    </c:forEach>
                  </div>
                </c:when>
                <c:otherwise>
                  <p class="text-muted">등록된 업무가 없습니다.</p>
                </c:otherwise>
              </c:choose>
              
              <!-- 하단 버튼 영역 -->
              <div class="d-flex justify-content-end mt-4">
                <a href="/project/list" class="btn btn-light me-2">
                  <i class="fas fa-list me-1"></i> 목록으로
                </a>
                <a href="/project/edit/${project.prjct_id}" class="btn btn-primary me-2">
                  <i class="fas fa-edit me-1"></i> 수정
                </a>
                <button type="button" class="btn btn-danger" onclick="confirmDelete(${project.prjct_id})">
                  <i class="fas fa-trash me-1"></i> 삭제
                </button>
              </div>
            </div>
          </div>
          
          <!-- 사이드 영역 -->
          <div class="col-lg-4">
            <div class="card-style mb-30 sticky-top" style="top: 80px;">
              <!-- 프로젝트 요약 정보 -->
              <h5 class="mb-3">프로젝트 요약</h5>
              <div class="project-stats">
                <div class="d-flex justify-content-between p-3 border-bottom">
                  <span class="fw-bold">프로젝트 상태</span>
                  <span>
                    <c:choose>
                      <c:when test="${project.prjct_sttus eq '00'}">
                        <span class="text-secondary">대기</span>
                      </c:when>
                      <c:when test="${project.prjct_sttus eq '01'}">
                        <span class="text-success">진행중</span>
                      </c:when>
                      <c:when test="${project.prjct_sttus eq '02'}">
                        <span class="text-primary">완료</span>
                      </c:when>
                      <c:when test="${project.prjct_sttus eq '03'}">
                        <span class="text-danger">취소</span>
                      </c:when>
                    </c:choose>
                  </span>
                </div>
                <div class="d-flex justify-content-between p-3 border-bottom">
                  <span class="fw-bold">시작일</span>
                  <span><fmt:formatDate value="${project.prjct_begin_date}" pattern="yyyy-MM-dd" /></span>
                </div>
                <div class="d-flex justify-content-between p-3 border-bottom">
                  <span class="fw-bold">종료일</span>
                  <span><fmt:formatDate value="${project.prjct_end_date}" pattern="yyyy-MM-dd" /></span>
                </div>
                <div class="d-flex justify-content-between p-3 border-bottom">
                  <span class="fw-bold">총 작업</span>
                  <span>${fn:length(tasks)}</span>
                </div>
                <div class="d-flex justify-content-between p-3 border-bottom">
                  <span class="fw-bold">완료된 작업</span>
                  <c:set var="completedTasks" value="0" />
                  <c:forEach items="${tasks}" var="task">
                    <c:if test="${task.task_sttus eq '2'}">
                      <c:set var="completedTasks" value="${completedTasks + 1}" />
                    </c:if>
                  </c:forEach>
                  <span>${completedTasks}</span>
                </div>
                <div class="d-flex justify-content-between p-3 border-bottom">
                  <span class="fw-bold">참여 인원</span>
                  <span>${fn:length(members)}</span>
                </div>
              </div>
              
              <!-- 프로젝트 날짜 정보 -->
              <h5 class="mt-4 mb-3">일정 정보</h5>
              <c:set var="today" value="<%= new java.util.Date() %>" />
              <c:set var="beginDate" value="${project.prjct_begin_date.time}" />
              <c:set var="endDate" value="${project.prjct_end_date.time}" />
              <c:set var="todayTime" value="${today.time}" />
              <c:set var="totalDuration" value="${endDate - beginDate}" />
              
              <c:choose>
                <c:when test="${todayTime < beginDate}">
                  <!-- 프로젝트 시작 전 -->
                  <div class="alert alert-secondary">
                    프로젝트가 아직 시작되지 않았습니다.
                    <div class="small mt-1">
                      시작까지 <fmt:formatNumber value="${(beginDate - todayTime) / (1000*60*60*24)}" pattern="#" /> 일 남았습니다.
                    </div>
                  </div>
                </c:when>
                <c:when test="${todayTime > endDate}">
                  <!-- 프로젝트 종료 -->
                  <div class="alert alert-primary">
                    프로젝트가 종료되었습니다.
                    <div class="small mt-1">
                      <fmt:formatNumber value="${(todayTime - endDate) / (1000*60*60*24)}" pattern="#" /> 일 전에 종료되었습니다.
                    </div>
                  </div>
                </c:when>
                <c:otherwise>
                  <!-- 프로젝트 진행중 -->
                  <c:set var="elapsedTime" value="${todayTime - beginDate}" />
                  <c:set var="progressPercent" value="${(elapsedTime / totalDuration) * 100}" />
                  <div class="alert alert-success">
                    프로젝트가 진행중입니다.
                    <div class="small mt-1">
                      전체 기간의 <fmt:formatNumber value="${progressPercent}" pattern="#" />% 경과
                      (<fmt:formatNumber value="${(endDate - todayTime) / (1000*60*60*24)}" pattern="#" /> 일 남음)
                    </div>
                  </div>
                  <div class="progress" style="height: 10px;">
                    <div class="progress-bar bg-success" role="progressbar" 
                        style="width: ${progressPercent}%;" 
                        aria-valuenow="${progressPercent}" 
                        aria-valuemin="0" 
                        aria-valuemax="100"></div>
                  </div>
                </c:otherwise>
              </c:choose>
              
              <!-- 파일 다운로드 섹션 -->
              <c:if test="${not empty files}">
                <h5 class="mt-4 mb-3">첨부 파일</h5>
                <ul class="list-group">
                  <c:forEach items="${files}" var="file">
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                      <span>
                        <i class="fas fa-file me-2"></i> ${file.orignl_file_nm}
                      </span>
                      <a href="/file/download/${file.atchmnfl_id}" class="btn btn-sm btn-outline-primary">
                        <i class="fas fa-download"></i>
                      </a>
                    </li>
                  </c:forEach>
                </ul>
              </c:if>
            </div>
          </div>
        </div>
      </div>
    </section>
    <c:import url="../layout/footer.jsp" />
  </main>
  
  <c:import url="../layout/prescript.jsp" />
  
  <script>
    // 프로젝트 삭제 확인
    function confirmDelete(projectId) {
      if (confirm("정말로 이 프로젝트를 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.")) {
        window.location.href = "/project/projectDelete/" + projectId;
      }
    }
  </script>
</body>
</html>