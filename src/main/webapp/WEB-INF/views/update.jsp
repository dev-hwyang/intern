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
<title>수정</title>
</head>
<body>
	<%@include file="tiles/aside.jsp"%>
	<%@include file="tiles/header.jsp"%>

	<!-- Content -->

	<div class="container-xxl flex-grow-1 container-p-y">
		<h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">메뉴 /</span> 게시글 수정하기</h4>
		</h4>

		<hr class="my-5" />

		<div class="row">
			<!-- Basic Layout -->
			<div class="col-xxl">
				<div class="card mb-4">
					<div class="card-header d-flex align-items-center justify-content-between">
						<h5 class="mb-0">게시글 수정하기</h5>
					<small class="text-muted float-end">작성자 : ${boardVO.memId }</small>
					</div>
					<div class="card-body">
						<form action="/intern/update?boNo=${boardVO.boNo }" method="post" id="modifyForm" enctype="multipart/form-data">
							<input type="hidden" value="${boardVO.boNo }" id="boNo" name="boNo">
							<div class="row mb-3">
								<label class="col-sm-2 col-form-label" for="title">제목</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력하세요" value="${boardVO.boTitle }">
								</div>
							</div>
							<div class="row mb-3">
								<label class="col-sm-2 col-form-label" for="content">내용</label>
								<div class="col-sm-10">
									<textarea id="content" name="content" class="form-control" placeholder="내용을 입력하세요."
										aria-label="내용을 입력하세요." aria-describedby="basic-icon-default-message2" rows="30">${boardVO.boContent }</textarea>
								</div>
							</div>
							<div class="row mb-3">
								<c:if test="${empty file }">
								<label class="col-sm-2 col-form-label" for="boFile">추가로 첨부할 파일</label>
								<div class="col-sm-10">
									<input type="file" class="form-control" id="boFile" name="boFile" multiple="multiple" />
								</div>
								</c:if>
								<c:if test="${not empty file }">
									<label class="col-sm-2 col-form-label" for="attachedFile">기존에 첨부된 파일</label>
									<div class="col-sm-10" id="attachedFile">
									<input type="hidden" id="DelfileNos" name="DelfileNos">
										<c:forEach items="${file }" var="file">
											<div class="mb-4 mb-xl-1" value="${file.fileNo }">
												<small class="text-light fw-semibold" value="${file.fileNo }">
													${file.fileOriginname }
													<a href="#" id="id_${file.fileNo }" class="delBtn">  ❌</a>
												</small>
											</div>
										</c:forEach>
									</div>
								</c:if>
							</div>
							<div class="row justify-content-end">
								<div class="col-sm-2">
									<button type="button" class="btn btn-primary" id="modifyBtn">저장하기</button>
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
$(function() {
	var modifyBtn = $("#modifyBtn");
	var listBtn = $("#listBtn");
	CKEDITOR.replace("content", {
// 		filebrowserUploadUrl : "/intern/fileUpload"
	});
	
	modifyBtn.on("click", function() {
		var modifyForm = $("#modifyForm");
		var boNo = $("#boNo").val();
		var title = $("#title").val();
// 		var content = $("#content").val();
		var content = CKEDITOR.instances.content.getData();
		
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
		};

		modifyForm.submit();
	});
	
	
	var delFileNo = "";
	$(".delBtn").on("click", function() {
		var id = $(this).prop("id");
// 	 	console.log("@@@@@@@" + id);
		
		var no = id.indexOf("_");
// 	 	console.log("@@@@@@@" + no);
		var fileNo = id.substring(no+1)
// 	 	console.log("@@@@@@@" + fileNo);
		
// 		delFileNo+=fileNo + ", ";
// 		console.log(delFileNo);
		var ptrn = "<input type='hidden' name='delFileNo' value='%V' />";
		$("#modifyForm").append(ptrn.replace("%V", fileNo));
		
		$("#DelfileNos").attr("name", delFileNo);
		//아쒸? 이거 필요없는거였네 하...
		
		$(this).parents("div:first").hide();
		
	});
	
	listBtn.on("click", function() {
		location.href = "/intern/list";
	});
	
});

</script>
</html>