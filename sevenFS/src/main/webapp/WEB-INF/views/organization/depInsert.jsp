<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--해당 파일에 타이틀 정보를 넣어준다--%>

<form action="/depInsertPost" method="post" id="depInsertForm">
	<div class="card-style chat-about h-100"
		style="justify-content: center;">
		<h6 class="text-sm text-medium"></h6>
		<div class="chat-about-profile">
			<div class="content text-center">
				<h5 class="text-bold mb-10"></h5>
				<span class="status-btn info-btn">DEPARTMENT</span>
			</div>
		</div>
		<div class="activity-meta text-start" style="margin-top: 20px;">
		
			<%-- 상위부서 값 --%>
			<%-- 여기가 실제 보내야할 값 --%>
			<div class="input-style-1 form-group col-8" style="margin-left: 15%;">
				<label for="upperDep" class="form-label required">부서
						<span class="text-danger">*</span>
				</label> 
				<select id="upperDep" class="form-select w-auto" name="upperCmmnCode" >
					<c:forEach var="upperDep" items="${upperList}">
						<option value="${upperDep.cmmnCode}" id="upperDepClick">${upperDep.cmmnCodeNm}</option>
					</c:forEach>
				</select>
			</div>
			
			<%-- 부서 선택하면 소속팀 출력 --%>
			<%--
			<div class="form-group col-8" style="margin-left: 15%;">
				<label for="" class="form-label required">소속팀
						<span class="text-danger">*</span>
				</label> 
			    <div class="" id="lowerDepartment">
			    
			    </div>
			</div>
			 --%>
			
			<div class="input-style-1 form-group col-8" style="margin-left: 15%;">
				<label for="cmmnCodeNm" class="form-label required">부서명 <span
					class="text-danger">*</span></label> 
					<input type="text" name="cmmnCodeNm" class="form-control" id="cmmnCodeNm" required>
				<div class="invalid-feedback">부서명을 작성하세요.</div>
			</div>
			<div class="input-style-1 form-group col-8" style="margin-left: 15%;">
				<label for="cmmnCodeDc" class="form-label required">부서설명
					<span class="text-danger">*</span>
				</label> 
				<input type="text" name="cmmnCodeDc" class="form-control" id="cmmnCodeDc" required>
				<div class="invalid-feedback"></div>
			</div>
			<div class="content text-center">
				<button type="button" id="insertBtn"
					class="main-btn success-btn-light square-btn btn-hover btn-sm">확인</button>
			</div>
		</div>
	</div>
</form>    

<script type="text/javascript">
/* $(function(){
	
	$("#upperDep").on("change", function(){
		const upperCmmnCode = this.value;
		console.log("선택한 상위부서 : " , upperCmmnCode);
		
		// 상위코드 보내서 비동기로 보내기
		fetch("/getLowerdeptList?upperCmmnCode="+upperCmmnCode, {
			method : "get",
		    headers : {
		        "Content-Type": "application/json"
	       }
		}) // end fetch
		.then(resp => resp.json())
		.then(res => {
			console.log("선택한 부서의 하위부서 리스트 : ", res);
			
			//const lowerSelect = $("#lowerDepartment");
			
			 res.map((lowerDep) => {
					console.log("lowerDep : " , lowerDep.cmmnCodeNm);
					$("#lowerDepartment").append(
						`
						 <input type="radio" value="\${lowerDep.cmmnCode}" id="lower">
			      		 <label for="lower">\${lowerDep.cmmnCodeNm}</label>
						`
					); 
	 			 }) // end map   
	 			 
	 			 
	 			 
		})// end result
	}) // end click event
	
}); // end fn */

// 동적으로 만든 라디오 클릭시
/* $(document).on('change', "input:radio[name='upperCmmnCode']", function() {
    const val = $("#lower").val();
    console.log(val);
 }); */

	
</script>
  
</main>


</body>
</html>
