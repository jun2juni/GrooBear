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
				</div>	
			 </div>		
		</section>
		<%@ include file="../layout/footer.jsp"%>
	</main>
	<%@ include file="../layout/prescript.jsp"%>
</body>
</html>
