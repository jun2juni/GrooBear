/**
 *
 */

class Loader {
  container; // loader를 표시할 container
  loaderWrap; // loader를 감싸줄 상위 div

  constructor(container) {
    if (container == null) container = document.body;

    this.loaderWrap = container.querySelector("div.loader-wrap");
    if (this.loaderWrap == null) {
      // loader-wrap 이 없는 경우 container 안에 생성
      this.loaderWrap = document.createElement("div");
      this.loaderWrap.classList.add("spinner-border", "d-none");
      this.loaderWrap.innerHTML = "<span class='sr-only'></span>";
      container.appendChild(this.loaderWrap);
    }
  }

  show() {
    this.loaderWrap.classList.remove("d-none");
  }

  hide() {
    this.loaderWrap.classList.add("d-none");
  }
}

/**
 * 페이징 custom elements
 * usage:
 *  <page-navi url="/?" current="${param.get("pageNo")}" total="30"/>
 * Javascript 코드 내에서도 append 및 insertAdjacentHTML 등 사용하면 자동으로 Generate 됨. 내부 function들도 모두 사용 가능
*/
class Pagination extends HTMLElement {
  // 정보에 맞게 html 코드 생성
  // Pagination 객체 생성 후 사용하면 비동기 화면에서도 처리 가능
  build(currentPage, maxPage, maxBlock) {
    currentPage = Number(currentPage == 0 ? 1 : currentPage);

    let nextPage = currentPage + 1;
    let prevPage = currentPage - 1; //이전 페이지 가기 - currentPage-1
    nextPage = currentPage + 1; //다음 페이지 이동 - currentPage+1

    //이전페이지가 0이하 일경우 currentPage
    if (prevPage <= 0) {
      prevPage = currentPage;
    }

    //nextPage가 maxPage보다 크면
    if (nextPage >= maxPage) {
      nextPage = maxPage;
    }

    //nextPage가 0일때 1로
    if (maxPage == 0) {
      maxPage = 1;
      nextPage = 1;
    }

    let block = Math.ceil(currentPage / maxBlock); //페이지 블럭 개수 // Math.ceil 주어진 숫자보다 크거나 같은 숫자 중 가장 작은 숫자를 integer 로 반환
    let firstPage = (block - 1) * maxBlock + 1; //생성된 블럭에서 첫번째 페이지
    let lastPage = Math.min(maxPage, block * maxBlock); //생성된 블럭에서 마지막 페이지  //Math.min 주어진 숫자들 중 가장 작은 값을 반환합니다.

    let pagingHtml = `<ul class="pagination">`; // 모달에서 페이지 2자리 넘어갈 경우 넘침 문제 때문에 small 적용 h.kang 21.04.13
    pagingHtml += `<li class="page-item"><button class="page-link" data-page="1">&laquo;</button></li>`; // 첫번째 페이지
    pagingHtml += `<li class="page-item"><button class="page-link" data-page="${prevPage}">&lt;</button></li>`; // 이전 페이지
    for (let i = firstPage; i <= lastPage; i++) {
      // 페이지 개수만큼 표시
      pagingHtml += `<li class="page-item ${
        currentPage == i ? "active" : ""
      }"><button class="page-link" data-page="${i}">${i}</button></li>`;
    }
    pagingHtml += `<li class="page-item"><button class="page-link" data-page="${nextPage}">&gt;</button></li>`; // 다음 페이지
    pagingHtml += `<li class="page-item"><button class="page-link" data-page="${maxPage}">&raquo;</button></li>`; // 마지막 페이지
    pagingHtml += `</ul>`;

    return pagingHtml;
  }

  constructor() {
    super();

    let currentPage = this.getAttribute("current"); // 현재 페이지
    let totalPage = this.getAttribute("total"); // 최대 페이지
    let maxBlock = this.getAttribute("show-max") ?? 10; // 최대로 보여줄 페이징 개수 기본 10

    let url = this.getAttribute("url").split("?")[0] + "?"; // 페이징 클릭 시 이동할 URL
    let params = this.getAttribute("url").split("?")[1]
      .match(/\((.*?)\)/)?.[1] // 괄호 안의 내용을 추출
      .split(",") || []; // 추출된 내용을 쉼표로 나눔

    params.forEach((param) => {
      let [key, value] = param.trim().split("="); // 키와 값을 분리
      value = value?.trim(); // 값의 공백 제거

      // 조건에 맞는 파라미터만 URL에 추가
      if (value && value !== "null" && value !== "0") {
        url += `${key}=${value}&`;
      }
    });

    let html = this.build(currentPage, totalPage, maxBlock);

    this.insertAdjacentHTML("beforeend", html);

    this.addEventListener("click", (e) => {
      e.preventDefault();
      e.stopImmediatePropagation();

      if (e.target.closest(".page-link")) {
        // console.log(`${url}&pageNo=${e.target.dataset.page}`);
        location.href = `${url}currentPage=${e.target.dataset.page}`;
      }
    });
  }
}

