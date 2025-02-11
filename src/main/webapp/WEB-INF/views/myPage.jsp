<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<meta charset="UTF-8" >
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
<title>내 정보 수정</title>
</head>
<body>
	<%@include file="tiles/aside.jsp"%>
	<%@include file="tiles/header.jsp"%>

	<!-- Content -->
	<div class="container-xxl flex-grow-1 container-p-y">
		<h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">메뉴 /</span> 마이페이지</h4>
	
		<div class="col-md-12 card">
<!-- 			<form action="signup" id="signupForm" method="post" enctype="multipart/form-data" > -->
			<form action="/intern/modifyMember" id="modifyForm" method="post" >
				<div class="row">
						<!-- Basic -->
						<c:if test="${status ne 'me' }">
							<div class="col-md-6">
								<div class="mb-4">
									<h5 class="card-header">회원정보 수정</h5>
									<div class="card-body demo-vertical-spacing demo-only-element">
										<label class="form-label" for="memId">ID  *</label>
										<div class="input-group">
											<input type="text" class="form-control" id="memId" name="memId" placeholder="아이디를 입력하세요." value="${vo.memId }" aria-describedby="idCheckBtn" maxlength="28" disabled="disabled">
										</div>
										<div class="form-password-toggle">
											<label class="form-label" for="memPassword">Password  *</label>
											<div class="input-group">
												<input type="password" class="form-control" id="memPassword" name="memPassword" placeholder="············" maxlength="16" disabled="disabled">
											</div>
										</div>
										<label class="form-label" for="memName">이름  *</label>
										<div class="input-group">
											<input type="text" class="form-control" id="memName" name="memName" placeholder="이름을 입력하세요." value="${vo.memName }" disabled="disabled">
										</div>
										<label class="form-label" for="memReg1">생년월일</label>
										<div class="input-group">
											<input type="text" class="form-control" id="memReg1" name="memReg1" placeholder="ex) 920422" value="${vo.memReg1 }" disabled="disabled">
										</div>
									</div>
								</div>
							</div>
					
							<!-- Merged -->
							<div class="col-md-6">
								<div class="mb-4">
									<h5 class="card-header">　</h5>
									<div class="card-body demo-vertical-spacing demo-only-element" style="padding-bottom: 0px;">
										<label class="form-label" for="memEmail">이메일</label>
										<div class="input-group">
											<input type="text" class="form-control" id="memEmail" name="memEmail" placeholder="이메일을 입력하세요." value="${vo.memEmail }"  disabled="disabled">
										</div>
										<label class="form-label" for="memTel">연락처</label>
										<div class="input-group">
											<input type="text" class="form-control" id="memTel" name="memTel" placeholder="연락처를 입력하세요." value="${vo.memTel }" disabled="disabled">
										</div>
										<label class="form-label" for="memAddr">주소</label>
										<p></p>
										<div class="input-group">
											<input type="text" class="form-control" id="memAddr" name="memAddr" placeholder="주소를 입력하세요." value="${vo.memAddr }" disabled="disabled" style="cursor: pointer;" onclick="DaumPostcode()">
										</div>
									</div>
								</div>
							</div>
						</c:if>
						<c:if test="${status eq 'me' }">
							<div class="col-md-6">
								<div class="mb-4">
									<h5 class="card-header">회원정보 수정</h5>
									<div class="card-body demo-vertical-spacing demo-only-element">
										<label class="form-label" for="memId">ID  *</label>
										<div class="input-group">
											<input type="text" class="form-control" id="memId" name="memId" placeholder="아이디를 입력하세요." value="${vo.memId }" aria-describedby="idCheckBtn" maxlength="28" disabled="disabled">
										</div>
										<div class="form-password-toggle">
											<label class="form-label" for="memPassword">Password  *</label>
											<div class="input-group">
												<input type="password" class="form-control" id="memPassword" name="memPassword" placehlder="변경할 비밀번호를 입력하세요." maxlength="16">
												<span id="password" class="input-group-text cursor-pointer"><i class="bx bx-hide"></i></span>
											</div>
										</div>
										<label class="form-label" for="memName">이름  *</label>
										<div class="input-group">
											<input type="text" class="form-control" id="memName" name="memName" placeholder="이름을 입력하세요." value="${vo.memName }">
										</div>
										<label class="form-label" for="memReg1">생년월일</label>
										<div class="input-group">
											<input type="text" class="form-control" id="memReg1" name="memReg1" placeholder="ex) 920422" value="${vo.memReg1 }">
										</div>
									</div>
								</div>
							</div>
					
							<!-- Merged -->
							<div class="col-md-6">
								<div class="mb-4">
									<h5 class="card-header">　</h5>
									<div class="card-body demo-vertical-spacing demo-only-element" style="padding-bottom: 0px;">
										<label class="form-label" for="memEmail">이메일</label>
										<div class="input-group">
											<input type="text" class="form-control" id="memEmail" name="memEmail" placeholder="이메일을 입력하세요." value="${vo.memEmail }">
										</div>
										<label class="form-label" for="memTel">연락처</label>
										<div class="input-group">
											<input type="text" class="form-control" id="memTel" name="memTel" placeholder="연락처를 입력하세요." value="${vo.memTel }">
										</div>
										<label class="form-label" for="memAddr">주소</label>
										<p></p>
										<div class="input-group">
											<input type="text" class="form-control" id="memAddr" name="memAddr" placeholder="주소를 입력하세요." value="${vo.memAddr }" style="cursor: pointer;" onclick="DaumPostcode()">
										</div>
										<c:if test="${not empty vo.memWdDate }">
											<label class="form-label" for="memAddr">탈퇴 신청일</label>
											<p></p>
											<div class="input-group">
												<input type="text" class="form-control" id="memWdDate" name="memWdDate" value="${vo.memWdDate }" disabled="disabled">
											</div>
										</c:if>
									</div>
								</div>
							</div>
						</c:if>
						<div class="d-grid gap-2 col-lg-6 mx-auto"  style="margin-bottom: 20px;">
							<div class="row gap-2" style="padding-left: 20px;">
								<c:if test="${status eq 'me' }">
									<span class="text-muted fw-light" style="position: relative; margin: auto; text-align: center;">* 표시는 필수로 입력해야 합니다.</span>
									<button type="button" class="btn btn-primary" id="updBtn" style="width: 35%">수정완료</button>
									<c:if test="${empty vo.memWdDate }">
										<button type="button" class="btn btn-outline-danger" id="delBtn" style="width: 20%">탈퇴신청</button>
										<button type="button" class="btn btn-secondary" style="width: 35%" onclick="location.href='/intern/myList'">내가 작성한 게시글</button>
									</c:if>
									<c:if test="${not empty vo.memWdDate }">
										<button type="button" class="btn btn-secondary" style="width: 50%" onclick="location.href='/intern/myList'">내가 작성한 게시글</button>
									</c:if>
								</c:if>
								<c:if test="${status ne 'me' }">
									<button type="button" class="btn btn-secondary" style="width: 50%; position: relative; margin: auto;" onclick="location.href='/intern/list'">게시판 목록</button>
								</c:if>
							</div>
						</div>
				</div>
				<sec:csrfInput/>
			</form>
		</div>
	</div>

	<!-- / Content -->
	<%@include file="tiles/footer.jsp"%>
