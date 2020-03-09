// Send message

$(document).on('ajax:success', '#send-u-message-box', function(e) {
    $('.popup-status-content').text('Message has been sent successfully');
    $('#show-ok').show();
    $.magnificPopup.close();
});

$(document).on('ajax:error', '#send-u-message-box', function(event, xhr, settings, exceptions) {
    $('.popup-status-content').text('Message has not been sent successfully. Try again');
    $('#show-failed').show();
});


$(document).on('ajax:success', '#send-message-box', function(e) {
    $('.popup-status-content').text('Message has been sent successfully to the listing owner');
    $('#show-ok').show();
    $.magnificPopup.close();
});

$(document).on('ajax:error', '#send-message-box', function(event, xhr, settings, exceptions) {
    $('.popup-status-content').text('Message has not been sent successfully. Try again');
    $('#show-failed').show();
});


// Send job application
$(document).on('ajax:success', '#send-message-job-box', function(e) {
    $('.popup-status-content').text('Job application has been sent successfully to the listing owner');
    $('#show-ok').show();
    $.magnificPopup.close();
});

$(document).on('ajax:error', '#send-message-job-box', function(event, xhr, settings, exceptions) {
    $('.popup-status-content').text('Job application has not been sent successfully. Try again');
    $('#show-failed').show();
});


// Report ad
$(document).on('ajax:success', '#send-report-box', function(e) {
    $('.popup-status-content').text('Report has been sent successfully to the administrator');
    $('#show-ok').show();
    $.magnificPopup.close();
});

$(document).on('ajax:error', '#send-report-box', function(event, xhr, settings, exceptions) {
    $('.popup-status-content').text('Report has not been sent successfully. Fix errors');
    $('#show-failed').show();
});



// Send message contact
$(document).on('ajax:success', '#send-contact-message', function(e) {
    $('.popup-status-content').text('Message has been sent successfully.');
    $('#show-ok').show();
  $(this).find('input[name="first_name"]').val("");
  $(this).find('input[name="email"]').val("");
  $(this).find('input[name="c_email"]').val("");
  $(this).find('input[name="phone"]').val("");
  $(this).find('input[name="message"]').val("");
});

$(document).on('ajax:error', '#send-contact-message', function(event, xhr, settings, exceptions) {
    $('.popup-status-content').text('Message has not been sent successfully. Try again.');
    $('#show-failed').show();
});


$(document).ready(function(){

  $('.hide-status').click(function(){
  	$('.popup-overlay').hide();
  });


  $('#send-message-box .btn-pink').on('click', function(){
      var v = grecaptcha.getResponse();
      if(v.length == 0)
      {
          console.log('fail');
          $(this).closest('#send-message-box').prepend('<div class="alert alert-danger">You cant leave Captcha Code empty</div>');
          return false;
      }
  });

  $('#send-message-job-box .btn-pink').on('click', function(){
      var v = grecaptcha.getResponse();
      if(v.length == 0)
      {
          console.log('fail');
          $(this).closest('#send-message-job-box').prepend('<div class="alert alert-danger">You cant leave Captcha Code empty</div>');
          return false;
      }
  });

  $('.open-bs-tab').click(function(){
    var target = $(this).data('move');
    activaTab(target);
  });

  $('#listing-show-map').hide();
  $('#trigger-map').click(function(){
    $('#listing-show-map').slideToggle(300);
  });

  $(function() {
    return $(document).on('change', '#cont_id', function(e) {
      return $.ajax({
        url: '/update_countries/',
        type: 'GET',
        dataType: 'script',
        data: {
          cont_id: $("#cont_id option:selected").val()
        },
        error: function(jqXHR, textStatus, errorThrown) {
          return console.log("AJAX Error: " + textStatus);
        }
      });
    });
  });

  $(function() {
    return $(document).on('change', '#country_id', function(e) {
      return $.ajax({
        url: '/update_regions/',
        type: 'GET',
        dataType: 'script',
        data: {
          country_id: $("#country_id option:selected").val()
        },
        error: function(jqXHR, textStatus, errorThrown) {
          return console.log("AJAX Error: " + textStatus);
        }
      });
    });
  });

  $(function() {
    return $(document).on('change', '#region_id', function(e) {
      return $.ajax({
        url: '/update_cities/',
        type: 'GET',
        dataType: 'script',
        data: {
          region_id: $("#region_id option:selected").val()
        },
        error: function(jqXHR, textStatus, errorThrown) {
          return console.log("AJAX Error: " + textStatus);
        }
      });
    });
  });

  function removeOpeningHoursField(e) {
    e.preventDefault();

    $(this).siblings('input').val(null);

    if($('.opening-hours-field-group').length == 1)
      $(this).parents('.opening-hours-field-group').addClass('hidden');
    else
      $(this).parents('.opening-hours-field-group').remove();
  }

  $(function() {
    $('#add-opening-hours-button').click(function(e) {
      e.preventDefault();

      var str = $('#weekday').val() + ' ' + $('#start_time').val() + ' - ' + $('#end_time').val()

      if($('.opening-hours-field-group.hidden').length > 0)
        var field = $('.opening-hours-field-group.hidden');
      else
        var field = $('.opening-hours-field-group:last').clone();

      field.find('input').val(str);
      field.find('a').off('click').click(removeOpeningHoursField);

      if($('.opening-hours-field-group.hidden').length == 0)
        field.insertAfter($('input.opening-hours-field:last').parent());
      else
        field.removeClass('hidden');
    });

    $('.remove-opening-hours-field-button').click(removeOpeningHoursField);
  });
});

function activaTab(tab){
  $('.nav-tabs a[href="#' + tab + '"]').tab('show');
};


// SEARCH CAR MAKES AND MODELS

$(document).ready(function(){
  var car_models = [];
  var car_makes = [];


  $.getJSON('../json/cars.json', function (data) {
    $.each( data, function( index_main, model ) {
      car_makes.push(index_main);
      var item = "<option value="+ index_main +">" + index_main + "</option>";
      $(item).appendTo('#search_car_make');
    });
  });

  $('#search_car_make').on('change', function(){
    current_make = $('#search_car_make').val();
    get_current_models(current_make);
  });


  function get_current_models(input){
    $('#search_car_model').html('<option value="0">All</option>');
    $.getJSON('../json/cars.json', function (data) {
      $.each( data, function( index_main, model ) {
        if (input == index_main){
          $.each( model, function( key, val ){
            car_models.push(val);
            var item = "<option value="+ val +">" + val + "</option>";
            $(item).appendTo('#search_car_model');
          });
        }
      });
    });
  }
});

