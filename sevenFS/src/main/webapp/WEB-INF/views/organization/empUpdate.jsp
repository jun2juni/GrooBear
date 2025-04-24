<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="메인" />

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<!-- <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script> -->
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
				<form action="/emplUpdatePost" method="post"
					class="needs-validation" novalidate id="emplUpdateForm"
					enctype="multipart/form-data">
					<div class="card-style chat-about h-100 "
						style="justify-content: center;">
						<h6 class="text-sm text-medium"></h6>
						<c:set var="emplDet" value="${emplDetail.emplDet}"></c:set>
						<div class="chat-about-profile" style="justify-content: center;">
							<h5 class="text-bold mb-10"></h5>
							<div class="image"
								style="justify-content: center; margin-left: 15%">
								<!-- 이전파일 정보는 넘겨줄 필요없다 -->
								<file-upload label="프로필 이미지 수정" name="uploadFile" max-files="1"
									contextPath="${pageContext.request.contextPath  }"
									uploaded-file="${fileAttachList}"<%-- atch-file-no="${emplDet.atchFileNo}" --%>
				          ></file-upload>
								<span class="text-medium text-dark"></span>
							</div>
						</div>
						<sec:authorize access="hasRole('ROLE_ADMIN')">
							<c:set var="emp" value="${emplDetail.emplDet}"></c:set>
							<div class="input-style-1 form-group col-12"
								style="display: flex;">
								<div class="input-style-1 form-group col-2"
									style="margin-left: 15%">
									<label for="clsfCode" class="form-label required">직급<span
										class="text-danger">*</span></label> <select id="duration"
										class="form-select w-auto" name="clsfCode">
										<c:forEach var="posList" items="${emplDetail.posList}">
											<option value="${posList.cmmnCode}"
												${emp.clsfCode == posList.cmmnCode ? 'selected' : '' }>
												${posList.cmmnCodeNm}</option>
										</c:forEach>
									</select>
								</div>
								<%-- ${emplDetail.upperDepList} --%>
								<input type="hidden" value="${emp.deptCode}" id="hiddenDeptCode">
								<div class="input-style-1 form-group col-2">
									<label for=upperDept class="form-label required">소속부서<span
										class="text-danger">*</span></label> <select id="upperDept"
										class="form-select w-auto" required="required">
										<c:forEach var="upperDepList" items="${emplDetail.upperDepList}">
											<option value="${upperDepList.cmmnCode}"
												<c:if test="${emp.upperCmmnCode == upperDepList.cmmnCode}">selected</c:if>>
												${upperDepList.cmmnCodeNm}</option>
										</c:forEach>
									</select>
								</div>
								<%-- 부서 선택하면 소속팀 출력 --%>
								<div>
									<label class="form-label required">소속팀 <span
										class="text-danger">*</span>
									</label>
									<div class="d-flex gap-3" id="lowerDepartment"></div>
								</div>
							</div>
						</sec:authorize>
						<c:set var="emp" value="${emplDetail.emplDet}"></c:set>
						<sec:authorize access="hasRole('ROLE_MEMBER')">
							<input type="hidden" name="emplNm" value="${emp.emplNm}" />
							<input type="hidden" name="genderCode" value="${emp.genderCode}" />
							<input type="hidden" name="clsfCode" value="${emp.clsfCode}" />
							<input type="hidden" name="deptCode" value="${emp.deptCode}" />
							<input type="hidden" name="ecnyDate" id="ecnyDate"
								value="${formattedEncy}" />
							<input type="hidden" name="retireDate" value="${emp.retireDate}" />
							<input type="hidden" name="anslry" value="${emp.anslry}" />
							<input type="hidden" name="acnutno" value="${emp.acnutno}" />
							<input type="hidden" name="bankNm" value="${emp.bankNm}" />
							<input type="hidden" name="partclrMatter"
								value="${emp.partclrMatter}" />
						</sec:authorize>
						<div class="activity-meta text-start" style="margin-top: 20px;">
							<input type="hidden" id="hiddenEmplNo" name="emplNo"
								value="${emp.emplNo}">
							<!-- <div class="input-style-1 form-group col-8" style="margin-left:15%;">
				            <label for="password" class="form-label required">비밀번호-수정필요<span class="text-danger">*</span></label>				            
				           <div class="invalid-feedback"></div>
			   	          </div>  -->
							<input type="hidden" name="password" class="form-control"
								value="java">
							<sec:authorize access="hasRole('ROLE_ADMIN')">
								<div class="col-12" style="display: flex;">
									<div class="input-style-1 form-group" style="margin-left: 15%;">
										<label for="emplNm" class="form-label required">이름<span
											class="text-danger">*</span></label> <input type="text" name="emplNm"
											class="form-control" id="emplNm" value="${emp.emplNm}"
											required>
										<div class="invalid-feedback">이름을 작성하세요.</div>
									</div>
									<!-- 성별 select box -->
									<%-- <div class="form-group" style="margin-left:15%;">
							    <label for="genderCode" class="form-label" style="font-size: 14px; font-weight: 500; color: #1A2142;">
							        성별
							    </label>
							    <select class="form-select" name="genderCode" id="genderCode" style="width: 200px;">
							        <option value="00" ${emp.genderCode == '00' ? 'selected' : ''}>남성</option>
							        <option value="01" ${emp.genderCode == '01' ? 'selected' : ''}>여성</option>
							    </select>
							</div> --%>
									<!-- 성별 radio box -->
									<div class="form-group" style="margin-left: 15%;">
										<label for="genderCode" class="form-label"
											style="font-size: 14px; font-weight: 500; color: #1A2142;">
											성별 </label>
										<div class="form-check checkbox-style checkbox-warning">
											<input class="form-check-input" type="radio" value="00"
												name="genderCode" id="radio-female"
												${emp.genderCode == '00' ? 'checked' : ''}> <label
												class="form-check-label" for="radio-female">남성</label>
										</div>
										<div class="form-check checkbox-style checkbox-warning mb-20">
											<input class="form-check-input" type="radio" value="01"
												name="genderCode" id="radio-male"
												${emp.genderCode == '01' ? 'checked' : ''}> <label
												class="form-check-label" for="radio-male">여성</label>
										</div>
									</div>
								</div>

							</sec:authorize>
							<%--  <div class="row col-12">
			            <div class="input-style-1 form-group col-3" style="margin-left:15%;">
				            <label for="email" class="form-label required">이메일 <span class="text-danger">*</span></label>
				            <input type="text" class="form-control" id="email" value="${emp.email}" required  pattern="[A-Za-z0-9]+"/>
				            <div class="invalid-feedback">이메일을 입력해주세요.</div>
			           </div>
			           <div class="col-4">
						<label for=upperDept class="form-label required"><span class="text-danger"></span></label>
			            <select id="selEmail" class="form-select w-auto" required="required">
								<option value="@naver.com">@naver.com</option>
								<option value="@gmail.com">@gmail.com</option>
								<option value="@hanmail.net">@hanmail.net</option>
								<option value="@nate.com">@nate.com</option>
						 </select>
			            </div>
		            </div>
		            <input type="hidden" id="hiddenEmail" name="email"> --%>

							<div class="col-12" style="display: flex;">
								<div class="input-style-1 form-group col-2"
									style="margin-left: 15%;">
									<label for="fmtBirth" class="form-label required" maxlength="8">생년월일
										<span class="text-danger">*</span>
									</label> <input type="date" class="form-control" id="fmtBirth"
										value="${formattedBrthdy}" required>
									<div class="invalid-feedback"></div>
									<input type="hidden" name="brthdy" id="brthdy">
								</div>
								<%-- <div class="input-style-1 form-group col-2" style="margin-left:15%;">
				            <label for="brthdy" class="form-label required" maxlength="8">생년월일 <span class="text-danger">*</span></label>
				            <input type="date" name="brthdy" class="form-control" id="brthdy" value="${emp.brthdy}" required>
				            <div class="invalid-feedback"></div>
			            </div> --%>
								<div class="input-style-1 form-group col-3"
									style="margin-left: 15%;">
									<label for="telno" class="form-label required" maxlength="11">휴대폰번호
										<span class="text-danger">*</span>
									</label> <input type="text" name="telno" class="form-control"
										id="telno" value="${emp.telno}" required
										oninput="this.value = this.value.replace(/[^0-9]/g, '')"
										maxlength="11">
									<div class="invalid-feedback"></div>
								</div>
							</div>

							<!-- 관리자일 경우에만 보이게하기 -->
							<sec:authorize access="hasRole('ROLE_ADMIN')">
								<div class="col-12" style="display: flex;">
									<div class="input-style-1 form-group col-2"
										style="margin-left: 15%;">
										<label for="fmtEncyDt" class="form-label required">입사일자<span
											class="text-danger"> *</span></label> <input type="date"
											class="form-control" id="fmtEncyDt" value="${formattedEncy}"
											required>
										<div class="invalid-feedback"></div>
										<input type="hidden" name="ecnyDate" id="ecnyDate">
									</div>
									<div class="input-style-1 form-group col-4"
										style="margin-left: 15%;">
										<label for="retireDate" class="form-label">퇴사일자</label>
										<c:choose>
											<c:when test="${emp.retireDate != null}">
												<input type="text" name="retireDate" class="form-control"
													id="retireDate" value="${emp.retireDate}">
											</c:when>
											<c:otherwise>
												<span>퇴사하지 않은 사원입니다.</span>
											</c:otherwise>
										</c:choose>
										<div class="invalid-feedback"></div>
									</div>
								</div>
								<div class="col-12" style="display: flex;">
									<div class="input-style-1 form-group col-2"
										style="margin-left: 15%">
										<label for="anslry" class="form-label required"
											style="margin-left: 10px;">급여<span
											class="text-danger"> *</span></label> <input type="text"
											name="anslry" class="form-control" id="anslry"
											value="${emp.anslry}" required>
										<div class="invalid-feedback"></div>
									</div>
									<div class="input-style-1 form-group col-3"
										style="margin-left: 10px;">
										<label for="acnutno" class="form-label required">계좌번호<span
											class="text-danger"> *</span></label> <input type="text"
											name="acnutno" class="form-control" id="acnutno"
											value="${emp.acnutno}" required>
										<div class="invalid-feedback"></div>
									</div>


									<%--  <div class="input-style-1 form-group col-2" style="margin-left: 10px;">
					            <label for="bankNm" class="form-label required">은행명<span class="text-danger"> *</span></label>
					            <input type="text" name="bankNm" class="form-control" id="bankNm" value="${emp.bankNm}" required>
					            <div class="invalid-feedback"></div>
					          </div> --%>

									<%--  <div class="input-style-1 form-group col-2" style="margin-left: 10px;">
								<label class="form-label required">은행명<span class="text-danger">*</span></label>
								<select class="form-select" name="bankNm" id="bankNm" value="${emp.bankNm}">
									<option value="">은행 선택</option>
									<option value="KB국민은행">KB국민은행</option>
									<option value="신한은행">신한은행</option>
									<option value="우리은행">우리은행</option>
									<option value="하나은행">하나은행</option>
									<option value="IBK기업은행">IBK기업은행</option>
									<option value="NH농협은행">NH농협은행</option>
									<option value="지역농협">지역농협</option>
									<option value="카카오뱅크">카카오뱅크</option>
									<option value="토스뱅크">토스뱅크</option>
									<option value="SC제일은행">SC제일은행</option>
									<option value="씨티은행">씨티은행</option>
								</select>
								<div class="invalid-feedback">은행을 선택헤주세요.</div>
				          	</div> --%>

									<c:set var="bankList"
										value="${['KB국민은행','신한은행','우리은행','하나은행','IBK기업은행','NH농협은행','지역농협','카카오뱅크','토스뱅크','SC제일은행','씨티은행']}" />
									<div class="input-style-1 form-group col-2"
										style="margin-left: 10px;">
										<label class="form-label required">은행명<span
											class="text-danger">*</span></label> <select class="form-select"
											name="bankNm" id="bankNm">
											<option value="">은행 선택</option>
											<c:forEach var="bank" items="${bankList}">
												<option value="${bank}"
													<c:if test="${emp.bankNm == bank}">selected</c:if>>
													${bank}</option>
											</c:forEach>
										</select>
										<div class="invalid-feedback">은행을 선택해주세요.</div>
									</div>


								</div>
								<div class="input-style-1 form-group col-6"
									style="margin-left: 15%;">
									<label for="partclrMatter" class="form-label">특이사항</label>
									<textarea rows="4" name="partclrMatter" id="partclrMatter"
										value="${emp.partclrMatter}">${emp.partclrMatter}</textarea>
									<div class="invalid-feedback"></div>
								</div>

							</sec:authorize>
							<div class="input-style-1 form-group col-8"
								style="margin-left: 15%;">
								<label for="cmmnCode" class="form-label required">주소 <span
									class="text-danger"></span></label>
								<div class="row">
									<div class="col-8">
										<div class="mb-4">
											<input type="text" name="adres" value="${emp.adres}"
												class="form-control address-select" id="adres"
												placeholder="주소를 입력하세요.">
											<div class="invalid-feedback restaurantAdd1"></div>
											<input type="text" name="detailAdres"
												value="${emp.detailAdres}" class="form-control mt-3"
												id="detailAdres" maxlength="30" placeholder="상세주소를 입력하세요.">
											<div class="invalid-feedback">상세주소를 입력해주세요</div>
										</div>
									</div>
								</div>
								<div class="invalid-feedback"></div>
							</div>
							<div class="content text-center">
								<button type="button" id="emplUpdateBtn"
									class="main-btn primary-btn-light square-btn btn-hover btn-sm mr-5">확인</button>
								<sec:authorize access="hasRole('ROLE_ADMIN')">
									<a href="/orglistAdmin"
										class="main-btn dark-btn-light square-btn btn-hover btn-sm">수정취소</a>
								</sec:authorize>
								<sec:authorize access="hasRole('ROLE_MEMBER')">
									<a href="/orglist"
										class="main-btn dark-btn-light square-btn btn-hover btn-sm">수정취소</a>
								</sec:authorize>
							</div>
						</div>
					</div>
				</form>
			</div>
		</section>
		<%@ include file="../layout/footer.jsp"%>
		<%@ include file="../layout/prescript.jsp"%>
		<script type="text/javascript">

 
