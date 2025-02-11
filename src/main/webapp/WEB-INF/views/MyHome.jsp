<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
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
<title>목록</title>
</head>
<body>
<%-- 	<%UserMember user = (UserMember)SecurityContextHolder.getContext().getAuthentication().getPrincipal(); %> --%>
	
	<%@include file="tiles/aside.jsp"%>
	<%@include file="tiles/header.jsp"%>

	<!-- Content -->

	<div class="container-xxl flex-grow-1 container-p-y">
		<h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">메뉴 /</span> 게시글 목록보기</h4>

		<hr class="my-5" />

		<!-- Bootstrap Table with Header - Light -->
		<div class="card">
			<form id="searchForm">
				<div class="row">
				<h5 class="card-header col-md-8">게시판 목록</h5>
				<div class="input-group input-group-merge col-md-3" style="width: 30%; padding: 24px;">
					<select class="form-select" name="searchType" id="searchType" style="border-color: #696cff;">
						<option value="title" <c:if test="${searchType eq 'title' }">selected</c:if>>제목</option>
						<option value="writer" <c:if test="${searchType eq 'writer' }">selected</c:if>>작성자</option>
					</select>
					<input type="text" class="form-control" placeholder="검색하기" value="${searchWord }" name="searchWord" id="searchWord" style="border-color: #696cff;" autocomplete="off" />
					<button type="button" id="searchBtn" class="btn btn-outline-primary"><i class="bx bx-search"></i></button>
					</div>
				</div>
			</form>
			<div class="table-responsive text-nowrap">
				<table class="table">
					<thead class="table-light">
						<tr style="text-align: center;">
							<th style="width: 5%">번호</th>
							<th style="width: 55%">제목</th>
							<th style="width: 15%">작성자</th>
							<th style="width: 5%">조회수</th>
							<th style="width: 15%">등록일</th>
						</tr>
					</thead>
					<tbody class="table-border-bottom-0">
						<c:if test="${empty list }">
							<tr>
								<th style="text-align: center; font-size: medium;" colspan="6">등록된 게시글이 없습니다.</th>
							</tr>
						</c:if>
						<c:forEach items="${list }" var="list">
							<tr>
								<th scope="row" style="text-align: center;">${list.boNo }</th>
								<td style="text-align: center;"><i class="fab fa-angular fa-lg text-danger me-3"></i>
									<a href="/intern/detail?boNo=${list.boNo }"><strong>${list.boTitle }</strong></a></td>
								<td style="text-align: center;">${list.memName }</td>
								<th scope="row" style="text-align: center;">${list.boHit }</th>
								<th scope="row" style="text-align: center;">${list.boRegDate }</th>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<!-- Bootstrap Table with Header - Light -->

		<hr class="my-5" />

		<div class="row justify-content-end">
			<div class="col-sm-2">
				<button type="button" class="btn btn-primary" id="registerBtn">등록하기</button>
			</div>
		</div>

	</div>
	<!-- / Content -->
	<%@include file="tiles/footer.jsp"%>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	var registerBtn = $("#registerBtn");
	var searchBtn = $("#searchBtn");
	
	registerBtn.on("click", function() {
		location.href="/intern/register";
	});
	
	searchBtn.on("click", function() {
		searchForm.submit();
	});
	
});
</script>
</html>