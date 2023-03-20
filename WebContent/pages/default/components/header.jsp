<%@page import="com.shoplane.dao.CategoryDAO"%>
<%@page import="com.shoplane.dao.ProductTypeDAO"%>
<%@page import="com.shoplane.dao.ProductDAO"%>
<%@page import="com.shoplane.utils.Helper"%>
<%@page import="com.shoplane.models.ProductType"%>
<%@page import="java.util.List"%>
<%@page import="com.shoplane.models.Category"%>
<%@page import="com.shoplane.models.User"%>
<%@page import="com.shoplane.utils.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%
String context = request.getContextPath();
ProductTypeDAO productTypeDAO = new ProductTypeDAO();
CategoryDAO categoryDAO = new CategoryDAO();

ProductType shirtProductType = productTypeDAO.find(Constants.SHIRT);
List<Category> shirtCategories = categoryDAO.findByProductType(shirtProductType);

ProductType shortProductType = productTypeDAO.find(Constants.SHORT);
List<Category> shortCategories = categoryDAO.findByProductType(shortProductType); 

// Flow 
String url = null;
url = context + "/login";
User u = (User) session.getAttribute("user");
if (u != null) {
	url = context + "/account";
} else {
	url = context + "/login";
}
%>
<header class="header">
	<div class="container">
		<ul class="header__navbar">
			<li class="header__navbar-left">
				<div class="header__navbar-item hide header__logo">
					<a href="<%=context%>/"> <span>SHOP</span><span>LANE</span>
					</a>
				</div>
				<div class="header__navbar-item hide dropdown">
					<a
						href="<%=context%>/collection/?product_type=<%=Constants.SHIRT%>&category_id=<%=Constants.SHIRT_ALL%>&current_page=1&page_size=12">ÁO</a>
					<div class="dropdown-content">
						<c:forEach var="item" items="<%=shirtCategories%>">
							<a
								href="<%=context %>/collection/?product_type=<%=Constants.SHIRT %>&category_id=${item.getCategoryId()}&current_page=1&page_size=12">${item.getCategoryName()}</a>
						</c:forEach>
					</div>
				</div>
				<div class="header__navbar-item hide dropdown">
					<a
						href="<%=context%>/collection/?product_type=<%=Constants.SHORT%>&category_id=<%=Constants.SHORT_ALL%>&current_page=1&page_size=12">QUẦN</a>
					<div class="dropdown-content">
						<c:forEach var="item" items="<%=shortCategories%>">
							<a
								href="<%=context %>/collection/?product_type=<%=Constants.SHORT %>&category_id=${item.getCategoryId()}&current_page=1&page_size=12">${item.getCategoryName() }</a>
						</c:forEach>
					</div>
				</div>
			</li>
			<li class="header__navbar-item header__navbar-item-search"><i
				class="fas fa-search header__navbar-item-search-icon"></i>
				<form action="<%=context %>/search" method="get" style="width: 100%;">
					<input type="text" placeholder="Tìm kiếm quần áo...."
						class="header__navbar-item-search-input" autofocus
						name="product_name" /> <input type="submit" style="display: none" />
				</form></li>
			<li class="header__navbar-item header__navbar-actions"><a
				href="<%=context%>/cart" class="header__navbar-item-link"><ion-icon
						name="cart-outline"></ion-icon>
					<div class="header_navbar-count"></div> <input id='ordersCount'
					type='hidden' value='${sessionScope.orderSize}' /> </a> <a
				href="<%=url%>" class="header__navbar-item-link"><ion-icon
						name="person-outline"></ion-icon></a></li>
		</ul>
	</div>
</header> 