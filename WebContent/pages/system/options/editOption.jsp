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
	href="<%=context%>/assets/css/system/option/editOption.css"
	type="text/css" />

<title>Chi tiết sản phẩm - SHOPLANE</title>
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
						href="<%=context%>/system/products/options/detail/?product_id=${productId}&option_id=${optionId}">Chỉnh
						sửa lựa chọn</a>
				</div>
				<div class="customer_info">
					<form action="" method="POST">
						<input type="text" name="optionId" placeholder="Mã lựa chọn"
							class="form-control" value="${option.getOptionId()}" disabled />
						<div class="form-group">
							<label for="meterial" class="form-label">Sản phẩm</label> 
							<select name="productId" class="form-control">
								<option value="${productId}">${product.getProductName()}</option>
							</select> 
						</div>
						
						<div class="form-group">
							<label for="meterial" class="form-label">Màu sắc</label> 
						<select name="colorId" class="form-control">
							<c:forEach var="item" items="${colors}">
								<c:choose>
									<c:when
										test="${item.getColorId().equals(option.getColor().getColorId())}">
										<option value="${item.getColorId()}" selected>
											${item.getColorName()}</option>
									</c:when>
									<c:otherwise>
										<option value="${item.getColorId()}">
											${item.getColorName()}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
						</div>

						<div class="form-group">
							<label for="meterial" class="form-label">Kích thước</label> <select
								name="sizeId" class="form-control">
								<c:forEach var="item" items="${sizes}">
									<c:choose>
										<c:when
											test="${item.getSizeId().equals(option.getSize().getSizeId())}">
											<option value="${item.getSizeId()}" selected>
												${item.getSizeName()}</option>
										</c:when>
										<c:otherwise>
											<option value="${item.getSizeId()}">
												${item.getSizeName()}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
						</div>
							<div class="form-group">
								<label for="meterial" class="form-label">Số lượng khả dụng</label> <input
									type="text" name="availableQuantity"
									placeholder="Số lượng khả dụng" class="form-control"
									value="${option.getAvailableQuantity()}" />
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
