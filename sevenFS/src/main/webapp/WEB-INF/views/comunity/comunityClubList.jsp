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
							<div class="row-5">
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
									      title="이곳은 여러분의 <br>Who am I? 사진이 나오는 곳입니다!<br>Who am I? 사진을 변경해주세요">
									      Who am I?
									    </span>
									  </th>
									
									  <th style="width: 200px; text-align: left;">
									    <span
									      data-bs-toggle="tooltip"
									      data-bs-html="true"
									      data-bs-placement="top"
									      title="사원의 이름입니다.<br>때로는 잘 고른 이모지 1개가<br>여러분의 많은 감정을 대변해 줄 수 있죠!<br>여러분의 감정을 골라주세요!!!">
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
			                    <tbody id="clubListBody">
			                    <c:forEach var="club" items="${clubList}">
			                     	<c:if test="${club.emplNo == loginEmplNo}">
				                      <tr>
				                      	<!-- Who am I?사진  -->
				                        <td style="text-align: left;">
				                          <div class="employee-image">
				                            <img
											  src="/upload/${club.profileImg}" 
											  alt="Who am I?"
											  onerror="this.src='/assets/images/profileDefaultImage.jpg';"
											  style="<c:choose>
											           <c:when test='${club.emplNo == loginEmplNo}'>cursor: pointer;</c:when>
											           <c:otherwise>cursor: default;</c:otherwise>
											         </c:choose>"
											  <c:if test="${club.emplNo == loginEmplNo}">
											    onclick="document.getElementById('hiddenProfileInput').click();"
											  </c:if>
											/>
				                          </div>
				                        </td>
				                        <!--Who am I? 사진 끝  -->
				                        <!-- 사원이름+이모지  -->
				                        <td style="text-align: left; white-space: nowrap;">
										  <!-- 이름은 무조건 출력 -->
											<span style="display: inline-block; font-weight: bold; font-size: 1.05rem; color: #2C3E50;">
												<a>
											  		${club.emplNm}
											 	 </a>
											</span>
										<!-- 이모지는 사원 본인만 클릭 가능 -->
										  <c:choose>
								          <c:when test="${club.emplNo == loginEmplNo}">
								            <a href="#" data-bs-toggle="modal" data-bs-target="#emojiModal"
								               style="display: inline-block; margin-left: 6px; text-decoration: none; font-size: 1.2rem;">
								              <c:choose>
								                <c:when test="${not empty club.emoji}">
								                  <span style="font-family: 'Apple Color Emoji', 'Segoe UI Emoji', 'Noto Color Emoji'">
								                    ${club.emoji}
								                  </span>
								                </c:when>
								                <c:otherwise><p>😆</p></c:otherwise>
								              </c:choose>
								            </a>
								          </c:when>
								          <c:otherwise>
								            <span style="margin-left: 6px;">
								              <c:choose>
								                <c:when test="${not empty club.emoji}">${club.emoji}</c:when>
								                <c:otherwise><p>😆</p></c:otherwise>
								              </c:choose>
								            </span>
								          </c:otherwise>
								        </c:choose>
								      </td>
				                        <!-- 사원이름+이모지  -->
				                        
				                       <!-- T.T-MI -->
										<td class="ttmi-col" title="${club.ttmiContent}">
										  <c:choose>
										    <c:when test="${club.emplNo == loginEmplNo}">
										      <!-- 본인이면 입력 가능 -->
										      <a href="#" data-bs-toggle="modal" data-bs-target="#100Modal">
										        <c:choose>
										          <c:when test="${not empty club.ttmiContent}">
										            <span class="ttmi-text">${club.ttmiContent}</span>
										          </c:when>
										          <c:otherwise>✍️ 등록하기</c:otherwise>
										        </c:choose>
										      </a>
										    </c:when>
										    <c:otherwise>
										      <!-- 타인이면 보기만 가능 -->
										      <span>
										        <c:choose>
										          <c:when test="${not empty club.ttmiContent}">
										            <span class="ttmi-text">${club.ttmiContent}</span>
										          </c:when>
										          <c:otherwise>🙈 아직 업데이트 하지 않았어요 ㅠ.ㅠ</c:otherwise>
										        </c:choose>
										      </span>
										    </c:otherwise>
										  </c:choose>
										</td>
				                        <!-- 오늘의 한 줄 -->
										<td class="today-col" title="${club.todayContent}">
										  <c:choose>
										    <c:when test="${club.emplNo == loginEmplNo}">
										      <a href="#" data-bs-toggle="modal" data-bs-target="#todayModal">
										        <c:choose>
										          <c:when test="${not empty club.todayContent}">
										            <span class="today-text">${club.todayContent}</span>
										          </c:when>
										          <c:otherwise>📝 작성 전</c:otherwise>
										        </c:choose>
										      </a>
										    </c:when>
										    <c:otherwise>
										      <span>
										        <c:choose>
										          <c:when test="${not empty club.todayContent}">
										            <span class="today-text">${club.todayContent}</span>
										          </c:when>
										          <c:otherwise>🙊 한 줄을 써주세요!!</c:otherwise>
										        </c:choose>
										      </span>
										    </c:otherwise>
										  </c:choose>
										</td>
				                      </tr>
				                     </c:if>
			                      </c:forEach>
			                      <!-- end table row 내정보 로우  -->
			                       <c:forEach var="club" items="${clubList}">
				                     <c:if test="${club.emplNo != loginEmplNo}">
				                     	<tr>
				                      	<!-- Who am I?사진  -->
				                        <td style="text-align: left;">
				                          <div class="employee-image">
				                            <img
											  src="/upload/${club.profileImg}" 
											  alt="Who am I?"
											  onerror="this.src='/assets/images/profileDefaultImage.jpg';"
											  style="<c:choose>
											           <c:when test='${club.emplNo == loginEmplNo}'>cursor: pointer;</c:when>
											           <c:otherwise>cursor: default;</c:otherwise>
											         </c:choose>"
											  <c:if test="${club.emplNo == loginEmplNo}">
											    onclick="document.getElementById('hiddenProfileInput').click();"
											  </c:if>
											/>
				                          </div>
				                        </td>
				                        <!-- 사원이름+이모지  -->
				                        <td style="text-align: left; white-space: nowrap;">
										  <!-- 이름은 무조건 출력 -->
											<span style="display: inline-block; font-weight: bold; font-size: 1.05rem; color: #2C3E50;">
											  ${club.emplNm}
											</span>
										<!-- 이모지는 사원 본인만 클릭 가능 -->
										  <c:choose>
								          <c:when test="${club.emplNo == loginEmplNo}">
								            <a href="#" data-bs-toggle="modal" data-bs-target="#emojiModal"
								               style="display: inline-block; margin-left: 6px; text-decoration: none; font-size: 1.2rem;">
								              <c:choose>
								                <c:when test="${not empty club.emoji}">
								                  <span style="font-family: 'Apple Color Emoji', 'Segoe UI Emoji', 'Noto Color Emoji'">
								                    ${club.emoji}
								                  </span>
								                </c:when>
								                <c:otherwise><p>😆</p></c:otherwise>
								              </c:choose>
								            </a>
								          </c:when>
								          <c:otherwise>
								            <span style="margin-left: 6px;">
								              <c:choose>
								                <c:when test="${not empty club.emoji}">${club.emoji}</c:when>
								                <c:otherwise><p>😆</p></c:otherwise>
								              </c:choose>
								            </span>
								          </c:otherwise>
								        </c:choose>
								      </td>
				                        <!-- 사원이름+이모지  -->
				                        
				                       <!-- T.T-MI -->
										<td class="ttmi-col" title="${club.ttmiContent}">
										  <c:choose>
										    <c:when test="${club.emplNo == loginEmplNo}">
										      <!-- 본인이면 입력 가능 -->
										      <a href="#" data-bs-toggle="modal" data-bs-target="#100Modal">
										        <c:choose>
										          <c:when test="${not empty club.ttmiContent}">
										            <span class="ttmi-text">${club.ttmiContent}</span>
										          </c:when>
										          <c:otherwise>✍️ 등록하기</c:otherwise>
										        </c:choose>
										      </a>
										    </c:when>
										    <c:otherwise>
										      <!-- 타인이면 보기만 가능 -->
										      <span>
										        <c:choose>
										          <c:when test="${not empty club.ttmiContent}">
										            <span class="ttmi-text">${club.ttmiContent}</span>
										          </c:when>
										          <c:otherwise>🙈 아직 업데이트 하지 않았어요 ㅠ.ㅠ</c:otherwise>
										        </c:choose>
										      </span>
										    </c:otherwise>
										  </c:choose>
										</td>
				                        <!-- 오늘의 한 줄 -->
										<td class="today-col" title="${club.todayContent}">
										  <c:choose>
										    <c:when test="${club.emplNo == loginEmplNo}">
										      <a href="#" data-bs-toggle="modal" data-bs-target="#todayModal">
										        <c:choose>
										          <c:when test="${not empty club.todayContent}">
										            <span class="today-text">${club.todayContent}</span>
										          </c:when>
										          <c:otherwise>📝 작성 전</c:otherwise>
										        </c:choose>
										      </a>
										    </c:when>
										    <c:otherwise>
										      <span>
										        <c:choose>
										          <c:when test="${not empty club.todayContent}">
										            <span class="today-text">${club.todayContent}</span>
										          </c:when>
										          <c:otherwise>🙊 한 줄을 써주세요!!</c:otherwise>
										        </c:choose>
										      </span>
										    </c:otherwise>
										  </c:choose>
										</td>
				                      </tr>
				                      <tr class="club-row" 
								    data-profileimg="${club.profileImg}" 
								    data-emoji="${club.emoji}" 
								    data-ttmi="${fn:escapeXml(club.ttmiContent)}" 
								    data-today="${fn:escapeXml(club.todayContent)}"
								    data-emplnm="${club.emplNm}"></tr>
				                     </c:if>
  								  </c:forEach>
			                      <!-- end table row -->
			                    </tbody>
			                  </table>
			                  <!-- end table -->
			                  <!-- table 아래에 이거 추가 -->
								<div id="loader" style="text-align:center; display:none; padding: 1rem;">
								  <span>⏳ 불러오는 중...</span>
								</div>
			                </div>
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
			 <!-- 프로팔 사진  모달 시작  -->
			 <form id="profileImgForm" action="/comunity/insertProfile" method="post" enctype="multipart/form-data">
				<div class="modal fade" id="profileModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h1 class="modal-title fs-5" id="exampleModalLabel">Who am I?파일 선택</h1>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
						<div class="emoji-picker my-3">
						  <!-- 이모지 버튼이 여기에 동적으로 들어갈 예정 -->
						</div>				      
				        <div class="input-style-1">
				          <input type="file" id="hiddenProfileInput" name="uploadFile" accept=".jpg,.jpeg,.png,.gif,.webp" style="display:none" />
		                  <file-upload
								label="파일 1장만 업로드 할수있습니다."
								name="uploadFile"
								max-files="1"
								 accept=".jpg,.jpeg,.png,.gif,.webp"
								contextPath="${pageContext.request.contextPath}"
						></file-upload>
		                </div>
				      </div>
				      <div class="modal-footer">
				        <button type="button" id="profileResetBtn" class="btn btn-outline-danger btn-sm mt-2">선택 초기화</button>
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				        <button type="submit" class="btn btn-primary">Who am I? 사진 저장하기</button>
				      </div>	
				    </div>
				  </div> 
				</div>     
			</form>
			<!-- 가이드모달  -->
			<div class="modal fade" id="guideModal" tabindex="-1" aria-labelledby="guideModalLabel" aria-hidden="true">
			  <div class="modal-dialog modal-dialog-centered">
			    <div class="modal-content">
			
			
			      <div class="modal-header">
			        <h5 class="modal-title" id="guideModalLabel">
			          Welcome! 🥳 
			        </h5>
			      </div>
			
			      <div class="modal-body text-center">
			        <h4 id="guideStepTitle">1. Who am I? 사진 변경</h4>
			        <p id="guideStepDesc">Who am I? 사진을 클릭해서 변경할 수 있어요!</p>
			      </div>
			
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" id="closeGuide">닫기</button>
			        <button type="button" class="btn btn-primary" id="nextGuide">다음</button>
			      </div>
			
			    </div>
			  </div>
			</div>


			<!-- 가이드모달  -->
		</section>
		<%@ include file="../layout/footer.jsp"%>
	</main>
	<%@ include file="../layout/prescript.jsp"%>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function () {
	  const guideModal = new bootstrap.Modal(document.getElementById('guideModal'));
	  const nextGuideBtn = document.getElementById('nextGuide');
	  const closeGuideBtn = document.getElementById('closeGuide');
	  const progressBar = document.getElementById('guideProgressBar');
	  const progressText = document.getElementById('progressText');
	  const stepTitle = document.getElementById('guideStepTitle');
	  const stepDesc = document.getElementById('guideStepDesc');

	  const steps = [
	    {
	      title: "1. Who am I? 변경",
	      desc: "Who am I? 사진을 클릭해서 변경할 수 있어요!"
	    },
	    {
	      title: "2. 이모지 등록",
	      desc: "오늘 기분을 이름 옆 이모지를 클릭해서 변경 할 수 있어요!"
	    },
	    {
	      title: "3. T.T-MI 작성",
	      desc: "200문 200답! 하루에 랜덤으로 올라오는\n 당신만의 이야기를 적어주세요!"
	    },
	    {
	      title: "4. 오늘의 한 줄",
	      desc: "오늘 하루를 시작하거나 마무리하 는 한 마디를 남겨주세요!"
	    },
	    {
	      title: "5. 모든 기능 사용법",
	      desc: "모든 기능은 상단 고정되어있는 자신의 게시글을\n 클릭하여 수정 할 수 있어요."
	    }
	  ];

	  let currentStep = 0;

	  function showStep() {
	    stepTitle.innerText = steps[currentStep].title;
	    stepDesc.innerText = steps[currentStep].desc;

	    const percent = ((currentStep + 1) / steps.length) * 100;
	    progressBar.style.width = `${percent}%`;
	    progressText.textContent = `(${currentStep + 1}/${steps.length})`;
	  }

	  nextGuideBtn.addEventListener('click', function () {
	    currentStep++;
	    if (currentStep < steps.length) {
	      showStep();
	    } else {
	      guideModal.hide();
	    }
	  });

	  closeGuideBtn.addEventListener('click', function () {
	    guideModal.hide();
	  });

	  // 처음 모달 띄우고 1번 스텝 보여주기
	  guideModal.show();
	  showStep();
	});


