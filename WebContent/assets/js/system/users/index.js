	let selectedItems = [];
	const inputAll = $('.all');
	const inputItems = [...$('input[type=checkbox]')].slice(1);
	inputItems.forEach(item => {
		item.addEventListener("click", e => {
			const isChecked = e.target.checked;
			if (isChecked) {
				selectedItems.push(e.target.value);
				if (selectedItems.length === inputItems.length) {
					$('.all').prop('checked', true);
				}
			} else {
				selectedItems = selectedItems.filter(item => item !== e.target.value);
				$('.all').prop('checked', false);
			}
		})
	});
	
	
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

function deleteUser() {
	const baseUrl = handleGetBaseUrl();
	$.ajax({
		url: `${baseUrl}/system/users/delete`,
		type: "POST",
		data: {
			data: selectedItems.join(',')
		},
		success: function(response) {
			alert('successfull')
/* 					window.location.reload()
 */				},
		error: function(xhr) {
			alert('error')
		}
	});
}
function handleSelectRole(elm) {
	const queryString = window.location.search;
	const urlParams = new URLSearchParams(queryString);

	const pageSize = urlParams.get('page_size');

	window.location = '?role_id=' + elm.value + '&current_page=1&page_size=' + pageSize;

}
function handleSelectEntries(elm) {
	const queryString = window.location.search;
	const urlParams = new URLSearchParams(queryString);

	const roleId = urlParams.get('role_id');

	window.location = '?eole_id=' + roleId + '&current_page=1&page_size=' + elm.value;
}