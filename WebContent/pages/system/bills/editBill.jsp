<%@page import="com.shoplane.utils.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="com.shoplane.utils.Helper"%>

<%
request.setCharacterEncoding(Constants.UTF8);
String context = request.getContextPath();
%>

<!doctype html>
<html lang="en">
<head>
<jsp:include page="../head.jsp" />
<title>Chỉnh sửa đơn hàng - SHOPLANE</title>
<link rel="stylesheet"
	href="<%=context%>/assets/css/system/bill/editBill.css" type="text/css" />
</head>
<body>
	<div id="app">
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
						href="<%=context%>/system/bills/?status=2&current_page=1&page_size=10">Quản
						lý đơn hàng</a> <i class="fas fa-angle-right"></i> <a
						class="sub-nav-item"
						href="<%=context%>/system/bills/?bill_id=${billId}">Chỉnh sửa
						đơn hàng</a>
				</div>
				<div class="customer_info">
					<form action="" method="post">
						<div class="form-group">
							<label for="date">Mã đơn hàng</label> <input type="text"
								name="billId" value="${bill.billId}" class="form-control"
								readonly />
						</div>
						<div class="form-group">
							<label for="date">Ngày tạo</label> <input class="form-control"
								type="text" name="date"
								value="${Helper.dateWithoutTime(bill.date)}" readonly>
						</div>

						<div class="form-group">
							<label for="date">Người mua</label> 
							<select class="form-control"
								name="customerId">
								<c:forEach var="item" items="${users}">
									<c:choose>
										<c:when
											test="${bill.getUser().getUserId().equals(item.getUserId())}">
											<option selected value="${item.getUserId()}">${item.getFullname()}</option>
										</c:when>
										<c:otherwise>
											<option value="${item.getUserId()}">${item.getFullname()}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
						</div>

						<div class="form-group">
							<label for="date">Trạng thái thanh toán</label> <select
								id="statusBill" name="statusBill" class="form-control">
								<option value="1" selected="${bill.getStatusBill() == 1}">Đã
									thanh toán</option>
								<option value="0" selected>Chưa thanh toán</option>
							</select>
						</div>
						<div class="form-group">
							<label for="date">Tổng số tiền</label> <input type="text"
								name="totalPrice" value="${bill.totalPrice}"
								class="form-control" readonly />
						</div>
						<button type="submit" class="btn-submit">Lưu</button>
					</form>
				</div>
			</main>
		</div>
	</div>
	<!-- Jquery -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"
		integrity="sha512-aVKKRRi/Q/YV+4mjoKBsE4x3H+BkegoM/em46NNlCqNTmUYADjBbeNefNxYV7giUp0VxICtqdrbqU7iVaeZNXA=="
		crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</body>
</html>