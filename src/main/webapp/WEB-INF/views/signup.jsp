<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>

<!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath }/resources/assets/img/favicon/favicon.ico">

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="">
    <link href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&amp;display=swap" rel="stylesheet">

    <!-- Icons. Uncomment required icon fonts -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendor/fonts/boxicons.css">

    <!-- Core CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendor/css/core.css" class="template-customizer-core-css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendor/css/theme-default.css" class="template-customizer-theme-css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/demo.css">

    <!-- Vendors CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css">

    <!-- Page CSS -->
    <!-- Page -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendor/css/pages/page-auth.css">
    <!-- Helpers -->
    <script src="${pageContext.request.contextPath }/resources/assets/vendor/js/helpers.js"></script><style type="text/css">
.layout-menu-fixed .layout-navbar-full .layout-menu,
.layout-page {
  padding-top: 0px !important;
}
.content-wrapper {
  padding-bottom: 0px !important;
}</style>

    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/config.js"></script>
    <meta charset="UTF-8">
	<title>회원가입</title>
  </head>
  </head>

  <body>
    <!-- Content -->

    <div class="container-xxl">
      <div class="authentication-basic container-p-y">
        <div class="authentication-inner">
          <!-- Register Card -->
          <div class="card">
            <div class="card-body">
              <!-- Logo -->
              <div class="app-brand justify-content-center">
                <a href="intern/list" class="app-brand-link gap-2">
                  <span class="app-brand-logo demo">
                    <svg width="25" viewBox="0 0 25 42" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                      <defs>
                        <path d="M13.7918663,0.358365126 L3.39788168,7.44174259 C0.566865006,9.69408886 -0.379795268,12.4788597 0.557900856,15.7960551 C0.68998853,16.2305145 1.09562888,17.7872135 3.12357076,19.2293357 C3.8146334,19.7207684 5.32369333,20.3834223 7.65075054,21.2172976 L7.59773219,21.2525164 L2.63468769,24.5493413 C0.445452254,26.3002124 0.0884951797,28.5083815 1.56381646,31.1738486 C2.83770406,32.8170431 5.20850219,33.2640127 7.09180128,32.5391577 C8.347334,32.0559211 11.4559176,30.0011079 16.4175519,26.3747182 C18.0338572,24.4997857 18.6973423,22.4544883 18.4080071,20.2388261 C17.963753,17.5346866 16.1776345,15.5799961 13.0496516,14.3747546 L10.9194936,13.4715819 L18.6192054,7.984237 L13.7918663,0.358365126 Z" id="path-1"></path>
                        <path d="M5.47320593,6.00457225 C4.05321814,8.216144 4.36334763,10.0722806 6.40359441,11.5729822 C8.61520715,12.571656 10.0999176,13.2171421 10.8577257,13.5094407 L15.5088241,14.433041 L18.6192054,7.984237 C15.5364148,3.11535317 13.9273018,0.573395879 13.7918663,0.358365126 C13.5790555,0.511491653 10.8061687,2.3935607 5.47320593,6.00457225 Z" id="path-3"></path>
                        <path d="M7.50063644,21.2294429 L12.3234468,23.3159332 C14.1688022,24.7579751 14.397098,26.4880487 13.008334,28.506154 C11.6195701,30.5242593 10.3099883,31.790241 9.07958868,32.3040991 C5.78142938,33.4346997 4.13234973,34 4.13234973,34 C4.13234973,34 2.75489982,33.0538207 2.37032616e-14,31.1614621 C-0.55822714,27.8186216 -0.55822714,26.0572515 -4.05231404e-15,25.8773518 C0.83734071,25.6075023 2.77988457,22.8248993 3.3049379,22.52991 C3.65497346,22.3332504 5.05353963,21.8997614 7.50063644,21.2294429 Z" id="path-4"></path>
                        <path d="M20.6,7.13333333 L25.6,13.8 C26.2627417,14.6836556 26.0836556,15.9372583 25.2,16.6 C24.8538077,16.8596443 24.4327404,17 24,17 L14,17 C12.8954305,17 12,16.1045695 12,15 C12,14.5672596 12.1403557,14.1461923 12.4,13.8 L17.4,7.13333333 C18.0627417,6.24967773 19.3163444,6.07059163 20.2,6.73333333 C20.3516113,6.84704183 20.4862915,6.981722 20.6,7.13333333 Z" id="path-5"></path>
                      </defs>
                      <g id="g-app-brand" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                        <g id="Brand-Logo" transform="translate(-27.000000, -15.000000)">
                          <g id="Icon" transform="translate(27.000000, 15.000000)">
                            <g id="Mask" transform="translate(0.000000, 8.000000)">
                              <mask id="mask-2" fill="white">
                                <use xlink:href="#path-1"></use>
                              </mask>
                              <use fill="#696cff" xlink:href="#path-1"></use>
                              <g id="Path-3" mask="url(#mask-2)">
                                <use fill="#696cff" xlink:href="#path-3"></use>
                                <use fill-opacity="0.2" fill="#FFFFFF" xlink:href="#path-3"></use>
                              </g>
                              <g id="Path-4" mask="url(#mask-2)">
                                <use fill="#696cff" xlink:href="#path-4"></use>
                                <use fill-opacity="0.2" fill="#FFFFFF" xlink:href="#path-4"></use>
                              </g>
                            </g>
                            <g id="Triangle" transform="translate(19.000000, 11.000000) rotate(-300.000000) translate(-19.000000, -11.000000) ">
                              <use fill="#696cff" xlink:href="#path-5"></use>
                              <use fill-opacity="0.2" fill="#FFFFFF" xlink:href="#path-5"></use>
                            </g>
                          </g>
                        </g>
                      </g>
                    </svg>
                  </span>
                  <span class="app-brand-text demo text-body fw-bolder">board crud</span>
                </a>
              </div>
              <!-- /Logo -->
              