// 부서코드 선택시 보여 줄 하위 부서팀
function lowerDepts(upperCmmnCode, emplNo){
	fetch('/getLowerdeptList?upperCmmnCode=' + upperCmmnCode + '&emplNo=' + emplNo , {
		method : 'get',
		headers: {
            "Content-Type": "application/json"
        }
	})
	.then(resp => resp.json())
	.then(res => {
		 // 여기서 $("#lowerDepartment") 내부 비우기
		  $("#lowerDepartment").html("");
		 
		 lowerDepList = res.lowerDep;
		 emplDetail = res.emplDetail;
		 console.log("선택한 부서의 하위부서 리스트 : ", lowerDepList);
		 console.log("사원 정보 : ", emplDetail);
		 
		 lowerDepList.map((lowerDep, idx) => {
				console.log("lowerDep : " , lowerDep.cmmnCode);
				console.log("사원의 부서 : " , emplDetail.deptCode);
				const id = idx;
				const deptChecked = lowerDep.cmmnCode === emplDetail.deptCode ? 'checked' : '';
				console.log("deptChecked" , deptChecked);
				 $("#lowerDepartment").append(
					`
					 <div class="flex">
						 <input type="radio" value="\${lowerDep.cmmnCode}" id="\${id}" name="deptCode" required \${deptChecked}>
			      		 <label for="\${id}">\${lowerDep.cmmnCodeNm}</label>
					 </div>
					`
				);
			 }) // end map      
			if(lowerDepList.length === 0){
				$("#lowerDepartment").append(
				 `<input type="hidden" value="00" name="deptCode" />`		
				 )
			}
		})
	}
	