</body>
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script> -->
<!-- CDN 방식 -->
<script src="/resources/jquery-3.7.1.min.js"></script>
<!-- 다운로드 방식 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 다음 주소 API -->
<script type="text/javascript">
$(function() {
	var modifyForm = $("#modifyForm");
	var updBtn = $("#updBtn");
	var delBtn= $("#delBtn");
	
	
	updBtn.on("click", function() {
		var memId = $("#memId").val();
		var memPassword = $("#memPassword").val();
		var memName = $("#memName").val();
		var memReg1 = $("#memReg1").val();
		var memEmail = $("#memEmail").val();
		var memTel = $("#memTel").val();
		var memAddr = $("#memAddr").val();
		
		if(memPassword == "" || memPassword == null) {
			alert("비밀번호를 입력해주세요.");
			return false;
		}
		
		if(memName == "" || memName == null) {
			alert("이름을 입력해주세요.");
			return false;
		}
		
		var pw = /^[A-Za-z0-9]{4,16}$/;
		if(pw.test(memPassword)){
			$("#memPassword").css("border", "1px solid #d9dee3");
		}else {
			$("#memPassword").css("border", "1px solid red");
			alert("비밀번호는 4자리 이상 가능합니다.");
			return false;
		}

		
		if(pw.test(memPassword)) {
			modifyForm.submit();
			alert("수정이 완료되었습니다!");
		}
		
	});
	
	$("#memPassword").change(function() {
		var pw = /^[A-Za-z0-9]{4,16}$/;
		var memPassword = $("#memPassword").val();
		if(pw.test(memPassword)){
			$("#memPassword").css("border", "1px solid #d9dee3");
		}else {
			$("#memPassword").css("border", "1px solid red");
			alert("비밀번호는 4자리 이상 가능합니다.");
			return false;
		}
	});
	
	$("#memReg1").change(function() {
		var nn = /[0-9]{6}/;
		var memReg1 = $("#memReg1").val();
		if(nn.test(memReg1)){
			$("#memReg1").css("border", "1px solid #d9dee3");
		}else {
			$("#memReg1").css("border", "1px solid red");
			alert("생년월일은 숫자로 6자리여야 합니다.");
			return false;
		}
	});
	
	$("#memEmail").change(function() {
		var email =/([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
		var memEmail = $("#memEmail").val();
		
		if(email.test(memEmail)){
			$("#memEmail").css("border", "1px solid #d9dee3");
		}else {
			$("#memEmail").css("border", "1px solid red");
			alert("이메일 형식에 맞지 않습니다.");
			return false;
		}
	});
	
	delBtn.on("click", function() {
		let text = "탈퇴를 신청하시겠습니까?\n *한번 신청하면 철회가 불가능합니다.";
		if (confirm(text) == true) {
			var data = {
				memId : memId
			}
			$.ajax({
				type: "post",
				url: "/intern/withdrawMember",
				beforeSend : function(xhr) {
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}")
				},
				data: JSON.stringify(data),
				contentType: "application/json; charset=utf-8",
				success: function(res) {
					alert("탈퇴 신청이 완료되었습니다\n탈퇴 신청일로부터 1주일 후 모든 정보가 삭제됩니다.");
					location.reload();
				}
			});
		} else {
			alert("탈퇴신청을 취소하였습니다.");
		}
	});
	
});
function DaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            document.getElementById("memAddr").value = roadAddr;
        }
    }).open();
}
</script>
</html>