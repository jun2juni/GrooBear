<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
					<div class="row ">
						<!-- 좌측 결재선사원선택부분 시작 -->
						<div class="col-md-3 flex-grow-1">
							<div class="s_scroll"
								style="float: left; border: 1px solid lightgray; height: 500px; padding: 20px; border-radius: 10px; overflow: auto;">
								<div class="row">
								<!-- 버튼 -->
								<!-- 조직도 -->
									<c:import url="../atrz/orgList.jsp"></c:import>
								
								</div>
							</div>
						</div>
						<!-- 좌측 결재선사원선택부분 끝 -->
						<!-- 결재선 추가 삭제 버튼 공간 시작-->
						<div class="col-sm-1">
							<div id="atrzLineAddRemBtn"
								style="height: 500px; padding-top: 180px;">
								<button id="add_appLine" type="button" class="btn btn-secondary"
									style="margin-bottom: 70px;">
									<i class="lni lni-arrow-right"></i>
								</button>
								<button id="remo_appLine" type="button" class="btn btn-secondary">
									<i class="lni lni-arrow-left"></i>
								</button>
								<span> <i class="bi bi-arrow-left-square-fill"
									style="background-color: pink"></i>
								</span>
							</div>
						</div>
						<!-- 결재선 추가 삭제 버튼 공간 끝-->
						<!-- 결재선리스트 -->
						<div class="col-sm-7"
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
									style="text-align: center;">


								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
					<button id="s_add_appLine_list" type="button" class="btn btn-primary">확인</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 결재선지정 모달창 끝 -->
