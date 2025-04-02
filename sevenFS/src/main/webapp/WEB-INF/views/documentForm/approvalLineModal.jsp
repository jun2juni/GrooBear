<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
#s_btn_i{

}
</style>

<!-- 결재선 지정 모달창 시작 -->
	<div class="modal fade" id="atrzLineModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">결재선지정</h1>
					<button type="button" class="btn-close"
						data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="row">
						<!-- 좌측 결재선사원선택부분 시작 -->
						<div class="col-sm-5">
							<div class="s_scroll"
								style="float: left; border: 1px solid lightgray; height: 500px; padding: 20px; border-radius: 10px; overflow: auto;">
								<div class="row">
								<!-- 검색 -->
								<nav class="navbar navbar-light"
									style="float: right;">
									<div class="container-fluid">
										<input class="form-control me-2" placeholder="Search"
											aria-label="Search" id="search" value=""
											style="width: 100px;">
									</div>
								</nav>
								<!-- 버튼 -->
								<div style="float: left; margin-top: 10px; margin-bottom: 10px;">
									<button class="btn btn-outline-success"
										onclick="openTree();">OPEN</button>
									<button class="btn btn-outline-dark"
										onclick="closeTree();">CLOSE</button>
								</div>
								<!-- 조직도 -->
								<div id="oraganList" class="form-control" style="height: 320px;">
									<table >
										<tbody>
											<th>
											<tr>사원명</tr>
											</th>
											
										</tbody>
									
									</table>
									<p>여기에 조직도 트리가 들어가야함</p>
								</div>
								</div>
							</div>
						</div>
						<!-- 좌측 결재선사원선택부분 끝 -->
						<!-- 결재선 추가 삭제 버튼 공간 시작-->
						<div class="col-sm-1">
							<div id="atrzLineAddRemBtn"
								style="height: 500px; padding-top: 180px;">
								<button type="button" class="btn btn-secondary"
									style="margin-bottom: 70px;">
									<i class="lni lni-arrow-right"></i>
								</button>
								<button type="button" class="btn btn-secondary">
									<i class="lni lni-arrow-left"></i>
								</button>
								<span> <i class="bi bi-arrow-left-square-fill"
									style="background-color: pink"></i>
								</span>
							</div>
						</div>
						<!-- 결재선 추가 삭제 버튼 공간 끝-->
						<!-- 결재선리스트 -->
						<div class="col-sm-5"
							style="float: left; text-align: center; margin-left: 20px;">
							<div style="font-size: 1.2em; font-weight: bold;">결재선
								리스트</div>
							<div
								style="border-bottom: 1px solid lightgray; margin: 20px 0;"></div>
							<table class="table">
								<thead>
									<tr>
										<th scope="col">NO</th>
										<th scope="col">이름</th>
										<th scope="col">부서</th>
										<th scope="col">직책</th>
										<th scope="col">권한</th>
										<th scope="col">전결여부</th>
									</tr>
								</thead>
								<!-- 여기에 결재선지정 사람들이 들어가야함 -->
								<tbody class="s_appLine_tbody_cl"
									style="text-align: center; width: 300px;">
									<tr>
										<th>1</th>
										<th>길준희</th>
										<th>회계1팀</th>
										<th>사원</th>
										<th>
											<select class="form-select" aria-label="Default select example" style="width: 70px;">
												<option selected>결재</option>
												<option value="1">참조</option>
											</select>
										</th>
										<th>
											<div class="form-check">
												<input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
											  </div>
										</th>

									</tr>

								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary">확인</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 결재선지정 모달창 끝 -->