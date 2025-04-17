<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script type="text/javascript">
    $(document).ready(function(){

      /* 리스트 조회 조건 시작 */
      let emailClTy = '';
      let label = ''
      /* 리스트 조회 조건 끝 */

      $('.email-section').hide();
      $('.email-section-list').show();
      console.log($('.email-section-list'));
      
      
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
        emailClTy = $(this).attr('data-emailClTy');
        console.log('emailClTy -> ',emailClTy);
      });
      // 리스트 클릭 이벤트
      $('.email-content').on('click',function(){
        let emailNo = $(this).closest('.email-item').attr('data-emailno');
        console.log('emailNo -> ',emailNo);
        window.location.href="/mail/emailDetail?emailNo="+emailNo;
      })

      $('.email-checkbox').change(function(){
        let emailNoList = [];
        console.log('클릭 확인 : ',this)
        let chkList = $('.email-checkbox:checked').get();
        console.log(chkList);
        chkList.forEach(chk=>{
          let emailNo = $(chk).closest('.email-item').attr('data-emailno');
          emailNoList.push(emailNo)
        })
        console.log("체크된 리스트 : ",emailNoList);
        if(emailNoList.length>1){
          $("#tab-repl").prop('disabled',true);
          $("#tab-trnsms").prop('disabled',true);
        }else{
          $("#tab-repl").prop('disabled',false);
          $("#tab-trnsms").prop('disabled',false);
        }
      })
    });
</script>
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
        <div class="sidebar-section" id="emailClTy">
          <div class="sidebar-item" data-emailClTy="0">
            <i class="fas fa-paper-plane"></i>
            <span class="sidebar-label">보낸편지함</span>
          </div>
          <div class="sidebar-item active" data-emailClTy="1">
            <i class="fas fa-inbox"></i>
            <span class="sidebar-label">받은편지함</span>
            <span class="sidebar-count">2,307</span>
          </div>
          <div class="sidebar-item" data-emailClTy="2">
            <i class="far fa-file-alt"></i>
            <span class="sidebar-label">임시보관함</span>
            <span class="sidebar-count">11</span>
          </div>
          <div class="sidebar-item" data-emailClTy="3">
            <i class="far fa-file-alt"></i>
            <span class="sidebar-label">스팸함</span>
            <span class="sidebar-count">11</span>
          </div>
          <div class="sidebar-item" data-emailClTy="4">
            <i class="far fa-file-alt"></i>
            <span class="sidebar-label">휴지통</span>
            <span class="sidebar-count">11</span>
          </div>
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

      <!-- 메일 콘텐츠 영역 -->
      <div class="emial-box" style="width: 90%; margin-left: 20px;">
        <!-- 이메일 listSection 시작 -->
        <div class="email-section email-section-list">
          <!-- 이메일 툴바 -->
          <div class="email-content-area">
            <div class="email-toolbar">
              <div class="checkbox-container">
                <input type="checkbox" id="select-all">
              </div>
              <button class="toolbar-button">
                <i class="fas fa-ellipsis-v"></i>
              </button>
              <div class="email-tabs">
                <button class="tab" id="tab-del">삭제</button>
                <button class="tab" id="tab-repl">답장</button>
                <button class="tab" id="tab-trnsms">전달</button>
                <select name="mailLbl" id="labeling">
                  <option value="1">테스트라벨1</option>
                  <option value="2">테스트라벨2</option>
                </select>
              </div>
              <div style="display: flex; justify-content: flex-end;">
                <select name="searchOption" id="searchOption">
                  <option value="title">제목</option>
                  <option value="content">내용</option>
                  <option value="title&content">제목+내용</option>
                  <option value="email">email</option>
                </select>
                <input type="text" name="keyword" id="search">
              </div>
            </div>
            <!-- 이메일 목록 - 여기에 스크롤이 적용됩니다 -->
            <div class="email-list" id="email-list">
              <!-- forEach 시작 -->
              <c:forEach items="${mailVOList}" var="mailVO">
                <div class="email-item ${mailVO.readngAt}" data-emailNo="${mailVO.emailNo}">
                  <div class="email-actions">
                    <input type="checkbox" class="email-checkbox">
                    <button class="star-button ${starClass}" data-emailNo="${mailVO.emailNo}">
                      <i class="far fa-star"></i>
                    </button>
                  </div>
                  <div class="email-sender">${mailVO.trnsmitEmail}</div>
                  <div class="email-content">
                    <c:if test="${mailVO.emailSj != null}">
                      <span class="email-subject">${mailVO.emailSj}</span>
                    </c:if>
                    <c:if test="${mailVO.emailSj == null}">
                      <span class="email-subject">(제목 없음)</span>
                    </c:if>
                    <c:if test="${mailVO.emailCn != null}">
                      -<span class="email-content-summary">${mailVO.emailCn}</span>
                    </c:if>
                  </div>
                  <div class="email-date">${mailVO.trnsmitDt}</div>
                </div>
              </c:forEach>
              <!-- forEach 끝 -->
            </div>
          </div>
        </div>
        <!-- 이메일 listSection 끝 -->
         <!-- 페이지네이션 -->
          <page-navi
            url="/mail?${articlePage.getSearchVo()}"
            current="${articlePage.getCurrentPage()}"
            show-max="5"
            total="${articlePage.getTotalPages()}"
          ></page-navi>
      </div>
    </div>
  </div>
