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
<title>Đăng ký tài khoản - SHOPLANE</title>
</head>
<body>
	<div id="app">
		<jsp:include page="../components/header.jsp" />
		<main class="main">
			<div class="container">
				<section id="register">
					<div class="border border-1 rounded register-form">

						<form action="register" method="POST">
							<h1 class="register-header">ĐĂNG KÝ</h1>
							<input class="form-control" type="text" name="fullName"
								placeholder="Họ và tên" required /> <input class="form-control"
								type="text" name="phonenumber" placeholder="Số điện thoại"
								required /> <input class="form-control" type="text"
								name="address" placeholder="Địa chỉ" required /> <input
								class="form-control" type="email" name="email"
								placeholder="Email" /> <input class="form-control"
								type="password" name="password" placeholder="Password">
							<div class="err__msg">
								<span>${errMsg}</span>
							</div>
							<button class="btn-submit" type="submit" name="registerButton">Đăng
								ký</button>

							<div class="have-account">
								<p>
									Đã có tài khoản?<a class="signin-text"
										href="<%=context%>/login"> Đăng nhập</a>
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