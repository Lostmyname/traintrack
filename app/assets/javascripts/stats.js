(function (Chart) {

	if (typeof Chart !== 'function') {
		return;
	}

	var $number = $('#conferences-per-month');
	var numberData = JSON.parse($number.text());

	var numberContext = $number.get(0).getContext('2d');
	new Chart(numberContext).Bar(formatData(numberData, 'Conferences per month'));

	var $cost = $('#cost-per-month');
	var costData = JSON.parse($cost.text());

	var costContext = $cost.get(0).getContext('2d');
	new Chart(costContext).Bar(formatData(costData, 'Cost per month'), {
		scaleLabel: formatCurrency,
		tooltipTemplate: formatCurrency
	});


	function formatData(data, name) {
		var months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
		return {
			labels: Object.keys(data).map(function (date) {
				return months[new Date(date).getMonth()]
			}),
			datasets: [
				{
					label: name,
					data: Object.keys(data).map(function (key) {
						return data[key]
					})
				}
			]
		};
	}

	function formatCurrency(value) {
		var number = '£' + value.value;

		if (number.lastIndexOf('.') === number.length - 2) {
			number += '0';
		}

		return number;
	}

})(window.Chart);