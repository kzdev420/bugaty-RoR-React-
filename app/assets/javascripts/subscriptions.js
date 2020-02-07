jQuery(document).ready(function ($){
  var viewControl = {
    plan: $("select#subscription_plan option:selected").text(),
    feature_type: $("select#feature_type option:selected").text(),
    payment_method: $('#subscription-options-method').text(),
    discount_percentage: 0,
    coupon: null,
    calculateSubscriptionAmount: function(){
      if (this.plan != '') {
        var amount = parseFloat(this.plan.split(' ')[0].slice(1)).toFixed(1);
        var sum = (amount - amount * this.discount_percentage / 100).toFixed(2);
        $('.subscription-details').find("span").text(this.plan.split(' ')[0].slice(0, 1) + sum);
        $('#subscription-options-price').text(this.plan.replace(amount, sum));
        $('#subscription-options-method').text(this.payment_method);
        if (this.discount_percentage == 0) {
          $('#subscription-options-coupon').text('Code not applied');
          $('#coupon_id').val('');
        } else {
          $('#subscription-options-coupon').text('Code applied');
          $('#coupon_id').val(this.coupon);
        }
        $('#subscription_amount').val(sum);
      } else if (this.feature_type != '') { // feature (category, homepage, urgent)
        var amount = parseFloat(this.feature_type.split(' - ')[1].slice(1)).toFixed(1)
        var sum = (amount - amount * this.discount_percentage / 100).toFixed(2);
        $('.subscription-details').find("span").text(this.feature_type.split(' - ')[1].slice(0, 1) + sum);
        $('#subscription-options-price').text(this.feature_type.replace(amount, sum));
        $('#subscription-options-method').text(this.payment_method);
        if (this.discount_percentage == 0) {
          $('#subscription-options-coupon').text('Code not applied');
          $('#coupon_id').val('');
        } else {
          $('#subscription-options-coupon').text('Code applied');
          $('#coupon_id').val(this.coupon);
        }
        $('#amount_to_pay').val(sum);
        $('#payment_description').val(this.feature_type.split(' - ')[0]);
        var frm = document.getElementById('payment-form');
        if (this.payment_method == 'Pay With PayPal') {
          var new_action = frm.action.replace('checkout-stripe-create/', 'checkout/');
          frm.action = new_action;
        } else {
          var new_action = frm.action.replace('checkout/', 'checkout-stripe-create/');
          frm.action = new_action;
        }
      }
    }
  }
  viewControl.calculateSubscriptionAmount();

  $("button#apply_coupon").click(function(event){
    event.preventDefault();
    var term = $('input#coupon_promotional_code').val();

    if (term != "")
    {
      var baseURL = window.location.protocol + "//" + window.location.host + "/";
      $.ajax({
        method: "GET",
        url: baseURL + "check-promotional-code",
        dataType: 'text',
        data: {
          q: term,
        },
        success: function(result){
          result = JSON.parse(result);
          viewControl.discount_percentage = parseFloat(result.discount);
          viewControl.coupon = result.coupon;
          viewControl.calculateSubscriptionAmount();
        }
      })
      .fail(function() {
        alert( "Error: Couldn't calculate total amount. Please try again. If this message keeps appearing contact us immediately." );
      });
    }
  })

  $("select#subscription_plan").change(function(event){
    viewControl.plan = $("select#subscription_plan option:selected").text();
    $('input#plan_id').val($("select#subscription_plan option:selected").val());
    viewControl.calculateSubscriptionAmount();
  })

  $("select#feature_type").change(function(event){
    viewControl.feature_type = $("select#feature_type option:selected").text();
    viewControl.calculateSubscriptionAmount();
  })

  $(".image-container img").click(function(event){
    if(event.target.id == 'paypal-payment') {
      $('img#paypal-payment').addClass('payment-method-active')
      $('img#stripe-payment').removeClass('payment-method-active')
      viewControl.payment_method = 'Pay With PayPal';
      $('button#process-subscription-stripe').hide();
      $('button#process-subscription-paypal').show();
    } else {
      $('img#paypal-payment').removeClass('payment-method-active')
      $('img#stripe-payment').addClass('payment-method-active')
      viewControl.payment_method = 'Pay With Credit/Debit card';
      $('button#process-subscription-stripe').show();
      $('button#process-subscription-paypal').hide();
    }
    viewControl.calculateSubscriptionAmount();
  })

  $("#process-subscription-paypal").click(function(event){
    $('form').submit();
  })

  $("#confirm-paypal").click(function(event) {
    $('form').submit();
  })
});
