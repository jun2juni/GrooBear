<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
      $('.email-section').hide();
      $('.email-section-list').show();
      console.log($('.email-section-list'))
      // 이메일 데이터
      const emails = [
        { id: 1, starred: false, from: 'Asana', subject: '목표를 설정하고 달성하세요', snippet: '팀과 목표를 달성해 보겠어요.', date: '4월 7일', read: false },
        { id: 2, starred: false, from: 'Battle.net', subject: '[블리자드] 정기 비밀번 재설정 유언 안내', snippet: 'Battle.net 안정성에는...', date: '4월 7일', read: true },
        { id: 3, starred: false, from: 'Asana', subject: '보다 더 스마트하게 일하는 법에 대해 이야기해요', snippet: 'Asana 팀에서 곧 연락드립니다.', date: '4월 6일', read: false },
        { id: 4, starred: false, from: 'Asana', subject: 'Asana 체험이 곧 종료됩니다', snippet: '최고의 경험이 기다리고 있습니다.', date: '4월 4일', read: true },
        { id: 5, starred: false, from: 'Google Maps Timeline', subject: '대한민국 3월 리마인더', snippet: '최근 기록을 사용 설정하시기 위한 방법을 알려드립니다.', date: '4월 4일', read: true },
        { id: 6, starred: false, from: 'NHN KCP', subject: 'Spotify(스포티파이)의 결제 내역입니다', snippet: '2025년 04월 02일 20시 59분 결제되었습니다.', date: '4월 2일', read: false },
        { id: 7, starred: false, from: 'Notion Team', subject: '내맘을 알아준 Notion AI', snippet: '최신 기능과 함께하세요!', date: '3월 31일', read: true },
        { id: 8, starred: false, from: 'Asana', subject: '조대를 받으셨습니다(팀 조대하기)', snippet: '팀과 Asana와 모든 목적을 함께하세요', date: '3월 29일', read: true },
        { id: 9, starred: false, from: 'Amazon Web Services', subject: 'AWS 계정 배치 확인', snippet: 'AWS로고 Amazon Web Services에서 알려드립니다.', date: '3월 28일', read: true },
        { id: 10, starred: false, from: 'freetier', subject: 'AWS Free Tier limit alert', snippet: 'AWS Free Tier usage limit alerting via AWS Budgets', date: '3월 28일', read: false }
        // ,{ id: 11, starred: false, from: 'NHN KCP', subject: 'Spotify(스포티파이)의 결제 내역입니다', snippet: '2025년 04월 02일 20시 59분 결제되었습니다.', date: '4월 2일', read: false },
        // { id: 12, starred: false, from: 'Notion Team', subject: '내맘을 알아준 Notion AI', snippet: '최신 기능과 함께하세요!', date: '3월 31일', read: true },
        // { id: 13, starred: false, from: 'Asana', subject: '조대를 받으셨습니다(팀 조대하기)', snippet: '팀과 Asana와 모든 목적을 함께하세요', date: '3월 29일', read: true },
        // { id: 14, starred: false, from: 'Amazon Web Services', subject: 'AWS 계정 배치 확인', snippet: 'AWS로고 Amazon Web Services에서 알려드립니다.', date: '3월 28일', read: true },
        // { id: 15, starred: false, from: 'freetier', subject: 'AWS Free Tier limit alert', snippet: 'AWS Free Tier usage limit alerting via AWS Budgets', date: '3월 28일', read: false }
      ];
      
      // 이메일 목록 렌더링
      function renderEmails() {
        const $emailList = $('#email-list');
        $emailList.empty();
        console.log('emailList : ',$emailList);
        emails.forEach(email => {
          const starClass = email.starred ? 'starred' : '';
          const readClass = email.read ? '' : 'unread';
          
          const $emailItem = $(`
            <div class="email-item \${readClass}" data-id="\${email.id}">
              <div class="email-actions">
                <input type="checkbox" class="email-checkbox">
                <button class="star-button \${starClass}" data-id="\${email.id}">
                  <i class="far fa-star\${email.starred ? ' fas' : ''}"></i>
                </button>
              </div>
              <div class="email-sender">\${email.from}</div>
              <div class="email-content">
                <span class="email-subject">\${email.subject}</span>
                <span class="email-snippet"> - \${email.snippet}</span>
              </div>
              <div class="email-date">\${email.date}</div>
            </div>
          `);
          $emailList.append($emailItem);
        });
        $('.email-item').on('click',function(){
          // console.log('리스트 클릭 이벤트 : ',this);
          let id = $(this).data('id');
          console.log('리스트 클릭 결과 id : ',id);
          let mail = emails.filter(email=>{
            return email.id == id;
          })[0]
          console.log(mail)
          $('.email-section').hide();
          console.log($('.email-section'));
          $('.email-section-detail').show();

          // 상세보기 내용 채우기
          $('.email-detail-subject').text(mail.subject);
          $('.sender-name').text(mail.from);
          $('.emanil-date-detail').text(mail.date);
          $('.email-detail-body').html('메일 디테일 테스트');

        })

        
        // 별표 버튼 이벤트 연결
        $('.star-button').on('click', function(e) {
          e.stopPropagation();
          const id = parseInt($(this).data('id'));
          toggleStar(id);
        });
      }
      
      // 별표 상태 토글
      function toggleStar(id) {
        emails.forEach(email => {
          if (email.id === id) {
            email.starred = !email.starred;
          }
        });
        renderEmails();
      }
      
      $('#mailWrite').on('click',function(){
        console.log('클릭 확인');
        // $('.email-section').hide();
        // console.log($('.email-section'));
        // $('.email-section write').show();
        // console.log($('.email-section write'));
        window.location.href="mail/mailSend";
      })

      // 탭 클릭 이벤트
      $('.tab').on('click', function() {
        $('.tab').removeClass('active');
        $(this).addClass('active');
      });
      
      // 사이드바 아이템 클릭 이벤트
      $('.sidebar-item').on('click', function() {
        $('.sidebar-item').removeClass('active');
        $(this).addClass('active');

      });
      
      // 초기 이메일 목록 렌더링
      renderEmails();
      
      // 알림 닫기 버튼
      // $('.close-button').on('click', function() {
      //   $('.notification-bar').hide();
      // });
    });
  </script>
