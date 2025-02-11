<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
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
<title>상세</title>
</head>
<body>
	<%@include file="tiles/aside.jsp"%>
	<%@include file="tiles/header.jsp"%>

	<!-- Content -->

	<div class="container-xxl flex-grow-1 container-p-y">
		<h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">메뉴 /</span> 게시글 상세보기</h4>

		<hr class="my-5" />

		<div class="row">
			<!-- Basic Layout -->
			<div class="col-xxl">
				<div class="card mb-4">
					<div class="card-header d-flex align-items-center justify-content-between">
						<h5 class="mb-0">${boardVO.boTitle }</h5>
					<small class="text-muted float-end">작성자 : ${boardVO.memId }</small>
					</div>
					<!-- Account -->
					<hr class="my-0">
					<div class="card-body">
						<div class="row">
							<div class="mb-3">
								<p class="text-muted">
									${boardVO.boContent }
								</p>
							</div>
						</div>
						<form action="/intern/delete" id="delForm" method="post">
							<input type="hidden" name="boNo" id="boNo" value="${boardVO.boNo }">
							<sec:csrfInput/>
						</form>
						<div class="row">
							<div class="gap-2">
								<c:if test="${not empty file }">
									<hr/>
									<small class="fw-semibold">첨부파일 (${boardVO.howManyFile })</small>
									<c:forEach items="${file }" var="file">
										<div class="mb-4 mb-xl-0">
											<small class="text-light fw-semibold">
												<a href="/intern/download?fileNo=${file.fileNo }">${file.fileOriginname }</a>
											</small>
										</div>
									</c:forEach>
								</c:if>
							</div>
						</div>
						<div class="row justify-content-end">
							<div class="col-sm-3 gap-2" style="display: flex; justify-content: flex-end;">
								<c:if test="${status eq 'me' }">
									<button type="button" class="btn btn-primary" id="updBtn">수정하기</button>
									<button type="button" class="btn btn-outline-danger" id="delBtn">삭제</button>
								</c:if>
								<button type="button" id="listBtn" class="btn btn-outline-secondary">목록</button>
							</div>
						</div>
						<hr>
						<c:if test="${not empty comment }">
							<c:forEach items="${comment }" var="comment">
								<form action="/intern/deleteComment" method="post" id="deleteForm">
									<input type="hidden" value="${comment.coNo }" id="coNo" name="coNo">
									<sec:csrfInput/>
								</form>
								<div class="row">
									<div class="col-sm-1"  style="width: 12.499999995%; flex: 0 0 12.499%;max-width: 12.499%;">
										<small class="text-muted">댓글 작성자<br>
										<c:if test="${commentWriter eq comment.memId }">
											<span class="badge rounded-pill bg-label-primary">글쓴이</span>　
										</c:if>
										${comment.memId }님</small>
									</div>
									<div class="col-sm-8 d-flex align-items-center">
										<span>　</span>
										<h7 class="mb-0">${comment.coContent }</h7>
									</div>
									<div class="col-sm-1">
										<small class="text-muted float-end">${comment.coDate }</small>
									</div>
									<c:if test="${user eq comment.memId }">
										<div class="col-sm-1 d-flex align-items-center justify-content-end" style="display: flex; width: 12.499999995%; flex: 0 0 12.499%;max-width: 12.499%;">
											<button type="button" class="btn btn-outline-danger" onclick="fn_deleteComment(${comment.coNo })">삭제</button>
										</div>
									</c:if>
								</div><p></p><hr><p></p>
								<sec:csrfInput/>
							</c:forEach>
						</c:if>
						
						
						<form action="" method="post" id="commentForm">
							<div class="row">
								<input type="hidden" name="boNo" id="boNo" value="${boardVO.boNo }">
								<div class="col-sm-11">
									<textarea class="form-control" rows="" cols="" id="coContent"></textarea>
								</div>
								<div class="col-sm-1 d-flex align-items-center justify-content-end">
									<button type="button" id="registerCommentBtn" class="btn btn-outline-primary">등록</button>
								</div>
								<sec:csrfInput/>
							</div>
						</form>
					</div>
					<!-- /Account -->
				</div>
			</div>
		</div>
		<hr class="my-5" />
	</div>
	<!-- / Content -->
	<%@include file="tiles/footer.jsp"%>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	var updBtn = $("#updBtn");		//수정하기 버튼
	var listBtn = $("#listBtn");	//목록으로 가기 버튼
	var delBtn = $("#delBtn");		//삭제 버튼
	var commentForm = $("#commentForm");	//댓글 정보를 담아 넘길 폼
	var registerCommentBtn = $("#registerCommentBtn");	//댓글 등록 버튼
	var coNo = $("#coNo").val();
	
	updBtn.on("click", function() {
		location.href = "/intern/update?boNo=" + ${boardVO.boNo };
		//수정하기 버튼 클릭 시 링크
	});
	
	listBtn.on("click", function() {
		location.href = "/intern/list";
		//목록으로 가기 버튼 클릭 시 링크
	});
	
	delBtn.on("click", function() {
		var delForm = $("#delForm");
		if(confirm("삭제하시겠습니까? 삭제되면 복구가 불가능 합니다.")){
			delForm.submit();
			alert("삭제가 완료되었습니다.");
		}
		//삭제하기 버튼 글릭시 한번 더 확인 및 폼 제출
	});
	
	registerCommentBtn.on("click", function() {
		var coContent = $("#coContent").val();
		var boNo = $("#boNo").val();
		
// 		console.log(coContent);
		var data = {
			coContent : coContent
			, boNo : boNo
		}
// 		console.log(JSON.stringify(data));
		$.ajax({
			type: "post",
			url: "/intern/registerComment",
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}")
			},
			data: JSON.stringify(data),
			contentType: "application/json; charset=utf-8",
			success: function(res) {
// 				alert(JSON.stringify(data));
				location.reload();
			}
		});
	});
	

});

function fn_deleteComment(param) {
	var deleteForm = $("#deleteForm");
	
	if(confirm("삭제하시겠습니까?")){
		var data = {
				coNo : param
			}
	 		console.log(JSON.stringify(data));
			$.ajax({
				type: "post",
				url: "/intern/deleteComment",
				beforeSend : function(xhr) {
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}")
				},
				data: JSON.stringify(data),
				contentType: "application/json; charset=utf-8",
				success: function(res) {
//	 				alert(JSON.stringify(data));
					location.reload();
				}
			});
	}
};
</script>
</html>