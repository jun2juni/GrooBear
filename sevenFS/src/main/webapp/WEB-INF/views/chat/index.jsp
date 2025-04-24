<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="채팅" />
<fmt:setLocale value="ko_KR" />
<fmt:setTimeZone value="Asia/Seoul" />
<c:set var="now" value="<%= new java.util.Date() %>" />
<c:set var="yesterday" value="<%= new java.util.Date(System.currentTimeMillis() - 86400000) %>" />

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
  
  <style>
      a {
          text-decoration: none;
      }

      .chat-avatar {
          width: 45px;
		  height: 45px;
      }

      #chatList {
          min-height: 64vh;
          max-height: 64vh;
          overflow-x: hidden; /* 가로 스크롤 활성화 */
          /*overflow-y: scroll; !* 세로 스크롤 숨김 *!*/
      }
	  
	  #chatRoomList {
          min-height: 76.2vh;
          max-height: 76.2vh;
          overflow-x: hidden; /* 가로 스크롤 활성화 */
          overflow-y: scroll; /* 세로 스크롤 숨김 */
	  }
	  
	  #orgList {
          max-height: 79vh;
          overflow-x: hidden; /* 가로 스크롤 활성화 */
          overflow-y: scroll; /* 세로 스크롤 숨김 */
	  }

      /*#chatRoomList::-webkit-scrollbar {*/
		/*  display: none;*/
	  /*}*/
	  
      /* ( 크롬, 사파리, 오페라, 엣지 ) 동작 */
      #chatList::-webkit-scrollbar-track-piece,
      #chatRoomList::-webkit-scrollbar-track-piece {
          display: none;
      }

      .text-truncate-2 {
          text-overflow: ellipsis;
          text-wrap: wrap;
          -webkit-line-clamp: 2;
          -webkit-box-orient: vertical;
          overflow: hidden;
          display: -webkit-box;
      }
	  
	  #chat .chat-message img {
		  min-height: 140px;
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
		
	  	<div class="col-md-9">
		  <div class="" id="chat3">
			
			  <div class="row">
				<div class="col-md-5">
				  <div>
					<%--채팅방 목록--%>
					<ul id="chatRoomList" class="list-unstyled mb-0 card card-body">
					  <c:forEach var="chatRoom" items="${chatRoomVOList}">
						<li class="p-2 rounded border-bottom chatRoom" data-chtt-room-no="${chatRoom.chttRoomNo}" data-target-empl-no="${chatRoom.targetEmplNo}">
						  <div class="d-flex justify-content-between text-truncate" style="cursor: pointer">
							<div class="d-flex flex-row">
								<%-- 채팅방 상대 이미지 --%>
							  <div>
								  <%--채팅방 이미지--%>
								<img src="/upload/${chatRoom.proflPhotoUrl}"
									alt="avatar" class="d-flex align-self-center me-3 rounded-circle chat-avatar"
									onerror="this.src='/assets/images/image-error.png'"
								>
								<span class="badge bg-success badge-dot"></span>
							  </div>
								
								<%-- 채티방 이름 마지막 메세지 --%>
							  <div>
								<p class="fw-bold mb-0">
									${chatRoom.chttRoomTy == '0' ? chatRoom.emplNm : chatRoom.chttRoomNm}
									  <span class="text-xs fw-normal text-gray">[${chatRoom.deptNm}, ${chatRoom.clsfNm}]</span>
								</p>
								<p class="chat-last-msg small text-muted text-truncate-2">
									${empty chatRoom.lastMsg ?
									  "대화 내용 없음" : chatRoom.mssageTy == "1" ?
									  "사진을 보냈습니다."
									  : chatRoom.mssageTy == "2" ?
									  "파일을 보냈습니다."
									   : chatRoom.lastMsg}
								</p>
							  </div>
							</div>
							<div>
								<%-- 마지막 보낸 메세지 시간 --%>
							  <p class="chat-create-date small text-muted mb-1">
								<c:choose>
								  <%-- 오늘이면 시간만 표시 --%>
								  <c:when test="${fn:substring(chatRoom.chttCreatDt, 0, 10) == fn:substring(now, 0, 10)}">
									<fmt:formatDate value="${chatRoom.chttCreatDt}" pattern="HH:mm" />
								  </c:when>
								  
								  <%-- 전날이면 날짜만 표시 --%>
								  <c:when
									  test="${fn:substring(chatRoom.chttCreatDt, 0, 4) == fn:substring(yesterday, 0, 4)}">
									<fmt:formatDate value="${chatRoom.chttCreatDt}" pattern="MM.dd" />
								  </c:when>
								  
								  <%-- 전날이면 날짜만 표시 --%>
								  <c:when
									  test="${fn:substring(chatRoom.chttCreatDt, 0, 4) != fn:substring(yesterday, 0, 4)}">
									<fmt:formatDate value="${chatRoom.chttCreatDt}" pattern="yyyy.MM.dd" />
								  </c:when>
								  
								  <%-- 그 외 날짜+시간 표시 --%>
								  <c:otherwise>
									<fmt:formatDate value="${chatRoom.chttCreatDt}" pattern="yyyy.MM.dd HH:mm" />
								  </c:otherwise>
								</c:choose>
							  </p>
							  
							  <%-- 채팅 안 읽은 카운트 --%>
							  <span class="read-badge badge bg-danger rounded-pill float-end ${chatRoom.readCount != 0 ? '' :  'd-none'}">
								  ${chatRoom.readCount}
							  </span>
							</div>
						  </div>
						</li>
					  </c:forEach>
					</ul>
				  </div>
				</div>
				
				<div id="chat-no" class="col-7 card card-body">
				  <div class="card text-center py-5">
					<div class="card-body">
					  <h5 class="card-title mt-3">선택한 채팅방이 없습니다</h5>
					  <p class="card-text text-muted">채팅방을 선택해주세요.</p>
					</div>
				  </div>
				</div>
				
				<div id="chat" class="col-7 position-relative card card-body d-flex justify-content-between d-none">
				  <div id="chatList" class="pt-3 pe-3">
					<div id="loader" class="d-none text-center">
					  <div class="spinner-border" role="status">
						<span class="visually-hidden">Loading...</span>
					  </div>
					</div>
					
					<%-- 옵저버 블록 --%>
					<div id="observerBlock"></div>
					<%-- 채팅 온경우 알림 --%>
					<div class="mx-2 mb-4 p-2 rounded-2 bg-warning-400 text-center">마지막 채팅입니다.</div>
					
					<%--진짜 채팅이 들어가느 구간--%>
					<div id="realChatList"></div>
					
					<div id="chatInnerAlert"
						 class="position-absolute left-0 mx-2 my-4 px-3 py-2 rounded-2
								bg-warning-400 text-truncate d-flex justify-content-between
								align-items-center d-none"
						 style="width: calc(100% - 4rem);
															bottom: 60px;
															cursor: pointer;"
						 onclick="document.querySelector('#chatList').scrollTop = document.querySelector('#chatList').scrollHeight">
						<span class="content text-truncate me-2" style="flex-grow: 1;">
							채팅 내용이 여기 들어갈거임 (클릭하면 제일 밑으로 내려감) 채팅 내용이 여기 들어갈거임 (클릭하면 제일 밑으로 내려감)
						</span>
					  <span>&darr;</span> <!-- 아래 화살표 추가 -->
					</div>
					
					<div id="alertObserverBlock"></div>
				  </div>
				  
				  <%--채팅 발송 부분 --%>
				  <div class="text-muted d-flex justify-content-start align-items-center pe-3 pt-3 mt-2 mb-2 gap-3">
					<input type="text" class="form-control form-control-lg" id="messageInput" placeholder="메세지를 입력해주세요." />
					<%--파일--%>
					<label for="uploadFiles" style="cursor: pointer">
					  <span class="material-symbols-outlined">attach_file</span>
					</label>
					
					<%-- 숨겨진 파일 인풋 --%>
					<input type="file" name="uploadFiles" id="uploadFiles" class="d-none">
					<a id="submitMessage" class="text-muted" href="#!">
					  <span class="material-symbols-outlined">arrow_upward</span>
					</a>
					
					
				  </div>
				</div>
			  </div>
		  </div>
		</div>

		
		<div class="col-3">
		  <div class="card">
			<div class="p-1 pb-3">
			  <c:import url="../organization/searchBar.jsp" />
			</div>
			<div id="orgList" class="card-body mt-3">
			  <c:import url="../organization/orgList.jsp" />
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
  let prevChatRoomNo = null;
  
  window.onload = function() {
	let chatRoomNo = "${param.get("chatRoomNo")}"
    // 채팅 무한 스크롤
    let chatList = document.querySelector("#chatList");
    let observerBlock = document.querySelector("#observerBlock");
    let scrollHeight = chatList.scrollHeight;

    let intersectionObserver = new IntersectionObserver(async (entries) => {
      if(entries[0].intersectionRatio > 0) {
        // 마지막 채팅인 경우 넘기기
        // 채팅 30개씩 가져오기
        console.log("여기가 옵저버 만나면 발동!~");

        // 여기서 채팅 목록 받아오기
        // buildChatMessage(observerBlock, {});

        // 메시지가 추가된 후 스크롤을 맨 아래로 이동
        // 현재 스크롤 위치와 전체 높이를 비교하여, 사용자가 스크롤을 맨 아래로 안 내린 경우에는 위치를 그대로 유지


        // 채팅 불러온 경우 지금 보던 스크롤 위치 고정
        // if(!chatList) return;
        // const currentScrollHeight = chatList.scrollHeight;
        // chatList.scrollTop = currentScrollHeight - scrollHeight;
        //
        // scrollHeight = currentScrollHeight;
      }
    });
    intersectionObserver.observe(observerBlock);

    let intersectionObserver2 = new IntersectionObserver(async (entries) => {
      if(entries[0].intersectionRatio > 0) {
        document.querySelector("#chatInnerAlert").classList.add("d-none");
      }
    });

    // 옵저버 설정
    intersectionObserver2.observe(document.querySelector("#alertObserverBlock"));

    // 채팅방 클릭
	
    document.querySelectorAll(".chatRoom").forEach(dom => {
      dom.addEventListener("click", (e) => chatRoomClick(e, dom))
      
	  if (dom.dataset.chttRoomNo == chatRoomNo) {
      	dom.click()
	  }
    })
  }
  
  async function chatRoomClick(e, dom) {
    e.stopPropagation();
    const chttRoomNo = dom.dataset.chttRoomNo; // this는 li 요소를 가리킴
    const targetEmplNo = dom.dataset.targetEmplNo; // this는 li 요소를 가리킴
    document.querySelector("#realChatList").innerHTML = ""; // 전에 보던 메세지 삭제
    // 채팅방 커넥션 끊고
    disconnectWebSocket({chttRoomNo: prevChatRoomNo}); // 나가는 채팅방 연결 끊기

    // 채팅창 비 활성화
    document.querySelectorAll(".chatRoom").forEach((dom) => {
      dom.classList.remove("bg-body-secondary");
    })

    if(chttRoomNo === prevChatRoomNo) {
      // 채팅창 비활성 화
      document.querySelector("#chat").classList.add("d-none");
      document.querySelector("#chat-no").classList.remove("d-none");
      prevChatRoomNo = null;
      return;
    }

    // 뱃지 데이터 초기화
    dom.querySelector(".read-badge").innerHTML = "0";
    dom.querySelector(".read-badge").classList.add("d-none");
	
    // await getLastMsgInfo({chttRoomNo, targetEmplNo});
    await getChatMessage({chttRoomNo, targetEmplNo}); // 이전 메세지 가져오기
	// await
    chatWebSocketConnect({chttRoomNo}); // 들어가는 채팅방 연결

    prevChatRoomNo = chttRoomNo; // 현재 채팅방 번호
    dom.classList.add("bg-body-secondary");
  }

  // 사원채팅방 클릭 시 만들기
  function dbClickEmp(data) {
	// 채팅방이 이미 있는 경우는 채팅방 열기
	// 채팅 보내는 사원 넘버 넘기기
	// 채팅방이 이미 있는지 확인
    fetch("/chat/roomInsert?targetEmplNo=" + data.id)
      .then((res) => res.json())
      .then((data) => {
        console.log(data)
		
		if (data.invalidChatRoom !== 0) {
		  // 채팅방 열기
          document.querySelectorAll(".chatRoom").forEach((item) => {
            let chttRoomNo = item.dataset.chttRoomNo;
            if (chttRoomNo == data.invalidChatRoom) {
              item.click();
            }
          })
		}

    	// 채팅방 추가하기
		if (data.chatRoom) {
          console.log(data.chatRoom)
      		let chatRoom = data.chatRoom;
      		let html = `
				<li class="p-2 rounded border-bottom chatRoom" data-chtt-room-no="\${chatRoom.chttRoomNo}">
				  <div class="d-flex justify-content-between text-truncate" style="cursor: pointer">
					<div class="d-flex flex-row">
					  <%-- 채팅방 상대 이미지 --%>
					  <div>
						<%--채팅방 이미지--%>
						<img src="/upload/\${chatRoom.proflPhotoUrl}"
							 alt="avatar" class="d-flex align-self-center me-3 rounded-circle chat-avatar"
							 onerror="this.src='/assets/images/image-error.png'"
						>
						<span class="badge bg-success badge-dot"></span>
					  </div>
					  
					  <%-- 채티방 이름 마지막 메세지 --%>
					  <div>
						<p class="fw-bold mb-0">
						  \${chatRoom.emplNm}
						</p>
						<p class="chat-last-msg small text-muted text-truncate-2">
						  대화 내용 없음
						</p>
					  </div>
					</div>
					<div>
					  <%-- 마지막 보낸 메세지 시간 --%>
					  <p class="chat-create-date small text-muted mb-1">
						\${formatDate(new Date(), "HH:mm")}
					  </p>
					  <%-- 채팅 안 읽은 카운트 --%>
					  <span class="read-badge badge bg-danger rounded-pill float-end d-none">0</span>
					</div>
				  </div>
				</li>
      		`;
            
            document.querySelector("#chatRoomList").insertAdjacentHTML("afterbegin", html);
            let dom = document.querySelector(".chatRoom");
          	dom.addEventListener("click", (e) => chatRoomClick(e, dom))
          	dom.click();
		}


    
      })
  }

  function dbClickDept(data) {
    // 부서 채팅방
	// 부서 채팅방은 없음
    // console.log(data);
  }

  function getChatMessage({chttRoomNo}) {
    // 로그인된 사용자
    fetch(`/chat/messageList?chttRoomNo=\${chttRoomNo}&emplNo=${myEmpInfo.emplNo}`)
      .then((res) => res.json())
      .then((result) => {
        // console.log(result);
        if(result != null) {
          result.forEach((message) => {
            buildChatMessage(document.querySelector("#realChatList"), {message});
          })
        }
      })
      .catch((error) => {
        console.error(error);
      })
      .finally(() => {
        submitMessage({messageValue: "읽었당~", chttRoomNo, emplNo: "${myEmpInfo.emplNo}", type: "READ"});
        setTimeout(() => {
          let chatList = document.querySelector("#chatList");

          document.querySelector("#chat-no").classList.add("d-none");
          document.querySelector("#chat").classList.remove("d-none");
          chatList.scrollTop = chatList.scrollHeight; // 채팅 밑으로 내리기
		}, 100)
      })
  }

</script>
</body>
</html>