customElements.define("page-navi", Pagination); // page-navi 으로 교체

/**
 * 무한 스크롤 구현 (옵저버를 활용해 구현)
 * url="" => 내가 비동기로 호출 할 URL 정보를 추가한다
 * data-query="" => 쿼리 정보를 넣어준다
 *
 * infinite-scroll
 *    => template
 *    => 내부에 UI를 넣어주면 해당 형식으로 데이터 회수만큼 반복해서 보여준다
 *
 *
 * 내가 데이터를 넣고 싶은 부분에 {{title}} 형식으로 작성하면 사용이 가능하다
 *
 *  ------------ 사용 예시
 <infinite-scroll
 url="/servletStudty/board/list2"
 total="${paging.getTotalRecordCount()}"
 last-page="${paging.getLastPageNo()}"
 data-search="${pagingOption['search']}"
 class="block max-w-3xl mx-auto">
 <template>
 <li>
 <div>{{index}}</div>
 <div><a href="detail?no={{boardNo}}">{{boardTitle}}</a></div>
 <p>{{boardContent}}</p>
 </li>
 </template>
 </infinite-scroll>
 *
 */

class InfiniteScroll extends HTMLElement {
  #index;

  // 비동기 데이터 가져오기
  async fetchData(url, params) {
    try {
      let query = new URLSearchParams(params).toString();

      let response = await fetch(`${url}?${query}`);
      if (!response.ok) throw new Error("Failed to fetch data");

      return await response.json(); // JSON 형태로 응답 처리
    } catch (error) {
      console.error("Error fetching data:", error);
      return null;
    }
  }

  // 데이터를 기반으로 HTML을 생성
  populateTemplate(template, data) {
    let content = template.content.children[0].cloneNode(true);
    let html = content.innerHTML;

    if (html == null) {
      throw new Error("template 내부에 DOM 정보를 추가해주세요.");
    }

    // 데이터 바인딩 ({{key}} 형식)
    data.index = this.#index--;
    for (const [key, value] of Object.entries(data)) {
      html = html.replace(`{{${key}}}`, value);
    }

    content.innerHTML = html;
    return content;
  }

  // 데이터를 가져와서 리스트에 추가
  async build() {
    // 현재 페이지와 요청 URL 읽기
    let url = this.getAttribute("url");
    let currentPage = Number(this.getAttribute("data-page-no") || 1);
    let query = "";
    let search = document.querySelector("infinite-scroll").dataset.search;
    search = search.substring(search.indexOf("(") + 1, search.indexOf(")")).split(",");
    search.forEach((item) => {
      let [key, value] = item.trim().split("=");

      if (value != "" && value != "null" && value != 0) {
        query += `${key}=${value}&`
      }
    })

    query += `pageNo=${currentPage}`;

    // 데이터 가져오기
    let data = await this.fetchData(
      url, query
    );

    if (!data || !data.items || data.items.length === 0) {
      console.log("더 이상 로드할 데이터가 없습니다");
      return;
    }

    // 템플릿 가져오기
    let template = this.querySelector("template");
    if (!template) {
      console.log("template이 있어야 실행이 가능합니다");
      throw new Error("Template not found in <infinite-scroll>");
    }

    // 데이터 바인딩 및 DOM 추가
    for (const item of data.items) {
      template.parentElement.appendChild(this.populateTemplate(template, item));
    }

    // 페이지 증가
    this.setAttribute("data-page-no", currentPage + 1);
  }

  // 생성자
  constructor() {
    super();

    let totalPage = this.getAttribute("total"); // 최대 페이지
    this.#index = totalPage; // 생성자에서 초기값 설정

    let intersectionObserver = new IntersectionObserver((entries) => {
      // 마지막인 경우 더이상 페이지 부르지 않게 설정
      let currentPage = Number(this.getAttribute("data-page-no") || 1);
      let lastPage = this.getAttribute("last-page");

      if (currentPage > lastPage) {
        console.log("마지막 데이터 가져온");
        intersectionObserver.disconnect();
        return;
      }

      if (entries[0].intersectionRatio > 0) {
        this.build();
      }
    });

    const footerDiv = document.createElement("div");
    footerDiv.classList.add("scrollerFooter");
    this.parentElement.appendChild(footerDiv);

    intersectionObserver.observe(document.querySelector(".scrollerFooter"));
  }
}

