
// 비밀번호 validation 통일을 위해 추가 (h.kang 21.02.26)
var constraints;

// Updates the inputs with the validation errors
function showErrors(form, errors) {
  // We loop through all the inputs and show the errors for that input
  form.querySelectorAll("input[name], select[name], textarea[name]").forEach((input) => {
    // Since the errors can be null if no errors were found we need to handle
    // that
    // if(input.offsetWidth > 0 && input.offsetHeight > 0) {
      showErrorsForInput(input, errors && errors[input.name]);
    // }
  });
}

// Shows the errors for a specific input
function showErrorsForInput(input, errors) {
  // This is the root of the input
  var formGroup = input.closest('.row, .form-group')

  if(formGroup) {
    // This is the root of the input
    let messages = formGroup.querySelector(".invalid-feedback");
    // First we remove any old messages and resets the classes
    resetInput(input, messages);
    // If we have errors
    if (errors) {
      // we first mark the group has having errors
      input.classList.add("is-invalid");
      if(input.parentNode !== messages.parentNode) {
        messages.classList.add('d-block');
      }
      // then we append all the errors
      errors.forEach((error) => {
        addError(messages, error);
      });

      return true;
    } else {
      // otherwise we simply mark it as success
      input.classList.add("is-valid");
      return  false;
    }
  }
}

function resetInput(input, messages) {
  // Remove the success and error classes
  input.classList.remove("is-invalid");
  input.classList.remove("is-valid");
  if(messages)messages.classList.remove('d-block');
}

// Adds the specified error with the following markup
function addError(messages, error) {
  messages.innerHTML = error;
}