</script>
</body>
<style>
/* 테이블 헤더 스타일 */
/* 공통: td, th 말줄임 처리 */
td, th {
  max-width: 240px;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
  word-break: break-word;
}
/* 테이블 스타일 */
.table {
  table-layout: fixed;
  width: 100%;
}
/* 테이블 헤더 스타일 */	
.table th {
  min-width: 100px;
}
/* 테이블 헤더 고정 및 스타일 */
.table-wrapper {
  overflow-x: auto;
  overflow-y: visible; 
  position: relative; 
  max-height: 800px;
}
/* 헤더 스타일 정리 - 겹침 방지용 */
.table-wrapper thead th {
  position: sticky;
  top: 0;
  background-color: #ffffff; /* 또는 연회색 #f1f3f5 */
  z-index: 5;
  border-bottom: 2px solid #ccc;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.06); /* 살짝 그림자 */
}
/* 필요 시 tbody의 셀 테두리 정리 */
.table-wrapper tbody td {
  border-top: 1px solid #e9ecef;
}

/* 툴팁 스타일 */
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

/* 이모지 버튼 스타일 */
.emoji-btn {
  position: relative;
  transition: all 0.2s;
}
/*이모지 버튼 스타일- selected  */
.emoji-btn.selected {
  background-color: #e8f0fe !important;
  border: 2px solid #365CF5;
  box-shadow: 0 0 6px rgba(54, 92, 245, 0.4);
}
/*이모지 버튼 스타일 -selected > after  */
.emoji-btn.selected::after {
  content: "✔";
  position: absolute;
  top: -5px;
  right: -5px;
  background: #365CF5;
  color: white;
  font-size: 0.65rem;
  padding: 2px 4px;
  border-radius: 50%;
  font-weight: bold;
  box-shadow: 0 0 3px rgba(0,0,0,0.2);
}

