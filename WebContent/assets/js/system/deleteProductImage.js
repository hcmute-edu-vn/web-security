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

function handleDeleteProductImage() {
	const productId = $('.productId').val();
	const btnDeleteImages = $('.btnDeleteImages');
	btnDeleteImages.click((e) => {
		e.preventDefault();
		const imagesSelected = [];
		$.each($("input[name='imageSelected']:checked"), function() {
			imagesSelected.push($(this).val());
		});
		const imagesSelectedStr = imagesSelected.join(',');
		const baseUrl = handleGetBaseUrl();

		$.ajax({
			url: `${baseUrl}/system/products/images/delete/`,
			type: 'GET',
			data: {
				imagesSelected: imagesSelectedStr,
				product_id: productId
			},
			success: function() {
				swal("Xóa ảnh thành công").then(() => {
					window.location.reload();
				})
			}
		});
	})
}
handleDeleteProductImage();