customElements.define("infinite-scroll", InfiniteScroll);

// 파일 업로드 커스텀 엘리먼츠
class FileUpload extends HTMLElement {
  constructor() {
    super();
    this.maxFiles = parseInt(this.getAttribute("max-files") || "1");
    this.label = this.getAttribute("label") || "Upload Files";
    this.name = this.getAttribute("name") || "";
    this.contextPath = this.getAttribute("contextPath") || "";
    this.uploadedFiles = this.getAttribute("uploaded-file");
    // this.fileRoot = this.getAttribute("file-root") || "";
    this.render();
  }

  render() {
    this.innerHTML = `
      <div class="mb-3">
        <label class="me-2">${this.label}</label>
        ${this.maxFiles > 1 ? '<button type="button" id="addFileBtn" class="btn btn-secondary">추가</button>' : ""}
      </div>
      <div id="fileInputsContainer"></div>
    `;
    this.addEventListeners();

    // 이미 추가된 파일 추가
    if (this.uploadedFiles != undefined) {
      let files = this.fileVoToJson(this.uploadedFiles);
      // 삭제할 파일 no 가지고 가기
      console.log(files)
      if (files.length > 0) {
        const input = document.createElement("input");
        input.type = "hidden";
        input.name = "atchFileNo";
        input.value = files[0].atchFileNo;
        this.appendChild(input);
      }

      files.forEach((file) => {
        this.addFileInput(this.querySelector("#fileInputsContainer"), file);
      });
    } else {
      // 기본 파일 입력 폼 하나 렌더링
      this.addFileInput(this.querySelector("#fileInputsContainer"));
    }
  }

  // fileVo 객체 JSON으로 변환
  fileVoToJson(fileList) {
    const fileDataArray = fileList
      .replace(/^\[|]$/g, '') // 대괄호 제거
      .split(/AttachFileVO\(/) // 각 FileVo 객체 분리
      .filter(Boolean) // 빈 문자열 제거
      .map(item => {
        const obj = {};
        item
          .replace(/\)$/, '') // 끝의 닫는 괄호 제거
          .split(/, /) // 각 키-값 분리
          .forEach(pair => {
            const [key, value] = pair.split(/=/);
            obj[key.trim()] = value ? value.trim() : null;
          });
        return obj;
      });

    return fileDataArray;
  }

  addEventListeners() {
    const addFileBtn = this.querySelector("#addFileBtn");
    const fileInputsContainer = this.querySelector("#fileInputsContainer");

    // Handle adding a new file input when "추가" button is clicked
    addFileBtn?.addEventListener("click", () => {
      // Check if the current file count has reached the maxFiles limit
      const currentFileCount = this.querySelectorAll("input[type='file']").length;
      if (currentFileCount >= this.maxFiles) {
        alert(`최대 ${this.maxFiles}개의 파일만 업로드할 수 있습니다.`);
        return;
      }

      this.addFileInput(fileInputsContainer);
    });
  }

  addFileInput(container, file) {
    // Create a new file input form
    const fileInputDiv = document.createElement("div");
    fileInputDiv.classList.add("mb-3");

    fileInputDiv.innerHTML = `
      <div>
        <div class="input-group mb-3">
          <div class="file-container text-truncate">
            <label class="input-group-text file-label">${file?.fileStreNm ?? "파일을 선택해주세요"}</label>
            <input type="file" name="${this.name}" class="file-input" data-id="${file?.fileSn}">
          </div>
          <button type="button" data-id="${file?.fileSn}" class="btn btn-danger removeFileBtn">삭제</button>
        </div>
          
        <div class="col-6  mb-2">
          <img  class="rounded preview"
                style="width: 100%; height: auto"
                src="/upload/${file?.fileStrePath}"
                onerror="this.src='${this.contextPath  }/assets/images/image-error.png'" alt="업로드한 이미지 미리보기"/>
            <!-- src="/upload/${this.fileRoot}/${file?.fileStrePath}" -->
        </div>
      </div>
    `;

    // 파일 추가
    // container.appendChild(fileInputDiv);
    container.prepend(fileInputDiv);
    // container.insertAdjacentHTML("beforebegin", fileInputDiv);

    const fileInput = fileInputDiv.querySelector("input[type='file']");
    fileInput.addEventListener("change", (event) => {
      this.handleFileChange(event, fileInput, fileInputDiv);

    });

    // 삭제 버튼
    const removeBtn = fileInputDiv.querySelector(".removeFileBtn");
    removeBtn.addEventListener("click", () => {
      this.removeEventListener(fileInputDiv, removeBtn.dataset.id, true);
    });
  }