<style>
   /* 기본 스타일 */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: 'Roboto', 'Noto Sans KR', Arial, sans-serif;
  background-color: #f8f9fa;
  color: #202124;
  line-height: 1.5;
}

.email-container {
  font-family: 'Roboto', 'Noto Sans KR', Arial, sans-serif;
  background-color: #ffffff;
  border-radius: 8px;
  height: 80vh;
  width: 100%;
  display: flex;
  flex-direction: column;
  /* box-shadow: 0 4px 6px rgba(0,0,0,0.1); */
  overflow: hidden; /* 바깥쪽 스크롤 제거 */
}

/* 메인 콘텐츠 영역 (사이드바 + 이메일 리스트) */
.email-main-content {
  display: flex;
  flex-grow: 1;
  overflow: hidden;
}

/* 사이드바 스타일 개선 */
.email-sidebar {
  width: 260px;
  border-right: 1px solid #e0e0e0;
  overflow-y: auto;
  transition: all 0.3s ease;
  padding-top: 12px;
  /* box-shadow: 1px 0 5px rgba(0,0,0,0.05); */
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
  /* box-shadow: 0 2px 8px rgba(59, 130, 246, 0.3); */
}

.compose-button:hover {
  background: linear-gradient(135deg, #3b6fe3, #2563eb);
  /* box-shadow: 0 4px 10px rgba(59, 130, 246, 0.4); */
  transform: translateY(-2px);
}

.compose-button:active {
  transform: translateY(0);
  /* box-shadow: 0 2px 5px rgba(59, 130, 246, 0.2); */
}

.compose-button i {
  margin-right: 12px;
  font-size: 16px;
}

.sidebar-section {
  margin-bottom: 16px;
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
  background-color: #edf2f7;
  color: #1a202c;
}

.sidebar-item.active {
  background-color: #e1effe;
  color: #2563eb;
  font-weight: 500;
}

.sidebar-item i {
  width: 24px;
  margin-right: 16px;
  text-align: center;
  font-size: 16px;
  transition: transform 0.2s;
}

.sidebar-item:hover i {
  transform: scale(1.1);
}

.sidebar-item.active i {
  color: #2563eb;
}

.sidebar-label {
  flex-grow: 1;
  transition: transform 0.1s;
}

.sidebar-item:active .sidebar-label {
  transform: translateX(3px);
}

.sidebar-count {
  font-size: 12px;
  font-weight: 500;
  color: #4b5563;
  background-color: #e5e7eb;
  padding: 2px 10px;
  border-radius: 12px;
  min-width: 26px;
  text-align: center;
  transition: all 0.2s;
}

.sidebar-item:hover .sidebar-count {
  background-color: #d1d5db;
}

.sidebar-item.active .sidebar-count {
  background-color: #bfdbfe;
  color: #2563eb;
}

.sidebar-section-header {
  font-size: 12px;
  color: #6b7280;
  padding: 10px 18px;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

/* 이메일 툴바 */
.email-toolbar {
  display: flex;
  align-items: center;
  padding: 12px 16px;
  border-bottom: 1px solid #e0e0e0;
  background-color: #fff;
  z-index: 10;
}

.checkbox-container {
  margin-right: 12px;
}

.checkbox-container input[type="checkbox"] {
  cursor: pointer;
  width: 18px;
  height: 18px;
  border-radius: 3px;
}

.toolbar-actions {
  display: flex;
  margin-left: 16px;
}

.toolbar-button {
  padding: 8px;
  margin-right: 10px;
  background: none;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  color: #4b5563;
  transition: all 0.2s;
}

.toolbar-button:hover {
  background-color: #f3f4f6;
  color: #1f2937;
}

.email-tabs {
  display: flex;
  margin-left: 10px;
  align-items: center;
}

.tab {
  padding: 8px 16px;
  font-size: 14px;
  cursor: pointer;
  border: none;
  background: none;
  border-radius: 4px;
  margin-right: 4px;
  transition: all 0.2s;
  color: #4b5563;
}

.tab:hover {
  background-color: #f3f4f6;
  color: #1f2937;
}

.tab.active {
  color: #2563eb;
  background-color: #e1effe;
  font-weight: 500;
}
.tab:disabled{
  opacity: 0.5;  /* 투명도를 낮춰 흐리게 보이게 */
  cursor: not-allowed;  /* 마우스 커서를 '사용 불가' 형태로 변경 */
}

#labeling {
  margin-left: 8px;
  padding: 8px 10px;
  border: 1px solid #d1d5db;
  border-radius: 4px;
  background-color: white;
  font-size: 14px;
  color: #4b5563;
  cursor: pointer;
  outline: none;
  transition: all 0.2s;
}

#labeling:hover {
  border-color: #9ca3af;
}

