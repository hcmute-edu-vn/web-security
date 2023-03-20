<%@page import="com.shoplane.utils.Constants"%>
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
	href="<%=context%>/assets/css/system/imagePreview/index.css"
	type="text/css" />
<title>Quản lý ảnh - SHOPLANE</title>
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
						href="<%=context%>/system/products/?product_type=ALL&category=AO5&current_page=1&page_size=10">Quản
						lý sản phẩm</a> <i class="fas fa-angle-right"></i><a
						class="sub-nav-item"
						href="<%=context%>/system/products/images/?product_id=${productId}">Quản
						lý ảnh xem trước</a>
				</div>
				<div class="actions">
					<a
						href="<%=context%>/system/products/images/create/?product_id=${productId}">Thêm
						hình</a> <a class="btnDeleteImages"
						href="<%=context%>/system/products/images/delete/?product_id=${productId}">Xóa
						hình</a>
				</div>
				<div class="table">
					<div class="table__head">
						<div style="width: 5%">
							<input type="checkbox">
						</div>
						<div style="width: 10%">Mã hình ảnh</div>
						<div style="width: 35%">Đường dẫn</div>
						<div style="width: 15%">Hình ảnh</div>
						<div style="width: 10%">Tên sản phẩm</div>
						<div style="width: 10%">Nguồn gốc</div>
						<div style="width: 15%"></div>
					</div>
					<div class="table__body">
						<c:forEach var="item" items="${productImages}">
							<div class="table__row">
								<div style="width: 5%">
									<input type="checkbox" name="imageSelected"
										value="${item.getImageId()}">
								</div>
								<div style="width: 10%">${item.getImageId()}</div>
								<div style="width: 35%">${item.getImageUrl()}</div>
								<div style="width: 15%">
									<img src="${item.getImageUrl()}"
										alt="${product.getProductName()}"
										style="height: 60px; object-fit: cover" />
								</div>
								<div style="width: 10%">${product.getProductName()}</div>
								<div style="width: 10%">${product.getOrigin()}</div>
								<div style="width: 15%" class="table__link">
									<a
										href="<%=context %>/system/products/images/detail/?product_id=${productId}&image_id=${item.getImageId()}">Xem
										chi tiết</a>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</main>
		</div>
	</div>

	<input type="text" id="createImageStatus"
		value="${sessionScope.createImageStatus}" hidden />
	<input type="text" id="editImageStatus"
		value="${sessionScope.editImageStatus}" hidden />
	<input class="productId" value="${productId}" hidden />
	<!-- Jquery -->
	<jsp:include page="../components/script.jsp"></jsp:include>
	<script type="text/javascript"
		src="<%=context%>/assets/js/system/deleteProductImage.js"></script>
	<script>
		const createImageStatus = $('#createImageStatus').val();
		if (createImageStatus === 'success') {
			swal("Thông báo", "Thêm hình thành công", "success");
		}
		const editImageStatus = $('#editImageStatus').val();
		if (editImageStatus === 'success') {
			swal("Thông báo", "Chỉnh sửa hình ảnh thành công", "success");
		}
	</script>
</body>
</html>
