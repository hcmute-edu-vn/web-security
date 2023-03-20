<%@page import="com.shoplane.utils.Helper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
request.setCharacterEncoding("utf-8");
String context = request.getContextPath();
String baseUrl = context + "/default/search-product";
%>

<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="./components/head.jsp" />
<link rel="stylesheet" href="<%=context%>/assets/css/default/searchProduct.css" />
<title>Tìm kiếm sản phẩm - SHOPLANE</title>
</head>
<body>
	<div id="app">
		<jsp:include page="./components/header.jsp" />
		<section class="catalog">
			<div class="container">
				<h1 class="catalog__heading">SẢN PHẨM BẠN ĐANG TÌM KIẾM:
					${findProduct}</h1>
				<div class="catalog__list">
					<c:forEach var="item" items="${listProductWithSearch}">
						<div class="catalog__item">
							<div class="group_content">
								<div class="home-product-item__img"
									style="background-image: url(${item.getMainImageUrl()});">
								</div>
								<h4 class="home-product-item__name">
									<a
										href="${pageContext.request.contextPath}/product-detail?product_id=${item.getProductId()}">${item.getProductName()}</a>
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
			</div>
		</section>
		<jsp:include page="./components/footer.jsp" />
		<jsp:include page="./components/backToTop.jsp" />
	</div>
	<jsp:include page="./components/script.jsp" />
</body>
</html>
