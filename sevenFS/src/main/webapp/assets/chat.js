const RECONNECT_INTERVAL = 5000; // 5초 후 재연결 시도
const TALK = "TALK";
const FILE = "FILE";
const IMAGE = "IMAGE";
const READ = "READ";
const NOTIFICATION = "NOTIFICATION";

let stompClientMap = {}; //
let isSubscribedMap = {}; // 구독 중인지 확인
// let emp = null; // 이거 바꿔야 함 (진짜 empNo로)
// 임시로 사용

// 알림 클래스
class Alert {
  dom = null;
  constructor(dom) {
      this.dom = dom;
  }

  setMessage({title, sender, content}) {
    this.dom.querySelector(".toast-header .alert-title").textContent = title;
    this.dom.querySelector(".toast-header .alert-sender").textContent = sender ?? "";
    this.dom.querySelector(".toast-body").textContent = content;
  }

  show() {
    const toastBootstrap = bootstrap.Toast.getOrCreateInstance(this.dom);
    toastBootstrap.show();
  }
}

document.addEventListener("DOMContentLoaded", function() {
  let infoAlert = new Alert(document.getElementById('infoSuccess'));
  // 내 계정 알림 구독
  connectWebSocket({
    roomPath: "alert/room",
    chttRoomNo: emp.emplNo,
    receiveMessage: (message) => {
      if (message.type === TALK) {
       chatAlert(message, infoAlert);
      }

      if (message.type === NOTIFICATION) {
        console.log("알림 확인 하기", message)
        infoAlert.setMessage({
          title: message.ntcnSj,
          content: message.ntcnCn
        })
        infoAlert.show();

        document.querySelector("#notificationList").insertAdjacentHTML("afterbegin", buildNotification(message));
      }
    }
  });

  // 메시지 전송 이벤트 등록
  let submitMessageDom = document.querySelector("#submitMessage");
  if(submitMessageDom) {
    let messageInput = document.querySelector("#messageInput");
    messageInput.addEventListener("keyup", (e) => {
      let value = e.target.value;

      // 채팅을 입력하면 전송 버튼 활성화
      if(value.length > 0) {
        submitMessageDom.classList.add("text-primary");
      } else {
        submitMessageDom.classList.remove("text-primary");
      }

      if(e.keyCode === 13) { // 엔터 친 겨우
        let chttRoomNo = findOpenChatRoomNo();

        submitMessage({
          messageValue: messageInput.value,
          chttRoomNo,
          type: TALK,
          emplNo: emp.emplNo
        });
        messageInput.value = "";
      }
    })

    submitMessageDom.addEventListener("click", () => {
      let chttRoomNo = findOpenChatRoomNo();

      submitMessage({
        messageValue: messageInput.value,
        chttRoomNo,
        type: TALK,
        emplNo: emp.emplNo
      });
      messageInput.value = "";
    });

    // #기능
    let prevKey = null;
    messageInput.addEventListener("keydown", (e) => {
      // 15 => shift 51 => #
      if (prevKey === 16 && e.keyCode === 51) {
        console.log("shift + #")
        // 여기서
      } else {

      }

      prevKey = e.keyCode;
    })
  }

  // 메세지 파일 업로드
  let uploadFiles = document.querySelector("#uploadFiles");
  if (uploadFiles) {
    uploadFiles.addEventListener("change", async (e) => {
      let files = e.target.files
      if(files.length > 0) {
        const formData = new FormData();
        for(const file of files) {
          formData.append("uploadFiles", file);
        }

        const response = await fetch("/message/file", {
          method: "POST",
          body: formData
        })

        const data = await response.json();

        let chttRoomNo = findOpenChatRoomNo();

        submitMessage({
          messageValue: data.attachFileVO.fileStrePath,
          chttRoomNo,
          type: data.attachFileVO.fileMime.includes("image") ? IMAGE : FILE,
          emplNo: emp.emplNo
        });

        e.target.value = null;
      }
    })
  }
});

/**
 *
 * @param chttRoomNo - 채팅방 id
 * @param messageSend - 메세지 보내는 JSON
 * @param receiveMessage - 메세지 받고 실행
 */
