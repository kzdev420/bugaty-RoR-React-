// (function() {
//   $(function() {
//     return $("form#login-box").bind("ajax:success", function(event, xhr, settings) {
//       alert('sucess');
//       return $.magnificPopup.close();
//     }).bind("ajax:error", function(event, xhr, settings, exceptions) {
//       alert('failed login');
//       var error_messages;
//       error_messages = xhr.responseJSON['error'] ? "<div class='alert alert-danger pull-left'>" + xhr.responseJSON['error'] + "</div>" : xhr.responseJSON['errors'] ? $.map(xhr.responseJSON["errors"], function(v, k) {
//         return "<div class='alert alert-danger pull-left'>" + k + " " + v + "</div>";
//       }).join("") : "<div class='alert alert-danger pull-left'>Unknown error</div>";
//       return $(this).parents('.modal').children('.modal-footer').html(error_messages);
//     });
//   });

// }).call(this);

$(document).on('ajax:success', '#login-box, #login-page-box', function(e) {
    var urlParams = new URLSearchParams(window.location.search);
    var redirect = urlParams.get("to")
    $.magnificPopup.close();
    if(redirect) {
       window.location.href = redirect
    } else {
        window.location.reload()
    }
});

$(document).on('ajax:error', '#login-box, #login-page-box', function(event, xhr, settings, exceptions) {
    var error_messages;

    $(this).find('.alert').remove();
	error_messages = xhr.responseJSON['error'] ? "<div class='alert alert-danger pull-left'>" + xhr.responseJSON['error'] + "</div>" : xhr.responseJSON['errors'] ? $.map(xhr.responseJSON["errors"], function(v, k) {
         return "<div class='alert alert-danger'>" + k + " " + v + "</div>";
       }).join("") : "<div class='alert alert-danger'>Unknown error. Please contact support</div>";
       return $('#login-box, #login-page-box').prepend(error_messages);
});

// registration form

$(document).on('ajax:success', '#register-box', function(e) {
    $.magnificPopup.close();
    $('.popup-status-content').text('You have successfully signed up. Please check your email to confirm your registration');
    $('#show-ok').show();
});

$(document).on('ajax:error', '#register-box', function(event, xhr, settings, exceptions) {
    $(this).find('.alert').remove();
    var error_messages;

	error_messages = xhr.responseJSON['error'] ? "<div class='alert alert-danger pull-left'>" + xhr.responseJSON['error'] + "</div>" : xhr.responseJSON['errors'] ? $.map(xhr.responseJSON["errors"], function(v, k) {
         return "<div class='alert alert-danger'>" + k + " " + v + "</div>";
       }).join("") : "<div class='alert alert-danger'>Unknown error. Please contact support</div>";
       return $('#register-box').prepend(error_messages);
});

// recover password

$(document).on('ajax:success', '#forget-box', function(e) {
    $.magnificPopup.close();
    $('.popup-status-content').text('You have successfully recovered password. Please check your email to set an new password');
    $('#show-ok').show();
});

$(document).on('ajax:error', '#forget-box', function(event, xhr, settings, exceptions) {
    $(this).find('.alert').remove();
    var error_messages;

  error_messages = xhr.responseJSON['error'] ? "<div class='alert alert-danger pull-left'>" + xhr.responseJSON['error'] + "</div>" : xhr.responseJSON['errors'] ? $.map(xhr.responseJSON["errors"], function(v, k) {
         return "<div class='alert alert-danger'>" + k + " " + v + "</div>";
       }).join("") : "<div class='alert alert-danger'>Unknown error. Please contact support</div>";
       return $('#forget-box').prepend(error_messages);
});

// $(document).ready(function() {
// 	//form id
// 	$('#login-box')
// 	.on("ajax:success", function(evt, data, status, xhr) {
// 	  //function called on status: 200 (for ex.)
// 	  console.log('success');
// 	})
// 	.on("ajax:error", function(evt, xhr, status, error) {
// 	  //function called on status: 401 or 500 (for ex.)
// 	  console.log(xhr.responseText);
// 	});
// });


// $(document).ready(function() {
// 	//form id
// 	$('#login-box').ajaxSuccess( function(evt, data, status, xhr) {
// 	  //function called on status: 200 (for ex.)
// 	  console.log('success');
// 	});

// 	$('#login-box').ajaxFail(function(evt, xhr, status, error) {
// 	  //function called on status: 401 or 500 (for ex.)
// 	  console.log(xhr.responseText);
// 	});
// });


// $(document).on('submit', '#login-box', function(){
// 	var $form, $btn;

// 	$form = $(this);
// 	$btn = $form.find('.btn-popup-login');
// 	$form.find('.errors').remove();

// 	$.post({
// 	  url: '/users/login',
// 	  data: $form.serialize()
// 	}).error(function(jqXHR, textStatus, errorThrown){
// 	  $form.prepend('<div class="errors">Invalid email or password</div>');
// 	  $btn.prop( "disabled", false );
// 	}).done(function(data, textStatus, jqXHR){
// 	  window.location.reload();
// 	});
// });



