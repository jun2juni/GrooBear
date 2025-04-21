<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="메인" />

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="ie=edge" />
<title>${title}</title>
<%@ include file="../layout/prestyle.jsp"%>
<style>

</style>
</head>
<body>
	<%@ include file="../layout/sidebar.jsp"%>
	<main class="main-wrapper">
		<%@ include file="../layout/header.jsp"%>
		<section class="section">
			<div class="container-fluid">
				<div class="row mt-5" name="row">
					<div class="col-12">
						<div class="card-style">
							<!-- 상위탭 시작  -->
							<div class="mb-20">
								<ul class="nav nav-tabs" id="myTab" role="tablist">
									<li class="nav-item" role="presentation">
										<button class="nav-link" id="tab1" data-bs-toggle="tab"
											data-bs-target="#content1" type="button"
											onClick="location.href='comunityHome'" role="tab"
											aria-controls="content1" aria-selected="true">Home</button>
									</li>
									<li class="nav-item" role="presentation">
										<button class="nav-link" id="tab2" data-bs-toggle="tab"
											data-bs-target="#content2" type="button" role="tab"
											onClick="location.href='comunityClubList'"
											aria-controls="content2" aria-controls="content2"
											aria-selected="false">스느스</button>
									</li>
									<li class="nav-item" role="presentation">
										<button class="nav-link" id="tab3" data-bs-toggle="tab"
											data-bs-target="#content3" type="button" role="tab"
											onClick="location.href='comunitySurveyList'"	
											aria-controls="content3" aria-selected="false">설문조사/투표</button>
									</li>
									<li class="nav-item" role="presentation">
										<button class="nav-link" id="tab4" data-bs-toggle="tab"
											data-bs-target="#content4" type="button"
											onClick="location.href='comunityMonthMenuList'" role="tab"
											aria-controls="content4" aria-selected="false">월별식단표</button>
									</li>
								</ul>
							</div> <!--내부 탭 분리 지점   -->
							<div class="row-5">
			            <div class="col-12 card-style">
			              <div class=" mb-30">		
			                <div class="table-wrapper table-responsive">
			                  <table class="table">
			                    <thead class="table-striped">
								  <tr>
									  <th style="width: 80px; text-align: left;">
									    <span
									      data-bs-toggle="tooltip"
									      data-bs-html="true"
									      data-bs-placement="top"
									      title="이곳은 여러분의 <br>프로필 사진이 나오는 곳입니다!<br>프로필 사진을 변경해주세요">
									      프로필
									    </span>
									  </th>
									
									  <th style="width: 200px; text-align: left;">
									    <span
									      data-bs-toggle="tooltip"
									      data-bs-html="true"
									      data-bs-placement="top"
									      title="사원의 이름입니다.<br>때로는<br>잘 고른 이모지 1개가<br>여러분의 많은 감정을 대변해 줄 수 있죠!<br>여러분의 감정을 골라주세요!!!">
									      이름
									    </span>
									  </th>
									
									  <th style="width: 280px; text-align: left;">
									    <span
									      data-bs-toggle="tooltip"
									      data-bs-html="true"
									      data-bs-placement="top"
									      title="여러분의<br>사소한 정보와 이야기를<br>여기 남겨주세요!!">
									      T.T-MI
									    </span>
									  </th>
									
									  <th style="width: 320px; text-align: left;">
									    <span
									      data-bs-toggle="tooltip"
									      data-bs-html="true"
									      data-bs-placement="top"
									      title="여러분의 일상의 오늘 말 하고 싶은 말들!<br>좌우명도 좋아요 한 마디씩 남겨주세요!">
									      오늘의 한 줄
									    </span>
									  </th>
									</tr>

								</thead>
			                    <tbody>
			                    <c:forEach var="clubList" items="${clubList}">
			                      <tr>
			                        <td style="text-align: left;">
			                          <div class="employee-image">
			                            <img src="assets/images/lead/lead-1.png" alt="">
			                          </div>
			                        </td>
			                        <!-- 사원이름+이모지  -->
			                        <td style="text-align: left; white-space: nowrap;">
									  <!-- 이름은 무조건 출력 -->
										<span style="display: inline-block; font-weight: bold; font-size: 1.05rem; color: #2C3E50;">
										  ${clubList.emplNm}
										</span>
										
									<!-- 이모지는 사원 본인만 클릭 가능 -->
									  <c:choose>
							          <c:when test="${clubList.emplNo == loginEmplNo}">
							            <a href="#" data-bs-toggle="modal" data-bs-target="#emojiModal"
							               style="display: inline-block; margin-left: 6px; text-decoration: none; font-size: 1.2rem;">
							              <c:choose>
							                <c:when test="${not empty clubList.emoji}">
							                  <span style="font-family: 'Apple Color Emoji', 'Segoe UI Emoji', 'Noto Color Emoji'">
							                    ${clubList.emoji}
							                  </span>
							                </c:when>
							                <c:otherwise><p>😆</p></c:otherwise>
							              </c:choose>
							            </a>
							          </c:when>
							          <c:otherwise>
							            <span style="margin-left: 6px;">
							              <c:choose>
							                <c:when test="${not empty clubList.emoji}">${clubList.emoji}</c:when>
							                <c:otherwise><p>😆</p></c:otherwise>
							              </c:choose>
							            </span>
							          </c:otherwise>
							        </c:choose>
							      </td>
			                        <!-- 사원이름+이모지  -->
			                        
			                        <!-- T.T-MI -->
			                         <td>
								      <a href="#" data-bs-toggle="modal" data-bs-target="#100Modal">
								        <c:choose>
								          <c:when test="${not empty clubList.ttmiContent}">
								            ${clubList.ttmiContent}
								          </c:when>
								          <c:otherwise>✍️ 등록하기</c:otherwise>
								        </c:choose>
								      </a>
								    </td>
			                        <!-- T.T-MI -->
			                        <!-- 오늘의 한 줄 -->
			                         <td>
								      <a href="#" data-bs-toggle="modal" data-bs-target="#todayModal">
								        <c:choose>
								          <c:when test="${not empty clubList.todayContent}">
								            ${clubList.todayContent}
								          </c:when>
								          <c:otherwise>작성 전</c:otherwise>
								        </c:choose>
								      </a>
								    </td>
			                        <!-- 오늘의 한 줄 -->
			                      </tr>
			                      </c:forEach>
			                      <!-- end table row -->
			                    </tbody>
			                  </table>
			                  <!-- end table -->
			                </div>
			              </div>
			              <!-- end card -->
			            </div>
	            <!-- end col -->
	          </div>
						</div>
					</div>
				</div> <!--탭 끝나는지점  -->	
			 </div>	<!--fluid  -->
			 
			 <!-- 백문백답모달 시작  -->
			 <form action="/comunity/insertTTMI" method="post">
				<div class="modal fade" id="100Modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h1 class="modal-title fs-5" id="exampleModalLabel">T.T-MI 입력</h1>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        <div class="input-style-1">
		                  <label><h4>가장 좋아하는 과일을 말해주세요!</h4></label> <!--백문백답 들어가는 곳   -->
		                  <textarea placeholder="답변을 입력해주세요" name="ttmiContent" rows="5" data-listener-added_0bb1bb59="true"></textarea>
		                </div>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				        <button type="submit" class="btn btn-primary">답변 저장하기</button>
				      </div>	
				    </div>
				  </div>
				</div>
			</form>
       		 <!-- 백문백답모달 끝  -->
			 <!-- 오늘의 한 줄 모달 시작  -->
			 <form id="todayForm" action="/comunity/insertToday" method="post">
				<div class="modal fade" id="todayModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h1 class="modal-title fs-5" id="exampleModalLabel">T.T-MI 입력</h1>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        <div class="input-style-1">
		                  <label><h4>😼오늘의 기분을 말해주세요!😻</h4></label> 
		                  <textarea name="bbscttCn" placeholder="답변을 입력해주세요" rows="5" data-listener-added_0bb1bb5="true"></textarea>
		                </div>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				        <button type="submit" class="btn btn-primary">답변 저장하기</button>
				      </div>	
				    </div>
				  </div>
				</div>     
			</form>
       		 <!-- 오늘의 한 줄 모달 끝  -->
			 <!-- 오늘의 이모지 모달 시작  -->
			 <form action="/comunity/insertEmoji" method="post">
				<div class="modal fade" id="emojiModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h1 class="modal-title fs-5" id="exampleModalLabel">이모지 선택</h1>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
						<div class="emoji-picker my-3">
						  <!-- 이모지 버튼이 여기에 동적으로 들어갈 예정 -->
						</div>				      
				        <div class="input-style-1">
		                  <label><h4>👍오늘의 기분을 이모지로 말해주세요!👎(최대 3개)</h4></label> <!--이모지 들어가는 곳   -->
		                  <textarea readonly="readonly"  id="emojiTextArea" name="emoji" placeholder="이모지를 입력해주세요" rows="5" data-listener-added_0bb1bb5="true"></textarea>
		                </div>
				      </div>
				      <div class="modal-footer">
				        <button type="button" id="emojiResetBtn" class="btn btn-outline-danger btn-sm mt-2">선택 초기화</button>
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				        <button type="submit" class="btn btn-primary">오늘의 이모지 저장하기</button>
				      </div>	
				    </div>
				  </div> 
				</div>     
			</form>
       		 <!-- 오늘의 이모지 모달 끝  -->
		</section>
		<%@ include file="../layout/footer.jsp"%>
	</main>
	<%@ include file="../layout/prescript.jsp"%>
