<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
request.setCharacterEncoding("utf-8");
String context = request.getContextPath();
%>

<!doctype html>
<html lang="en">
<head>
<jsp:include page="../head.jsp" />
<link rel="stylesheet"
	href="<%=context%>/assets/css/system/user/index.css" type="text/css" />
<link rel="stylesheet"
	href="<%=context%>/assets/css/system/components/pagination.css"
	type="text/css" />
<title>Quản lý người dùng - SHOPLANE</title>
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
						href="<%=context%>/system/users/?role_id=ROL0&current_page=1&page_size=10">Quản
						lý người dùng</a>
				</div>
				<div class="actions">
					<div class="action__select">
						Loại người dùng <select id="select__type"
							onchange="javascript:handleSelectRole(this)">
							<c:forEach var="item" items="${roles}">
								<c:choose>
									<c:when test="${item.getRoleId().equals(roleId)}">
										<option value="${item.getRoleId()}" selected>${item.getRoleName()}</option>
									</c:when>
									<c:otherwise>
										<option value="${item.getRoleId()}">${item.getRoleName()}</option>
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
					<a href="<%=context%>/system/users/create">Thêm người dùng</a> <a
						onclick="deleteUser(this)"> Xóa người dùng</a>
				</div>
				<div class="table">
					<div class="table__head">
						<div style="width: 5%">
							<input type="checkbox" class="all">
						</div>
						<div style="width: 10%">Mã người dùng</div>
						<div style="width: 25%">Họ và tên</div>
						<div style="width: 25%">Email</div>
						<div style="width: 15%">Loại người dùng</div>
						<div style="width: 15%">Ngày tạo</div>
						<div style="width: 10%"></div>
					</div>
					<div class="table__body" id="data-users">
						<c:forEach var="item" items="${users}">
							<div class="table__row">
								<div style="width: 5%">
									<input type="checkbox" value="${item.getUserId()}" />
								</div>
								<div style="width: 10%">${item.getUserId()}</div>
								<div style="width: 25%">${item.getFullname()}</div>
								<div style="width: 25%">${item.getEmail()}</div>
								<div style="width: 15%">${item.getRole().getRoleName()}</div>
								<div style="width: 15%">Ngày tạo</div>
								<div style="width: 10%">
									<a href="./edit?user_id=${item.getUserId()}">Xem chi tiết</a>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
				<input type="text" id="createUserStatus" value="${createUserStatus}"
					hidden /> <input type="text" id="editUserStatus"
					value="${editUserStatus}" hidden />
				<jsp:include page="./pagination.jsp"></jsp:include>
			</main>
		</div>
	</div>
	<!-- Script included-->
	<jsp:include page="../components/script.jsp"></jsp:include>
	<script type="text/javascript"
		src="<%=context%>/assets/js/system/users/index.js"></script>
	<script>
		const createUserStatus = $('#createUserStatus').val();
		const editUserStatus = $('#editUserStatus').val();
		if (createUserStatus === 'success') {
			swal("Thông báo", "Tạo người dùng thành công", "success");
		}
		if (editUserStatus === 'success') {
			swal("Thông báo", "Chỉnh sửa người dùng thành công", "success");
		}
	</script>
</body>
</html>

