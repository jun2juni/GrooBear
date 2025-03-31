<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="메인" />

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<meta
			name="viewport"
			content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"
	/>
	<meta http-equiv="X-UA-Compatible" content="ie=edge" />
	<title>${title}</title>
	<c:import url="../layout/prestyle.jsp" />
</head>
<body>
<c:import url="../layout/sidebar.jsp" />
<main class="main-wrapper">
	<c:import url="../layout/header.jsp" />
	
	<section class="section">
		<div class="container-fluid">
			
			 <div class="row">
          <div class="col-xl-3 col-lg-4 col-sm-6">
            <div class="icon-card mb-30">
            
              <div class="icon orange">
                <i class="lni lni-user"></i>
              </div>
              <div class="content">
	              <h6>근무</h6>
                <h3 style="margin-top: 20px;" class="text-bold mb-10">1건</h3>
                <p class="text-sm text-success">
                  <span class="text-gray"></span>
                </p>
              </div>
            </div>
            <!-- End Icon Cart -->
          </div>
          <!-- End Col -->
          <div class="col-xl-3 col-lg-4 col-sm-6">
            <div class="icon-card mb-30">
              <div class="icon success">
                <i class="lni lni-users"></i>
              </div>
              <div class="content">
                <h6 class="mb-10">출장</h6>
                <h3 style="margin-top: 20px;" class="text-bold mb-10">3건</h3>
                <p class="text-sm text-success">
                  <span>외근 1</span> / 
                  <span>출장 2</span>
                </p>
              </div>
            </div>
            <!-- End Icon Cart -->
          </div>
          <!-- End Col -->
          
          <!-- End Col -->
          <div class="col-xl-3 col-lg-4 col-sm-6">
            <div class="icon-card mb-30">
              <div class="icon orange">
                <i class="lni lni-smile"></i>
              </div>
              <div class="content">
                <h6 class="mb-10">휴가</h6>
                <h3 style="margin-top: 20px;" class="text-bold mb-10">1건</h3>
                <p class="text-sm text-success">
                  <span>병가 1</span>
                </p>
              </div>
            </div>
            <!-- End Icon Cart -->
          </div>
          <div class="col-xl-3 col-lg-4 col-sm-6">
            <div class="icon-card mb-30">
              <div class="icon primary">
                <i class="lni lni-alarm-clock"></i>
              </div>
              <div class="content">
                <h6 class="mb-10">기타</h6>
                <h3 style="margin-top: 20px;" class="text-bold mb-10">3건</h3>
                <p class="text-sm text-danger">
                  <span>지각 2</span> / 
                  <span>조퇴 1</span>
                </p>
              </div>
            </div>
            <!-- End Icon Cart -->
          </div>
          <!-- End Col -->
        </div>
        <!-- End Row -->
        
        <div class="row">
          <div class="">
            <div class="card-style mb-30">
              <div class="title d-flex flex-wrap justify-content-between align-items-center">
                <div style="width: 50%">
                  <h6 class="text-medium mb-30">전체 근무일자</h6>
                </div>
                <div class="right">
                  <div class="select-style-1">
                    <div class="select-position select-sm">
                      <select class="light-bg">
                        <option value="">Yearly</option>
                        <option value="">Monthly</option>
                        <option value="">Weekly</option>
                      </select>
                    </div>
                  </div>
                  <!-- end select -->
                </div>
              </div>
              <!-- End Title -->
              <div class="table-responsive">
                <table class="table top-selling-table">
                  <thead>
                    <tr>
                      <th></th>
                      <th>
                        <h6 class="text-sm text-medium">일자</h6>
                      </th>
                      <th class="min-width">
                        <h6 class="text-sm text-medium">업무시작</h6>
                      </th>
                      <th class="min-width">
                        <h6 class="text-sm text-medium">업무종료</h6>
                      </th>
                      <th class="min-width">
                        <h6 class="text-sm text-medium">총 근무시간</h6>
                      </th>
                    </tr>
                  </thead>
                  
                  <!-- 반복문 돌리기 -->
                  <tbody>
                    <tr>
                      <td>
                        <div class="check-input-primary">
                          <input class="form-check-input" type="checkbox" id="checkbox-1">
                        </div>
                      </td>
                      <td>
                        <div>
                          <p class="text-sm">근태 번호 ?</p>
                        </div>
                      </td>
                      <td>
                        <p class="text-sm">08 : 50 ~ </p>
                      </td>
                      <td>
                        <p class="text-sm">19 : 00</p>
                      </td>
                      <td>
                        <p class="text-sm">43</p>
                      </td>
                    </tr>
                  </tbody>
                </table>
                <!-- End Table -->
              </div>
            </div>
          </div>
          <!— End Col —>
        </div>
			
		</div>
	</section>
	<c:import url="../layout/footer.jsp" />
</main>
<c:import url="../layout/prescript.jsp" />
</body>
</html>
