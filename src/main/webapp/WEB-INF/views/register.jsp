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
<title>등록</title>
</head>
<body>
	<%@include file="tiles/aside.jsp"%>
	<%@include file="tiles/header.jsp"%>

	<!-- Content -->

	<div class="container-xxl flex-grow-1 container-p-y">
		<h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">메뉴 /</span> 게시글 등록하기</h4>

		<hr class="my-5" />

		<div class="row">
			<!-- Basic Layout -->
			<div class="col-xxl">
				<div class="card mb-4">
					<div class="card-header d-flex align-items-center justify-content-between">
						<h5 class="mb-0">게시글 등록하기</h5>
					<small class="text-muted float-end">작성자 : ${user }</small>
					</div>
					<div class="card-body">
						<form action="/intern/register" method="post" id="registerForm" enctype="multipart/form-data">
<!-- 						<form action="/intern/register" method="post" id="registerForm"> -->
							<div class="row mb-3">
								<label class="col-sm-2 col-form-label" for="basic-default-name">제목</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력하세요">
								</div>
							</div>
							<div class="row mb-3">
								<label class="col-sm-2 col-form-label" for="basic-default-message">내용</label>
								<div class="col-sm-10">
									<textarea id="content" name="content" class="form-control" placeholder="내용을 입력하세요."
										aria-label="내용을 입력하세요." aria-describedby="basic-icon-default-message2" rows="30"></textarea>
								</div>
							</div>
							<div class="row mb-3">
								<label class="col-sm-2 col-form-label" for="basic-default-name">첨부파일</label>
								<div class="col-sm-10">
									<input type="file" class="form-control" id="boFile" name="boFile" multiple="multiple" />
<!-- 									<input type="text" class="form-control" id="test" name="test"/> -->
								</div>
							</div>

							<div class="row justify-content-end">
								<div class="col-sm-2">
									<button type="button" class="btn btn-primary" id="registerBtn">등록하기</button>
									<button type="button" id="listBtn" class="btn btn-outline-secondary">목록</button>
								</div>
							</div>
							<sec:csrfInput/>
						</form>
					</div>
				</div>
			</div>
		</div>

		<hr class="my-5" />

	</div>
	<!-- / Content -->
	<%@include file="tiles/footer.jsp"%>
</body>
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script> -->
<!-- CDN 방식 -->
<script src="/resources/jquery-3.7.1.min.js"></script>
<!-- 다운로드 방식 -->
<!-- <script src="//cdn.ckeditor.com/4.19.0/full/ckeditor.js"></script> -->
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/ckeditor/ckeditor.js"></script>
<!-- 경로 다시 찾아보기 -->
<script type="text/javascript">
$(function() {
	var registerBtn = $("#registerBtn");		//게시물 등록완료 버튼
	var listBtn = $("#listBtn");				//목록으로 가기 버튼
	
	//CK에디터 사용
	CKEDITOR.replace("content", {
// 		filebrowserUploadUrl : "/intern/fileUpload"
	});
	
	//등록버튼 클릭 시 실행
	registerBtn.on("click", function() {
		var registerForm = $("#registerForm");
		var title = $("#title").val();
		var content = CKEDITOR.instances.content.getData();	//에디터 사용시 내용 받아오는 법
		//제목, 내용 값 받아오기
		
		if(title == null || title == "") {
			alert("제목을 입력하세요.");
			return false;
			//제목 없거나 공백일 시 alert 띄우고 반환값 false
		};
		if(content == null || content == "") {
			alert("내용을 입력하세요.");
			return false;
			//내용 없거나 공백일 시 alert 띄우고 반환값 false
		};
		
		if(content.includes('유클리드')) {
			alert("사용할 수 없는 단어가 포함되어 있습니다. \n 단어 → 유클리드");
			return false;
			//내용 없거나 공백일 시 alert 띄우고 반환값 false
		};
		
		registerForm.submit();
		//제목, 내용 모두 채워져있으면 제출
	});
	
	listBtn.on("click", function() {
		location.href = "/intern/list";
		//목록으로 가기 버튼 클릭 시 링크
	});
	
});
</script>
</html>