  removeEventListener(fileInputDiv, id, bChanged) {
    // 삭제 버튼 클릭 시 이미지 삭제 하고
    // 새로운 input 추가 해주기 (removeFileId)
    if (id != undefined && id != null && id != 'undefined') {
      const input = document.createElement("input");
      input.type = "hidden";
      input.name = "removeFileId";
      input.value = id;
      this.appendChild(input);
    }

    // fileInputDiv 삭제 하기
    if (bChanged) {
      fileInputDiv.remove();
    }
    const currentFileCount = this.querySelectorAll("input[type='file']").length;
    if (currentFileCount == 0) {
      this.addFileInput(this.querySelector("#fileInputsContainer"));
    }
  }

  handleFileChange(event, fileInput, fileInputDiv) {
    const files = Array.from(event.target.files);

    // Ensure we don't exceed the max file limit
    const currentFileCount = this.querySelectorAll("input[type='file']").length;
    if (currentFileCount > this.maxFiles) {
      alert(`최대 ${this.maxFiles}개의 파일만 업로드할 수 있습니다.`);
      return;
    }

    // 이전 이미지 삭제해주기
    this.removeEventListener(fileInputDiv, event.target.dataset.id);
    event.target.dataset.id = undefined;

    // 이미지 미리보기 처리
    this.previewImage(files, fileInputDiv);
  }

  previewImage(files, fileInputDiv) {
    if (files && files[0]) {
      let reader = new FileReader()
      const preview = fileInputDiv.querySelector(".preview");
      reader.onload = (e) => {
        preview.src = e.target.result;
      }
      reader.readAsDataURL(files[0]);
      // 파일 이름 label에 추가
      fileInputDiv.querySelector(".file-label").textContent = files[0].name;
    }
  }
}

customElements.define("file-upload", FileUpload);

function toQueryString(obj) {
  let params = "";

  for (const [key, value] of Object.entries(obj)) {
    if (value !== null && value !== 0 && value !== undefined) {
      params += `${key}=${value}`;
    }
  }

  return params;
}


if (document.querySelectorAll("#postcodeModal").length > 0) {
  let loader = new Loader(document.querySelector(".postcode-wrap"));


  // 우편번호 찾기 화면을 넣을 modal
  let modal = document.querySelector("#postcodeModal");
  // 우편번호 찾기 화면을 넣을 element
  let postcodeWrap = modal.querySelector(".postcode-wrap");

  // modal close
  function foldDaumPostcode() {
    // iframe을 넣은 element를 안보이게 한다.
    if (bootstrap.Modal.getOrCreateInstance) {
      bootstrap.Modal.getOrCreateInstance(modal).hide();
    } else {
      $('#postcodeModal').modal("hide");
    }

    modal.querySelector(".modal-footer button").innerText = "확인";
  }

  // postcode selected
  function popupDaumPostcode(inputElem) {
    // 현재 scroll 위치를 저장해놓는다.
    var currentScroll = Math.max(
      document.body.scrollTop,
      document.documentElement.scrollTop
    );

    new daum.Postcode({
      oncomplete: function (data) {
        console.log(data);
        // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
        // 각 주소의 노출 규칙에 따라 주소를 조합한다.
        // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
        var addr = ""; // 주소 변수
        var extraAddr = ""; // 참고항목 변수

        //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
        if (data.userSelectedType === "R") {
          // 사용자가 도로명 주소를 선택했을 경우
          addr = data.roadAddress;
        } else {
          // 사용자가 지번 주소를 선택했을 경우(J)
          addr = data.jibunAddress;
        }

        // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
        if (data.userSelectedType === "R") {
          // 법정동명이 있을 경우 추가한다. (법정리는 제외)
          // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
          if (data.bname !== "" && /[동|로|가]$/g.test(data.bname)) {
            extraAddr += data.bname;
          }
          // 건물명이 있고, 공동주택일 경우 추가한다.
          if (data.buildingName !== "" && data.apartment === "Y") {
            extraAddr +=
              extraAddr !== "" ? ", " + data.buildingName : data.buildingName;
          }
          // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
          if (extraAddr !== "") {
            extraAddr = " (" + extraAddr + ")";
          }
          // 조합된 참고항목을 해당 필드에 넣는다.
          inputElem.value = extraAddr;
        } else {
          inputElem.value = "";
        }

        // 우편번호와 주소 정보를 해당 필드에 넣는다.
        // document.getElementById('sample3_postcode').value = data.zonecode;
        inputElem.value = addr;

        // iframe을 넣은 element를 안보이게 한다.
        // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
        foldDaumPostcode();

        // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
        document.body.scrollTop = currentScroll;
      },
      // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
      onresize: function (size) {
        loader.hide();
        postcodeWrap.style.height = size.height + "px";
      },
      width: "100%",
      height: "100%",
    }).embed(postcodeWrap);
    // modal show
    if (bootstrap.Modal.getOrCreateInstance) {
      bootstrap.Modal.getOrCreateInstance(modal).show();
    } else {
      $('#postcodeModal').modal("show");
    }
  }

  // 주소 input 클릭 시 주소api 초기화
  document.querySelectorAll(".address-select").forEach((el) => {
    el.addEventListener("click", (e) => {
      let inputElem = e.target; // element가 input인 경우
      if (e.target.nodeName != "INPUT") {
        // element와 input이 다른 경우
        inputElem = e.target
          .closest(".address-group")
          .querySelector("input[type=text]");
      }

      loader.show();
      popupDaumPostcode(inputElem);
    });
  });
}

