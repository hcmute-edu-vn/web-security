<%@page import="com.shoplane.models.ProductType"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.shoplane.models.Product"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.shoplane.utils.Helper"%>
<%@page import="com.shoplane.utils.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="productDAO" class="com.shoplane.dao.ProductDAO"></jsp:useBean>
<jsp:useBean id="productTypeDAO" class="com.shoplane.dao.ProductTypeDAO"></jsp:useBean>

<%
request.setCharacterEncoding(Constants.UTF8);
response.setCharacterEncoding(Constants.UTF8);

String context = request.getContextPath();
ProductType productType = productTypeDAO.find(Constants.SHIRT);

Map<String, Object> params = new HashMap<>();
params.put("isDelete", (byte) 0);
params.put("productType", productType);

List<Product> products = new ArrayList<>();
products = productDAO.paginationByProductTypeAndIsDeleted(params, 1, 12, Constants.ASC);
%>

<section class="catalog">
	<div class="container">
		<h1 class="catalog__heading">DANH MỤC ÁO</h1>
		<div class="catalog__list">
			<c:forEach var="item" items="<%=products%>">
				<div class="catalog__item">
					<div class="group_content">
						<div class="home-product-item__img"
							style="background-image: url(${item.getMainImageUrl()});">
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
		<div class="btn-more">
			<a class="btn-more-link"
				href="<%=context%>/collection/?product_type=<%=Constants.SHIRT%>&category_id=<%=Constants.SHIRT_ALL%>&current_page=1&page_size=12">
				XEM TẤT CẢ </a>
		</div>
	</div>
</section>