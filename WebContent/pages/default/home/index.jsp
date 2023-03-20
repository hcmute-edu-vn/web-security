<%@page import="com.shoplane.utils.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding(Constants.UTF8);
response.setCharacterEncoding(Constants.UTF8);

String context = request.getContextPath();
String baseUrl = request.getContextPath() + "/default/home";
%>
<!doctype html>
<html lang="en">
<head>
<jsp:include page="../components/head.jsp" />
<link rel="stylesheet"
	href="<%=context%>/assets/css/default/home/slider.css" type="text/css" />
<link rel="stylesheet"
	href="<%=context%>/assets/css/default/home/home.css" type="text/css" />
<title>Cửa hàng quần áo - SHOPLANE</title>
</head>
<body>
	<div id="app">
		<jsp:include page="../components/header.jsp" />
		<main class="main">
			<!-- Slider section -->
			<jsp:include page="./slider.jsp" />
			<!-- Shirt section-->
			<jsp:include page="./shirtCatalog.jsp" />
			<!-- Short section-->
			<jsp:include page="./shortCatalog.jsp" />
		</main>
		<jsp:include page="../components/footer.jsp" />
		<jsp:include page="../components/backToTop.jsp" />
	</div>
	<input id="filterMsg" value="${sessionScope.filterMsg}" hidden />
	<!-- Import script -->
	<jsp:include page="../components/script.jsp" />
	<script type="text/javascript"
		src="<%=context%>/assets/js/default/sliderConfig.js"></script>
	<script>
		const filterMsg = $('#filterMsg').val();

		if (filterMsg !== '') {
			swal("Thông báo", filterMsg, "warning");
		}
	</script>
</body>
</html>
<%
request.getSession().setAttribute("filterMsg", "");
%>
