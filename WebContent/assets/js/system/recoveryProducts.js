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

function handleRecoveryProducts() {

	const btnDeleteProducts = $('.btnRecoveryProducts');
	btnDeleteProducts.click((e) => {
		swal({
			title: "Cảnh báo",
			text: "Bạn có muốn khôi phục tất cả?",
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
					url: `${baseUrl}/system/products/trash/recovery/`,
					type: 'POST',
					data: {
						productsSelected: productsSelectedStr
					},
					success: function() {
						swal("Thông báo!", "Tất cả sản phẩm được khôi phục thành công", "success").then(() => {
							window.location.reload();
						})
					}
				});
			}
		})

	})
}
handleRecoveryProducts();

