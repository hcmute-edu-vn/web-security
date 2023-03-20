<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
List<String> slideUrls = Arrays.asList(
		"https://theme.hstatic.net/200000305259/1000922697/14/slide_index_1_master.jpg?v=213",
		"https://theme.hstatic.net/200000305259/1000922697/14/slide_index_2.jpg?v=383",
		"https://theme.hstatic.net/200000305259/1000922697/14/slide_index_1_master.jpg?v=213",
		"https://theme.hstatic.net/200000305259/1000922697/14/slide_index_2.jpg?v=383");
%>

<section>
	<!-- Slider main container -->
	<div class="swiper">
		<!-- Additional required wrapper -->
		<div class="swiper-wrapper">
			<!-- Slides -->
			<%
			for (int i = 0; i < slideUrls.size(); i++) {
			%>
			<div class="swiper-slide">
				<div class="swiper-slide__img"
					style="background-image: url(<%=slideUrls.get(i)%>);"></div>
			</div>
			<%
			}
			%>
		</div>
		<!-- If we need pagination -->
		<div class="swiper-pagination"></div>

		<!-- If we need navigation buttons -->
		<div class="swiper-button-prev"></div>
		<div class="swiper-button-next"></div>
	</div>
</section>