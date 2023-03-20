<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<head>
<title>Products Manage</title>
<link rel="stylesheet" href="../../assets/css/index.css" type="text/css" />

<style>
#admin {
	display: flex;
}

#sidebar {
	width: 25rem;
}

#content {
	width: calc(100% - 25rem);
}

#header {
	height: 6rem;
}

#main-content {
	padding: 3rem 2rem 10rem 1rem;
}

.actions {
	display: flex;
	justify-content: flex-end;
	gap: 2rem;
	padding-bottom: 1rem;
	border-bottom: 1px solid #ddd;
}

.actions>a:hover {
	text-decoration: underline;
}

.table {
	padding-top: 1rem;
}

.table__head, .table__row {
	display: flex;
	align-items: center;
	border: 1px solid #ddd;
	border-radius: 4px;
	box-shadow: 0px 0px 9px 3px rgb(41 41 41/ 10%);
}

.table__head>div, .table__row>div {
	text-align: center;
}

.table__head {
	font-weight: 600;
	margin-bottom: 2rem;
	padding: 1rem 0;
}

.table__row {
	padding: 1.5rem 0;
	font-size: 1.4rem;
	transition: all linear 0.2s;
}

.table__row:hover {
	box-shadow: 0px 0px 9px 3px rgb(41 41 41/ 20%);
}

.table__body {
	display: flex;
	flex-direction: column;
	gap: 1.5rem;
}
</style>
</head>

<div id="admin">
	<div id="sidebar">
		<jsp:include page="../components/sidebar.jsp" />
	</div>
	<div id="content">
		<div id="header">
			<jsp:include page="../components/header.jsp" />
		</div>
		<main id="main-content">
			<div class="actions">
				<a href="#">Quản lý màu sắc</a> <a href="">Quản lý kích thước</a> <a
					href="#">Thêm bản ghi</a> <a href="#">Xóa bản ghi</a>
			</div>
			<div class="table">
				<div class="table__head">
					<div style="width: 5%">
						<input type="checkbox">
					</div>
					<div style="width: 10%">ID</div>
					<div style="width: 35%">Tên sản phẩm</div>
					<div style="width: 15%">Màu sắc</div>
					<div style="width: 10%">Kích cỡ</div>
					<div style="width: 10%">Khả dụng</div>
					<div style="width: 15%"></div>
				</div>
				<div class="table__body">
					<div class="table__row">
						<div style="width: 5%">
							<input type="checkbox">
						</div>
						<div style="width: 10%">ID</div>
						<div style="width: 35%">Tên sản phẩm</div>
						<div style="width: 15%">Màu sắc</div>
						<div style="width: 10%">Kích cỡ</div>
						<div style="width: 10%">Khả dụng</div>
						<div style="width: 15%">Xem chi tiết</div>
					</div>
					<div class="table__row">
						<div style="width: 5%">
							<input type="checkbox">
						</div>
						<div style="width: 10%">ID</div>
						<div style="width: 35%">Tên sản phẩm</div>
						<div style="width: 15%">Màu sắc</div>
						<div style="width: 10%">Kích cỡ</div>
						<div style="width: 10%">Khả dụng</div>
						<div style="width: 15%"></div>
					</div>
				</div>
			</div>
		</main>
	</div>
</div>