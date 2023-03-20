<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String context = request.getContextPath();
%>

<meta charset="UTF-8" />
<meta name="viewport" content="width=divice-width, initial-scale=1" />
<!-- Google font  -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@100;200;300;400;500;600;700&display=swap"
	rel="stylesheet">

<!-- Fontawesome -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"
	integrity="sha384-DyZ88mC6Up2uqS4h/KRgHuoeGwBcD4Ng9SiP4dIRy0EXTlnuz47vAwmeGwVChigm"
	crossorigin="anonymous" />
<!-- Swiper -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css" />
<link rel="stylesheet" type="text/css"
	href="<c:url value='/assets/css/index.css?v=1' />" />
<link rel="stylesheet" type="text/css"
	href="<%=context %>/assets/css/system/components/header.css" />
<link rel="stylesheet" type="text/css"
	href="<%=context %>/assets/css/system/components/sidebar.css" />
<link rel="shortcut icon"
	href="<%=context %>/assets/images/favicon/favicon.ico"
	type="image/x-icon" />

<script defer
	src="https://use.fontawesome.com/releases/v5.15.4/js/all.js"
	integrity="sha384-rOA1PnstxnOBLzCLMcre8ybwbTmemjzdNlILg8O7z1lUkLXozs4DHonlDtnE7fpc"
	crossorigin="anonymous"></script>

<script type="module" defer
	src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
<script nomodule defer
	src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>