function connectWebSocket({roomPath = "chat/room", chttRoomNo, receiveMessage}) {
  let stompClient = stompClientMap[chttRoomNo];
  let isSubscribed = isSubscribedMap[chttRoomNo];
  if(stompClient) {
    stompClient.disconnect();
    stompClient = null;
    isSubscribed = false;
  }
  // localhost
  const socket = new SockJS("http://localhost/ws");
  const client = Stomp.over(socket);
  client.debug = null;

  client.connect(
    {},
    () => {
      stompClientMap[chttRoomNo] = client;
      if(!isSubscribed) {
        console.log("웹소켓 연결 성공! => " + roomPath + "/" + chttRoomNo);

        client.subscribe(`/sub/${roomPath}/${chttRoomNo}`, (message) => {
          const newMessage = JSON.parse(message.body);
          receiveMessage(newMessage);
        });

        isSubscribedMap[chttRoomNo] = true;
      }
    },
    (error) => {
      console.error("웹소켓 연결 실패:", error);
      setTimeout(() => connectWebSocket({roomPath, chttRoomNo, receiveMessage}), RECONNECT_INTERVAL);
    }
  );

  client.onclose = () => {
    console.warn("웹소켓 연결 종료됨. 재연결 시도...");
    setTimeout(() => connectWebSocket({roomPath, chttRoomNo, receiveMessage}), RECONNECT_INTERVAL);
  };
}

// 웹소켓 끊기
function disconnectWebSocket({chttRoomNo}) {
  console.log("웹소켓 연결 끊기! => " + chttRoomNo);

  if (stompClientMap[chttRoomNo]) {
    stompClientMap[chttRoomNo].disconnect();
  }
}

// 채팅 웹 소켓 연결 함수
function chatWebSocketConnect({chttRoomNo}) {
  connectWebSocket({
    roomPath: "chat/room",
    chttRoomNo, receiveMessage: (message) => {

      // 내가 보낸 메세지는 안받기
      if(emp.emplNo === message.mssageWritngEmpno) return;
      // 여기는 알림
      console.log(message, "recevide" + chttRoomNo);

      // 보고 있는경우
      // 읽음처리 하기
      document.querySelectorAll(".read-count-badge").forEach((dom) => dom.remove());
      if (message.type === READ) {
        return;
      }

      // 보고 있는경우 상대방 채팅 읽음 처리해주기
      // message.type = READ;
      // message.mssageWritngEmpno = emp.emplNo; // 내 번호로 변경
      // stompClientMap[chttRoomNo]?.send(`/pub/chat/reading`, {}, JSON.stringify(message));

      buildChatMessage(
        document.querySelector("#realChatList"),
        {message}
      );

      // 채팅 보고 있는 화면이 맨 밑이 아닌경우
      let chatList = document.querySelector("#chatList");
      if (chatList.scrollHeight - chatList.scrollTop > 1200) {
        // 보고 있는 채팅방인 경우 채팅방 하단에 알림 뜨게 만들기
        document.querySelector("#chatInnerAlert").classList.remove("d-none");
        document.querySelector("#chatInnerAlert .content").innerHTML = message.mssageCn;
      } else {
        chatList.scrollTop = chatList.scrollHeight;
      }
    }
  });
}

function submitMessage({messageValue, type, chttRoomNo, emplNo}) {
  // 채팅 입력한게 없으면 채팅 안보내지게
  if(messageValue.length <= 0) return;

  if(!stompClientMap[chttRoomNo]) {
    console.warn("웹소켓이 아직 연결되지 않았습니다.");
    return;
  }

  const message = {
    type,
    chttRoomNo,
    mssageWritngEmpno: emplNo,
    emplNm: emp.emplNM,
    proflPhotoUrl: emp.proflPhotoUrl,
    mssageCn: messageValue,
    mssageCreatDt: new Date(),
    bPrevChat: false,
  };

  stompClientMap[chttRoomNo]?.send(`/pub/chat/message`, {}, JSON.stringify(message));

  if (type === READ) return;

  // 채팅방 목록 텍스트도 변경
  document.querySelectorAll(".chatRoom").forEach((dom) => {
    if (dom.dataset.chttRoomNo === chttRoomNo) {
      dom.querySelector(".chat-last-msg").innerHTML = messageValue;
    }
  })

  message.read = true;
  buildChatMessage(
    document.querySelector("#realChatList"),
    {message}
  );

  setTimeout(() => {
    let chatList = document.querySelector("#chatList");
    chatList.scrollTop = chatList.scrollHeight; // 채팅 밑으로 내리기
  }, 100)
}

