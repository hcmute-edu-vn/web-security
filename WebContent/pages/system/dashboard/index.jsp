<%@page import="com.shoplane.utils.Helper"%>
<%@page import="com.shoplane.utils.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.shoplane.services.client.ProductService"%>

<%
request.setCharacterEncoding(Constants.UTF8);
response.setCharacterEncoding(Constants.UTF8);
String context = request.getContextPath();
%>

<!doctype html>
<html lang="en">
<head>
<jsp:include page="../head.jsp" />
<title>Overview - SHOPLANE</title>
<style>
.cards {
	display: flex;
	width: 100%;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 5rem;
}

.cards__item {
	border: 0.5px solid #5ec9ff;
	border-radius: 0.4rem;
	min-width: calc(25% - 5rem);
	padding: 1rem;
	background-color: #f4f6fa;
}

.cards__body {
	display: flex;
	align-items: center;
	gap: 2rem;
}

.cards__body>svg {
	font-size: 5rem;
	color: #00b5ad;
}

.cards__content {
	display: flex;
	align-items: center;
	flex-direction: column;
	gap: 2rem;
}

.cards__content>.cards__content-title {
	font-size: 1.6rem;
	font-weight: 600;
}

.cards__content>.cards__content-count {
	font-size: 2.2rem;
	font-weight: 700;
}

.cards__div {
	width: 100%;
	height: 0.5px;
	background-color: #d2d2d2;
	margin: 2rem 0;
}

.cards__footer {
	display: flex;
	align-items: center;
	gap: 1rem;
	font-size: 1.2rem;
}

.cards__footer>svg {
	color: #5ec9ff;
}

.cards__footer>span {
	color: #a9a9a9;
}

.charts {
	display: flex;
	align-items: center;
	gap: 3rem;
	justify-content: space-between;
	margin-bottom: 5rem;
}

.charts__item {
	min-width: calc(50% - 3rem);
	min-height: 40rem;
	border: 1px solid #d2d2d2;
	background-color #f2f2f2;
	border-radius: 0.4rem;
	padding: 1rem;

	display: flex;
	align-items: center;
	flex-direction: column;
	gap: 2rem;
}

