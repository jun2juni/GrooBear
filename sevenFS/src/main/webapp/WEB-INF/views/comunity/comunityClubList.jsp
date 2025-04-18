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
			                        <th>
			                          <h6>프로필</h6>
			                        </th>
			                        <th>
			                          <h6>이름</h6>
			                        </th>
			                        <th>
			                          <h6>T.T-MI</h6>
			                        </th>
			                        <th>
			                          <h6>오늘의 한 줄</h6>
			                        </th>
			                        <th>
			                          <h6>상태</h6>
			                        </th>
			                        <th>
			                          <h6>Action</h6>
			                        </th>
			                      </tr>
			                      <!-- end table row-->
			                    </thead>
			                    <tbody>
			                    <c:forEach var="clubList" items="${clubList}">
			                      <tr>
			                        <td>
			                          <div class="employee-image">
			                            <img src="assets/images/lead/lead-1.png" alt="">
			                          </div>
			                        </td>
			                        <!-- 사원이름  -->
			                        <td class="min-width">
			                          <p>${clubList.emplNm}</p>
			                        </td>
			                        <!-- 사원이름  -->
			                        
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
			                        <!-- 이모지 -->
			                        <td>
								      <a href="#" data-bs-toggle="modal" data-bs-target="#emojiModal">
								        <c:choose>
								          <c:when test="${not empty clubList.emoji}">
								            ${clubList.emoji}
								          </c:when>
								          <c:otherwise>🙂 감정을 골라주세요</c:otherwise>
								        </c:choose>
								      </a>
								    </td>
			                        <td>
			                          <div class="action">
			                            <button class="text-danger">
			                              <i class="lni lni-trash-can"></i>
			                            </button>
			                          </div>
			                        </td>
			                        <!-- 상태 -->
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
			 <form action="">
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
		                  <textarea placeholder="답변을 입력해주세요" rows="5" data-listener-added_0bb1bb59="true"></textarea>
		                </div>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
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
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
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
		                  <label><h4>👍오늘의 기분을 이모지로 말해주세요!👎</h4></label> <!--이모지 들어가는 곳   -->
		                  <textarea id="emojiTextArea" name="emoji" placeholder="이모지를 입력해주세요" rows="5" data-listener-added_0bb1bb5="true"></textarea>
		                </div>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
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
<script type="text/javascript">

      	 
	  
	  
	/*이모지 위 입력하는 이모지칸  */
const Emojis = [
	  "😀", "😄", "😆", "😅", "🤣", "😂", "😉", "😇", "🥰", "😍",
	  "🤪", "😜", "😬", "😒", "🙄", "😪", "😴", "💀", "☠️", "💩",
	  "😵‍💫", "🙈", "🙉", "🙊", "🙏", "👩‍❤️‍👨", "🦕", "🦖", "🍀",
	  "🦑", "🦋", "🐛", "🦞", "🐠", "🌂", "🌤️", "⛈️", "⛅", "🌥️",
	  "🌦️", "🌪️", "🌩️", "🪐", "🌞", "🌝", "🔥", "☄️", "💘",	
	  "❤️‍🔥", "🚭", "⁉️"
	];
	
function renderEmojis() {
    const emojiContainer = document.querySelector('.emoji-picker');
    const emojiTextArea = document.querySelector('#emojiTextArea');

    if (!emojiContainer || !emojiTextArea) {
      console.warn('이모지 DOM 요소가 없습니다.');
      return;
    }
    // 이미 버튼이 있다면 초기화
    emojiContainer.innerHTML = '';

    Emojis.forEach(emoji => {
      const button = document.createElement('button');
      button.type = 'button';
      button.className = 'btn btn-light m-1';
      button.style.fontSize = '1rem';
      button.textContent = emoji;

      button.addEventListener('click', () => {
        emojiTextArea.value += emoji;
        emojiTextArea.focus();
      });

      emojiContainer.appendChild(button);
    });
  }

  document.addEventListener('DOMContentLoaded', () => {
    // Bootstrap 모달이 열릴 때마다 renderEmojis 실행
    const emojiModal = document.getElementById('emojiModal');
    if (emojiModal) {
      emojiModal.addEventListener('shown.bs.modal', () => {
        renderEmojis();
      });
    }
  });
    

  
</script>
</html>