/* T.T-MI 칸 - 말줄임 처리 */
.ttmi-col .ttmi-text {
  display: inline-block;
  max-width: 220px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  vertical-align: bottom;
}
/* 오늘의 한 줄 칸 - 말줄임 처리 */
.today-col .today-text {
  display: inline-block;
  max-width: 240px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.guide-step {
  text-align: center;
}
.d-none {
  display: none !important;
}
</style>

<!--파일 및 이모지  -->
<script type="text/javascript">
	function emptyFile(){
		console.log("emptyFile----",this);
	}

	

/* 파일이 존재 할 때. Who am I?이미지 변경  */
const fileInput = document.getElementById('hiddenProfileInput');
fileInput.addEventListener('change', function () {
  const loginEmplNo = '${loginEmplNo}'; // 서버에서 넘겨준 본인 사번
  const currentEmplNo = loginEmplNo;    // 여기는 고정 (지금은 내 것만 가능)

  if (this.files.length > 0) {
    if (currentEmplNo !== loginEmplNo) {
    	
    	 swal({
             title: "!!!!!!!",
             text: "타인의 사진은 변경 할 수 없습니다.",
             icon: "danger",
             button: "확인"
           });
    	
      return;
    }
    document.getElementById('profileImgForm').submit();
  }
});

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

  emojiContainer.innerHTML = '';

  Emojis.forEach(emoji => {
    const button = document.createElement('button');
    button.type = 'button';
    button.className = 'btn btn-light m-1 emoji-btn';
    button.style.fontSize = '1rem';
    button.textContent = emoji;

    // ✅ 중첩 없이 이벤트 1번만 등록
    button.addEventListener('click', () => {
    	const currentText = emojiTextArea.value;
    	const emojiArray = Array.from(currentText);
	
      // 선택 해제 (토글)
      if (button.classList.contains('selected')) {
        button.classList.remove('selected');
        emojiArray = emojiArray.filter(e => e !== emoji);
        emojiTextArea.value = emojiArray.join('');
        return;
      }

      // 최대 3개 제한
      if (emojiArray.length >= 5) {
        swal({
          title: "⚠️ 제한 초과",
          text: "이모지는 최대 3개까지만 선택할 수 있어요!",
          icon: "warning",
          button: "확인"
        });
        return;
      }

      // 선택 처리
      emojiTextArea.value += emoji;
      emojiTextArea.focus();
    });

    // ✅ appendChild는 반드시 forEach 바깥에서 실행
    emojiContainer.appendChild(button);
  });

  // ✅ 초기화 버튼도 정리
  if (resetButton && emojiTextArea) {
    resetButton.addEventListener('click', () => {
      emojiTextArea.value = "";
      document.querySelectorAll('.emoji-btn.selected')
        .forEach(btn => btn.classList.remove('selected'));
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
