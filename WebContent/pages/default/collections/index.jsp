<%@page import="com.shoplane.utils.Helper"%>
<%@page import="com.shoplane.utils.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
request.setCharacterEncoding(Constants.UTF8);
response.setCharacterEncoding(Constants.UTF8);

String categoryId = (String) request.getAttribute("categoryId");
String context = request.getContextPath();
String baseUrl = context + "/default/collections";
%>

<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="../components/head.jsp" />
<link rel="stylesheet"
	href="<%=context%>/assets/css/default/collection/collection.css" />
<link rel="stylesheet"
	href="<%=context%>/assets/css/default/collection/pagination.css" />
<title>${category.getCategoryName()} - SHOPLANE</title>
</head>
<body>
	<div id="app">
		<jsp:include page="../components/header.jsp" />
		<main class="main">
			<div class="container">
				<div class="grid__row collection__container">
					<div class="grid__column">
						<div class="category__container">
							<h3 class="category__heading">Danh Mục</h3>
							<div class="btn_close">
								<i class="fa-solid fa-xmark"></i>
							</div>
							<ul class="category-list">
								<c:forEach var="item" items="${categories}">
									<li
										class="category-item ${categoryId == item.getCategoryId() ? 'active' : ''}">
										<a
										href="<%=context %>/collection/?product_type=${item.getProductTypeBean().getTypeId()}&category_id=${item.getCategoryId()}&current_page=1&page_size=12"
										class="category-item__link">${item.getCategoryName()}</a>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
					<div class="grid__column_3">
						<div class="product__nav">
							<h3 class="product__heading">${category.getCategoryName()}</h3>
							<div class="product__filter">
								<div class="option_filter">
									<h3 class="option_filter-label">GIÁ</h3>
									<select onchange="javascript:handleSelectOrderByPrice(this)"
										name="orderType" class="option_filter-group" tabindex="-1">
										<option value="<%=Constants.DESC%>">Giảm dần</option>
										<option value="<%=Constants.ASC%>">Tăng dần</option>
									</select>
								</div>
							</div>
						</div>
						<div class="grid__row">
							<c:forEach var="item" items="${products}">
								<div class="grid__column-3-3">
									<div class="group_content">
										<div class="home-product-item__img"
											style="background-image: url(${item.getMainImageUrl()})">
											<c:if test="${item.getIsActive() == 1}">
												<img style="width: 15rem"
													src="https://theme.hstatic.net/200000305259/1000963148/14/icon_soldout_img.png?v=70"
													alt="" />
											</c:if>
										</div>
										<h4 class="home-product-item__name">
											<a
												href="<%=context %>/product-detail?product_id=${item.getProductId()}">${item.getProductName()}</a>
										</h4>
										<h4 class="shop_name">SHOPLANE</h4>
										<div class="home-product-item__rating">
											<c:forEach begin="1" end="5">
												<i class="fas fa-star"></i>
											</c:forEach>
										</div>
										<div class="home-product-item__price">
											<span class="home-product-item__price-current">${Helper.intToVND(item.getNewPrice())}</span>
											<span class="home-product-item__price-old">${Helper.intToVND(item.getOldPrice())}</span>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
						<div class="show_all">
							<jsp:include page="./pagination.jsp" />
						</div>
					</div>
				</div>
			</div>
		</main>
		<jsp:include page="../components/footer.jsp" />
		<jsp:include page="../components/backToTop.jsp" />
	</div>
	<jsp:include page="../components/script.jsp" />
	<script type="text/javascript">
		function handleSelectOrderByPrice(elm) {
			const queryString = window.location.search;
			const urlParams = new URLSearchParams(queryString);

			const productTypeId = urlParams.get('product_type');
			const categoryId = urlParams.get('category_id');
			const pageSize = urlParams.get('page_size');
			const currentPage = urlParams.get('current_page');

			window.location = '?product_type=' + productTypeId
					+ '&category_id=' + categoryId + '&current_page='
					+ currentPage + '&page_size=' + pageSize
					+ '&sort_by_price=' + elm.value;
		}
	</script>
</body>
</html>
