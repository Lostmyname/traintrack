var $rejectedForm = $('[name="status"][value="rejected"]').closest('form');

$rejectedForm.on('submit', function () {
	var reason = prompt('Why? WHY?!');
	$rejectedForm.find('[name="reason"]').val(reason);
});