/**
 * @param dom - 채팅이 들어갈 dom
 * @param message - 메세지 넘버
 * --- 하단 내용 message에 들어간 내용
 *             mssageCn - 메세지
 *             emplNo - 나의 no
 *             empName - 사용자 이름
 *             created - 메세지 보낸 시간
 *             bPrevChat - 이전 채팅 내역
 */
function buildChatMessage(dom, {message}) {
  // 보내는 사람이랑 받는 사람이 같은 경우는 내가보낸 것
  const messageHTML = message.mssageWritngEmpno === emp.emplNo ? `
      <div class="d-flex flex-row justify-content-end">
          <div class="chat-message text-end d-flex flex-column align-items-end" style="width: 80%">
              <p class="small me-4" style="font-size: 14px">${message.emplNm}</p>
              <div class="d-flex justify-content-end align-items-end me-3 mb-1">
                  <!-- 안읽은것만 -->
                  ${message.read ? `<span class="read-count-badge me-1 badge text-bg-warning" style="height: 18px;color: white !important;font-size: 10px;">1</span>` : ''}
                  ${ message.type === TALK ? 
                    `<p class="small p-2 text-white rounded-3 bg-primary" style="width: fit-content">${message.mssageCn}</p>`
                    : message.type === FILE ?
                      `<p class="small p-2 text-white rounded-3 bg-primary" style="width: fit-content">
                          <span>${message.mssageCn}</span>
                          <a class="float-end mt-2 text-white p-1 rounded d-flex align-items-center justify-content-center" href="/download?fileName=${message.mssageCn}" style="background: rgba(255, 255, 255, 0.2); transition: background 0.2s; width: 32px; height: 32px;">
                            <span class="material-symbols-outlined" style="font-size: 1.2rem;">
                              download
                            </span>
                          </a>  
                       </p>`
                    : `<img src="/upload/${message.mssageCn}" class="rounded float-start w-50" alt"프로필 이미지" onerror="this.src='/assets/images/image-error.png'" >`}
                  </div>
              <p class="small me-3 mb-3 rounded-3 text-muted" style="font-size: 14px">${formatDate(new Date(message.mssageCreatDt))}</p>
          </div>
          <img src="/upload/${message.proflPhotoUrl}"
               onerror="this.src='/assets/images/image-error.png'"
               alt="avatar 1" class="chat-avatar rounded-circle" style="height: 45px">
      </div>
  ` // 보낸 메세지
    : // 받은 메세지
    `
      <div class="d-flex flex-row justify-content-start">
          <img src="/upload/${message.proflPhotoUrl}"
               onerror="this.src='/assets/images/image-error.png'"
               alt="avatar 1" class="chat-avatar rounded-circle" style="height: 45px;">
          <div class="chat-message d-flex flex-column align-items-start" style="width: 80%">
              <p class="small ms-4" style="font-size: 14px">${message.emplNm}</p>
              <div class="d-flex justify-content-start align-items-end ms-3 mb-1">
                ${ message.type === TALK ?
                    `<p class="small p-2 rounded-3 bg-body-secondary">${message.mssageCn}</p>`
                  : message.type === FILE ?
                    `<p class="small p-2 rounded-3 bg-body-secondary">
                        <span>${message.mssageCn}</span>
                          <a class="float-left mt-2 text-black p-1 rounded d-flex align-items-center justify-content-center" href="/download?fileName=${message.mssageCn}" style="background: rgba(0, 0, 0, 0.2); transition: background 0.2s; width: 32px; height: 32px;">
                            <span class="material-symbols-outlined" style="font-size: 1.2rem;">
                              download
                            </span>
                          </a>  
                     </p>`
                  : `<img src="/upload/${message.mssageCn}" class="rounded float-start w-50" alt="프로필 이미지" onerror="this.src='/assets/images/image-error.png'">`}
              </div>
              <p class="small ms-3 mb-3 rounded-3 text-muted float-end" style="font-size: 14px">${formatDate(new Date(message.mssageCreatDt))}</p>
          </div>
      </div>
  `;


  // observerBlock 뒤에 메시지 추가
  if(!message.bPrevChat) {
    // 새로 추가된 채팅
    dom.insertAdjacentHTML("beforeend", messageHTML);
  } else {
    // 이전 채팅
    dom.insertAdjacentHTML("afterend", messageHTML);
  }
}