$(function(){
	
	const employeeName = $('#emplNm').val();
	const employeeDeptCode = $('#hiddenDeptCode').val();
	
	console.log('사원이름 : ' , employeeName);
	console.log('부서코드 : ' , employeeDeptCode);
	
	//사원의 상위부서가 00(대표이사)일때 부서코드를 00으로 넘겨주기
	if(employeeDeptCode === '00'){
		$('#upperDept').val('00');
	}/* else{
		$('#hiddenUpperCmmnCode').val(employeeDeptCode);
		$('#upperDept').val(employeeDeptCode);
	} */

	$("#emplUpdateBtn").on("click", function(){
		
		let fmtEncyDt = $('#fmtEncyDt').val();
		if(fmtEncyDt != null){
			console.log("입사일자 : " ,fmtEncyDt);	
			let replaceEncy = fmtEncyDt.replaceAll('-', '');
			 //hidden input으로 값 바꿔주기
			$('#ecnyDate').val(replaceEncy);
		}
		 
		let ecnyDate = $('#ecnyDate').val();
		if(ecnyDate != null){
			let replaceEncyDt = ecnyDate.replaceAll('-', '');
			console.log(replaceEncyDt);
			$('#ecnyDate').val(replaceEncyDt);
		}
		
		// 생년월일 하이픈 없애는 처리
		let fmtBirth = $('#fmtBirth').val();
		let replaceBirth = fmtBirth.replaceAll('-', '');
		let brthdy = $('#brthdy').val(replaceBirth);
		console.log(brthdy.val());	
		// alert창 수정하기ㅡㅡ
	
		/* 	if(!$('input[name="deptCode"]:checked').val()){
			swal("하위 부서를 선택해주세요.");
			return;
		}else{ */
			//document.getElementById('emplUpdateForm').requestSubmit();
			swal({
			  title: "수정되었습니다.",
			  icon: "success",
			  draggable: true
			})
			.then((value) =>{
				$("#emplUpdateForm").submit();
			})
		/* } */
		});
	
	// 페이지 로딩시
	const upperCmmnCode = $('#upperDept').val();
	const emplNo = $('#hiddenEmplNo').val();
	lowerDepts(upperCmmnCode, emplNo);
	
	// 상위부서 변경될 시
	$('#upperDept').on('change', function(){
		const upperCmmnCode = $(this).val();
		const emplNo = $('#hiddenEmplNo').val();
		lowerDepts(upperCmmnCode, emplNo);
	})
});
	
	

</script>

	</main>


</body>
</html>
