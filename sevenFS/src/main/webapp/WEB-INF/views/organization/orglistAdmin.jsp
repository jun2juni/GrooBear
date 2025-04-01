<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<%@ include file="organizationList.jsp" %>
<script>
	$('#employeeDetail').html(`
			<p style="margin-top: 150px;">
				<span class="material-symbols-outlined">group_add</span>
				변경할 부서와 사원을 선택해주세요.
			</p>
	`);
</script>