</head>
<body>
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
            <span class="sidebar-count">2,307</span>
          </div>
          <!-- <div class="sidebar-item">
            <i class="fas fa-star"></i>
            <span class="sidebar-label">별표편지함</span>
          </div>
          <div class="sidebar-item">
            <i class="far fa-clock"></i>
            <span class="sidebar-label">다시 알림 항목</span>
          </div> -->
          <div class="sidebar-item">
            <i class="fas fa-paper-plane"></i>
            <span class="sidebar-label">보낸편지함</span>
          </div>
          <div class="sidebar-item">
            <i class="far fa-file-alt"></i>
            <span class="sidebar-label">임시보관함</span>
            <span class="sidebar-count">11</span>
          </div>
          <!-- <div class="sidebar-item">
            <i class="fas fa-chevron-down"></i>
            <span class="sidebar-label">더보기</span>
          </div> -->
        </div>
        
        <div class="sidebar-section">
          <div class="sidebar-section-header">라벨</div>
          <div class="sidebar-item">
            <i class="fas fa-tag" style="color: #4285f4;"></i>
            <span class="sidebar-label">내일정</span>
          </div>
          <div class="sidebar-item">
            <i class="fas fa-tag" style="color: #ea4335;"></i>
            <span class="sidebar-label">뉴스레터</span>
          </div>
          <div class="sidebar-item">
            <i class="fas fa-tag" style="color: #fbbc04;"></i>
            <span class="sidebar-label">중요</span>
          </div>
        </div>
      </div>

      <!-- 모든 컨텐츠가 여기에 비동기로 들어옴. -->
      <div class="emial-box" >
        <!-- 이메일 listSection 시작 -->
        <div class="email-section email-section-list" >
          <!-- 이메일 탭 -->
          <div class="email-content-area">
            <!-- 이메일 툴바 이건 네이버메일처럼 구현할 예정임!!!!-->
            <div class="email-toolbar">
              <div class="checkbox-container">
                <input type="checkbox" id="select-all">
              </div>
              <button class="toolbar-button">
                <i class="fas fa-ellipsis-v"></i>
              </button>
              <div class="email-tabs">
                <!-- <button class="tab active">읽음</button> -->
                <button class="tab">삭제</button>
                <button class="tab">답장</button>
                <!-- <button class="tab">전체 답장</button> -->
                <button class="tab">전달</button>
                <select name="mailLbl" id="labeling">
                  <option value="1">테스트라벨1</option>
                  <option value="2">테스트라벨2</option>
                </select>
              </div>
            </div>
            
            
            <!-- 이메일 목록 -->
            <div class="email-list" id="email-list">
              <!-- 이메일 항목들은 jQuery로 추가됩니다 -->
            </div>
          </div>
        </div>
        <!-- 이메일 listSection 끝 -->

        <!-- 이메일 detailSection 시작 -->
        <div class="email-section email-section-detail" style="width: 100%; " >
          <div class="email-detail-toolbar">
            <div class="toolbar-actions">
              <button class="toolbar-button back-to-list">
                <i class="fas fa-arrow-left"></i>
              </button>
              <button class="toolbar-button">
                <i class="fas fa-archive"></i>
              </button>
              <button class="toolbar-button">
                <i class="fas fa-trash"></i>
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
              <span class="email-date-detail"></span>
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
              <h2 class="email-detail-subject"></h2>
              <div class="email-detail-info">
                <div class="sender-info">
                  <div class="sender-avatar">
                    <div class="avatar-circle"></div>
                  </div>
                  <div class="sender-details">
                    <div class="sender-name"></div>
                    <div class="sender-email">sender@example.com</div>
                  </div>
                </div>
                <div class="email-detail-actions">
                  <button class="reply-button">
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
              <!-- 이메일 본문 내용 -->
            </div>

            <div class="email-detail-attachments">
              <!-- 첨부 파일이 있는 경우 표시 -->
            </div>

            <div class="email-detail-actions-bottom">
              <button class="reply-button">
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
        <!-- 이메일 detailSection 끝 -->

        <!-- 이메일 write 페이지 시작 -->
        <div class="email-section email-section-write">
          <c:import url="mailSend.jsp" />
        </div>
        <!-- 이메일 write 페이지 끝 -->
        
      </div>
      <!-- 이메일 콘텐츠 영역 -->
      
    </div>
    
    <!-- 알림 바 -->
    <!-- <div class="notification-bar">
      <span>Gmail 데스크톱 알림을 사용 설정하세요.</span>
      <div class="notification-actions">
        <button class="notification-button">확인</button>
        <button class="notification-button">나중에 하기</button>
        <button class="close-button">×</button>
      </div>
    </div> -->
  </div>
