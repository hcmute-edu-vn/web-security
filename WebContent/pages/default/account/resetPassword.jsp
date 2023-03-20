<%@page import="com.shoplane.utils.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding(Constants.UTF8);
response.setCharacterEncoding(Constants.UTF8);
String context = request.getContextPath();
String url = context + "/default/account/register";
%>

<!doctype html>
<html lang="en">
<head>
<jsp:include page="../components/head.jsp" />
<link rel="stylesheet"
	href="<%=context%>/assets/css/default/account/formAccount.css" />
<title>Xác thực OTP - SHOPLANE</title>
<style>
.main {
	padding-top: 6rem;
}
</style>
</head>
<body>
	<div id="app">
		<jsp:include page="../components/header.jsp" />
		<main class="main">
			<div class="container">
				<section id="register">
					<div class="border border-1 rounded register-form">

						<form action="" method="POST">
							<h1 class="register-header">THAY ĐỔI MẬT KHẨU</h1>
							<input class="form-control" type="password" name="newPassword"
								placeholder="Nhập mật khẩu mới" required /> <input
								class="form-control" type="password" name="confirmPassword"
								placeholder="Xác nhận mật khẩu mới" required />
							<div class="error__msg">
								<span>${errMsg}</span>
							</div>

							<button class="btn-submit" type="submit" name="registerButton">Xác
								nhận</button>

							<div class="have-account">
								<p>
									Chưa có mã xác nhận? <a class="signin-text"
										href="<%=context%>/login">Lấy lại mã</a>
								</p>
							</div>

						</form>

					</div>

				</section>
			</div>
		</main>
		<jsp:include page="../components/footer.jsp" />
	</div>
	<jsp:include page="../components/script.jsp" />
</body>
</html>