.charts__item > .charts__item-name {
	font-style: italic;
	font-size: 1.2rem;
}
</style>
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
				<div class="cards">
					<div class="cards__item">
						<div class="cards__body">
							<i class="teal fas fa-shopping-cart"></i>
							<div class="cards__content">
								<span class="cards__content-title">Tổng số đơn hàng</span> <span
									class="cards__content-count">${billCount}</span>
							</div>
						</div>
						<div class="cards__div"></div>
						<div class="cards__footer">
							<i class="fas fa-calendar"></i> <span>Trong vòng một tuần</span>
						</div>
					</div>
					<div class="cards__item">
						<div class="cards__body">
							<i class="fas fa-users" style="color: green"></i>
							<div class="cards__content">
								<span class="cards__content-title">Tổng số người dùng</span> <span
									class="cards__content-count">${userCount}</span>
							</div>
						</div>
						<div class="cards__div"></div>
						<div class="cards__footer">
							<i class="fas fa-calendar"></i> <span>Trong vòng một tuần</span>
						</div>
					</div>
					<div class="cards__item">
						<div class="cards__body">
							<i class="fab fa-product-hunt" style="color: purple"></i>
							<div class="cards__content">
								<span class="cards__content-title">Tổng sản phẩm</span> <span
									class="cards__content-count">${productCount}</span>
							</div>
						</div>
						<div class="cards__div"></div>
						<div class="cards__footer">
							<i class="fas fa-calendar"></i> <span>Trong vòng một tuần</span>
						</div>
					</div>
					<div class="cards__item">
						<div class="cards__body">
							<i class="fas fa-dollar-sign" style="color: pink"></i>
							<div class="cards__content">
								<span class="cards__content-title">Doanh thu</span> <span
									class="cards__content-count">${Helper.intToVND(totalPriceBills)}</span>
							</div>
						</div>
						<div class="cards__div"></div>
						<div class="cards__footer">
							<i class="fas fa-calendar"></i> <span>Trong vòng một tuần</span>
						</div>
					</div>
				</div>
				<div class="charts">
					<div class="charts__item">
						<div class="canvas-wrapper">
							<canvas class="chart" id="trafficflow"></canvas>
						</div>
					</div>
					<div class="charts__item">
						<div class="canvas-wrapper">
							<canvas class="chart" id="sales"></canvas>
						</div>
					</div>
				</div>
				<div class="cards">
					<div class="cards__item">
						<div class="cards__body">
							<i class="fas fa-thumbs-up" style="color: blue"></i>
							<div class="cards__content">
								<span class="cards__content-title">FACEBOOK PAGE LIKES</span> <span
									class="cards__content-count">+21,900</span>
							</div>
						</div>
						<div class="cards__div"></div>
						<div class="cards__footer">
							<i class="fas fa-calendar"></i> <span>Trong vòng một tuần</span>
						</div>
					</div>
					<div class="cards__item">
						<div class="cards__body">
							<i class="orange large-icon mb-2 fas fa-reply-all"
								style="color: orange"></i>
							<div class="cards__content">
								<span class="cards__content-title">INSTAGRAM FOLLOWERS</span> <span
									class="cards__content-count">+22,566</span>
							</div>
						</div>
						<div class="cards__div"></div>
						<div class="cards__footer">
							<i class="fas fa-calendar"></i> <span>Trong vòng một tuần</span>
						</div>
					</div>
					<div class="cards__item">
						<div class="cards__body">
							<i class="fas fa-mail-bulk" style="color: grey"></i>
							<div class="cards__content">
								<span class="cards__content-title">E-MAIL SUBSCRIBERS</span> <span
									class="cards__content-count">+15,566</span>
							</div>
						</div>
						<div class="cards__div"></div>
						<div class="cards__footer">
							<i class="fas fa-calendar"></i> <span>Trong vòng một tuần</span>
						</div>
					</div>
					<div class="cards__item">
						<div class="cards__body">
							<svg xmlns="http://www.w3.org/2000/svg" width="50" height="50"
								style="color: black" fill="currentColor" class="bi bi-tiktok"
								viewBox="0 0 16 16"> <path
									d="M9 0h1.98c.144.715.54 1.617 1.235 2.512C12.895 3.389 13.797 4 15 4v2c-1.753 0-3.07-.814-4-1.829V11a5 5 0 1 1-5-5v2a3 3 0 1 0 3 3V0Z" /> </svg>
							<div class="cards__content">
								<span class="cards__content-title">TIKTOK FOLLOWERS</span> <span
									class="cards__content-count">+6,267</span>
							</div>
						</div>
						<div class="cards__div"></div>
						<div class="cards__footer">
							<i class="fas fa-calendar"></i> <span>Trong vòng một tuần</span>
						</div>
					</div>
				</div>
				<div class="charts">
					<div class="charts__item">
						<div class="canvas-wrapper">
							<canvas id="myPieChart"></canvas>
						</div>
						<div class="charts__item-name">Biểu đồ người dùng</div>
					</div>
					<div class="charts__item">
						<canvas id="myAreaChart"></canvas>
					</div>
				</div>
			</main>
		</div>
	</div>
	<input type="text" hidden id="adminUserCount" value="${adminUserCount}"/>
	<input type="text" hidden id="customerUserCount" value="${customerUserCount}"/>
	<input type="text" hidden id="employeeUserCount" value="${employeeUserCount}"/>
	<!-- Jquery -->
	<jsp:include page="../components/script.jsp"></jsp:include>
	<script type="text/javascript"
		src="<%=context%>/assets/js/system/dashboard/chart.js"></script>
</body>
</html>