</body>
<style>
    /* 기본 스타일 */
    .email-container {
      font-family: 'Roboto', Arial, sans-serif;
      background-color: #f8f9fa;
      border-radius: 4px;
      overflow: hidden;
      height: 100%;
      display: flex;
      flex-direction: column;
    }
    
    /* 메인 콘텐츠 영역 (사이드바 + 이메일 리스트) */
    .email-main-content {
      display: flex;
      flex-grow: 1;
      overflow: hidden;
    }
    
    /* 사이드바 스타일 */
    .email-sidebar {
      width: 200px;
      background-color: #f8f9fa;
      border-right: 1px solid #e0e0e0;
      overflow-y: auto;
    }
    
    .sidebar-compose {
      margin: 10px;
    }
    
    .compose-button {
      display: flex;
      align-items: center;
      padding: 10px 16px;
      background-color: #4361ee;
      color: white;
      border-radius: 16px;
      border: none;
      font-weight: 500;
      cursor: pointer;
      font-size: 14px;
      transition: box-shadow 0.2s;
      width: 100%;
    }
    
    .compose-button:hover {
      box-shadow: 0 1px 3px rgba(0,0,0,0.2);
    }
    
    .compose-button i {
      margin-right: 8px;
    }
    
    .sidebar-section {
      margin-bottom: 8px;
    }
    
    .sidebar-item {
      display: flex;
      align-items: center;
      padding: 8px 16px;
      color: #202124;
      font-size: 14px;
      cursor: pointer;
      border-top-right-radius: 20px;
      border-bottom-right-radius: 20px;
    }
    
    .sidebar-item:hover {
      background-color: #eaecef;
    }
    
    .sidebar-item.active {
      background-color: #d3e1fd;
      color: #1a73e8;
      font-weight: 500;
    }
    
    .sidebar-item i {
      width: 20px;
      margin-right: 16px;
      color: #5f6368;
    }
    
    .sidebar-item.active i {
      color: #1a73e8;
    }
    
    .sidebar-label {
      flex-grow: 1;
    }
    
    .sidebar-count {
      font-size: 12px;
      color: #5f6368;
    }
    
    .sidebar-section-header {
      font-size: 12px;
      color: #5f6368;
      padding: 8px 16px;
      font-weight: 500;
      text-transform: uppercase;
    }
    
    /* 이메일 툴바 */
    .email-toolbar {
      display: flex;
      align-items: center;
      padding: 8px;
      border-bottom: 1px solid #dadce0;
      background-color: #fff;
    }
    
    .checkbox-container {
      margin-right: 8px;
    }
    
    .toolbar-actions {
      display: flex;
      margin-left: 16px;
    }
    
    .toolbar-button {
      padding: 4px;
      margin-right: 8px;
      background: none;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }
    
    .toolbar-button:hover {
      background-color: #f1f3f4;
    }
    
    .pagination {
      margin-left: auto;
      color: #5f6368;
      font-size: 12px;
    }
    
    .pagination-controls {
      margin-left: 16px;
      display: flex;
    }
    
    /* 이메일 탭
    .email-tabs {
      display: flex;
      border-bottom: 1px solid #dadce0;
      background-color: #fff;
    } */
    
    .tab {
      padding: 8px 16px;
      font-size: 14px;
      cursor: pointer;
      border: none;
      background: none;
    }
    
    .tab.active {
      color: #4361ee;
      border-bottom: 2px solid #4361ee;
      font-weight: 500;
    }
    
    .tab:not(.active) {
      color: #5f6368;
    }
    
    /* 이메일 콘텐츠 영역 */
    .email-content-area {
      display: flex;
      flex-direction: column;
      flex-grow: 1;
      overflow: hidden;
    }
    
    /* 이메일 목록 */
    .email-list {
      flex-grow: 1;
      overflow-y: auto;
    }
    
    .email-item {
      display: flex;
      align-items: center;
      padding: 8px;
      border-bottom: 1px solid #f1f3f4;
      cursor: pointer;
    }
    
    .email-item:hover {
      background-color: #f1f3f4;
    }
    
    .email-item.unread {
      background-color: #f2f6ff;
      font-weight: 500;
    }
    
    .email-actions {
      display: flex;
      align-items: center;
      width: 40px;
    }
    
    .star-button {
      background: none;
      border: none;
      cursor: pointer;
      padding: 4px;
      color: #5f6368;
    }
    
    .star-button.starred {
      color: #fbbc04;
    }
    
    .email-sender {
      width: 160px;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }
    
    .email-content {
      flex-grow: 1;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }
    
    .email-subject {
      font-weight: 500;
    }
    
    .email-snippet {
      color: #5f6368;
    }
    
    .email-date {
      width: 60px;
      text-align: right;
      color: #5f6368;
      font-size: 12px;
    }
    
    /* 알림 바 */
    .notification-bar {
      background-color: #202124;
      color: #fff;
      padding: 8px 16px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      font-size: 14px;
    }
    
    .notification-actions {
      display: flex;
    }
    
    .notification-button {
      background: none;
      border: none;
      color: #8ab4f8;
      cursor: pointer;
      margin-left: 16px;
    }
    
    .close-button {
      background: none;
      border: none;
      color: #9aa0a6;
      cursor: pointer;
      margin-left: 16px;
    }
    /* 이메일 상세보기 스타일 시작 */
    .email-detailSection {
      flex-grow: 1;
      display: flex;
      flex-direction: column;
      background-color: #fff;
      overflow-y: auto;
    }
    .email-detail-toolbar {
      display: flex;
      justify-content: space-between;
      padding: 8px 16px;
      border-bottom: 1px solid #dadce0;
      background-color: #fff;
    }
    .toolbar-actions-right {
      display: flex;
      align-items: center;
    }

    .email-date-detail {
      margin-right: 16px;
      color: #5f6368;
      font-size: 13px;
    }

    .email-detail-content {
      padding: 16px 24px;
      overflow-y: auto;
    }

    .email-detail-header {
      padding-bottom: 16px;
      border-bottom: 1px solid #f1f3f4;
      margin-bottom: 20px;
    }

    .email-detail-subject {
      font-size: 22px;
      font-weight: normal;
      color: #202124;
      margin: 0 0 16px 0;
    }

    .email-detail-info {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .sender-info {
      display: flex;
      align-items: center;
    }
    .sender-details {
      display: flex;
      flex-direction: column;
    }

    .sender-name {
      font-size: 14px;
      font-weight: 500;
      color: #202124;
    }

    .sender-email {
      font-size: 13px;
      color: #5f6368;
    }

    .email-detail-actions {
      display: flex;
    }

    .reply-button, .forward-button {
      display: flex;
      align-items: center;
      padding: 8px 16px;
      background-color: #f1f3f4;
      border: none;
      border-radius: 4px;
      margin-left: 8px;
      cursor: pointer;
      color: #5f6368;
      font-size: 14px;
    }

    .reply-button:hover, .forward-button:hover {
      background-color: #e8eaed;
    }

    .reply-button i, .forward-button i {
      margin-right: 8px;
    }

    .email-detail-body {
      padding: 16px 0;
      font-size: 14px;
      line-height: 1.5;
      color: #202124;
      min-height: 200px;
    }

    .email-detail-attachments {
      border-top: 1px solid #f1f3f4;
      padding-top: 16px;
      margin-top: 16px;
    }

    .email-detail-actions-bottom {
      margin-top: 24px;
      display: flex;
      gap: 8px;
    }

    .back-to-list {
      margin-right: 8px;
    }
    /* 이메일 상세보기 스타일 끝 */
  </style>
</html>
    
  
  