if (document.getElementById('phoneNumber')) {
  document.getElementById('phoneNumber').addEventListener('input', function (e) {
    // 입력값에서 하이픈을 제거하고 숫자만 남기기
    let phone = e.target.value.replace(/\D/g, '');

    // 3자리, 4자리, 4자리로 포맷팅
    if (phone.length < 4) {
      e.target.value = phone;
    } else if (phone.length < 7) {
      e.target.value = phone.slice(0, 3) + '-' + phone.slice(3);
    } else if (phone.length < 11) {
      e.target.value = phone.slice(0, 3) + '-' + phone.slice(3, 6) + '-' + phone.slice(6);
    } else {
      e.target.value = phone.slice(0, 3) + '-' + phone.slice(3, 7) + '-' + phone.slice(7, 11);
    }
  });
}

// 벨리데이션 기능 - form 에 css 추가 (needs-validation) ** novalidate 속성 추가
if (document.querySelector('.needs-validation')) {
  const forms = document.querySelectorAll('.needs-validation')

  // Loop over them and prevent submission
  Array.from(forms).forEach(form => {
    form.addEventListener('submit', event => {
      // 주소찾기를 안한 경우 안넘어가게 만들기

      if (!form.checkValidity()) {
        event.preventDefault();
        event.stopPropagation()
      }

      form.classList.add('was-validated')
    }, false)
  })
}

// document.addEventListener("DOMContentLoaded", function () {
//   const FOOTER_HEIGHT = document.querySelector(".footer")?.offsetHeight ?? 0;
//   const HEADER_HEIGHT = document.querySelector("#header")?.offsetHeight ?? 0;
//
//   // 푸터 높이만큼 container에 padding 부여 (화면보다 작을 경우에만)
//   const mainElement = document.querySelector(".main");
//   if (mainElement) {
//     const mainHeight = mainElement.offsetHeight;
//     const availableHeight = window.innerHeight - HEADER_HEIGHT - FOOTER_HEIGHT;
//
//     if (mainHeight < availableHeight) {
//       mainElement.style.paddingBottom = FOOTER_HEIGHT + "px";
//       mainElement.style.height = `calc(100vh - ${HEADER_HEIGHT + FOOTER_HEIGHT}px)`;
//     }
//   }
//
//   const contentWrapper = document.querySelector(".content-wrapper");
//   if (contentWrapper) {
//     contentWrapper.style.paddingBottom = FOOTER_HEIGHT + "px";
//   }
//
//
//   let loginRequired = document.querySelectorAll(".login-required");
//   loginRequired.forEach((item) => {
//     const memberNo = item.dataset.memberNo;
//
//     item.addEventListener("click", (e) => {
//       // 로그인 안되어 있는 경우
//       if (memberNo == undefined || memberNo == 0) {
//         e.preventDefault();
//         bootstrap.Modal.getOrCreateInstance(document.querySelector("#loginConfirmModal")).show();
//       }
//     })
//   })
//
// })