<!-- 			<form action="signup" id="signupForm" method="post" enctype="multipart/form-data" > -->
			<form action="/signup" id="signupForm" method="post" >
				<div class="row">
						<!-- Basic -->
						<div class="col-md-6">
							<div class="mb-4">
								<h5 class="card-header">회원가입</h5>
								<div class="card-body demo-vertical-spacing demo-only-element">
									<label class="form-label" for="memId">ID  *</label>
									<div class="input-group">
										<input type="text" class="form-control" id="memId" name="memId" placeholder="아이디를 입력하세요." aria-describedby="idCheckBtn" maxlength="29">
										<button class="btn btn-outline-primary" type="button" id="idCheckBtn">중복확인</button>
									</div>
									<div class="form-password-toggle">
										<label class="form-label" for="memPassword">Password  *</label>
										<div class="input-group">
											<input type="password" class="form-control" id="memPassword" name="memPassword" placeholder="············" maxlength="16">
											<span id="password" class="input-group-text cursor-pointer"><i class="bx bx-hide"></i></span>
										</div>
									</div>
									<label class="form-label" for="memName">이름  *</label>
									<div class="input-group">
										<input type="text" class="form-control" id="memName" name="memName" placeholder="이름을 입력하세요.">
									</div>
									<label class="form-label" for="memReg1">생년월일</label>
									<div class="input-group">
										<input type="text" class="form-control" id="memReg1" name="memReg1" placeholder="ex) 920422" maxlength="6">
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
										<input type="text" class="form-control" id="memEmail" name="memEmail" placeholder="이메일을 입력하세요." maxlength="50">
									</div>
									<label class="form-label" for="memTel">연락처</label>
									<div class="input-group">
										<input type="text" class="form-control" id="memTel" name="memTel" placeholder="연락처를 입력하세요." maxlength="13">
									</div>
									<label class="form-label" for="memAddr">주소</label>
									<p></p>
									<div class="input-group">
										<input type="text" class="form-control" id="memAddr" name="memAddr" placeholder="주소를 입력하세요."  style="cursor: pointer;" onclick="DaumPostcode()">
									</div>
