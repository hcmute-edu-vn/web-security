<%@page import="com.shoplane.utils.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
request.setCharacterEncoding(Constants.UTF8);
response.setCharacterEncoding(Constants.UTF8);
String context = request.getContextPath();
%>

<div class="cart__success">
	<div class="cart__success-icon">
		<ion-icon name="cart"></ion-icon>
	</div>
	<div class="cart__noti">
		<h3 class="cart__noti-txt">Giỏ hàng của bạn đang trống!</h3>
		<a href="<%=context%>/" class="cart__noti-btn"> <span
			class="cart__noti-lb">TIẾP TỤC MUA HÀNG</span> <ion-icon name="cart"></ion-icon>
		</a>
	</div>
</div>