#labeling:focus {
  border-color: #3b82f6;
  /* box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.2); */
}

/* 이메일 콘텐츠 영역 */
.email-content-area {
  display: flex;
  flex-direction: column;
  flex-grow: 1;
  overflow: hidden;
  background-color: #ffffff;
}

.emial-box {
  transition: all 0.3s ease;
}

/* 이메일 목록 */
.email-list {
  flex-grow: 1;
  overflow-y: auto; /* 여기에 스크롤 적용 */
  scrollbar-width: thin;
  scrollbar-color: #cbd5e1 #f1f5f9;
  height: calc(100vh - 60px); /* 툴바 높이를 제외한 나머지 공간 */
}

.email-list::-webkit-scrollbar {
  width: 8px;
}

.email-list::-webkit-scrollbar-track {
  background: #f1f5f9;
}

.email-list::-webkit-scrollbar-thumb {
  background-color: #cbd5e1;
  border-radius: 4px;
}

.email-item {
  display: flex;
  align-items: center;
  padding: 7px 8px;
  border-bottom: 1px solid #e5e7eb;
  cursor: pointer;
  transition: all 0.15s ease;
  position: relative;
  width: 100%;
  box-sizing: border-box;
}

.email-item:hover {
  background-color: #f3f4f6;
  transform: translateY(-1px);
  /* box-shadow: 0 1px 3px rgba(0,0,0,0.05); */
}

.email-item.unread {
  background-color: #f0f7ff;
}

.email-item.unread:hover {
  background-color: #e6f0fd;
}

.email-item::after {
  content: '';
  position: absolute;
  left: 0;
  top: 0;
  height: 100%;
  width: 4px;
  background-color: transparent;
  transition: background-color 0.2s;
}

.email-item.unread::after {
  background-color: #3b82f6;
}

.email-actions {
  display: flex;
  align-items: center;
  width: 60px;
  margin-right: 8px;
}

.email-checkbox {
  margin-right: 10px;
  cursor: pointer;
  width: 18px;
  height: 18px;
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

.email-sender {
  width: 180px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  font-weight: 500;
  color: #374151;
  padding-right: 12px;
}

.email-content {
  flex-grow: 1;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  padding-right: 16px;
  min-width: 0;
}

.email-subject {
  font-weight: 500;
  color: #1f2937;
}

.email-snippet {
  color: #6b7280;
  margin-left: 4px;
}

.email-date {
  width: 80px;
  min-width: 160px;
  text-align: right;
  color: #6b7280;
  font-size: 13px;
  white-space: nowrap;
  margin: auto;
  flex-shrink: 0;
  text-overflow: ellipsis;
}

.email-item.unread .email-date {
  color: #4b5563;
  font-weight: 500;
}

/* 반응형 스타일 */
@media (max-width: 768px) {
  .email-sidebar {
    width: 60px;
  }
  
  .sidebar-label, .sidebar-count, .compose-button span {
    display: none;
  }
  
  .compose-button {
    padding: 12px;
    border-radius: 50%;
    justify-content: center;
  }
  
  .compose-button i {
    margin-right: 0;
  }
  
  .emial-box {
    width: calc(100% - 60px) !important;
    margin-left: 0 !important;
  }
  
  .email-sender {
    width: 120px;
  }
}

/* 알림 바 (현재 주석 처리되어 있지만 스타일 유지) */
.notification-bar {
  background: linear-gradient(135deg, #1a202c, #2d3748);
  color: #fff;
  padding: 12px 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 14px;
  /* box-shadow: 0 2px 8px rgba(0,0,0,0.15); */
}

.notification-actions {
  display: flex;
}

.notification-button {
  background: none;
  border: 1px solid rgba(255,255,255,0.2);
  color: #90cdf4;
  cursor: pointer;
  margin-left: 16px;
  padding: 6px 12px;
  border-radius: 4px;
  transition: all 0.2s;
}

.notification-button:hover {
  background-color: rgba(255,255,255,0.1);
  color: #bde0fe;
}

.close-button {
  background: none;
  border: none;
  color: #9aa0a6;
  cursor: pointer;
  margin-left: 16px;
  font-size: 18px;
  transition: all 0.2s;
}

.close-button:hover {
  color: #ffffff;
}

/* 이메일 상세 페이지 스타일 (현재는 사용하지 않지만 추가) */
.email-detail-header {
  padding: 16px;
  border-bottom: 1px solid #e5e7eb;
}

.email-detail-subject {
  font-size: 18px;
  font-weight: 600;
  color: #1f2937;
  margin-bottom: 8px;
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

.sender-avatar {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  background-color: #3b82f6;
  color: white;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 600;
  margin-right: 12px;
}

.sender-details {
  display: flex;
  flex-direction: column;
}

.sender-name {
  font-weight: 500;
  color: #374151;
}

.sender-email {
  font-size: 13px;
  color: #6b7280;
}

.email-detail-body {
  padding: 20px;
  line-height: 1.6;
  color: #374151;
}
    
  </style>
    
  
  
