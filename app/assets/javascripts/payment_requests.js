jQuery(document).ready(function ($){
  var viewControl = {
    price: parseFloat($("input#payment_request_price").val()),
    delivery_cost: parseFloat($("input#payment_request_delivery_cost").val()),
    discount_percentage: 0,
    calculateTotalAmount: function(source){
      var amount = this.price + this.delivery_cost;
      var sum = (amount - amount * this.discount_percentage / 100).toFixed(2);
      source.closest('#buy-box').find("input#total").val(sum);
    },
    resetValues: function() {
      this.price = parseFloat($("input#payment_request_price").val());
      this.delivery_cost = parseFloat($("input#payment_request_delivery_cost").val());
      this.discount_percentage = 0;
    }
  }

  $("input#payment_request_discount_code").change(function(event){
    var term = $(this).val();
    var listing_id = $('input#payment_request_listing_id').val();
    var elem = $(this);

    if (term != "")
    {
      var baseURL = window.location.protocol + "//" + window.location.host + "/";
      $.ajax({
        method: "GET",
        url: baseURL + "check_coupon_code",
        dataType: 'text',
        data: {
          listing_id: listing_id,
          q: term,
        },
        success: function(result){
          result = JSON.parse(result);
          viewControl.discount_percentage = parseFloat(result.discount);
          viewControl.calculateTotalAmount(elem);
        }
      })
      .fail(function() {
        alert( "Error: Couldn't calculate total amount. Please try again. If this message keeps appearing contact us immediately." );
      });
    }
  })

  $("input#payment_request_price").change(function(event){
    viewControl.price = parseFloat($(this).val());
    viewControl.calculateTotalAmount($(this));
  })

  $("a#cancel_link").click(function(event){
    event.preventDefault();
    $(this).closest('#buy-box').find('input[name="payment_request[payment_method]"]').prop('checked', false);
    $(this).closest('#buy-box').find("input#payment_request_discount_code").val('');
    $(this).closest('#buy-box').find("textarea#payment_request_message").val('');
    viewControl.resetValues();
    if ($(this).closest('#buy-box').find('input#payment_request_price').is('[readonly]')) {
      viewControl.calculateTotalAmount($(this));
    }
    else {
      $(this).closest('#buy-box').find('input#payment_request_price').val('');
      $(this).closest('#buy-box').find('input#total').val('');
    }
  });
});
