<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
String context = request.getContextPath();
%>

<!doctype html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<link rel="stylesheet" href="<%=context%>/assets/css/error.css"
	type="text/css" />
<title>500 | Internal Server Error!</title>
</head>

<body>
	<div class="wrapper">
		<div class="page vertical-align text-center">
			<div class="page-content vertical-align-middle">
				<header>
					<h1 class="animation-slide-top">500</h1>
					<p>Internal Server Error !</p>
				</header>
				<p class="error-advise">Whoopps, something went wrong.</p>
				<a class="btn btn-primary btn-round mb-5" href="${homeUrl}">GO
					TO HOME PAGE</a>
				<footer class="page-copyright">
					<p>© 2022. All RIGHT RESERVED.</p>
				</footer>
			</div>
		</div>
	</div>
</body>

</html>
>
