<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="back-to-top">
	<i class="fas fa-chevron-up"></i>
</div>

<script>
	const backToTopRef = document.querySelector(".back-to-top");
	const headerheight = 80;
	document.addEventListener('scroll', () => {
		if(document.body.scrollTop > headerheight ||
			      document.documentElement.scrollTop > headerheight) {
			backToTopRef.classList.add("visible");
		} else {
			backToTopRef.classList.remove("visible");
		}
	})
	console.log({backToTopRef})
	backToTopRef.addEventListener('click', () => {
		window.scrollTo({top: 0, behavior: 'smooth'});
	})
</script>