function findOpenChatRoomNo() {
  let chttRoomNo = 0;
  document.querySelectorAll(".chatRoom").forEach((dom) => {
    if (dom.classList.contains("bg-body-secondary")) {
      chttRoomNo = dom.dataset.chttRoomNo;
    }
  })

  return chttRoomNo;
}

function formatDate(date, format = "yyyy-MM-dd HH:mm") {
  if (!(date instanceof Date)) date = new Date(date); // 문자열 또는 숫자일 경우 Date 객체로 변환

  const pad = (num) => String(num).padStart(2, "0");

  const year = date.getFullYear();
  const month = pad(date.getMonth() + 1);
  const day = pad(date.getDate());
  const hour = pad(date.getHours());
  const minute = pad(date.getMinutes());

  return format
    .replace("yyyy", year)
    .replace("MM", month)
    .replace("dd", day)
    .replace("HH", hour)
    .replace("mm", minute);
}

function chatAlert(message, infoAlert) {
  let bFocus = true;
  // 채팅 화면에 들어와 있는 경우
  for (const dom of document.querySelectorAll(".chatRoom")) {
    bFocus = false;
    // 내가 보고 있는 채팅방이 아닌 경우
    if (!dom.classList.contains("bg-body-secondary") && dom.dataset.chttRoomNo == message.chttRoomNo) {
      let badgeDom = dom.querySelector(".read-badge");
      let chatLastMsgDom = dom.querySelector(".chat-last-msg");
      let chatCreateDateDom = dom.querySelector(".chat-create-date");

      badgeDom.classList.remove("d-none");
      badgeDom.innerHTML = Number(badgeDom.innerHTML) + 1; // 알림 카운트
      chatLastMsgDom.innerHTML = message?.mssageCn ?? "내용 없음"; // 채팅 내용
      chatCreateDateDom.innerHTML = formatDate(message?.createDate ?? new Date(), "HH:mm"); // 채팅 받은 시간
      break; // 루프 중단
    }
  }

  // 채팅방 화면을 안보고 있는 경우만 알림 활성 화
  if (bFocus) {
    document.querySelector("#messageNoti span").classList.remove("d-none");
    document.querySelector("#chatNotification .alert").classList.add("d-none");
    infoAlert.setMessage({
      title: `${message.emplNm ?? "마동석"} 님이 보냈습니다.`,
      content: message.mssageCn
    });
    // 내가 보낸 메세지는 안받기
    infoAlert.show();

    let alertChatNoList = []
    document.querySelectorAll("#chatNotification li").forEach((item) => {
      alertChatNoList.push(item.dataset.chatRoomNo);
    })

    if (alertChatNoList.includes(message.chttRoomNo + "")) {
      // 이미 있는 채팅방인 경우는 내용만 수정
      let findDom = document.querySelectorAll("#chatNotification li")[alertChatNoList.indexOf(message.chttRoomNo + "")];

      findDom.querySelector(".content").innerHTML = `
                  <div class="content">
                    <h6>${message.emplNm}</h6>
                    <p>${message.mssageCn}</p>
                    <span>${formatDate(message.mssageCreatDt)}</span>
                  </div>
            `;
    } else {
      document.querySelector("#chatNotification").innerHTML += `
          <li data-chat-room-no="${message.chttRoomNo}">
            <a href="/chat/list?chatRoomNo=${message.chttRoomNo}" target="_blank">
              <div class="image">
                <img class="rounded-circle" src="${message.proflPhotoUrl}" alt="채팅방 메인 이미지" onerror="this.src='/assets/images/image-error.png'" />
              </div>
              <div class="content">
                <h6>${message.emplNm}</h6>
                <p>${message.mssageCn}</p>
                <span>${formatDate(message.mssageCreatDt)}</span>
              </div>
            </a>
          </li>
        `
    }

  }
}

