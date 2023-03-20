<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
request.setCharacterEncoding("utf-8");
String context = request.getContextPath();
String[] isActiveTexts = { "Chưa kích hoạt", "Đã kích hoạt" };
%>

<!doctype html>
<html lang="en">
<head>
<jsp:include page="../head.jsp" />
<link rel="stylesheet"
	href="<%=context%>/assets/css/system/user/editUser.css"
	type="text/css" />
<title>Chỉnh sửa người dùng - SHOPLANE</title>
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
						href="<%=context%>/system/users/edit?user_id=${userId}">Chỉnh
						sửa người dùng</a>
				</div>
				<div class="customer_info">
					<div class="img">
						<img
							src="https://cpad.ask.fm/450/774/576/-29996968-1tfd7tc-gpggmmc5d0og3a0/original/image.jpg"
							alt="" class="">
					</div>
					<button class="change_img">Thay đổi ảnh</button>

					<div id="form_userData">
						<form action="" method="POST">
							<div class="form-group">
								<label for="userId">Mã người dùng</label> <input type="text"
									name="userId" id="userId" placeholder="Mã người dùng"
									class="form-control" value="${user.getUserId()}"
									readonly="readonly">
							</div>
							<div class="form-group">
								<label for="fullname">Tên đầy đủ</label> <input type="text"
									name="fullname" id="fullname" placeholder="Họ và tên"
									class="form-control" value="${user.getFullname()}"
									required="required" />
							</div>
							<div class="form-group">
								<label for="email">Email</label> <input type="text" name="email"
									id="email" placeholder="Email" class="form-control"
									value="${user.getEmail()}" required="required" />
							</div>

							<div class="form-group">
								<label for="phonenumber">Số điện thoại</label> <input
									type="text" name="phonenumber" id="phonenumber"
									placeholder="Số điện thoại" class="form-control"
									value="${user.getPhonenumber()}" required="required" />
							</div>

							<div class="form-group">
								<label for="phonenumber">Địa chỉ</label> <input type="text"
									name="address" id="address" placeholder="Địa chỉ"
									class="form-control" value="${user.getAddress()}"
									required="required" />
							</div>

							<div class="form-group">
								<label for="acctiveAcc">Trạng thái tài khoản</label> <select
									class="form-control" id="acctiveAcc" name="acctiveAcc">
									<c:forEach items="<%=isActiveTexts%>" var="item" varStatus="i">
										<c:choose>
											<c:when test="${i.index == user.getIsActiveAcc()}">
												<option value="${i.index}" selected>${item}</option>
											</c:when>
											<c:otherwise>
												<option value="${i.index}">${item}</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</select>
							</div>

							<div class="form-group">
								<label for="acctiveAcc">Vai trò</label> <select
									class="form-control" id="roleId" name="roleId">
									<c:forEach var="item" items="${roles}">
										<c:choose>
											<c:when
												test="${item.getRoleId().equals(user.getRole().getRoleId())}">
												<option value="${item.getRoleId()}" selected>${item.getRoleName()}</option>
											</c:when>
											<c:otherwise>
												<option value="${item.getRoleId()}" selected>${item.getRoleName()}</option>
											</c:otherwise>
										</c:choose>

									</c:forEach>
								</select>
							</div>
							<button type="submit" class="btn-submit">Lưu</button>
						</form>
					</div>
				</div>
			</main>
		</div>
	</div>
</body>
</html>
