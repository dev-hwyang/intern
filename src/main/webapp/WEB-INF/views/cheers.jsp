<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>

<!-- Favicon -->
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath }/resources/assets/img/favicon/favicon.ico">

<!-- Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="">
<link
	href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&amp;display=swap"
	rel="stylesheet">

<!-- Icons. Uncomment required icon fonts -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/assets/vendor/fonts/boxicons.css">

<!-- Core CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendor/css/core.css"
	class="template-customizer-core-css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/assets/vendor/css/theme-default.css"
	class="template-customizer-theme-css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/demo.css">

<!-- Vendors CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css">

<!-- Helpers -->
<script src="${pageContext.request.contextPath }/resources/assets/vendor/js/helpers.js"></script>

<script src="${pageContext.request.contextPath }/resources/assets/js/config.js"></script>

<meta charset="UTF-8">
<title>짜잔</title>
</head>
<body>
	<%@include file="tiles/aside.jsp"%>
	<%@include file="tiles/header.jsp"%>

	<!-- Content -->

	<div class="container-xxl flex-grow-1 container-p-y">
		<h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">해보자 /</span> 오옝</h4>
		</h4>

		<hr class="my-5" />

		<div class="row">
			<!-- Basic Layout -->
			<div class="col-xxl">
				<div class="card mb-4">
					<div class="card-header d-flex align-items-center justify-content-between">
						<h5 class="mb-0">관심가져주셔서</h5>
						<small class="text-muted float-end">화이팅...</small>
					</div>
					<div class="card-body">
						감사합니다
					</div>
				</div>
			</div>
		</div>

		<hr class="my-5" />

	</div>
	<!-- / Content -->
	<%@include file="tiles/footer.jsp"%>
</body>
</html>