function readNotification(ntcnSn) {
  console.log(ntcnSn, emp.emplNo)
  fetch("/notification/readNotification",  {
    method: "post",
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
        "ntcnSn": ntcnSn
    })
  })
}

function getNotification() {
  fetch("/getNotification")
    .then(res => res.json())
    .then((result) => {
      // console.log(result.chatList);
      // console.log(result.notification);

      // 읽지 않은 채팅이 있는 경우
      if (result.chatList.length > 0) {
        document.querySelector("#messageNoti span").classList.remove("d-none");
        document.querySelector("#chatNotification .alert").classList.add("d-none");

        for(const chat of result.chatList) {

          buildChatNotification(chat)

        }
      }

      // 알림이 있는 경우
      if (result.notification.length > 0) {
        for(const notification of result.notification) {
          document.querySelector("#notificationList").insertAdjacentHTML("beforeend", buildNotification(notification));
        }
      }
    })
}

// 알림 정보 호출 하기
getNotification();

// 헤드에 알림 빌드
function buildNotification(message) {
  document.querySelector("#notificationList .alert").classList.add("d-none");
  document.querySelector("#notification span").classList.remove("d-none");

  // 헤더 알림에 추가 하기
  let html = `
      <li onclick="readNotification(${message.ntcnSn})">
        <a href="${message.originPath}">
          <div class="image">
              ${message.notificationIcon}
          </div>
          <div class="content">
            <h6>
                ${message.ntcnSj}
            </h6>
            <p>
                ${message.ntcnCn}
            </p>
            <span>${formatDate(new Date())}</span>
          </div>
        </a>
      </li>
    `;

  return html;
}

// 헤드에 메세지 빌드
function buildChatNotification(message) {
  // 헤더에 채팅 추가
  let alertChatNoList = []
  document.querySelectorAll("#chatNotification li").forEach((item) => {
    alertChatNoList.push(item.dataset.chatRoomNo);
  })
  console.log(message)

  if (message.lastMsg.includes("chat/")) {
    message.lastMsg = "사진을 보냈습니다."
  }

  if (alertChatNoList.includes(message.chttRoomNo + "")) {
    // 이미 있는 채팅방인 경우는 내용만 수정
    let findDom = document.querySelectorAll("#chatNotification li")[alertChatNoList.indexOf(message.chttRoomNo + "")];

    findDom.querySelector(".content").innerHTML = `
                <div class="content">
                  <h6>${message.emplNm}</h6>
                  <p>${message.lastMsg}</p>
                  <span>${formatDate(message.chttCreatDt)}</span>
                </div>
            `;
  } else {
    document.querySelector("#chatNotification").innerHTML += `
          <li data-chat-room-no="${message.chttRoomNo}">
            <a href="/chat/list?chatRoomNo=${message.chttRoomNo}" target="_blank">
              <div class="image">
                <img class="rounded-circle" src="${message.proflPhotoUrl}" alt="채팅방 메인 이미지" onerror="this.src='/assets/images/image-error.png'" />
              </div>
              <div class="content">
                <h6>${message.emplNm}</h6>
                <p>${message.lastMsg}</p>
                <span>${formatDate(message.chttCreatDt)}</span>
              </div>
            </a>
          </li>
        `
  }
}


{
  /* 알림창 */
  const toastTrigger = document.getElementById('liveToastBtn')
  const toastLiveExample = document.getElementById('liveToast')

  if(toastTrigger) {
    const toastBootstrap = bootstrap.Toast.getOrCreateInstance(toastLiveExample)
    toastTrigger.addEventListener('click', () => {
      toastBootstrap.show()
    })
  }
}

/* 알림창 */
var toastButtonList = [].slice.call(document.querySelectorAll(".toast-btn"));

toastButtonList.map(function(toastButtonEl) {
  toastButtonEl.addEventListener("click", function() {
    var toastToTrigger = document.getElementById(toastButtonEl.dataset.target);
    console.log(toastToTrigger)
    if(toastToTrigger) {
      var toast = bootstrap.Toast.getOrCreateInstance(toastToTrigger);
      toast.show();
    }
  });
});