</body>
<style>
 td, th  {
  position: relative;
  overflow: hidden;
  white-space: nowrap;
  text-align: left;
  text-overflow: ellipsis;
  max-width: 150px; /* 최대 너비 설정 */ 
  }
  .tooltip-inner {
  min-width: 120px;  /* 최소 너비 확보 */
  max-width: none;   /* Bootstrap 기본값 제한 해제 */
  background-color: #365CF5 !important; /* 밝은 파란색 */
  color: #fff !important; /* 텍스트는 흰색 */
  font-size: 0.85rem;
  padding: 6px 10px;
  border-radius: 4px;
  padding: 8px 12px;
  text-align: center;
  white-space: normal;  /* 줄바꿈 허용 */
}
</style>

<script type="text/javascript">
// ✅ 1. 이모지 배열은 최상단에 선언!
const Emojis = [
  "😀", "😄", "😆", "😅", "🤣", "😂", "😉", "😇", "🥰", "😍",
  "🤪", "😜", "😬", "😒", "🙄", "😪", "😴", "💀", "☠️", "💩",
  "😵‍💫", "🙈", "🙉", "🙊", "🙏", "👩‍❤️‍👨", "🦕", "🦖", "🍀",
  "🦑", "🦋", "🐛", "🦞", "🐠", "🌂", "🌤️", "⛈️", "⛅", "🌥️",
  "🌦️", "🌪️", "🌩️", "🪐", "🌞", "🌝", "🔥", "☄️", "💘",
  "❤️‍🔥", "🚭", "⁉️"
];

