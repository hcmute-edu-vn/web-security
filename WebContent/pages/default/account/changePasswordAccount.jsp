<%@page import="com.shoplane.utils.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding(Constants.UTF8);
response.setCharacterEncoding(Constants.UTF8);
String context = request.getContextPath();
String url = context + "/default/account/modify";
%>

<!doctype html>
<html lang="en">
<head>
<jsp:include page="../components/head.jsp" />
<link rel="stylesheet"
	href="<%=context%>/assets/css/default/account/formAccount.css" />
<title>Thay đổi mật khẩu - SHOPLANE</title>
</head>
<body>
	<div id="app">
		<jsp:include page="../components/header.jsp" />
		<main class="main">
			<div class="container">
				<section id="modify">
					<div class="modify-form">
						<form action="" method="POST">
							<h1 class="modify-header">THAY ĐỔI MẬT KHẨU</h1>
							<input class="form-control" type="password"
								name="currentPassword" placeholder="Mật khẩu hiện tại">

							<input class="form-control" type="password" name="newPassword"
								placeholder="Mật khẩu mới" /> <input class="form-control"
								type="password" name="confirmPassword"
								placeholder="Xác nhận mật khẩu">
							<div class="err__msg">
								<span>${errMsg}</span>
							</div>
							<button class="btn-submit" type="submit" name="modifyButton">Cập
								nhật</button>
						</form>
						<a class="btn-submit" href="<%=context%>/account"
							style="text-align: center; margin-top: 1rem">Quay lại</a>
					</div>
				</section>
			</div>
		</main>
		<jsp:include page="../components/footer.jsp" />
	</div>
	<jsp:include page="../components/script.jsp" />
</body>
</html>