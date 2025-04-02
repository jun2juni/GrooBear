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
			<div class="input-style-1 form-group col-8" style="margin-left: 15%;">
				<label for="cmmnCodeNm" class="form-label required">부서명 <span
					class="text-danger">*</span></label> 
					<input type="text" name="cmmnCodeNm" class="form-control" id="cmmnCodeNm" required>
				<div class="invalid-feedback">부서명을 작성하세요.</div>
			</div>
			<div class="input-style-1 form-group col-8" style="margin-left: 15%;">
				<label for="upperCmmnCode" class="form-label required">소속부서
						<span class="text-danger">*</span>
				</label> 
				<select id="duration" class="form-select w-auto" name="upperCmmnCode">
						<option value="#">없음</option>
					<c:forEach var="departList" items="${depList}">
						<option value="${departList.cmmnCode}">${departList.cmmnCodeNm}</option>
					</c:forEach>
				</select>
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

	
</script>
  
</main>


</body>
</html>
