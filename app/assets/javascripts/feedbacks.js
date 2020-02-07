$(document).on('ajax:success', '#leave-feedback-box', function(e) {
    $('.popup-status-content').text('Your feedback has been sent successfully. After review it will be availalbe on this page');
    $('#show-ok').show();
	function close_magnific() {
		  $.magnificPopup.close();
		}

		setTimeout(close_magnific, 3000)
});


$(document).on('ajax:error', '#leave-feedback-box', function(event, xhr, settings, exceptions) {
    $('.popup-status-content').text('Your feedback has not been sent successfully. Try again');
    $('#show-failed').show();

});


