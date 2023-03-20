<%@page import="com.shoplane.utils.Constants"%>
<%@page import="com.shoplane.utils.Helper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
request.setCharacterEncoding(Constants.UTF8);
String context = request.getContextPath();
%>

<!doctype html>
<html lang="en">
<head>
<jsp:include page="../head.jsp" />
<title>Quản lý đơn hàng - SHOPLANE</title>
<link rel="stylesheet" href="<%=context%>/assets/css/system/bill/index.css"
	type="text/css" />
<link rel="stylesheet" href="<%=context%>/assets/css/system/components/pagination.css" />
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
					<a class="sub-nav-item" href="<%=context%>/system/bills/">Quản
						lý đơn hàng</a>
				</div>
				<div class="actions">
					<div class="action__select">
						Trạng thái <select id="select__status"
							onchange="javascript:handleSelectEntries(this)">
							<option value="2">Tất cả</option>
							<option value="0">Chưa thanh toán</option>
							<option value="1">Đã thanh toán</option>
							<c:forEach end="1" begin="0" var="item">
								<%-- 								<c:choose>
									<c:when test="${item == status}">
										<option value="${item}" selected>Chưa thanh toán</option>
									</c:when>
									<c:otherwise>
										<option value="${item * 10}">${item * 10}</option>
									</c:otherwise>
								</c:choose>
 --%>
							</c:forEach>
						</select>
					</div>
					<div class="action__select">
						Xem <select style="width: 5rem" id="select__entries"
							onchange="javascript:handleSelectEntries(this)">
							<c:forEach end="3" begin="1" var="item">
								<c:choose>
									<c:when test="${(item * 10) == pageSize}">
										<option value="${item * 10}" selected>${item * 10}</option>
									</c:when>
									<c:otherwise>
										<option value="${item * 10}">${item * 10}</option>
									</c:otherwise>
								</c:choose>

							</c:forEach>
						</select> sản phẩm
					</div>
					<a href="<%=context%>/system/bills/create">Thêm đơn hàng</a> <a
						href="#!"
						onclick="event.preventDefault();document.getElementById('selectedBill').submit();">Xóa
						đơn hàng</a>
				</div>
				<div class="table">
					<div class="table__head">
						<div style="width: 5%"></div>
						<div style="width: 10%" class="table__cell">
							<span>Mã đơn hàng</span><i class="fas fa-sort"></i>
						</div>
						<div style="width: 15%" class="table__cell">
							<span>Ngày đặt</span><i class="fas fa-sort"></i>
						</div>
						<div style="width: 15%" class="table__cell">Trạng thái thanh
							toán</div>
						<div style="width: 20%" class="table__cell">
							<span>Người đặt</span><i class="fas fa-sort"></i>
						</div>
						<div style="width: 15%" class="table__cell">
							<span>Tổng tiền</span><i class="fas fa-sort"></i>
						</div>
						<div style="width: 15%"></div>
						<div style="width: 10%"></div>
					</div>
					<div class="table__body">
						<c:forEach var="b" items="${bills}">
							<div class="table__row">
								<div style="width: 5%">
									<input type="checkbox" name="selectedBills" value="${b.billId}">
								</div>
								<div style="width: 10%">${b.billId}</div>
								<div style="width: 15%">${Helper.dateWithoutTime(b.date)}</div>
								<div style="width: 15%">
									<c:choose>
										<c:when test="${b.statusBill==0}">
        								Chưa thanh toán
        							</c:when>
										<c:otherwise>
        								Đã thanh toán
        							</c:otherwise>
									</c:choose>
								</div>
								<div style="width: 20%">${b.getUser().getFullname()}</div>
								<div style="width: 15%">${Helper.intToVND(b.totalPrice)}</div>
								<div style="width: 15%" class="table__link">
									<a
										href="<%=context %>/system/bills/orders/?bill_id=${b.billId}">
										Chi tiết đơn hàng</a>
								</div>
								<div style="width: 10%" class="table__link">
									<a
										href="<%=context %>/system/bills/detail/?bill_id=${b.billId}">Chỉnh
										sửa</a>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
				<jsp:include page="./pagination.jsp"></jsp:include>
			</main>
		</div>
	</div>
	<input type="text" id="createBillStatus" value="${sessionScope.createBillStatus}" hidden/>
	<input type="text" id="editBillStatus" value="${sessionScope.editBillStatus}" hidden/>
	<!-- Jquery -->
	<jsp:include page="../components/script.jsp"></jsp:include>
	<script>
		const createBillStatus = $('#createBillStatus').val();
		if (createBillStatus === 'success') {
			swal("Thông báo", "Tạo đơn hàng thành công", "success");
		}
		const editBillStatus = $('#editBillStatus').val();
		if (editBillStatus === 'success') {
			swal("Thông báo", "Chỉnh sửa đơn hàng thành công", "success");
		}
	</script>
</body>
</html>
