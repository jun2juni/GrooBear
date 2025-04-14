<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
.modalBtn{
	padding: 10px 20px;
	font-size: 1.1em;
}
</style>
<!-- 결재선 지정 모달창 시작 -->
	<div class="modal fade" id="atrzLineModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">결재선지정</h1>
					<button type="button" class="btn-close"
						data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="row">
						<!-- 좌측 결재선사원선택부분 시작 -->
						<div class="col-md-3 flex-grow-1">
							<div class="s_scroll" style="float: left; border: 1px solid lightgray; height: 500px; padding: 20px; border-radius: 10px; overflow: hidden; display: flex; flex-direction: column;">
								<!-- 검색창 -->
								<div style="flex-shrink: 0; margin-bottom: 20px;">
									<c:import url="../organization/searchBar.jsp"></c:import>
								</div>
								<!-- 조직도 -->
								<div style="flex-grow: 1; overflow: auto;">
									<c:import url="../atrz/orgList.jsp"></c:import>
								</div>
							</div>
						</div>
						<!-- 좌측 결재선사원선택부분 끝 -->
						<!-- 결재선 추가 삭제 버튼 공간 시작-->
						<div class="col-sm-1 d-flex flex-column align-items-center" style="padding-top: 180px;">

							<!-- 위쪽 세트 -->
							<div class="d-flex flex-column align-items-center" style="gap: 5px; margin-bottom: 80px;">
								<button id="add_appLine" type="button" class="btn btn-secondary">
								<i class="lni lni-arrow-right"></i>
								</button>
								<button id="remo_appLine" type="button" class="btn btn-secondary">
								<i class="lni lni-arrow-left"></i>
								</button>
							</div>
							<!-- 아래쪽 세트 -->
							<div class="d-flex flex-column align-items-center" style="gap: 5px;">
								<button id="add_attLine" type="button" class="btn btn-secondary">
								<i class="lni lni-arrow-right"></i>
								</button>
								<button id="remo_attLine" type="button" class="btn btn-secondary">
								<i class="lni lni-arrow-left"></i>
								</button>
							</div>
						</div>
						<!-- 결재선 추가 삭제 버튼 공간 끝-->
						<!-- 결재선리스트 -->
						<div class="col-sm-7" style="float: left; text-align: center; margin-left: 20px;">
							<div style="font-size: 1.2em; font-weight: bold;">결재선 리스트</div>
							<div style="border-bottom: 1px solid lightgray; margin: 20px 0;"></div>
							<table class="table">
								<thead>
									<tr>
										<th scope="col">NO</th>
										<th scope="col">이름</th>
										<th scope="col">부서</th>
										<th scope="col">직책</th>
										<th scope="col" hidden>권한</th>
										<th scope="col">전결여부</th>
									</tr>
								</thead>
								<!-- 여기에 결재선지정 사람들이 들어가야함 -->
								<tbody class="s_appLine_tbody_new" style="text-align: center;">
								</tbody>
							</table>
							<div style="margin-top: 50px;">	
								<div style="font-size: 1.2em;font-weight: bold;">참조자 리스트</div>
									<div style="border-bottom: 1px solid lightgray; margin: 20px 0;"></div>
									<table class="table">
										<thead>
											<tr>
											<th scope="col">NO</th>
											<th scope="col">참조자명</th>
											<th scope="col">부서</th>
											<th scope="col">직급</th>
											</tr>
										</thead>
									<tbody class="s_appLine_tbody_ref" style="text-align: center;">
									</tbody>
									</table>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="main-btn light-btn rounded-full btn-hover modalBtn"
						data-bs-dismiss="modal">취소</button>
					<button id="s_add_appLine_list" type="button" class="main-btn primary-btn rounded-full btn-hover modalBtn">확인</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 결재선지정 모달창 끝 -->
