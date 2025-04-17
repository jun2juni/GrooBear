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
				<div class="row mt-5">
					<div class="col-10 mx-auto" >
						<div class="card-style">
						    <!-- form 시작 / action 잡아줘야함  -->
					          <h2>📋 오늘의 질문 만들기</h2>

							  <!-- 질문 입력 -->
							  <div class="form-section">
							     <div class="input-style-1 form-group col-6">
						           <label for="questionText" class="form-label">이름 <span class="text-danger">❓ 질문을 입력하세요</span></label>
						           <textarea name="fullName" class="form-control" id="questionText" cols="10" rows="5" placeholder="예: 이번 사내 워크숍 위치로 좋은 곳을 골라주세요" required></textarea>
						         </div>
							  </div>
							
							
							  <div class="form-section">
							    <label class="mb-2">🙏 선택지를 추가하세요🙏:</label><br>
							    
							    <!--선택지 입력 추가되는 div -->
							    <div id="optionsContainer"></div>
							    <!--선택지 입력 추가되는 div -->
							    <div>
							    	<button onclick="addOption()"  class="btn submit btn-warning norwarp">➕ 선택지 추가</button>
							    	<button onclick="generateSurvey()"  class="btn submit btn-primary norwarp">✅ 설문 생성하기</button>
							    </div>	
							    	
							  </div>
							
							 
					            
					            
						
						</div> <!-- 첫번째 외부카드  -->
					</div>
				</div>	
			 </div>			
		</section>
		<%@ include file="../layout/footer.jsp"%>
	</main>
	<%@ include file="../layout/prescript.jsp"%>
<!--질문만들기  -->
<script type="text/javascript">
	let optionCount = 0;
	
	// 선택지 추가 
	function addOption() {
	  const container = document.getElementById("optionsContainer");
	  const optionId = `opt${optionCount}`;
	
	  const div = document.createElement("div");
	  div.className = "form-check d-flex align-items-center gap-2 mb-2";
	  div.id = `${optionId}-wrapper`;
	  
	  div.innerHTML = `
	      <input class="form-check-input mt-0" type="radio" disabled>
	      <input class="form-control w-50" name="radio" type="text" id="${optionId}" placeholder="선택지 입력">
	      <button type="button" class="btn btn-danger btn-xs" onclick="removeOption('${optionId}')">❌</button>
	  `;
	  container.appendChild(div);
      optionCount++;
	
	}
	
	// 선택지 삭제
	 function removeOption(id) {
		    const el = document.getElementById(`${id}-wrapper`);
		    if (el) el.remove();
		  }
	
	// 설문 생성
	function generateSurvey() {
	  const question = document.getElementById("questionText").value.trim();
	  const container = document.getElementById("optionsContainer");
	  const inputs = container.querySelectorAll("input[type='text']");
	
	  let html = `<div class="question">🤔 오늘의 질문: ${question}</div>`;
	
	  inputs.forEach((input, index) => {
	    const val = input.value.trim();
	    if (val !== "") {
	      const radioId = `genOpt${index}`;
	      html += `
	        <div class="option">
	          <input type="radio" name="color" id="${radioId}" value="${val}">
	          <label for="${radioId}">${val}</label>
	        </div>`;
	    }
	  });
	
	  document.getElementById("surveyOutput").innerHTML = html;
	}	
</script>	
</body>
</html>
