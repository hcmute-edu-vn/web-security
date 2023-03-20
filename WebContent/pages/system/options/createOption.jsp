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
	href="<%=context%>/assets/css/system/option/createOption.css"
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
						lý sản phẩm</a> <i class="fas fa-angle-right"></i><a
						class="sub-nav-item"
						href="<%=context%>/system/products/options/?product_id=${productId}">Quản
						lý lựa chọn</a><i class="fas fa-angle-right"></i><a
						class="sub-nav-item"
						href="<%=context%>/system/products/options/create/?product_id=${productId}">Thêm
						lựa chọn</a>
				</div>
				<div class="customer_info">
					<form action="" method="POST">
						<input name="optionId" value="OP<%=Helper.getRandom()%>" hidden />
						<div class="form-group">
							<label for="productId">Tên sản phẩm</label> 
							<select
								name="productId" class="form-control">
								<option value="${productId}" selected>${product.getProductName()}</option>
							</select>
						</div>

						<div class="form-group">
							<label for="productId">Màu sắc</label> 
							<select name="colorId" class="form-control">
							<c:forEach var="item" items="${colors}">
								<option value="${item.getColorId()}">
									${item.getColorName()}</option>
							</c:forEach>
							</select> 
						</div>	

						<div class="form-group">
							<label for="productId">Kích cỡ</label> 
							<select name="sizeId" class="form-control">
							<c:forEach var="item" items="${sizes}">
								<option value="${item.getSizeId()}">
									${item.getSizeName()}</option>
							</c:forEach>
							</select> 
						</div>	

						<div class="form-group">
							<label for="availableQuantity">Số lượng khả dụng</label> 
							<input type="text" name="availableQuantity" id="availableQuantity"
							placeholder="Số lượng khả dụng" class="form-control" required />
						</div>
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
