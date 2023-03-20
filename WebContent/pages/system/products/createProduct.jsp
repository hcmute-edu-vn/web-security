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
	href="<%=context%>/assets/css/system/product/createProduct.css"
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
						href="<%=context%>/system/products/create">Thêm sản phẩm</a>
				</div>
				<div class="customer_info">
					<form action="" method="POST">
						<input type="text" name="productId" hidden
							value="<%=Helper.getRandom()%>" /> 
							
					<div class="form-group">
							<label for="categoryId" class="form-label">Loại sản phẩm</label>	
						<select name="categoryTypeId" class="form-control">
							<c:forEach var="item" items="${productTypes}">
								<option value="${item.getTypeId()}">${item.getTypeName()}</option>
							</c:forEach>
						</select>
						</div>
						<div class="form-group">
							<label for="categoryId" class="form-label">Danh mục</label>	
						 <select name="categoryId" class="form-control">
							<c:forEach var="item" items="${categories}">
								<option value="${item.getCategoryId()}">${item.getCategoryName()}</option>
							</c:forEach>
						</select> 
						</div>
						
						<input name="productId" value="${productId}" hidden /> 
						
						<div class="form-group">
							<label for="productName" class="form-label">Tên sản phẩm</label>	
							<input
							type="text" name="productName" placeholder="Nhập sản phẩm"
							class="form-control"  id="productName" /> 
						</div>

						<div class="form-group">
							<label for="mainImageUrl" class="form-label">Đường dẫn hình ảnh</label>	
							<input
							type="text" name="mainImageUrl" id="mainImageUrl"
							placeholder="Hình ảnh" class="form-control"
							/> 
						</div>
						<div class="form-group">
							<label for="oldPrice" class="form-label">Giá cũ</label>	
							<input type="text"
							name="oldPrice" id="oldPrice" placeholder="Giá cũ"
							class="form-control" /> 
							</div>

						<div class="form-group">
							<label for="newPrice" class="form-label">Giá mới</label>	
							<input
							type="text" name="newPrice" id="newPrice" placeholder="Giá mới"
							class="form-control"  /> 
						</div>

						<div class="form-group">
							<label for="origin" class="form-label">Nguồn gốc</label>	
							<input
							type="text" name="origin" placeholder="Nguồn gốc" id="origin"
							class="form-control" /> 
						</div>

						<div class="form-group">
							<label for="description" class="form-label">Mô tả</label>	
							<input
							type="text" name="description" placeholder="Mô tả" id="description"
							class="form-control" /> 
						</div>

						<div class="form-group">
							<label for="pattern" class="form-label">Họa tiết</label>	
							<input
							type="text" name="pattern" id="pattern" placeholder="Họa tiết" id="pattern"
							class="form-control" /> 
						</div>

						<div class="form-group">
							<label for="meterial" class="form-label">Loại vải</label>	
						<input
							type="text" name="meterial" id="meterial" placeholder="Loại vải"
							class="form-control"  />
						</div>
						<div class="form-group">
							<label for="meterial" class="form-label">Tình trạng</label>	
							<select name="select_active" class="form-control">
								<option value="0" >Còn hàng</option>
								<option value="1" >Hết hàng</option>
							</select>
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