<!-- 									<div class="input-group"> -->
<!-- 										<input type="file" class="form-control" id="inputGroupFile02"> -->
<!-- 										<label class="input-group-text" for="inputGroupFile02">등록하기</label> -->
<!-- 									</div> -->
								</div>
							</div>
						</div>
						<div class="d-grid gap-2 col-lg-3 mx-auto"  style="margin-bottom: 20px;">
							<div class="input-group">
								<div style="vertical-align: middle; align-items: center; align-content: center; position: relative; margin:auto;">
									<input class="form-check-input mt-0" id="memAgr" name="memAgr" type="checkbox" value="Y" aria-label="Checkbox for following text input">
									<label class="form-label" for="memAgr" style="vertical-align: middle;"><a>개인정보 처리방침</a>에 동의합니다.</label>
								</div>
							</div>
							<span class="text-muted fw-light" style="position: relative; margin: auto;">* 표시는 필수로 입력해야 합니다.</span>
							<div class="row gap-2" style="padding-left: 20px;">
							<button type="button" class="btn btn-primary" id="signupBtn" style="width: 55%">회원가입</button>
							<button type="button" class="btn btn-secondary" style="width: 35%" onclick="location.href='/intern/list'">취소</button>
							</div>
						</div>
				</div>
				<sec:csrfInput/>
			</form>

              <p class="text-center">
                <span>이미 계정이 있습니까?</span>
                <a href="/intern/list">
                  <span>로그인 하기</span>
                </a>
              </p>
            </div>
          </div>
          <!-- Register Card -->
        </div>
      </div>
    </div>

    <!-- / Content -->

    <!-- build:js assets/vendor/js/core.js -->
    <script src="${pageContext.request.contextPath }/resources/assets/vendor/libs/jquery/jquery.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/vendor/libs/popper/popper.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/vendor/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

    <script src="${pageContext.request.contextPath }/resources/assets/vendor/js/menu.js"></script>
    <!-- endbuild -->

    <!-- Vendors JS -->

    <!-- Main JS -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/main.js"></script>

    <!-- Page JS -->

    <!-- Place this tag in your head or just before your close body tag. -->
    <script async="" defer="" src="https://buttons.github.io/buttons.js"></script>
  

</body>

<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script> -->
<!-- CDN 방식 -->
<script src="/resources/jquery-3.7.1.min.js"></script>
<!-- 다운로드 방식 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 다음 주소 API -->
<script type="text/javascript">
$(function() {
	var signupForm = $("#signupForm");
	var idCheckBtn = $("#idCheckBtn");
	var signupBtn = $("#signupBtn");
	var idCheckFlag = false;
	
	idCheckBtn.on("click", function() {
		var memId = $("#memId").val();
		
		if(memId == "" || memId == null) {
			alert("아이디를 입력해주세요.");
			return false;
		}
		
		var data = {
				memId : memId
		}
		$.ajax({
			type: "post",
			url: "/idCheck",
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}")
			},
			data: JSON.stringify(data),
			contentType: "application/json; charset=utf-8",
			success: function(res) {
// 				console.log("아이디 중복 확인 결과 : " + res);
				if(res == "NOTEXIST") {
					alert("사용 가능한 아이디입니다!");
					idCheckFlag = true;
				}else {
					alert("이미 사용중인 아이디입니다!");
				}
			}
		});
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
			alert("이메일 형식에 맞지 않습니다.\n올바르게 입력해주세요.");
			return false;
		}
	});
	
	signupBtn.on("click", function() {
		var memId = $("#memId").val();
		var memPassword = $("#memPassword").val();
		var memName = $("#memName").val();
		var memReg1 = $("#memReg1").val();
		var memEmail = $("#memEmail").val();
		var memTel = $("#memTel").val();
		var memAddr = $("#memAddr").val();
		var memAgr = $("#memAgr");
		
		if(memId == "" || memId == null) {
			alert("아이디를 입력해주세요.");
			return false;
		}
		
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

		if(idCheckFlag == true && pw.test(memPassword) == true){
			signupForm.submit();
			alert("회원가입이 완료되었습니다! 로그인해주세요.");
		} else {
			alert("아이디 중복확인을 진행해주세요.");
			return false;
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