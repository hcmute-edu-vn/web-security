<%@page import="com.shoplane.utils.Constants"%>
<%@page import="com.shoplane.utils.Helper"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.shoplane.models.Order"%>
<%@page import="com.shoplane.models.User"%>

<%
request.setCharacterEncoding(Constants.UTF8);
response.setCharacterEncoding(Constants.UTF8);

String context = request.getContextPath();
String url = context + "/default/cart/checkouts";
// Calc total price
int priceOrders = 0;
List<Order> ors = (List<Order>) session.getAttribute("orders");
if (ors != null) {
	for (Order order : ors) {
		priceOrders += order.getPrice();
	}
}
int totalPrice = priceOrders + Constants.SHIPMENT;
%>

<!doctype html>
<html lang="en">
<head>
<jsp:include page="../components/head.jsp" />
<c:choose>
	<c:when test="${orders.size() > 0}">

		<link rel="stylesheet" href="<%=context%>/assets/css/default/checkout/checkout.css" />
	</c:when>
	<c:otherwise>
		<link rel="stylesheet" href="<%=context%>/assets/css/default/checkout/checkoutSuccess.css" />
	</c:otherwise>
</c:choose>
<title>Thanh toán đơn hàng - SHOPLANE</title>
</head>
<body>
	<div id="app">
		<jsp:include page="../components/header.jsp" />
		<main class="main">
			<div class="container">
				<c:choose>

					<c:when test="${orders.size() > 0}">
						<!-- Content -->
						<div class="checkouts__container">
							<div class="group_content">
								<h3 class="info_customer">THÔNG TIN GIAO HÀNG</h3>
								<input class="form-control" type="text" name="fullname"
									value="${sessionScope.user.getFullname()}"
									placeholder="Họ và tên" required> <input
									class="form-control" type="text" name="phonenumber"
									value="${sessionScope.user.getPhonenumber()}"
									placeholder="Số điện thoại" required> <select
									name="province" id="province" class="form-control">
									<option value="-1">Vui lòng chọn tỉnh (thành phố)...</option>
								</select> <select name="district" id="district" class="form-control">
									<option value="-1">Vui lòng chọn quận (huyện)...</option>
								</select> <select name="ward" id="ward" class="form-control">
									<option value="-1">Vui lòng chọn phường (xã)...</option>
								</select> <input class="form-control" type="text" name="address"
									value="${sessionScope.user.getAddress()}"
									placeholder="Địa chỉ tên đường, (số nhà)" required> <input
									type="text" name="totalPrice" value="<%=totalPrice%>" hidden />
								<div class="form-control"
									style="display: flex; align-items: center; justify-content: space-between;">
									<div style="color: #d2d2d2">
										<i class="fas fa-dot-circle"></i> <span>Giao hàng tận
											nơi</span>
									</div>
									<span>35,000đ</span>
								</div>
								<div class="checkBill_policy-second">
									<div>
										<i class="fa-regular fa-circle-dot"></i> <span>Thanh
											toán khi giao hàng (COD)</span>
									</div>
								</div>
								<div class="checkBill_policy-content">
									<p>1. Khi click vào nút hoàn tất đơn hàng thì đơn hàng sẽ
										được hệ thống tự động xác nhận mà không cần phải gọi qua điện
										thoại, nếu điền thông tin địa chỉ và số điện thoại chính xác
										thì đơn hàng sẽ được vận chuyển từ 3-4-5 ngày tùy vùng miền.</p>
									<p>2. Trường hợp đặt hàng xong nhưng muốn HỦY ĐƠN, vui lòng
										soạn tin nhắn theo cú pháp: SĐT ĐÃ ĐẶT ĐƠN (hoặc MÃ ĐƠN hoặc
										GMAIL ĐƠN HÀNG) + TÊN NGƯỜI NHẬN sau đó gửi qua các kênh
										online: Page Facebook, Intagram. Nhân viên check tin nhắn sẽ
										xử lý hủy giúp Quý KH.</p>
								</div>
								<div class="btn_container">
									<a class="btn-submit btn__back" href="<%=context%>/cart"> <span
										class="btn_cart-lable">Quay lại giỏ hàng</span> <ion-icon
											name="cart"></ion-icon>
									</a>
									<button class="btn-submit btn__order" type="button">
										<span class="btn_cart-lable">Hoàn tất đơn hàng</span>
									</button>
								</div>
							</div>
							<div class="group_content">
								<div class="bill_info">
									<h3>Tạm tính:</h3>
									<h3><%=Helper.intToVND(priceOrders)%>
									</h3>
								</div>
								<div class="bill_info">
									<h3>Phí vận chuyển:</h3>
									<h3>35,000 đ</h3>
								</div>
								<div class="bill_info">
									<h3>Tổng:</h3>
									<h3><%=Helper.intToVND(totalPrice)%>
									</h3>
								</div>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<jsp:include page="./checkoutSuccess.jsp" />
					</c:otherwise>
				</c:choose>
			</div>
		</main>
		<jsp:include page="../components/footer.jsp" />
	</div>
	<jsp:include page="../components/script.jsp" />
	<script src="<%=context%>/assets/js/default/checkout.js"></script>
</body>
</html>

