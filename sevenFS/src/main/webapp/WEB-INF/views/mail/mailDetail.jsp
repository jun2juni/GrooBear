<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <style type="text/css">
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Pretendard', 'Noto Sans KR', sans-serif;
    }
    
    body {
      background-color: #f6f8fa;
      color: #202124;
      line-height: 1.0;
    }

    .email-container {
      display: flex;
      height: 100vh;
      height: 100%;
      overflow: hidden;
    }
    
    .email-main-content {
      display: flex;
      width: 100%;
      /* height: 100%; */
    }
    
    /* 사이드바 스타일 개선 */
    .email-sidebar {
      width: 260px;
      background-color: #ffffff;
      border-right: 1px solid #e0e0e0;
      overflow-y: auto;
      transition: all 0.3s ease;
      padding-top: 12px;
      flex-shrink: 0; /*사이드바 너비 고정*/
      /* height: 100%; */
    }
    
    .sidebar-compose {
      margin: 8px 12px 20px;
    }
    
    .compose-button {
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 14px 18px;
      background: linear-gradient(135deg, #4776E6, #3b82f6);
      color: white;
      border-radius: 24px;
      border: none;
      font-weight: 500;
      cursor: pointer;
      font-size: 15px;
      transition: all 0.2s;
      width: 100%;
    }
    
    .compose-button:hover {
      background: linear-gradient(135deg, #3b6fe3, #2563eb);
      transform: translateY(-2px);
    }
    
    .compose-button i {
      margin-right: 12px;
      font-size: 16px;
    }
    
    .sidebar-section {
      margin-bottom: 12px;
    }
    
    .sidebar-item {
      display: flex;
      align-items: center;
      padding: 12px 18px;
      color: #4b5563;
      font-size: 14px;
      cursor: pointer;
      border-top-right-radius: 24px;
      border-bottom-right-radius: 24px;
      transition: all 0.2s;
      margin: 2px 0;
      position: relative;
    }
    
    .sidebar-item:hover {
      background-color: #eaecef;
      color: #1f2937;
    }
    
    .sidebar-item.active {
      background-color: #dbeafe;
      color: #2563eb;
      font-weight: 500;
    }
    
    .sidebar-item i {
      width: 24px;
      margin-right: 16px;
      text-align: center;
      font-size: 16px;
    }
    
    .sidebar-item.active i {
      color: #2563eb;
    }
    
    .sidebar-label {
      flex-grow: 1;
    }
    
    .sidebar-count {
      font-size: 12px;
      font-weight: 500;
      color: #6b7280;
      background-color: #e5e7eb;
      padding: 2px 8px;
      border-radius: 10px;
      min-width: 24px;
      text-align: center;
    }
    
    .sidebar-section-header {
      font-size: 12px;
      color: #6b7280;
      padding: 8px 16px;
      font-weight: 600;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }
    
    /* 이메일 상세보기 스타일 개선 */
    .email-box {
      display: flex;
      flex-direction: column;
      flex-grow: 1;
      overflow: hidden;
      height: 100%; /* 높이 100% 설정 */
    /* } */
    
    .email-section-detail {
      display: flex;
      flex-direction: column;
      background-color: #fff;
      overflow-y: auto;
      /* border-radius: 8px; */
      /* margin: 16px; */
      /* box-shadow: 0 1px 3px rgba(0,0,0,0.1); */
      flex-grow: 1;
    }
    
    .toolbar-actions {
      display: flex;
      gap: 8px;
    }
    
    .toolbar-button {
      display: flex;
      align-items: center;
      justify-content: center;
      width: 36px;
      height: 36px;
      border-radius: 50%;
      border: none;
      background-color: transparent;
      color: #4b5563;
      cursor: pointer;
      transition: background-color 0.2s;
    }
    
    .toolbar-button:hover {
      background-color: #f3f4f6;
      color: #1f2937;
    }
    
    .toolbar-actions-right {
      display: flex;
      align-items: center;
    }
    
    .email-date-detail {
      display: flex;
      margin-right: 16px;
      color: #6b7280;
      font-size: 14px;
    }
    
    .email-detail-content {
      padding: 24px;
      overflow-y: auto;
      flex-grow: 1;
    }
    
    .email-detail-header {
      padding-bottom: 20px;
      border-bottom: 1px solid #e5e7eb;
      margin-bottom: 24px;
    }
    
    .email-detail-subject {
      font-size: 24px;
      font-weight: 600;
      color: #111827;
      margin: 0 0 20px 0;
      line-height: 1.3;
    }
    
    .email-detail-info {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    
    
    .avatar-circle {
      width: 40px;
      height: 40px;
      background-color: #3b82f6;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      color: white;
      font-weight: bold;
      font-size: 16px;
    }
    
    .email-participants {
      margin-bottom: 20px;
    }

.participant-row {
  display: flex;
  margin-bottom: 10px;
  align-items: flex-start;
}

.participant-type {
  width: 80px;
  font-size: 13px;
  color: #6b7280;
  padding-top: 3px;
}

.participant-list {
  flex-grow: 1;
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.participant-item {
  display: flex;
  align-items: center;
  background-color: #f3f4f6;
  border-radius: 16px;
  padding: 5px 12px;
  cursor: pointer;
}

.participant-avatar {
  width: 24px;
  height: 24px;
  background-color: #3b82f6;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-weight: bold;
  font-size: 11px;
  margin-right: 8px;
}

.participant-info {
  display: flex;
  flex-direction: column;
}

.participant-name {
  font-size: 13px;
  font-weight: 500;
  color: #374151;
}

.participant-email {
  font-size: 12px;
  color: #6b7280;
}
    .email-detail-actions {
      display: flex;
      gap: 8px;
    }
    
    .reply-button, .forward-button {
      display: flex;
      align-items: center;
      padding: 8px 16px;
      background-color: #f3f4f6;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      color: #4b5563;
      font-size: 14px;
      transition: all 0.2s;
    }
    
    .reply-button:hover, .forward-button:hover {
      background-color: #e5e7eb;
      color: #1f2937;
    }
    
    .reply-button i, .forward-button i {
      margin-right: 8px;
    }
    
    .email-detail-body {
      padding: 8px 24px 24px;
      font-size: 15px;
      line-height: 1.6;
      color: #374151;
      min-height: 200px;
    }
    
    .email-detail-attachments {
      background-color: #ffffff;
      border-radius: 8px;
      padding: 16px;
      margin-top: 24px;
    }
    
    .attachment-title {
      font-size: 14px;
      font-weight: 500;
      margin-bottom: 12px;
      color: #4b5563;
    }
    
    .attachment-list {
      display: flex;
      flex-wrap: wrap;
      gap: 12px;
    }
    
    .attachment-item {
      display: flex;
      align-items: center;
      padding: 8px 12px;
      background-color: white;
      border: 1px solid #e5e7eb;
      border-radius: 6px;
      cursor: pointer;
      transition: all 0.2s;
    }
    
    .attachment-item:hover {
      border-color: #d1d5db;
      box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    }
    
    .attachment-icon {
      margin-right: 8px;
      color: #4b5563;
    }
    
    .attachment-name {
      font-size: 13px;
      color: #374151;
    }
    
    .email-detail-actions-bottom {
      margin-top: 32px;
      display: flex;
      gap: 8px;
      padding: 8px;
    }
    
    .back-to-list {
      display: flex;
      align-items: center;
      justify-content: center;
      background-color: transparent;
      border: none;
      color: #4b5563;
      cursor: pointer;
      transition: color 0.2s;
    }
    
    .back-to-list:hover {
      color: #1f2937;
    }
    .email-sidebar .dropdown-toggle::after,
    .email-sidebar .dropdown .dropdown-toggle::after {
      display: none !important;
    }

    
    .star-button>i {
      color: #FFD700; /* 밝은 금색으로 변경 */
      font-size: 18px; /* 아이콘 크기 증가 */
    }
    .star-button {
      background: none;
      border: none;
      cursor: pointer;
      padding: 4px;
      color: #9ca3af;
      transition: all 0.2s;
      border-radius: 50%;
    }
    .star-button:hover {
      background-color: #f3f4f6;
      color: #f59e0b;
    }
    </style>
    <!-- </head> -->
    <!-- <body> -->
      <div class="email-container">
        <!-- 메인 콘텐츠 영역 (사이드바 + 이메일 영역) -->
        <div class="email-main-content">
          <!-- 이메일 사이드바 -->
          <div class="email-sidebar">
            <div id="fixed" style="position: fixed; width: 260px; height: auto;">
              <div class="sidebar-compose">
                <button class="compose-button" id="mailWrite">
                  <i class="fas fa-plus"></i>
                  <span>편지쓰기</span>
                </button>
              </div>
              <!-- 사이드 바 -->
              <c:set var="emailClTy" value="${param.emailClTy}" />
              <div class="sidebar-section " id="emailClTy">
          
                <div class="sidebar-item type-select ${mailVO.emailClTy eq '0' ? 'active' : ''}" data-emailClTy="0">
                  <i class="fas fa-paper-plane"></i>
                  <span class="sidebar-label">보낸편지함</span>
                </div>
                <div class="sidebar-item type-select ${mailVO.emailClTy eq '1' ? 'active' : ''}" data-emailClTy="1">
                  <i class="fas fa-inbox"></i>
                  <span class="sidebar-label">받은편지함</span>
                  <!-- <span class="sidebar-count">2,307</span> -->
                </div>
                <div class="sidebar-item type-select ${mailVO.emailClTy eq '2' ? 'active' : ''}" data-emailClTy="2">
                  <i class="far fa-file-alt"></i>
                  <span class="sidebar-label">임시보관함</span>
                  <!-- <span class="sidebar-count">11</span> -->
                </div>
                <!-- <div class="sidebar-item type-select ${mailVO.emailClTy eq '3' ? 'active' : ''}" data-emailClTy="3">
                  <i class="far fa-file-alt"></i>
                  <span class="sidebar-label">스팸함</span>
                  <span class="sidebar-count">11</span>
                </div> -->
                <div class="sidebar-item type-select ${mailVO.emailClTy eq '5' ? 'active' : ''}" data-emailClTy="5">
                  <i class="fas fa-star"></i>
                  <span class="sidebar-label">중요 메일함</span>
                  <!-- <span class="sidebar-count">11</span> -->
                </div>
                <div class="sidebar-item type-select ${mailVO.emailClTy eq '4' ? 'active' : ''}" data-emailClTy="4">
                  <i class="far fa-trash-alt"></i>
                  <!-- <i class="fas fa-trash"></i> -->
                  <span class="sidebar-label">휴지통</span>
                  <!-- <span class="sidebar-count">11</span> -->
                </div>
              </div>
              
              <div class="sidebar-section">
                <div class="sidebar-section-header">라벨</div>
                <c:forEach items="${mailLabelList}" var="mailLabel">
                  <div class="sidebar-item label-select ${mailVO.lblNo == mailLabel.lblNo ? 'active' : ''}" data-lblNo="${mailLabel.lblNo}">
                    <i class="fas fa-tag" data-col="${mailLabel.lblCol}" style="color: ${mailLabel.lblCol};"></i>
                    <span class="sidebar-label">${mailLabel.lblNm}</span>
                    <div class="dropdown label-actions" style="margin-left: auto; position: relative;">
                      <button class="dropdown-toggle" style="background: none; border: none; cursor: pointer;">
                        <i class="fas fa-ellipsis-v"></i>
                      </button>
                      <div class="dropdown-menu" style="display: none; position: absolute; right: 0; background: white; border: 1px solid #e5e7eb; border-radius: 4px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); z-index: 1000;">
                        <button class="dropdown-item edit-label" type="button" data-lblNo="${mailLabel.lblNo}" style="background: none; border: none; cursor: pointer; padding: 8px 16px; width: 100%; text-align: left;">
                          <i class="fas fa-edit" style="margin-right: 8px;"></i> 수정
                        </button>
                        <button class="dropdown-item delete-label" type="button" data-lblNo="${mailLabel.lblNo}" style="background: none; border: none; cursor: pointer; padding: 8px 16px; width: 100%; text-align: left;">
                          <i class="fas fa-trash-alt" style="margin-right: 8px;"></i> 삭제
                        </button>
                      </div>
                    </div>
                  </div>
                </c:forEach>
                <div class="sidebar-item" id="addLabelBtn" style="cursor: pointer;">
                  <i class="fas fa-plus-circle" style="color: #34a853;"></i>
                  <span class="sidebar-label">라벨 추가</span>
                </div>
              </div>
              <!-- 라벨 추가 팝업 -->
        <div id="label-popup" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background: white; padding: 20px; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); z-index: 1000;">
          <h3 style="margin-bottom: 10px;" id="lblPopTitle">라벨 추가</h3>
          <form action="/mail/mailLblAdd" method="post">
            <input type="text" name="lblNm" id="label-name" placeholder="라벨 이름 입력" style="width: 100%; padding: 8px; margin-bottom: 10px; border: 1px solid #d1d5db; border-radius: 4px;">
            <input type="hidden" name="lblNo" id="lblNo" value="0">
            <input type="hidden" name="lblCol" id="lblCol">
            <input type="hidden" name="emplNo" value="${emplNo}">
            <label for="label-color" style="display: block; margin-bottom: 5px;">라벨 색상 선택</label>
            <div id="label-color" style="display: grid; grid-template-columns: repeat(5, 1fr); gap: 5px;">
              <div class="color-option" style="width: 24px; height: 24px; background-color: #D50000; border-radius: 50%; cursor: pointer;" data-color="#D50000"></div>
              <div class="color-option" style="width: 24px; height: 24px; background-color: #C51162; border-radius: 50%; cursor: pointer;" data-color="#C51162"></div>
              <div class="color-option" style="width: 24px; height: 24px; background-color: #AA00FF; border-radius: 50%; cursor: pointer;" data-color="#AA00FF"></div>
              <div class="color-option" style="width: 24px; height: 24px; background-color: #6200EA; border-radius: 50%; cursor: pointer;" data-color="#6200EA"></div>
              <div class="color-option" style="width: 24px; height: 24px; background-color: #304FFE; border-radius: 50%; cursor: pointer;" data-color="#304FFE"></div>
              <div class="color-option" style="width: 24px; height: 24px; background-color: #2962FF; border-radius: 50%; cursor: pointer;" data-color="#2962FF"></div>
              <div class="color-option" style="width: 24px; height: 24px; background-color: #0091EA; border-radius: 50%; cursor: pointer;" data-color="#0091EA"></div>
              <div class="color-option" style="width: 24px; height: 24px; background-color: #00B8D4; border-radius: 50%; cursor: pointer;" data-color="#00B8D4"></div>
              <div class="color-option" style="width: 24px; height: 24px; background-color: #00BFA5; border-radius: 50%; cursor: pointer;" data-color="#00BFA5"></div>
              <div class="color-option" style="width: 24px; height: 24px; background-color: #00C853; border-radius: 50%; cursor: pointer;" data-color="#00C853"></div>
              <div class="color-option" style="width: 24px; height: 24px; background-color: #64DD17; border-radius: 50%; cursor: pointer;" data-color="#64DD17"></div>
              <div class="color-option" style="width: 24px; height: 24px; background-color: #AEEA00; border-radius: 50%; cursor: pointer;" data-color="#AEEA00"></div>
              <div class="color-option" style="width: 24px; height: 24px; background-color: #FFD600; border-radius: 50%; cursor: pointer;" data-color="#FFD600"></div>
              <div class="color-option" style="width: 24px; height: 24px; background-color: #FFAB00; border-radius: 50%; cursor: pointer;" data-color="#FFAB00"></div>
              <div class="color-option" style="width: 24px; height: 24px; background-color: #FF6D00; border-radius: 50%; cursor: pointer;" data-color="#FF6D00"></div>
              <div class="color-option" style="width: 24px; height: 24px; background-color: #DD2C00; border-radius: 50%; cursor: pointer;" data-color="#DD2C00"></div>
              <div class="color-option" style="width: 24px; height: 24px; background-color: #8D6E63; border-radius: 50%; cursor: pointer;" data-color="#8D6E63"></div>
              <div class="color-option" style="width: 24px; height: 24px; background-color: #9E9E9E; border-radius: 50%; cursor: pointer;" data-color="#9E9E9E"></div>
              <div class="color-option" style="width: 24px; height: 24px; background-color: #607D8B; border-radius: 50%; cursor: pointer;" data-color="#607D8B"></div>
              <div class="color-option" style="width: 24px; height: 24px; background-color: #000000; border-radius: 50%; cursor: pointer;" data-color="#000000"></div>
            </div>
            <div style="display: flex; justify-content: flex-end; gap: 10px; margin-top: 10px;">
              <button id="cancel-label" type="button" style="padding: 8px 16px; border: none; background-color: #e5e7eb; border-radius: 4px; cursor: pointer;">취소</button>
              <button id="save-label" type="submit" style="padding: 8px 16px; border: none; background-color: #2563eb; color: white; border-radius: 4px; cursor: pointer;">저장</button>
            </div>
          </form> 
        </div>
		<!-- 팝업 배경 -->
		<div id="popup-overlay" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5); z-index: 999;"></div>
            </div>
          </div>
    
          <!-- 이메일 콘텐츠 영역 -->
          <div class="email-box">
            <!-- 이메일 detailSection 시작 -->
            <div class="email-section-detail">
              <div class="email-detail-content">
                <div class="email-detail-header">
                  <div style="margin-bottom:20px;">
                    <div style="display: flex; align-items: center; gap: 10px;">
                      <c:if test="${mailVO.emailClTy == '0' || mailVO.emailClTy == '1'}">
                        <button class="star-button ${mailVO.starred}" data-emailNo="${mailVO.emailNo}">
                          <i class="${mailVO.starred=='Y'?'fas':'far'} fa-star"></i>
                        </button>
                      </c:if>
                      <h4 class="email-detail-subject" style="margin: 0;">
                        <c:if test="${mailVO.emailSj != null && mailVO.emailSj != ''}">${mailVO.emailSj}</c:if>
                        <c:if test="${mailVO.emailSj == null || mailVO.emailSj == ''}">(제목 없음)</c:if>
                      </h4>
                      <c:if test="${(mailVO.lblCol != null and mailVO.lblCol != '')&&(mailVO.emailClTy=='0' || mailVO.emailClTy=='1')}">
                        <i class="fas fa-tag" id="labelTag" data-col="${mailVO.lblCol}" data-lblNo="${mailVO.lblNo}" style="color: ${mailVO.lblCol}; font-size: 16px;"></i>
                      </c:if>
                      <!-- <button class="toolbar-button" style="margin-left: auto;">
                        <i class="fas fa-ellipsis-v"></i>
                      </button> -->
                    </div>
                  </div>
                  <div class="email-detail-info">
                    <div class="email-participants">
                      <!-- 보낸 사람 -->
                      <div class="participant-row">
                        <div class="participant-type">보낸 사람:</div>
                        <div class="participant-list">
                          <div class="participant-item">
                            <div class="participant-avatar">
                              ${fn:substring(mailVO.emplNm, 0, 1)}
                            </div>
                            <div class="participant-info">
                              <div class="participant-name" id="trnsmitEmplNm">${mailVO.emplNm}</div>
                              <div class="participant-email" data-emplNo="${mailVO.emplNo}" id="trnsmitEmail">${mailVO.trnsmitEmail}</div>
                            </div>
                          </div>
                        </div>
                      </div>
                      
                      <!-- 받는 사람 -->
                      <div class="participant-row">
                        <div class="participant-type">받는 사람:</div>
                        <div class="participant-list">
                          <c:forEach items="${mailVO.recptnMapList}" var="recp">
                            <div class="participant-item participant-recptn">
                              <div class="participant-avatar">
                                <!-- <c:if test="${recp.emplNm != null and recp.emplNm != ''}"> -->
                                  ${fn:substring(recp.emplNm, 0, 1)}
                                <!-- </c:if> -->
                              </div>
                              <div class="participant-info">
                                <div class="participant-name">${recp.emplNm}</div>
                                <div class="participant-email" data-emplNo="${recp.emplNo}">${recp.recptnEmail}</div>
                              </div>
                            </div>
                          </c:forEach>
                        </div>
                      </div>
                      
                      <!-- 참조자 - 참조자가 있을 경우만 표시 -->
                      <c:if test="${not empty mailVO.refMapList}">
                        <div class="participant-row">
                          <div class="participant-type">참조:</div>
                          <div class="participant-list">
                            <c:forEach items="${mailVO.refMapList}" var="ref">
                              <div class="participant-item participant-recptn">
                                <div class="participant-avatar">
                                  ${fn:substring(ref.emplNm, 0, 1)}
                                </div>
                                <div class="participant-info">
                                  <div class="participant-name">${ref.emplNm}</div>
                                  <div class="participant-email" data-emplNo="${ref.emplNo}">${ref.recptnEmail}</div>
                                </div>
                              </div>
                            </c:forEach>
                          </div>
                        </div>
                      </c:if>
                      <div>
                        <div class="participant-row">
                          <div class="participant-type">보낸 날짜:</div>
                          <div class="email-date-detail">${mailVO.trnsmitDt}</div>
                        </div>
                      </div>
                    </div>
                  </div>
                    <c:if test="${mailVO.emailTrnsmisTy != '2' && mailVO.emailTrnsmisTy != '3'}">
                      <div class="email-detail-actions">
                        <c:if test="${mailVO.emailClTy != '0' && mailVO.emailClTy != '2' && mailVO.emailClTy != '4'}">
                          <button class="reply-button" id="replyBtn">
                            <i class="fas fa-reply"></i>
                            <span>답장</span>
                          </button>
                        </c:if>
                        <c:if test="${mailVO.emailClTy != '2' && mailVO.emailClTy != '4'}">
                          <button class="forward-button" id="mailTrnsms">
                            <i class="fas fa-share"></i>
                            <span>전달</span>
                          </button>
                        </c:if>
                        <button class="forward-button" id="deleteMail" data-emailClTy="${mailVO.emailClTy}">
                          <i class="material-icons">delete</i>
                          <c:if test="${mailVO.emailClTy == '4'}">
                            <span>삭제</span>
                          </c:if>
                          <c:if test="${mailVO.emailClTy != '4'}">
                            <span>휴지통</span>
                          </c:if>
                        </button>
                        <!-- 라벨 지정 select 추가 -->
                        <select name="label" id="labeling" class="label-select forward-button" style="margin: 0 10px; padding: 5px;">
                          <option value="" disabled selected>라벨</option>
                          <c:forEach items="${mailLabelList}" var="mailLabel">
                            <option value="${mailLabel.lblNo}">${mailLabel.lblNm}</option>
                          </c:forEach>
                          <option id="detLabel" value="0">라벨 해제</option>
                        </select>
                      </div>
                    </c:if>
                  </div>
                </div>
    
                <div class="email-detail-body">
                  ${mailVO.emailCn}
                </div>
    
                <div class="email-detail-attachments">
                  <div class="attachment-title">첨부파일 (${attachFileVOList.size()})</div>
                  <div class="attachment-list">
                    <c:forEach items="${attachFileVOList}" var="attachFileVO">
                      <a class="attachment-item" href="/download?fileName=${attachFileVO.fileStrePath}">
                        <i class="far fa-file-pdf attachment-icon"></i>
                        <span class="attachment-name">${attachFileVO.fileNm} (${attachFileVO.fileViewSize})</span>
                      </a>
                      <!-- <div class="attachment-item">
                        <i class="far fa-file-pdf attachment-icon"></i>
                        <span class="attachment-name">${attachFileVO.fileNm} (${attachFileVO.fileViewSize})</span>
                      </div> -->
                    </c:forEach>
                  </div>
                </div>
                <div class="email-detail-actions-bottom">
                  <c:if test="${mailVO.emailClTy != '0' && mailVO.emailClTy != '2' && mailVO.emailClTy != '4'}">
                    <button class="reply-button" id="replyBtn">
                      <i class="fas fa-reply"></i>
                      <span>답장</span>
                    </button>
                  </c:if>
                  <c:if test="${mailVO.emailClTy != '2' && mailVO.emailClTy != '4'}">
                    <button class="forward-button">
                      <i class="fas fa-share"></i>
                      <span>전달</span>
                    </button>
                  </c:if>
                  <button class="forward-button" id="toList">
                    <!-- <i class="fas fa-share"></i> -->
                    <span>목록</span>
                  </button>
                </div>
              </div>
            </div>
            <!-- 이메일 detailSection 끝 -->
          </div>
        </div>
      </div>
    <style>
      .email-sidebar .dropdown-toggle::after,
      .email-sidebar .dropdown .dropdown-toggle::after {
        display: none !important;
      }
    </style>
    <script>
      // 아바타 이니셜 생성
      document.addEventListener('DOMContentLoaded', function() {
        //const senderName = document.querySelector('.sender-name').textContent;
        //const initials = senderName.split(' ').map(name => name.charAt(0)).join('');
        
        // 메일 휴지통 / 삭제
        $('#deleteMail').on('click',function(){
          const params = new URLSearchParams(window.location.search);
          const value = params.get('emailNo');

          console.log(this);

          let emailClTy = $(this).attr('data-emailClTy')
          console.log('emailClTy : ',emailClTy);

          let emailNoList = [];
          emailNoList.push(value);

          let url="";
          if(emailClTy == '4'){
            url = "/mail/realDelete"
            console.log('realDelete')
          }else{
            url="/mail/delete"
            console.log('delete')
          }
          console.log('삭제 할 메일',emailNoList);
          $.ajax({
            url:url,
            method:'post',
            data:{"emailNoList":emailNoList},
            success:function(resp){
              window.location.href = resp+'?emailClTy='+emailClTy;
            },
            error:function(err){
              console.log(err);
            }
          })
        })

        // 라벨 적용
        $('#labeling').on('change',function(){
          const params = new URLSearchParams(window.location.search);
          const value = params.get('emailNo');
          let lblNo = this.value;
          let checkedList = []
          checkedList.push(value)
          console.log('라벨 no : ',lblNo);
          console.log('checkedList 메일 선택 : ',checkedList);
          data = {
            lblNo:lblNo,
            checkedList:checkedList
          }
          console.log('data : ',data);
          $.ajax({
            url:'/mail/labelingUpt',
            data:data,
            method:'post',
            success:function(resp){
              console.log(resp);
              labeling(lblNo,resp)
            },
            error:function(err){
              console.log(err);
            }
          })
        })
        /*<h4 class="email-detail-subject" style="margin: 0;">
            <c:if test="${mailVO.emailSj != null && mailVO.emailSj != ''}">${mailVO.emailSj}</c:if>
            <c:if test="${mailVO.emailSj == null || mailVO.emailSj == ''}">(제목 없음)</c:if>
          </h4>
          <c:if test="${(mailVO.lblCol != null and mailVO.lblCol != '')&&(mailVO.emailClTy=='0' || mailVO.emailClTy=='1')}">
            <i class="fas fa-tag" id="labelTag" data-col="${mailVO.lblCol}" data-lblNo="${mailVO.lblNo}" style="color: ${mailVO.lblCol}; font-size: 16px;"></i>
          </c:if> */
        function labeling(lblNo,color){
            console.log('lblNo : ',lblNo);
            console.log('color : ',color);
            if(color == null || color == '' ){
              console.log('라벨 삭제')
              $('#labelTag').remove();
            }else{
              if($('#labelTag').length){
                // 라벨 존재하는 경우 -> 변경
                $('#labelTag').remove();
                $('.email-detail-subject').after(`<i class="fas fa-tag" id="labelTag" data-col="\${color}" data-lblNo="\${lblNo}" style="color: \${color}; font-size: 16px;"></i>`)
              }else{
                // 라벨 존재하지 않는 경우 -> 추가
                console.log('라벨 추가 혹은 변경')
                $('.email-detail-subject').after(`<i class="fas fa-tag" id="labelTag" data-col="\${color}" data-lblNo="\${lblNo}" style="color: \${color}; font-size: 16px;"></i>`)
              }
            }
        }


        // 별표 클릭
        $('.fa-star').on('click',function(e){
          e.stopPropagation();
          let starredYN = '';
          $(this).toggleClass('fas');
          $(this).toggleClass('far');
          let className = $(this).prop('className')
          let emailNo = $(this).closest('button').data('emailno');
          console.log('별표 이벤트 -> emailNo : ',emailNo);
          console.log('별표 이벤트 -> className : ',className);
          if(className.indexOf('far') != -1){
            starredYN = 'N';
          }else if(className.indexOf('fas') != -1){
            starredYN = 'Y';
          }
          console.log('별표 이벤트 -> starredYN : ',starredYN);
          $.ajax({
            url:'/mail/starred',
            data:{emailNo:emailNo,starred:starredYN},
            method:'post',
            success:function(resp){
              console.log('ajax 요청 결과 : ',resp);
            },
            error:function(err){
              console.log('에러 발생 : ',err)
            }
          })
        })


        $('#toList').on('click',function(){
          window.location.href="/mail"
        })

        $('.participant-item').on('click',function(){
          let emplNm = $(this).find('.participant-name').text();
          let emplEmail = $(this).find('.participant-email').text();
          let emplNo = $(this).find('.participant-email').data('emplno');

          // console.log('.participant-recptn 클릭 : ',this);
          console.log('.participant-recptn 클릭 emplNm : ',emplNm);
          console.log('.participant-recptn 클릭 emplEmail : ',emplEmail);
          console.log('.participant-recptn 클릭 emplNo : ',emplNo);
          window.location.href=`/mail/mailSend?emplNm=\${emplNm}&&email=\${emplEmail}&&emplNo=\${emplNo}`;
          // $.ajax({
          //   url:'/mail/mailReplSend',
          //   data:{
          //     emplNm : emplNm,
          //     emplEmail : emplEmail,
          //     emplNo : emplNo
          //   },
          //   method:'post',
          //   success:function(resp){
          //     window.location.href=resp
          //   },
          //   error:function(err){
          //     console.log(err);
          //   }
          // })
        })

        $('#mailTrnsms').on('click',function(){
          let queryString = window.location.search.substring(1);
          let param = queryString.split("=")[1];
          console.log(param);
          window.location.href=`/mail/mailTrnsms?emailNo=\${param}`;
        })

        $('#replyBtn').on('click',function(){
          let queryString = window.location.search.substring(1);
          let param = queryString.split("=")[1];
          console.log(param);

          // let emplNm = $('#trnsmitEmplNm').text();
          // let emplEmail = $('#trnsmitEmail').text();
          // console.log('답장 이벤트 emplEmail : ',emplEmail);
          // console.log('답장 이벤트 emplNm : ',emplNm);
          window.location.href=`/mail/mailRepl?emailNo=\${param}`;
        })

        

       /*사이드바 관련 함수 시작*/
        			// 사이드바 아이템 클릭 이벤트 시작 //
              $('.sidebar-item.type-select').on('click', function() {
        // $('.sidebar-item').removeClass('active');
        // $(this).addClass('active');
        emailClTy = $(this).attr('data-emailClTy');
        if(emailClTy){
          // console.log('emailClTy -> ',emailClTy);
          window.location.href = "/mail?emailClTy="+emailClTy;
        }
      });
      
      $('.sidebar-item.label-select').on('click',function(){
        // console.log('.label-select 클릭 이벤트 : ',this);
        let lblNo = $(this).data('lblno');
        console.log('.label-select 클릭 이벤트 lblNo : ',lblNo);
        window.location.href="/mail/labeling?lblNo="+lblNo;
        // window.location.href="/mail?lblNo="+lblNo;
      })
      // 사이드바 아이템 클릭 이벤트 끝 //
      let selectedColor = "#000000"; // Default color

// 라벨 추가 버튼 클릭 이벤트
$('#addLabelBtn').on('click', function() {
  $('#label-popup').show();
  $('#popup-overlay').show();
  $('.color-option').css('border', 'none');
  $('#label-name').val('');
  $('#lblPopTitle').text('라벨 추가');
});

// 라벨 색상 선택 이벤트
$('.color-option').on('click', function() {
  $('.color-option').css('border', 'none'); // Reset border
  $(this).css('border', '3px solid #2563eb');// Highlight selected color
  selectedColor = $(this).data('color');
  $('#lblCol').val(selectedColor);
  console.log("$('#lblCol').val() : ",$('#lblCol').val());
});

// 저장 버튼 클릭 이벤트
$('#save-label').on('click', function() {
  let labelName = $('#label-name').val().trim();
  let labelCol = $('#lblCol').val();
  console.log('라벨 추가 labelName: ',labelName);
  console.log('라벨 추가 labelCol: ',labelCol);
});

// 취소 버튼 클릭 이벤트
$('#cancel-label').on('click', function() {
  $('#label-popup').hide();
  $('#popup-overlay').hide();
});
            // 드롭다운 토글
            $('.dropdown-toggle').on('click', function(e) {
              e.stopPropagation();
              const dropdownMenu = $(this).siblings('.dropdown-menu');
              $('.dropdown-menu').not(dropdownMenu).hide(); // 다른 드롭다운 닫기
              dropdownMenu.toggle();
            });

            // 페이지 외부 클릭 시 드롭다운 닫기
            $(document).on('click', function() {
              $('.dropdown-menu').hide();
            });

            // 라벨 수정 버튼 클릭 이벤트
            $('.edit-label').on('click', function(e) {
              e.stopPropagation();
              // console.log(this);
              const lblNo = $(this).data('lblno');
              const lblNm = $(this).closest('.dropdown-menu').parent().siblings('.sidebar-label').text();
              const lblCol = $(this).closest('.dropdown-menu').parent().siblings('.fas').data('col');
              console.log('수정 -> lblNo : ',lblNo);
              console.log('수정 -> lblNm : ',lblNm);
              console.log('수정 -> lblCol : ',lblCol);
              $('#lblNo').val(lblNo);
              $('#addLabelBtn').trigger('click');
              $('#lblPopTitle').text('라벨 수정');
              // $(`.color-option[data-color=\${lblCol}]`).css('border', '2px solid #2563eb');
              $('.color-option[data-color="' + lblCol + '"]').css('border', '3px solid #2563eb');
              $('#label-name').val(lblNm);
              $('#lblCol').val(lblCol);
              // $('color-option').css('border', '2px solid #2563eb'); // Highlight selected color
            });
            
            // 라벨 삭제 버튼 클릭 이벤트
            $('.delete-label').on('click', function(e) {
              e.stopPropagation();
              const lblNo = $(this).data('lblno');
              console.log('삭제 -> lblNo : ',lblNo);
              $.ajax({
                url:'mail/deleteLbl',
                method:'post',
                data:{lblNo:lblNo},
                success:function(resp){
                  if(resp=='success'){
                    $('.label-select[data-lblno="' + lblNo + '"]').hide();
                  }else{

                  }
                },
                error:function(err){
                  console.log('ajax요청결과 에러 발생 : ',err);
                }
              })
            });
        /*사이드바 관련 함수 끝*/

      });
    </script>
    <!-- </body> -->
    <!-- </html> -->