// ✅ 2. 이모지 렌더링 함수
function renderEmojis() {
  const emojiContainer = document.querySelector('.emoji-picker');
  const emojiTextArea = document.querySelector('#emojiTextArea');
  const resetButton = document.querySelector('#emojiResetBtn');

  if (!emojiContainer || !emojiTextArea) {
    console.warn('이모지 DOM 요소가 없습니다.');
    return;
  }

  // 기존 버튼 초기화
  emojiContainer.innerHTML = '';

  // 이모지 버튼 생성
  Emojis.forEach(emoji => {
    const button = document.createElement('button');
    button.type = 'button';
    button.className = 'btn btn-light m-1';
    button.style.fontSize = '1rem';
    button.textContent = emoji;

    button.addEventListener('click', () => {
      const emojiArray = Array.from(emojiTextArea.value);
      if (emojiArray.length >= 5) {
        swal({
          title: "⚠️ 제한 초과",
          text: "이모지는 최대 3개까지만 선택할 수 있어요!",
          icon: "warning",
          button: "확인"
        });
        return;
      }
      emojiTextArea.value += emoji;
      emojiTextArea.focus();
    });

    emojiContainer.appendChild(button);
  });

  // ✅ 3. 초기화 버튼 클릭 시 이모지 초기화
  if (resetButton && emojiTextArea) {
    resetButton.addEventListener('click', () => {
      emojiTextArea.value = "";
    });
  }
}

// ✅ 4. 모달이 열릴 때 이모지 렌더링 실행
document.addEventListener('DOMContentLoaded', () => {
  const emojiModal = document.getElementById('emojiModal');
  if (emojiModal) {
    emojiModal.addEventListener('shown.bs.modal', () => {
      renderEmojis();
    });
  }

  // ✅ (선택) 툴팁 초기화 등 다른 초기화
  const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
  tooltipTriggerList.forEach(function (tooltipTriggerEl) {
    new bootstrap.Tooltip(tooltipTriggerEl);
  });
});
</script>

</html>