document.addEventListener("DOMContentLoaded", function () {
  // var errorIcon =  "i class='material-icons sm text-danger align-text-bottom'>X</i>"
  // var successIcon = "<i class='material-icons sm text-danger'>check</i>"

  // input 체인지 할때 사용
  document.addEventListener("change", (e) => {
    if (e.target.closest(".form-valid")) {
      if (e.target.closest("input[name]:not([type=radio], [type=checkbox], [type=hidden]), textarea:required, select")) {
        if (!constraints) {
          return
        }

        let errors = validate.single(e.target.value, constraints[e.target.getAttribute("name")]);
        let asyncErrors = validate.async(e.target.value, constraints.validUsername);
        showErrorsForInput(e.target, errors)
      }
    }
  })

  // 벨리데이션 기능 - submit한 경우
  if (document.querySelector('.form-valid')) {
    const forms = document.querySelectorAll('.form-valid')

    // Loop over them and prevent submission
    Array.from(forms).forEach(form => {
      form.addEventListener('submit', e => {
        e.preventDefault();
        e.stopPropagation()

        // 벨리데이션을 들어가고
        // 벨리데이션이 전부 성공한 경우만 넘어가기
        // 필수인 input 과 hidden이 아니고 체크, 라디오 박스가 아닌 것들
        let bSubmit = false
        let validIdx = null;
        document.querySelector("form")
          .querySelectorAll("input:required, textarea:required, select, input[name]:not([type=radio], [type=checkbox], [type=hidden])")
          .forEach((item, i) => {
          // input이 아닌 경우 innerText 사용
          // select 적용 안됨 해결 방법 찾기

          let value = item.value ?? item.innerText;
          let errors = validate.single(value == "" ? null  : value, constraints[item.getAttribute("name")]);
          let valid = showErrorsForInput(item, errors)
            // 제일 처음 Input index 정보
          if (!bSubmit && valid) validIdx = i;
          bSubmit = bSubmit || valid;
        })

        if (!bSubmit) {
          // e.target.submit();
        }

        // 처음 인풋으로 포커스
        document.querySelector("form")
          .querySelectorAll("input:required, textarea:required, select, input[name]:not([type=radio], [type=checkbox], [type=hidden])")[validIdx].focus();
      }, false)

    })
  }

  validate.validators.validEmail = (value, options) => {
    let params = new FormData();
    params.append('email', value);
    let result = async () => {
      try {
        let response = await fetch('/admin/user/validEmail', {method: "GET", body: params});

        if(!response.ok) throw string.error;

        let data = await response.json();
        if(data) {
          return true;
        } else {
          return false;
        }
      } catch(error) {
        return options.message;
      }
    }
    Promise.resolve(result());
  };

  validate.validators.validUsername = (value, options) => {
    let result = async () => {
      try {
        let response = await fetch('/admin/user/validUsername?username='+value);

        if(!response.ok) throw string.error;

        let data = await response.json();
        if(data.code =="15") {
        } else {
          return {presence: {
            message: "사용 중인 아이디 입니다.",
          }
        }
        }
      } catch(error) {
        return options.message;
      }
    }
    Promise.resolve(result());
  };

  let loginContainer = document.getElementById("login")
  if (loginContainer) {
    constraints = {
      username: {
        presence: {
          message: "아이디를 입력하세요.",
        }
      },
      password: {
        presence: {
          message: "비밀번호를 입력하세요.",
        }
      }
    }
  }

  //사용자
  let userContainer = document.getElementById("userContainer")
  if (userContainer) {
    //사용자 추가
    if (userContainer.querySelector("form#userAdd")) {
      constraints = {
        username: {
          presence: {
            message: "아이디를 입력하세요.",
          },
          length: {
            minimum: 6,
            tooShort: "6자 이상으로 입력하세요.",
            maximum: 16,
            tooLong: "16자 이하로 입력하세요.",
          },
          format: {
            pattern: /^[a-zA-Z0-9]+$/,
            message: "영문 대소문자, 숫자만 가능합니다.",
          }
        },
        email: {
          presence: {
            message: "이메일을 입력하세요.",
          },
          email: {
            message: "메일 형식이 아닙니다.",
          },
          validEmail: {
            message: "이미 사용 중입니다."
          }
        },
        fullName: {
          presence: {
            message: "이름을 입력하세요.",
          },
          length: {
            minimum: 2,
            tooShort: "2자 이상으로 입력하세요.",
            maximum: 12,
            tooLong: "12자 이하로 입력하세요.",
          },
          format: {
            pattern: /^[가-힣a-zA-Z0-9]+$/,
            message: "한글, 영문 대소문자, 숫자만 가능합니다.",
          },
        },
        phone: {
          presence: {
            message: "전화번호를 입력하세요.",
          },
          format: {
            pattern: /^([0-9]{2,3}-[0-9]{3,4}-[0-9]{4})$|^([0-9]{4}-[0-9]{4})$/,
            message: "잘못된 전화번호 형식입니다.",
          },
        },
        password: {
          presence: {
            message: "비밀번호를 입력하세요.",
          },
          length: {
            minimum: 8,
            tooShort: "8자 이상으로 입력하세요.",
            maximum: 20,
            tooLong: "20자 이하로 입력하세요.",
          },
          format: {
            pattern: /^[a-zA-Z0-9]+$/,
            message: "영문, 숫자를 조합하여 8~20자까지 입력하세요.",
          },
        },
        passwordConfirm: {
          presence: {
            message: "다시한번 비밀번호를 입력하세요.",
          },
          length: {
            minimum: 8,
            tooShort: "8자 이상으로 입력하세요.",
            maximum: 20,
            tooLong: "20자 이하로 입력하세요.",
          },
          equality: {
            attribute: "password",
            message: "입력한 비밀번호가 다릅니다.",
            comparator: function (v1, v2) {
              if (v1 != null && v2 != null) {
                return v1 === v2
              } else {
                // 단일 validation 시 v2를 못받아옴
                return document.querySelector('input[name="password"]').value === v1
              }
            },
          },
        },
        dept: {
          presence: {
            message: "직급을 선택해주세요.",
          }
        },
        uploadFile: {
          presence: {
            message: "이미지를 선택하세요.",
          }
        },

      }
    }
    if (userContainer.querySelector("form#edit")) {
      constraints = {
        email: {
          presence: {
            message: "이메일을 입력하세요.",
          },
          email: {
            message: "메일 형식이 아닙니다.",
          },
          validEmail: {
            message: "이미 사용 중입니다."
          }
        },
        fullName: {
          presence: {
            message: "이름을 입력하세요.",
          },
          length: {
            minimum: 2,
            tooShort: "2자 이상으로 입력하세요.",
            maximum: 12,
            tooLong: "12자 이하로 입력하세요.",
          },
          format: {
            pattern: /^[가-힣a-zA-Z0-9]+$/,
            message: "한글, 영문 대소문자, 숫자만 가능합니다.",
          },
        },
        phone: {
          presence: {
            message: "전화번호를 입력하세요.",
          },
          format: {
            pattern: /^([0-9]{2,3}-[0-9]{3,4}-[0-9]{4})$|^([0-9]{4}-[0-9]{4})$/,
            message: "잘못된 전화번호 형식입니다.",
          },
        },
        password: {
          length: {
            minimum: 8,
            tooShort: "8자 이상으로 입력하세요.",
            maximum: 20,
            tooLong: "20자 이하로 입력하세요.",
          },
          format: {
            pattern: /^[a-zA-Z0-9]+$/,
            message: "영문, 숫자를 조합하여 8~20자까지 입력하세요.",
          },
        },
        passwordConfirm: {
          length: {
            minimum: 8,
            tooShort: "8자 이상으로 입력하세요.",
            maximum: 20,
            tooLong: "20자 이하로 입력하세요.",
          },
          equality: {
            attribute: "password",
            message: "입력한 비밀번호가 다릅니다.",
            comparator: function (v1, v2) {
              if (v1 != null && v2 != null) {
                return v1 === v2
              } else {
                // 단일 validation 시 v2를 못받아옴
                return document.querySelector('input[name="password"]').value === v1
              }
            },
          },
        },
      }
    }
  }
});

