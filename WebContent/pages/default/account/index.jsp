<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.shoplane.utils.Helper"%>
<%@page import="com.shoplane.utils.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
request.setCharacterEncoding(Constants.UTF8);
response.setCharacterEncoding(Constants.UTF8);
String context = request.getContextPath();
String url = context + "/default/account";
%>

<!doctype html>
<html lang="en">
<head>
<jsp:include page="../components/head.jsp" />
<link rel="stylesheet"
	href="<%=context%>/assets/css/default/account/account.css" />
<title>Tài khoản - SHOPLANE</title>
</head>
<body>
	<div id="app">
		<jsp:include page="../components/header.jsp" />
		<main class="main">
			<div class="container">
				<div class="your__container">
					<div class="your__orders">
						<h1 class="your__order-heading">ĐƠN HÀNG CỦA BẠN</h1>
						<div class="your__order-table">
							<div class="your__order-table-head">
								<span class="your__order-title">Đơn hàng</span> <span
									class="your__order-title">Ngày đặt</span> <span
									class="your__order-title">Thanh toán</span> <span
									class="your__order-title">Vận chuyển</span> <span
									class="your__order-title">Tổng tiền</span>
							</div>
							<div class="your__order-table-body">
								<c:forEach var="item" items="${bills}">
									<div class="your__order-table-item">
										<a class="your__order-value" href="./my-orders.jsp">${item.getBillId()}</a>
										<span class="your__order-value">${ item.getDate() }</span> <span
											class="your__order-value">Chưa hoàn tất</span> <span
											class="your__order-value">Đang vận chuyển</span> <span
											class="your__order-value">${Helper.intToVND(item.getTotalPrice())}</span>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>
					<div class="your__info">
						<h1 class="your__info-heading">TÀI KHOẢN CỦA BẠN</h1>
						<div class="your__info-list">
							<div class="infor-item">
								<span>Họ và tên:</span> <span>${sessionScope.user.getFullname()}</span>
							</div>
							<div class="infor-item">
								<span>Địa chỉ:</span> <span>${sessionScope.user.getAddress()}</span>
							</div>
							<div class="infor-item">
								<span>Email:</span> <span>${sessionScope.user.getEmail()}</span>
							</div>
							<div class="infor-item">
								<span>Điện thoại:</span> <span>${sessionScope.user.getPhonenumber()}</span>
							</div>
						</div>
						<input hidden value="${sessionScope.modifyAccountStatus}"
							id="modifyAccountStatus" /> <input
							value="${sessionScope.changePasswordAccountStatus}" hidden
							id="changePasswordAccountStatus" />
						<div class="your__info-action">
							<a class="btn-submit" type="submit" name="modify-button"
								href="<%=context%>/account/modify">Chỉnh sửa thông tin</a> <a
								class="btn-submit" href="<%=context%>/account/change-password">Thay
								đổi mật khẩu</a> <a class="btn-submit" href="<%=context%>/logout">Đăng
								xuất</a>
						</div>
					</div>
				</div>
			</div>
		</main>
		<jsp:include page="../components/footer.jsp" />
	</div>
	<jsp:include page="../components/script.jsp" />
	<script>
		const modifyAccountStatus = $('#modifyAccountStatus').val();
		const changePasswordAccountStatus = $('#changePasswordAccountStatus')
				.val();
		if (modifyAccountStatus === 'success') {
			swal("Thông báo", "Chỉnh sửa thông tin thành công", "success");
		}
		console.log(changePasswordAccountStatus);
		if (changePasswordAccountStatus === 'success') {
			swal("Thông báo", "Thay đổi mật khẩu thành công", "success");
		}
	</script>
</body>
</html>

