$("#listing_city_id").prop('disabled', false)
$("#listing_city_id").empty()
  .append($("<option></option>")).append("<%= escape_javascript(render(:partial => @cities)) %>")
