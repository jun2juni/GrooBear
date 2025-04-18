<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
      width: 240px;
      background-color: #ffffff;
      border-right: 1px solid #e0e0e0;
      height: 100%;
      overflow-y: auto;
      transition: width 0.3s ease;
      padding-top: 12px;
      flex-shrink: 0; /* 사이드바 너비 고정 */
    }
    
    .sidebar-compose {
      margin: 8px 12px 16px;
    }
    
    .compose-button {
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 12px 16px;
      background-color: #3b82f6;
      color: white;
      border-radius: 16px;
      border: none;
      font-weight: 500;
      cursor: pointer;
      font-size: 15px;
      transition: all 0.2s;
      width: 100%;
      box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    }
    
    .compose-button:hover {
      background-color: #2563eb;
      box-shadow: 0 2px 5px rgba(0,0,0,0.15);
      transform: translateY(-1px);
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
      padding: 10px 16px;
      color: #4b5563;
      font-size: 14px;
      cursor: pointer;
      border-top-right-radius: 20px;
      border-bottom-right-radius: 20px;
      transition: background-color 0.2s, color 0.2s;
      margin: 2px 0;
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
    }
    
    .email-section-detail {
      display: flex;
      flex-direction: column;
      background-color: #fff;
      overflow-y: auto;
      border-radius: 8px;
      margin: 16px;
      /* box-shadow: 0 1px 3px rgba(0,0,0,0.1); */
      flex-grow: 1;
    }
    
    .email-detail-toolbar {
      display: flex;
      justify-content: space-between;
      padding: 12px 16px;
      border-bottom: 1px solid #e5e7eb;
      background-color: #fff;
      border-top-left-radius: 8px;
      border-top-right-radius: 8px;
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
      padding: 8px 0 24px;
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
    </style>
    <!-- </head> -->
    <!-- <body> -->
      <div class="email-container">
        <!-- 메인 콘텐츠 영역 (사이드바 + 이메일 영역) -->
        <div class="email-main-content">
          <!-- 이메일 사이드바 -->
          <div class="email-sidebar">
            <div class="sidebar-compose">
              <button class="compose-button" id="mailWrite">
                <i class="fas fa-plus"></i>
                <span>편지쓰기</span>
              </button>
            </div>
            <!-- 사이드 바 -->
            <div class="sidebar-section">
              <div class="sidebar-item active">
                <i class="fas fa-inbox"></i>
                <span class="sidebar-label">받은편지함</span>
                <!-- <span class="sidebar-count">2,307</span> -->
              </div>
              <div class="sidebar-item">
                <i class="fas fa-paper-plane"></i>
                <span class="sidebar-label">보낸편지함</span>
              </div>
              <div class="sidebar-item">
                <i class="far fa-file-alt"></i>
                <span class="sidebar-label">임시보관함</span>
                <!-- <span class="sidebar-count">11</span> -->
              </div>
              <div class="sidebar-item">
                <i class="fas fa-star"></i>
                <span class="sidebar-label">별표편지함</span>
              </div>
              <div class="sidebar-item">
                <i class="far fa-trash-alt"></i>
                <span class="sidebar-label">휴지통</span>
              </div>
            </div>
            
            <div class="sidebar-section">
              <div class="sidebar-section-header">라벨</div>
              <div class="sidebar-item">
                <i class="fas fa-tag" style="color: #3b82f6;"></i>
                <span class="sidebar-label">내일정</span>
              </div>
              <div class="sidebar-item">
                <i class="fas fa-tag" style="color: #ef4444;"></i>
                <span class="sidebar-label">뉴스레터</span>
              </div>
              <div class="sidebar-item">
                <i class="fas fa-tag" style="color: #f59e0b;"></i>
                <span class="sidebar-label">중요</span>
              </div>
              <div class="sidebar-item">
                <i class="fas fa-tag" style="color: #10b981;"></i>
                <span class="sidebar-label">업무</span>
              </div>
              <div class="sidebar-item">
                <i class="fas fa-tag" style="color: #8b5cf6;"></i>
                <span class="sidebar-label">개인</span>
              </div>
            </div>
          </div>
    
          <!-- 이메일 콘텐츠 영역 -->
          <div class="email-box">
            <!-- 이메일 detailSection 시작 -->
            <div class="email-section-detail">
              <div class="email-detail-toolbar">
                <div class="toolbar-actions">
                  <button class="toolbar-button back-to-list">
                    <i class="fas fa-arrow-left"></i>
                  </button>
                  <button class="toolbar-button">
                    <i class="fas fa-archive"></i>
                  </button>
                  <button class="toolbar-button">
                    <i class="fas fa-trash-alt"></i>
                  </button>
                  <button class="toolbar-button">
                    <i class="fas fa-envelope"></i>
                  </button>
                  <button class="toolbar-button">
                    <i class="fas fa-clock"></i>
                  </button>
                  <button class="toolbar-button">
                    <i class="fas fa-tag"></i>
                  </button>
                </div>
                <div class="toolbar-actions-right">
                  <span class="email-date-detail">${mailVO.trnsmitDt}</span>
                  <button class="toolbar-button">
                    <i class="fas fa-print"></i>
                  </button>
                  <button class="toolbar-button">
                    <i class="fas fa-ellipsis-v"></i>
                  </button>
                </div>
              </div>
    
              <div class="email-detail-content">
                <div class="email-detail-header">
                  <h2 class="email-detail-subject">${mailVO.emailSj}</h2>
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
                              <div class="participant-email" id="trnsmitEmail">${mailVO.trnsmitEmail}</div>
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
                                ${fn:substring(recp.emplNm, 0, 1)}
                              </div>
                              <div class="participant-info">
                                <div class="participant-name">${recp.emplNm}</div>
                                <div class="participant-email">${recp.recptnEmail}</div>
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
                                  <div class="participant-email">${ref.recptnEmail}</div>
                                </div>
                              </div>
                            </c:forEach>
                          </div>
                        </div>
                      </c:if>
                    </div>
                  </div>
                    <div class="email-detail-actions">
                      <button class="reply-button" ${mailVO.emailClTy == '0' ? 'hidden' : ''}>
                        <i class="fas fa-reply"></i>
                        <span>답장</span>
                      </button>
                      <button class="forward-button">
                        <i class="fas fa-share"></i>
                        <span>전달</span>
                      </button>
                    </div>
                  </div>
                </div>
    
                <div class="email-detail-body">
                  ${mailVO.emailCn}
                  mailVO : ${mailVO} <br/>
                  attachFileVOList : ${attachFileVOList}
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
                    <button class="reply-button" id="replyBtn" ${mailVO.emailClTy == '0' ? 'hidden' : ''}>
                    <i class="fas fa-reply"></i>
                    <span>답장</span>
                  </button>
                  <button class="forward-button">
                    <i class="fas fa-share"></i>
                    <span>전달</span>
                  </button>
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
    
    <script>
      // 아바타 이니셜 생성
      document.addEventListener('DOMContentLoaded', function() {
        //const senderName = document.querySelector('.sender-name').textContent;
        //const initials = senderName.split(' ').map(name => name.charAt(0)).join('');
        
        $('#toList').on('click',function(){
          window.location.href="/mail"
        })

        $('.sidebar-item').on('click', function() {
            $('.sidebar-item').removeClass('active');
            $(this).addClass('active');
            emailClTy = $(this).attr('data-emailClTy');
            console.log('emailClTy -> ',emailClTy);
            window.location.href="/mail"
        });
        $('.participant-recptn').on('click',function(){
          let emplNm = $(this).find('.participant-name').text();
          let emplEmail = $(this).find('.participant-email').text();

          // console.log('.participant-recptn 클릭 : ',this);
          console.log('.participant-recptn 클릭 : ',emplNm);
          console.log('.participant-recptn 클릭 : ',emplEmail);
          window.location.href=`/mail/mailSend?emplNm=\${emplNm}&&email=\${emplEmail}`;
        })
        $('#replyBtn').on('click',function(){
          let emplNm = $('#trnsmitEmplNm').text();
          let emplEmail = $('#trnsmitEmail').text();
          console.log('답장 이벤트 emplEmail : ',emplEmail);
          console.log('답장 이벤트 emplNm : ',emplNm);
          window.location.href=`/mail/mailSend?emplNm=\${emplNm}&&email=\${emplEmail}`;
        })

      });
    </script>
    <!-- </body> -->
    <!-- </html> -->