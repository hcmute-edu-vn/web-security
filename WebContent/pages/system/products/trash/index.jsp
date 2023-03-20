<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
request.setCharacterEncoding("utf-8");
String context = request.getContextPath();

int[] entries = {10, 20, 30};
%>

<!doctype html>
<html lang="en">
<head>
<jsp:include page="../../head.jsp" />
<link rel="stylesheet"
	href="<%=context%>/assets/css/system/product/trash/index.css"
	type="text/css" />
<link rel="stylesheet"
	href="<%=context%>/assets/css/system/components/pagination.css"
	type="text/css" />
<title>Thùng rác - SHOPLANE</title>
</head>
<body>
	<div id="app">
		<div id="sidebar">
			<jsp:include page="../../components/sidebar.jsp" />
		</div>
		<div id="content">
			<div id="header">
				<jsp:include page="../../components/header.jsp" />
			</div>
			<main id="main-content">
				<div class="sub-nav">
					<a class="sub-nav-item"
						href="<%=context%>/system/products/?product_type=ALL&category=AO5&current_page=1&page_size=10">Quản
						lý sản phẩm</a> <i class="fas fa-angle-right"></i> <a
						class="sub-nav-item" href="<%=context%>/system/products/trash/">Thùng
						rác</a>
				</div>
				<div class="actions">
					<a href="" class="btnDeleteProducts">Xóa tất cả</a> <span
						style="cursor: pointer;" class="btnRecoveryProducts">Khôi
						phục tất cả</span>
				</div>
				<div class="table">
					<div class="table__head">
						<div style="width: 5%">
							<input type="checkbox">
						</div>
						<div style="width: 10%">Mã sản phẩm</div>
						<div style="width: 20%">Tên sản phẩm</div>
						<div style="width: 10%">Hình ảnh</div>
						<div style="width: 10%">Loại sản phẩm</div>
						<div style="width: 10%">Danh mục</div>
						<div style="width: 10%">Tình trạng</div>
						<div style="width: 10%"></div>
						<div style="width: 15%"></div>
					</div>
					<div class="table__body">
						<c:forEach var="item" items="${products}">
							<div class="table__row">
								<div style="width: 5%">
									<input type="checkbox" name="productSelected"
										value="${item.getProductId()}">
								</div>
								<div style="width: 10%">${item.getProductId()}</div>
								<div style="width: 20%">${item.getProductName()}</div>
								<div style="width: 10%">
									<img src="${item.getMainImageUrl()}"
										alt="${item.getProductName()}"
										style="height: 60px; object-fit: cover" />
								</div>
								<div style="width: 10%">${item.getProductTypeBean().getTypeName()}</div>
								<div style="width: 10%">
									${item.getCategory().getCategoryName()}</div>
								<div style="width: 10%" class="table__link">
									<c:choose>
										<c:when test="${item.getIsActive() == 0}">
										Còn hàng	
									</c:when>
										<c:otherwise>
										Hết hàng	
									</c:otherwise>
									</c:choose>
								</div>
								<div style="width: 10%" class="table__link">
									<a
										href="<%=context %>/system/products/trash/recovery/?product_id=${item.getProductId()}">Xóa</a>
								</div>
								<div style="width: 15%" class="table__link">
									<a
										href="<%=context %>/system/products/trash/recovery/?product_id=${item.getProductId()}">Khôi
										phục</a>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
				<jsp:include page="./pagination.jsp"></jsp:include>
			</main>
		</div>
	</div>
	<input id="recoveryProductItemStatus"
		value="${sessionScope.recoveryProductItemStatus}" hidden />
	<input id="editProductStatus" value="${sessionScope.editProductStatus}"
		hidden />
	<!-- Jquery -->
	<jsp:include page="../../components/script.jsp"></jsp:include>>
	<script type="text/javascript"
		src="<%=context%>/assets/js/system/recoveryProducts.js"></script>
	<script>
		const recoveryProductItemStatus = $('#recoveryProductItemStatus').val();
		if (recoveryProductItemStatus === 'success') {
			swal("Thông báo", "Khôi phuc sản phẩm thành công", "success");
		}
		const editProductStatus = $('#editProductStatus').val();
		if (editProductStatus === 'success') {
			swal("Thông báo", "Chỉnh sửa sản phẩm thành công", "success");
		}
	</script>
</body>
</html>
