
$(document).on('ajax:success', '#set-email-references-box', function(e) {
    $('.popup-status-content').text('Your email preferences successfully updated');
    $('#show-ok').show();
    $.magnificPopup.close();
});

$(document).on('ajax:error', '#set-email-references-box', function(event, xhr, settings, exceptions) {
    $('.popup-status-content').text('Sorry. Some error happens. Please try again');
    $('#show-failed').show();
});