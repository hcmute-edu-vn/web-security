<%@page import="com.shoplane.utils.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding(Constants.UTF8);
response.setCharacterEncoding(Constants.UTF8);
String context = request.getContextPath();
String url = context + "/default/account/login";
%>

<!doctype html>
<html lang="en">
<head>
<jsp:include page="../components/head.jsp" />
<link rel="stylesheet"
	href="<%=context%>/assets/css/default/account/formAccount.css" />
<title>Đăng nhập tài khoản - SHOPLANE</title>
</head>
<body>
	<div id="app">
		<jsp:include page="../components/header.jsp" />
		<main class="main">
			<div class="container">
				<section id="login">
					<div class="border border-1 rounded login-form">
						<form action="login" method="POST">
							<h1 class="login-header">ĐĂNG NHẬP</h1>
							<input type="text" hidden name="caller" value="${caller}" /> <input
								class="form-control" type="email" name="email"
								placeholder="Email" required> <input
								class="form-control" type="password" name="password"
								placeholder="Mật khẩu" required> <input id="status"
								value="${sessionScope.status}" hidden="" />
							<div class="err__msg">
								<span>${errMsg}</span>
							</div>
							<button class="btn-submit" type="submit">Đăng nhập</button>
							<a class="register-text"
								style="font-size: 1.3rem; margin: 1rem 0;"
								href="<%=context%>/forgot-password""> Quên mật khẩu?</a>
							<div class="no-account">
								<p>
									Không có tài khoản?<a class="register-text"
										href="<%=context%>/register"> Đăng ký</a>
								</p>
							</div>
						</form>
					</div>
				</section>
			</div>
		</main>
		<input id="filterMsg" value="${sessionScope.filterMsg}" hidden /> <input
			id="resetPasswordStatus" value="${sessionScope.resetPasswordStatus}"
			hidden />
		<jsp:include page="../components/footer.jsp" />
	</div>
	<jsp:include page="../components/script.jsp" />
	<script>
		const status = $('#status').val();
		const filterMsg = $('#filterMsg').val();
		const resetPasswordStatus = $('#resetPasswordStatus').val();

		// Check
		if (status === 'success') {
			swal("Xin chúc mừng!", "Tài khoản của bạn đã được tạo thành công.",
					"success");
		}
		if (filterMsg !== '') {
			swal("Thông báo", filterMsg, "warning");
		}
		if (resetPasswordStatus === 'success') {
			swal("Thông báo", "Thay đổi mật khẩu thành công", "success");
		} else if (resetPasswordStatus === 'failure') {
			swal("Thông báo", "Đã có lỗi xảy ra, vui lòng thực hiện lại",
					"warning");
		}
	</script>
</body>
</html>