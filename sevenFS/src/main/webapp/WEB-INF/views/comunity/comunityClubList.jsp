<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%--해당 파일에 타이틀 정보를 넣어준다--%>
<c:set var="title" scope="application" value="메인" />

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
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
				<div class="row mt-5">
					<div class="col-12">
						<div class="card-style">
							<!-- 상위탭 시작  -->
							<div>
								<ul class="nav nav-tabs" id="myTab" role="tablist">
									<li class="nav-item" role="presentation">
										<button class="nav-link" id="tab1" data-bs-toggle="tab"
											data-bs-target="#content1" type="button"
											onClick="location.href='comunityHome'" role="tab"
											aria-controls="content1" aria-selected="true">Home</button>
									</li>
									<li class="nav-item" role="presentation">
										<button class="nav-link" id="tab2" data-bs-toggle="tab"
											data-bs-target="#content2" type="button" role="tab"
											onClick="location.href='comunityClubList'"
											aria-controls="content2" aria-controls="content2"
											aria-selected="false">동호회1</button>
									</li>
									<li class="nav-item" role="presentation">
										<button class="nav-link" id="tab3" data-bs-toggle="tab"
											data-bs-target="#content3" type="button" role="tab"
											aria-controls="content3" aria-selected="false">동호회2</button>
									</li>
									<li class="nav-item" role="presentation">
										<button class="nav-link" id="tab4" data-bs-toggle="tab"
											data-bs-target="#content4" type="button"
											onClick="location.href='comunityMonthMenuList'" role="tab"
											aria-controls="content4" aria-selected="false">월별식단표</button>
									</li>
								</ul>
							</div>
						</div>
					</div>
					<div class="row-5">
			            <div class="col-12">
			              <div class="card-style mb-30">
			                <h6 class="mb-10">Data Table</h6>
			                <p class="text-sm mb-20">
			                  For basic styling—light padding and only horizontal
			                  dividers—use the class table.
			                </p>
			                <div class="table-wrapper table-responsive">
			                  <table class="table">
			                    <thead>
			                      <tr>
			                        <th>
			                          <h6>#</h6>
			                        </th>
			                        <th>
			                          <h6>Name</h6>
			                        </th>
			                        <th>
			                          <h6>Email</h6>
			                        </th>
			                        <th>
			                          <h6>Project</h6>
			                        </th>
			                        <th>
			                          <h6>Status</h6>
			                        </th>
			                        <th>
			                          <h6>Action</h6>
			                        </th>
			                      </tr>
			                      <!-- end table row-->
			                    </thead>
			                    <tbody>
			                      <tr>
			                        <td>
			                          <div class="employee-image">
			                            <img src="assets/images/lead/lead-1.png" alt="">
			                          </div>
			                        </td>
			                        <td class="min-width">
			                          <p>Esther Howard</p>
			                        </td>
			                        <td class="min-width">
			                          <p><a href="#0">yourmail@gmail.com</a></p>
			                        </td>
			                        <td class="min-width">
			                          <p>Admin Dashboard Design</p>
			                        </td>
			                        <td class="min-width">
			                          <span class="status-btn active-btn">Active</span>
			                        </td>
			                        <td>
			                          <div class="action">
			                            <button class="text-danger">
			                              <i class="lni lni-trash-can"></i>
			                            </button>
			                          </div>
			                        </td>
			                      </tr>
			                      <!-- end table row -->
			                      <tr>
			                        <td>
			                          <div class="employee-image">
			                            <img src="assets/images/lead/lead-2.png" alt="">
			                          </div>
			                        </td>
			                        <td class="min-width">
			                          <p>D. Jonathon</p>
			                        </td>
			                        <td class="min-width">
			                          <p><a href="#0">yourmail@gmail.com</a></p>
			                        </td>
			                        <td class="min-width">
			                          <p>React Dashboard</p>
			                        </td>
			                        <td class="min-width">
			                          <span class="status-btn active-btn">Active</span>
			                        </td>
			                        <td>
			                          <div class="action">
			                            <button class="text-danger">
			                              <i class="lni lni-trash-can"></i>
			                            </button>
			                          </div>
			                        </td>
			                      </tr>
			                      <!-- end table row -->
			                      <tr>
			                        <td>
			                          <div class="employee-image">
			                            <img src="assets/images/lead/lead-3.png" alt="">
			                          </div>
			                        </td>
			                        <td>
			                          <p>John Doe</p>
			                        </td>
			                        <td>
			                          <p><a href="#0">yourmail@gmail.com</a></p>
			                        </td>
			                        <td>
			                          <p>Bootstrap Template</p>
			                        </td>
			                        <td>
			                          <span class="status-btn success-btn">Done</span>
			                        </td>
			                        <td>
			                          <div class="action">
			                            <button class="text-danger">
			                              <i class="lni lni-trash-can"></i>
			                            </button>
			                          </div>
			                        </td>
			                      </tr>
			                      <!-- end table row -->
			                      <tr>
			                        <td>
			                          <div class="employee-image">
			                            <img src="assets/images/lead/lead-4.png" alt="">
			                          </div>
			                        </td>
			                        <td>
			                          <p>Rayhan Jamil</p>
			                        </td>
			                        <td>
			                          <p><a href="#0">yourmail@gmail.com</a></p>
			                        </td>
			                        <td>
			                          <p>Css Grid Template</p>
			                        </td>
			                        <td>
			                          <span class="status-btn info-btn">Pending</span>
			                        </td>
			                        <td>
			                          <div class="action">
			                            <button class="text-danger">
			                              <i class="lni lni-trash-can"></i>
			                            </button>
			                          </div>
			                        </td>
			                      </tr>
			                      <!-- end table row -->
			                      <tr>
			                        <td>
			                          <div class="employee-image">
			                            <img src="assets/images/lead/lead-5.png" alt="">
			                          </div>
			                        </td>
			                        <td>
			                          <p>Esther Howard</p>
			                        </td>
			                        <td>
			                          <p><a href="#0">yourmail@gmail.com</a></p>
			                        </td>
			                        <td>
			                          <p>Admin Dashboard Design</p>
			                        </td>
			                        <td>
			                          <span class="status-btn close-btn">Close</span>
			                        </td>
			                        <td>
			                          <div class="action">
			                            <button class="text-danger">
			                              <i class="lni lni-trash-can"></i>
			                            </button>
			                          </div>
			                        </td>
			                      </tr>
			                      <!-- end table row -->
			                      <tr>
			                        <td>
			                          <div class="employee-image">
			                            <img src="assets/images/lead/lead-6.png" alt="">
			                          </div>
			                        </td>
			                        <td>
			                          <p>Anee Doe</p>
			                        </td>
			                        <td>
			                          <p><a href="#0">yourmail@gmail.com</a></p>
			                        </td>
			                        <td>
			                          <p>Space Template Update</p>
			                        </td>
			                        <td>
			                          <span class="status-btn active-btn">Active</span>
			                        </td>
			                        <td>
			                          <div class="action">
			                            <button class="text-danger">
			                              <i class="lni lni-trash-can"></i>
			                            </button>
			                          </div>
			                        </td>
			                      </tr>
			                      <!-- end table row -->
			                    </tbody>
			                  </table>
			                  <!-- end table -->
			                </div>
			              </div>
			              <!-- end card -->
			            </div>
	            <!-- end col -->
	          </div>
				</div> <!--탭 끝나는지점  -->	
					
			 </div>	<!--fluid  -->
		</section>
		<%@ include file="../layout/footer.jsp"%>
	</main>
	<%@ include file="../layout/prescript.jsp"%>
</body>
</html>
