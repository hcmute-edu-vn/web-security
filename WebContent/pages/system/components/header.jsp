<%@page import="com.shoplane.utils.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String context = request.getContextPath();
%>

<div class="header__container">
	<div class="header__userinfo">
		<span class="header__userinfo-username">Xin chào,
			${sessionScope.user.getFullname()}</span>
		<div class="header__navbar-item hide dropdown">
			<img
				src="https://cpad.ask.fm/450/774/576/-29996968-1tfd7tc-gpggmmc5d0og3a0/original/image.jpg"
				alt="" class="header__userinfo-img">
			<div class="dropdown-content">
				<a
					href="">Tài khoản</a>
				<a
					href="">Đăng xuất</a>
			</div>
		</div>

	</div>


</div>