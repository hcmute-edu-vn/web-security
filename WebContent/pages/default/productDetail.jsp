<%@page import="com.shoplane.utils.Constants"%>
<%@page import="com.shoplane.utils.Helper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
request.setCharacterEncoding(Constants.UTF8);
response.setCharacterEncoding(Constants.UTF8);

String context = request.getContextPath();
String baseUrl = context + "/default/product-detail";
%>

<!doctype html>
<html lang="en">
<head>
<jsp:include page="./components/head.jsp" />
<link rel="stylesheet"
	href="<%=context%>/assets/css/default/productDetail.css" />
<title>${product.getProductName()}-SHOPLANE</title>
<style>
.main {
	padding-top: 10rem;
	padding-bottom: 4rem;
}
</style>
</head>
<body>
	<div id="app">
		<jsp:include page="./components/header.jsp" />
		<main class="main">
			<div class="container">
				<div class="product__inner">
					<div class="container_product_img">
						<div class="product_img"
							style="background-image: url(${productImagesDetail != null ? productImagesDetail.getImageUrl() : product.getMainImageUrl()});">
						</div>
					</div>
					<div class="product_info">
						<h3 class="product_info-name">${product.getProductName()}</h3>
						<div class="home-product-item__price">
							<span class="home-product-item__price-current">${Helper.intToVND(product.getNewPrice())}</span>
							<span class="home-product-item__price-old">${Helper.intToVND(product.getOldPrice())}</span>
						</div>
						<p class="product_info-more">
							<span>Thông tin sản phẩm: ILLUSION T-SHIRT.</span> <span>
								Họa tiết: ${product.getPattern()}</span> <span>Màu sắc:
								${product.getProductName().split('/')[1]}</span> <span>Chất
								liệu: ${product.getMeterial()}</span>
						</p>
						<div class="product_info-size">
							<h3 class="product_info-size-label">KÍCH THƯỚC:</h3>
							<c:choose>
								<c:when test="${product.getIsActive() == 0}">
									<div class="product_info-size-list">
										<c:forEach var="o" items="${options}">
											<div class="product_info-size-item">
												<input type="radio" id="${o.getSize().getSizeId()}"
													value="${o.getOptionId()}" name="radioButton" /> <label
													for="${o.getSize().getSizeId()}">${o.getSize().getSizeName()}</label>
											</div>
										</c:forEach>
									</div>
								</c:when>
								<c:otherwise>
									<div>Hết hàng</div>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="product_info-quantity">
							<h3 class="product_info-quantity-label">SỐ LƯỢNG:</h3>
							<div class="product_info-quantity-group">
								<button class="product_info-quantity-btn btn-sub">-</button>
								<input type="text" name="quantity" value="1"
									class="product_info-quantity-text" />
								<button class="product_info-quantity-btn btn-ins">+</button>
							</div>
						</div>
						<h3 class="some_more_img_lable">XEM THÊM HÌNH ẢNH</h3>
						<div class="some_more_img">
							<c:forEach var="item" items="${productImages}">
								<div class="member-item">
									<img class="member-img" src="${item.getImageUrl()}" alt="Name">
								</div>
							</c:forEach>
						</div>
						<div class="btn_container">
							<button class="btn_cart btn__add-to-cart">
								<h3 class="btn_cart-lable">THÊM VÀO GIỎ</h3>
								<ion-icon name="cart"></ion-icon>
							</button>
							<button class="btn_cart">
								<h3 class="btn_cart-lable">MUA NGAY</h3>
								<ion-icon name="checkmark-outline"></ion-icon>
							</button>
						</div>
					</div>
				</div>
			</div>
		</main>
		<jsp:include page="./components/footer.jsp" />
	</div>
	<!-- Import script lib -->
	<jsp:include page="./components/script.jsp" />
	<script type="text/javascript"
		src="<%=context%>/assets/js/default/productDetail.js"></script>
</body>
</html>

