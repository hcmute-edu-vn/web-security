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
<jsp:include page="../head.jsp" />
<link rel="stylesheet"
	href="<%=context%>/assets/css/system/product/index.css" type="text/css" />
<link rel="stylesheet"
	href="<%=context%>/assets/css/system/components/pagination.css"
	type="text/css" />
<title>Quản lý sản phẩm - SHOPLANE</title>
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
						lý sản phẩm</a>
				</div>
				<div class="actions">
					<div class="action__select">
						Loại sản phẩm <select style="width: 6rem" id="select__type"
							onchange="javascript:handleSelectProductType(this)">
							<c:forEach var="item" items="${productTypes}">
								<c:choose>
									<c:when test="${item.getTypeId().equals(productType)}">
										<option value="${item.getTypeId()}" selected>${item.getTypeName()}</option>
									</c:when>
									<c:otherwise>
										<option value="${item.getTypeId()}">${item.getTypeName()}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
					</div>
					<div class="action__select">
						Danh mục <select id="select__category"
							onchange="javascript:handleSelectCategory(this)">
							<c:forEach var="item" items="${categories}">
								<c:choose>
									<c:when test="${item.getCategoryId().equals(category)}">
										<option value="${item.getCategoryId()}" selected>${item.getCategoryName()}</option>
									</c:when>
									<c:otherwise>
										<option value="${item.getCategoryId()}">${item.getCategoryName()}</option>
									</c:otherwise>
								</c:choose>
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

					<a href="<%=context%>/system/products/create/">Thêm sản phẩm</a> <span
						style="cursor: pointer;" class="btnDeleteProducts">Xóa sản
						phẩm</span> <a href="<%=context%>/system/products/trash/">Thùng rác</a>
				</div>
				<div class="table">
					<div class="table__head">
						<div style="width: 5%">
							<input type="checkbox">
						</div>
						<div style="width: 10%">Mã sản phẩm</div>
						<div style="width: 20%">Tên sản phẩm</div>
						<div style="width: 10%">Hình ảnh</div>
						<div style="width: 10%">Danh mục</div>
						<div style="width: 10%">Tình trạng</div>
						<div style="width: 10%">Các lựa chọn</div>
						<div style="width: 10%">Ảnh xem trước</div>
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
								<div style="width: 10%">${item.getCategory().getCategoryName()}</div>
								<div style="width: 10%">
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
										href="<%=context %>/system/products/options/?product_id=${item.getProductId()}">Xem
										thêm</a>
								</div>
								<div style="width: 10%" class="table__link">
									<a
										href="<%=context %>/system/products/images/?product_id=${item.getProductId()}">Xem
										thêm</a>
								</div>
								<div style="width: 15%" class="table__link">
									<a
										href="<%=context %>/system/products/detail/?product_id=${item.getProductId()}">Xem
										chi tiết</a>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
				<input id="createProductStatus"
					value="${sessionScope.createProductStatus}" hidden /> <input
					id="editProductStatus" value="${sessionScope.editProductStatus}"
					hidden />
				<jsp:include page="./pagination.jsp"></jsp:include>
			</main>
		</div>
	</div>
	<!-- Jquery -->
	<jsp:include page="../components/script.jsp"></jsp:include>
	<script type="text/javascript"
		src="<%=context%>/assets/js/system/softDeleteProduct.js"></script>
	<script type="text/javascript"
		src="<%=context%>/assets/js/system/products/index.js"></script>
	<script>
		const createProductStatus = $('#createProductStatus').val();
		if (createProductStatus === 'success') {
			swal("Thông báo", "Tạo sản phẩm thành công", "success");
		}
		const editProductStatus = $('#editProductStatus').val();
		if (editProductStatus === 'success') {
			swal("Thông báo", "Chỉnh sửa sản phẩm thành công", "success");
		}
	</script>
</body>
</html>
