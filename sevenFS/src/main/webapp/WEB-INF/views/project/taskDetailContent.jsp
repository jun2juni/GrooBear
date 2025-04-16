<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div data-task-no="${task.taskNo}">
	<div class="p-3">
		<h5 class="mb-3">
			<i class="fas fa-tasks me-2 text-primary"></i>업무 상세 정보
		</h5>

		<table class="table table-bordered table-sm">
			<tbody>
				<tr>
					<th class="bg-light w-25 text-center">상위 업무</th>
					<td class="ps-4 fw-bold">
						<c:choose>
							<c:when test="${not empty task.parentTaskNm}">
								${task.parentTaskNm}
							</c:when>
							<c:otherwise>
								<span class="text-muted">없음</span>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th class="bg-light text-center">업무명</th>
					<td class="ps-4">${task.taskNm != null ? task.taskNm : '업무명이 비어있음'}</td>
				</tr>
				<tr>
					<th class="bg-light text-center">담당자</th>
					<td class="ps-4">${task.chargerEmpNm != null ? task.chargerEmpNm : '담당자 없음'}</td>
				</tr>
				<tr>
					<th class="bg-light text-center">기간</th>
					<td class="ps-4">
						<fmt:formatDate value="${task.taskBeginDt}" pattern="yyyy-MM-dd" /> ~ 
						<fmt:formatDate value="${task.taskEndDt}" pattern="yyyy-MM-dd" />
					</td>
				</tr>
				<tr>
					<th class="bg-light text-center">중요도</th>
					<td class="ps-4">
						<c:choose>
							<c:when test="${task.priort == '00'}">낮음</c:when>
							<c:when test="${task.priort == '01'}">보통</c:when>
							<c:when test="${task.priort == '02'}">높음</c:when>
							<c:when test="${task.priort == '03'}">긴급</c:when>
							<c:otherwise>-</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th class="bg-light text-center">등급</th>
					<td class="ps-4">${task.taskGrad}</td>
				</tr>
				<tr>
					<th class="bg-light text-center">업무 내용</th>
					<td class="ps-4">${task.taskCn}</td>
				</tr>
			</tbody>
		</table>

		<c:if test="${not empty task.attachFileList}">
			<h6 class="mt-4">
				<i class="fas fa-paperclip me-2 text-secondary"></i>첨부 파일
			</h6>
			<ul class="list-group mt-2">
				<c:forEach var="file" items="${task.attachFileList}">
					<li class="list-group-item d-flex justify-content-between align-items-center">
						<span><i class="fas fa-file-alt me-2 text-primary"></i>${file.fileNm}</span>
						<a href="/projectTask/download?fileName=${file.fileStrePath}" class="btn btn-sm btn-outline-success">
							<i class="fas fa-download"></i>
						</a>
					</li>
				</c:forEach>
			</ul>
		</c:if>
	</div>
</div>

<script>
	const currentTaskNo = "${task.taskNo}";
	function goToTaskEdit(taskNo) {
		location.href = `/projectTask/editForm?taskNo=\${taskNo}`;
	}
</script>
