<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
String context = request.getContextPath();
%>

<div class="cart__success">
	<div class="cart__success-icon">
		<ion-icon name="bag-check"></ion-icon>
	</div>
	<div class="cart__noti">
		<h3 class="cart__noti-txt">ĐẶT HÀNG THÀNH CÔNG</h3>
		<a href="<%=context %>/" class="cart__noti-btn"> <span class="cart__noti-lb">TIẾP
				TỤC MUA HÀNG</span> <ion-icon name="cart"></ion-icon>
		</a>
	</div>
</div>
