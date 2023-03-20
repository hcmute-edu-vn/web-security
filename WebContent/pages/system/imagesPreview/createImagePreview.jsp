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
	href="<%=context%>/assets/css/system/imagePreview/createImagePreview.css"
	type="text/css" />
<title>Thêm sản phẩm - SHOPLANE</title>
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
						href="<%=context%>/system/products/?product_type=ALL&category=AO5&current_page=1&page_size=10">Quản
						lý sản phẩm</a> <i class="fas fa-angle-right"></i> <a
						class="sub-nav-item"
						href="<%=context%>/system/products/images/?product_id=${productId}">Quản
						lý hình ảnh</a> <i class="fas fa-angle-right"></i><a
						class="sub-nav-item"
						href="<%=context%>/system/products/images/create/?product_id=${productId}">Thêm
						hình ảnh</a>
				</div>
				<div class="customer_info">
					<form action="" method="POST">
						<input name="imageId" value="<%=Helper.getRandom()%>" hidden />

						<div class="form-group">
							<label for="productId">Sản phẩm</label> <select name="productId"
								class="form-control">
								<option value="${productId}">${product.getProductName()}</option>
							</select>
						</div>
						<div class="form-group">
							<label for="imageUrl">Đường dẫn</label> <input type="text"
								name="imageUrl" placeholder="Đường dẫn" class="form-control"
								required />
						</div>
						<img
							src="https://product.hstatic.net/200000305259/product/l57bh1o8-1-y6dc-shirt_tpr-wht_4_0a0b05105c3a4b0aa08fb93995b00809_master.jpg"
							style="width: 40rem; height: 40rem; object-fit: cover;" />
						<button class="btn-submit" type="submit">Lưu</button>
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
