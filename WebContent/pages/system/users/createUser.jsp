<%@page import="com.shoplane.utils.Helper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
request.setCharacterEncoding("utf-8");
String context = request.getContextPath();
%>

<!doctype html>
<html lang="en">
<head>
<jsp:include page="../head.jsp" />
<link rel="stylesheet"
	href="<%=context%>/assets/css/system/user/createUser.css"
	type="text/css" />
<title>Thêm người dùng - SHOPLANE</title>
</head>
<body>
	<div id="system">
		<div id="sidebar">
			<jsp:include page="../components/sidebar.jsp" />
		</div>
		<div id="content">
			<div id="header">
				<jsp:include page="../components/header.jsp" />
			</div>
			<main id="main-content">
				<div class="sub-nav">
					<a class="sub-nav-item"
						href="<%=context%>/system/users/?role_id=ROL0&current_page=1&page_size=10">Quản
						lý người dùng</a> <i class="fas fa-angle-right"></i> <a
						class="sub-nav-item"
						href="<%=context%>/system/bills/detail/?status=2&current_page=1&page_size=10">Thêm
						người dùng</a>
				</div>
				<div class="customer_info">
					<div class="img">
						<img
							src="https://cpad.ask.fm/450/774/576/-29996968-1tfd7tc-gpggmmc5d0og3a0/original/image.jpg"
							alt="" class="">
					</div>
					<button class="change_img">Thay đổi ảnh</button>

					<form action="create" method="POST">
						<input type="text" name="userId" id="userId"
							placeholder="Mã người dùng" hidden value="${Helper.getRandom()}">
						<div class="form-group">
							<label for="fullname">Họ và tên</label> <input type="text"
								name="fullname" id="fullname" placeholder="Họ và tên"
								class="form-control" required="required">
						</div>
						<div class="form-group">
							<label for="email">Email(Username)</label> <input type="text"
								name="email" id="email" placeholder="Email" class="form-control"required="required" />
						</div>
						<div class="form-group">
							<label for="phonenumber">Số điện thoại</label> <input type="text"
								name="phonenumber" id="phonenumber" placeholder="Số điện thoại"
								class="form-control" required="required">
						</div>
						<div class="form-group">
							<label for="address">Địa chỉ</label> <input type="text"
								name="address" id="address" placeholder="Địa chỉ"
								class="form-control" required="required"/>
						</div>
						<div class="form-group">
							<label for="password">Mật khẩu</label> <input type="password"
								name="password" id="password" placeholder="Mật khẩu"
								class="form-control" required="required"/>
						</div>
						<div class="form-group">
							<label for="acctiveAcc">Kích hoạt người dùng</label> <select
								class="form-control" id="acctiveAcc" name="acctiveAcc">
								<option value="1">Kích hoạt</option>
								<option value="0">Kích hoạt sau</option>
							</select>
						</div>

						<div class="form-group">
							<label for="roleId">Quyền</label> <select class="form-control"
								id="roleId" name="roleId">
								<c:forEach var="item" items="${roles}">
									<option value="${item.getRoleId()}">${item.getRoleName()}</option>
								</c:forEach>
							</select>
						</div>
						<button type="submit" class="btn-submit">Lưu</button>
					</form>
				</div>
			</main>
		</div>
	</div>
	<!-- <!-- Jquery -->
<jsp:include page="../components/script.jsp"></jsp:include>
</body>
</html>
