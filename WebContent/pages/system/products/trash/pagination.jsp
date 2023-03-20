<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
request.setCharacterEncoding("utf-8");
String context = request.getContextPath();
String baseUrl = context + "/system/products/list";
%>

<nav class="navigation">
	<div class="pagination">
		<c:choose>
			<c:when test="${currentPage == 1}">
				<div class="page-item btn-submit disable">
					<span>Previous</span>
				</div>
			</c:when>
			<c:otherwise>
				<a class="page-item btn-submit"
					href="<%=context%>/system/products/?product_type=${productType}&category=${category}&current_page=${currentPage - 1}&page_size=${pageSize}"><span>Previous</span></a>
			</c:otherwise>
		</c:choose>
		<c:forEach begin="1" end="${totalPage}" var="item">
			<c:choose>
				<c:when test="${item == currentPage}">
					<a class="page-item btn-submit active"
						href="<%=context%>/system/products/?product_type=${productType}&category=${category}&current_page=${item}&page_size=${pageSize}"><span>${item}</span></a>
				</c:when>
				<c:otherwise>
					<a class="page-item btn-submit"
						href="<%=context%>/system/products/?product_type=${productType}&category=${category}&current_page=${item}&page_size=${pageSize}"><span>${item}</span></a>
				</c:otherwise>
			</c:choose>

		</c:forEach>
		<c:choose>
			<c:when test="${currentPage == totalPage}">
				<div class="page-item btn-submit disable">
					<span>Next</span>
				</div>
			</c:when>
			<c:otherwise>
				<a class="page-item btn-submit"
					href="<%=context%>/system/products/?product_type=${productType}&category=${category}&current_page=${currentPage + 1}&page_size=${pageSize}"><span>Next</span></a>
			</c:otherwise>
		</c:choose>
	</div>
</nav>