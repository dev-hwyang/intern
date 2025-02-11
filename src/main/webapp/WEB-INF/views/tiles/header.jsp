<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
				<!-- Navbar -->

				<nav class="navbar-detached align-items-center" id="layout-navbar">
					<div class="navbar-nav-right d-flex align-items-center col-md-11" id="navbar-collapse">
						<ul class="navbar-nav flex-row align-items-center ms-auto">
							<!-- User -->
							<li class="nav-item navbar-dropdown dropdown-user dropdown">
								<a class="nav-link dropdown-toggle hide-arrow" href="javascript:void(0);" data-bs-toggle="dropdown">
									<div class="avatar avatar-online">
										<img src="${pageContext.request.contextPath }/resources/assets/img/avatars/1.png" alt="" class="w-px-40 h-auto rounded-circle">
									</div>
								</a>
								<ul class="dropdown-menu dropdown-menu-end">
									<li>
										<a class="dropdown-item" href="/intern/myPage">
											<i class="bx bx-user me-2"></i>
											<span class="align-middle">My Profile</span>
										</a>
									</li>
									<li>
										<form action="/logout" method="post" id="logoutForm">
											<a class="dropdown-item" id="logoutBtn">
												<i class="bx bx-power-off me-2"></i>
												<span class="align-middle">Log Out</span>
											</a>
											<sec:csrfInput/>
										</form>
									</li>
								</ul>
							</li>
							<!--/ User -->
						</ul>
					</div>
				</nav>

				<!-- / Navbar -->
				
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	<script type="text/javascript">
		$(function() {
			var logoutForm = $("#logoutForm");
			var logoutBtn = $("#logoutBtn");
			
			logoutBtn.on("click", function() {
				logoutForm.submit();
			});
		});
	</script>
				
				<!-- Content wrapper -->
				<div class="content-wrapper">