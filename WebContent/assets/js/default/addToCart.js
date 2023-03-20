function handleChangeCartCount() {
	const cartCountString = $('#ordersCount').val() || '0';

	const cartCount = +cartCountString;
	$('.header_navbar-count').text(cartCount);
}

handleChangeCartCount();