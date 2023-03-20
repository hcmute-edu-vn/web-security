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

function handleSoftDeleteProduct() {

	const btnDeleteProducts = $('.btnDeleteProducts');
	btnDeleteProducts.click((e) => {
		swal({
			title: "Cảnh báo",
			text: "Bạn có chắc chắc xóa?",
			icon: "warning",
			buttons: true,
			dangerMode: true,
		}).then((willDelete) => {
			if (willDelete) {
				e.preventDefault();
				const productsSelected = [];
				$.each($("input[name='productSelected']:checked"), function() {
					productsSelected.push($(this).val());
				});
				const productsSelectedStr = productsSelected.join(',');
				const baseUrl = handleGetBaseUrl();

				$.ajax({
					url: `${baseUrl}/system/products/delete/`,
					type: 'GET',
					data: {
						productsSelected: productsSelectedStr
					},
					success: function() {
						swal("Thông báo!", "Sản phẩm đã bị xóa", "success").then(() => {
							window.location.reload();
						})
					}
				});
			}
		})

	})
}
handleSoftDeleteProduct();

