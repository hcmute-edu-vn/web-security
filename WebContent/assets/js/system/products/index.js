function handleSelectProductType(elm) {
	const queryString = window.location.search;
	const urlParams = new URLSearchParams(queryString);

	const category = urlParams.get('category');
	const pageSize = urlParams.get('page_size');

	window.location = '?product_type=' + elm.value + '&category='
		+ category + '&current_page=1&page_size=' + pageSize;

}
function handleSelectCategory(elm) {
	const queryString = window.location.search;
	const urlParams = new URLSearchParams(queryString);

	const productType = urlParams.get('product_type');
	const pageSize = urlParams.get('page_size');

	window.location = '?product_type=' + productType + '&category='
		+ elm.value + '&current_page=1&page_size=' + pageSize;
}

function handleSelectEntries(elm) {
	const queryString = window.location.search;
	const urlParams = new URLSearchParams(queryString);

	const productType = urlParams.get('product_type');
	const category = urlParams.get('category');

	window.location = '?product_type=' + productType + '&category='
		+ category + '&current_page=1&page_size=' + elm.value;
}