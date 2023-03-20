function handleGetBaseUrl() {
	const { hostname, host, protocol } = window.location;
	let url = "";
	if (hostname !== 'localhost') {
		url = `${protocol}//${host}`;
	} else {
		url = `${protocol}//${host}/shoplane-ft`;
	}
	return url;
}


function handlePreviewImage() {
	// Preview image
	const pImage = document.querySelector('.product_img');

	$('.member-img').click(e => {
		const imgPreviewSrc = e.target.src;
		Object.assign(pImage.style, {
			backgroundImage: `url(${imgPreviewSrc})`,
		})
	})
}

function handleBtnQuantity() {
	const quantityInput = document.querySelector('.product_info-quantity-text');
	$('.btn-ins').click(() => {
		console.log(document.location.hostname);
		const { value } = quantityInput;
		quantityInput.value = +value + 1;
	})

	$('.btn-sub').click(() => {
		const { value } = quantityInput;
		if (+value > 1) {
			quantityInput.value = value - 1;
		}
	})
}

function handleAddToCart() {
	$('.btn__add-to-cart').click(() => {
		const data = { oId: '', quanty: '' };
		// Get quantity 
		data.quanty = $('.product_info-quantity-text').val();

		// Get checked radio
		const selected = $(".product_info-size-item input[type='radio']:checked");
		if (selected.length > 0) {
			data.oId = selected.val();
		}
		// Verify
		if (data.oId === '') {
			swal("Vui lòng lựa chọn kích thước");
			return;
		}
		if (data.quanty === '') {
			swal('Vui lòng chọn số lượng')
			return;
		}

		// POST data using ajax
		const baseUrl = handleGetBaseUrl();
		$.ajax({
			type: 'POST',
			url: `${baseUrl}/product-detail`,
			data: data,
			success: function(result) {
				swal("Thông báo!", "Thêm sản phẩm thành công", "success").then(() => {
					handleChangeCartCount();
				})
			},
			error: function(err) {
				swal("Thông báo!", "Thêm sản phẩm thất bại", "error");
			}
		})
	})
}

function handleChangeCartCount() {
	window.location.reload();
	const cartCountString = $('#ordersCount').val() || '0';

	const cartCount = +cartCountString;
	$('.header_navbar-count').text(cartCount);
}


handleGetBaseUrl();

handlePreviewImage();
handleBtnQuantity();
handleAddToCart();