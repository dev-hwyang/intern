<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="soft.euclid.intern.vo.UserMember"%>
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
<title>회원목록</title>
</head>
<body>
<%-- 	<%UserMember user = (UserMember)SecurityContextHolder.getContext().getAuthentication().getPrincipal(); %> --%>
	
	<%@include file="tiles/aside.jsp"%>
	<%@include file="tiles/header.jsp"%>

	<!-- Content -->

	<div class="container-xxl flex-grow-1 container-p-y">
		<h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">메뉴 /</span> 회원 목록보기</h4>

		<hr class="my-5" />

		<!-- Bootstrap Table with Header - Light -->
		<div class="card">
			<form id="searchForm">
				<div class="row">
				<h5 class="card-header col-md-8">회원 목록 (${paginationVO.totalRecord })</h5>
				<div class="input-group input-group-merge col-md-3" style="width: 30%; padding: 24px;">
					<select class="form-select" name="searchType" id="searchType" style="border-color: #696cff;">
						<option value="name" <c:if test="${searchType eq 'name' }">selected</c:if>>이름</option>
						<option value="auth" <c:if test="${searchType eq 'auth' }">selected</c:if>>권한</option>
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
							<th style="width: 33%">아이디</th>
							<th style="width: 33%">이름</th>
							<th style="width: 34%">권한</th>
						</tr>
					</thead>
					<tbody class="table-border-bottom-0">
						<c:if test="${empty list }">
							<tr>
								<th style="text-align: center; font-size: medium;" colspan="6">등록된 회원이 없습니다.</th>
							</tr>
						</c:if>
						<c:forEach items="${list }" var="list">
							<tr>
								<td scope="row" style="text-align: center;"><a href="/myPage?memId=${list.memId }"><strong>${list.memId }</strong></a></td>
								<td style="text-align: center;"><i class="fab fa-angular fa-lg text-danger me-3"></i>
									<a href="/myPage?memId=${list.memId }"><strong>${list.memName }</strong></a></td>
								<th scope="row" style="text-align: center;">${list.auth }</th>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
<div class="col-lg-12">
	<div class="demo-inline-spacing">
		<nav aria-label="Page navigation" id="paging">
		</nav>
	</div>
</div>
		</div>
		<!-- Bootstrap Table with Header - Light -->


	</div>
	<!-- / Content -->
	<%@include file="tiles/footer.jsp"%>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	var searchBtn = $("#searchBtn");
	var paging = $("#paging");
	
	searchBtn.on("click", function() {
		searchForm.submit();
	});
	
	paging.append("${paginationVO.html}");
	
});
</script>
</html>