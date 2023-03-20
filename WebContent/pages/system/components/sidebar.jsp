<%@page import="com.shoplane.utils.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
request.setCharacterEncoding("utf-8");
String context = request.getContextPath();
String productUrl = context + "/system/products/?product_type=" + Constants.ALL + "&category=" + Constants.SHIRT_ALL
		+ "&current_page=1&page_size=10";
String userUrl = context + "/system/users/?role_id=ROL0&current_page=1&page_size=10";
String dashboardUrl = context + "/system/";
String billUrl = context + "/system/bills/?status=2&current_page=1&page_size=10";

String[] urls = { dashboardUrl, userUrl, billUrl, productUrl };
String[] icons = { "fas fa-chart-line", "fas fa-users", "fas fa-file-invoice", "fas fa-vest" };
String[] labels = { "Tổng quan", "Người dùng", "Đơn hàng", "Sản phẩm" };
String[] pattenUrls = { "", Constants.USERS, Constants.BILLS, Constants.PRODUCTS };
String urlPatten = (String) request.getSession().getAttribute("urlPatten");
if (urlPatten == null) {
	urlPatten = "";
}
%>

<div class="sidebar__container">
	<div class="sidebar__logo">
		<i class="fas fa-bars"></i> <a class="sidebar__logo-name"
			href="<%=dashboardUrl%>"> SHOPLANE </a>
	</div>
	<div class="sidebar__nav">
		<%
		for (int i = 0; i < labels.length; i++) {
		%>
		<%
		if (pattenUrls[i].equals(urlPatten)) {
		%>
		<a class="sidebar__nav-item active" href="<%=urls[i]%>"><i
			class="<%=icons[i]%>"></i><span><%=labels[i]%></span></a>
		<%
		} else {
		%>
		<a class="sidebar__nav-item" href="<%=urls[i]%>"><i
			class="<%=icons[i]%>"></i><span><%=labels[i]%></span></a>
		<%
		}
		%>
		<%
		}
		%>
	</div>
</div>
