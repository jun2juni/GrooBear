<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
.modalBtn{
	padding: 10px 20px;
	font-size: 1.1em;
}
.dragging {
  opacity: 0.5;
  background-color: #f0f8ff;
}

.drop-highlight {
  background-color: #e0f7fa;
}
</style>
	<!-- 결재선 지정 모달창 시작 -->
	<div class="modal fade" id="atrzLineModal" tabindex="-1" aria-labelledby="atrzLineModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-xl modal-dialog-centered">
		<div class="modal-content rounded-4 shadow-lg">
			<div class="modal-header border-0 pb-0">
			<h5 class="modal-title fw-bold" id="atrzLineModalLabel">결재선 지정</h5>
			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
			</div>
	
			<div class="modal-body pt-2">
			<div class="row g-4">
				<!-- 좌측: 조직도 선택 -->
				<div class="col-md-4">
				<div class="border rounded-4 p-3 d-flex flex-column h-100 shadow-sm">
					<!-- 검색창 -->
					<div class="mb-3">
					<c:import url="../organization/searchBar.jsp" />
					</div>
					<!-- 조직도 -->
					<div class="flex-grow-1 overflow-auto" style="max-height: 500px;">
					<c:import url="../atrz/orgList.jsp" />
					</div>
				</div>
				</div>
	
				<!-- 중간: 버튼 -->
				<div class="col-md-1 d-flex flex-column justify-content-center align-items-center py-3">
				<!-- 결재선 버튼 -->
				<div class="d-flex flex-column gap-3">
					<button id="add_appLine" type="button" class="btn btn-outline-success btn-lg rounded-3">→</button>
					<button id="remo_appLine" type="button" class="btn btn-outline-danger  btn-lg rounded-3">←</button>
				</div>
				<!-- 참조자 버튼 -->
				<div class="d-flex flex-column gap-3 mt-4">
					<button id="add_attLine" type="button" class="btn btn-outline-success btn-lg rounded-3">→</button>
					<button id="remo_attLine" type="button" class="btn btn-outline-danger  btn-lg rounded-3">←</button>
				</div>
				</div>
	
				<!-- 우측: 결재선/참조자 리스트 -->
				<div class="col-md-7">
				<div class="border rounded-4 p-3 shadow-sm">
					<!-- 결재선 리스트 -->
					<h6 class="fw-bold">결재선 리스트</h6>
					<hr />
					<table class="table table-hover align-middle text-center">
					<thead class="table-light">
						<tr>
						<th>NO</th>
						<th>이름</th>
						<th>부서</th>
						<th>직급</th>
						<th hidden>권한</th>
						<th>전결여부</th>
						</tr>
					</thead>
					<tbody class="s_appLine_tbody_new"></tbody>
					</table>
	
					<!-- 참조자 리스트 -->
					<h6 class="fw-bold mt-5">참조자 리스트</h6>
					<hr />
					<table class="table table-hover align-middle text-center">
					<thead class="table-light">
						<tr>
						<th hidden>NO</th>
						<th></th>
						<th>이름</th>
						<th>부서</th>
						<th>직급</th>
						<th></th>
						<!-- <th style="visibility: hidden;">전결여부</th> -->
						</tr>
					</thead>
					<tbody class="s_appLine_tbody_ref"></tbody>
					</table>
				</div>
				</div>
			</div>
			</div>
	
			<div class="modal-footer border-0 mt-3">
			<button type="button" class="btn btn-light rounded-4 px-5 py-2" data-bs-dismiss="modal">취소</button>
			<button id="s_add_appLine_list" type="button" class="btn btn-primary rounded-4 px-5 py-2">확인</button>
			</div>
		</div>
		</div>
	</div>
	<!-- 결재선 지정 모달창 끝 -->