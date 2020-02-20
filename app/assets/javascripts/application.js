// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
// require tinymce-jquery
//= require ckeditor/init
// require turbolinks
//= require_tree .

$(function() {
  $('[data-tooltip]').qtip({
    content: {
      attr: 'data-tooltip'
    },
    style: {
      tip: {
        corner: 'left center',
        height: 24,
        width: 10
      },
      classes: 'qtip-blue'
    },
    position: {
      my: 'left center',
      adjust: {
        y: -7
      }
    }
  });
});

$(function() {
  $('.listing-select-checkbox input#listing-all').change(function(e) {
    $('.listing-select-checkbox input:not([id="listing-all"])').prop('checked', $(this).prop('checked'));
  });

  $('.listings-batch-actions .dropdown a').click(function(e) {
    var ids = $('input[name="selected_listing"]:checked').map(function(i, input) {
      return $(input).val();
    }).get().join(',');

    if(ids.length == 0) {
      alert('Please select at least one listing!');
      return false;
    } else {
      if($(this).attr('id') == 'delete-button') {
        $('#delete-listings-popup').find('#delete-link').off('click').attr('href', $(this).data('original-href') + '?listings=' + ids);
        return false;
      } else {
        $(this).attr('href', $(this).data('original-href') + '?listings=' + ids);
        return true;
      }
    }
  });
});

$.fn.scrollView = function () {
  return this.each(function () {
    $('html, body').animate({
      scrollTop: $(this).offset().top
    }, 1000);
  });
}

$(document).ready(function(){
	$('#process-redirect').click(function(){
		var read_value = $('#post-ad-popup-select').val();
		if (read_value !== "" ) {
			window.location.href = "/listings/new/" + read_value;
		} else{

		}
	});
	$('.popup-content .btn-blue').click(function(){
		$.magnificPopup.close();
	});
  $(".paginator-form").change(function() {
    $(this).submit();
  });

  $('#reviews_link').click(function(){
    $('a[href="#reviews"]').trigger('click');
    $('a[href="#reviews"]').scrollView();
  });

  $("#owl-mainpage").owlCarousel({
    loop: true,
    nav: false,
    dots: true,
    items: 1,
    autoplay:false
  });
});
