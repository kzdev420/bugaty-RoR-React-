# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $(".paginator-form").change ->
    $(this).submit()

  $("input[type='radio']").click ->
    $("#new_search").submit()

  $("a#show_more").click (event)->
    event.preventDefault()
    $(this).siblings(".latent").toggle()
    $(this).toggle()

  n = $(".show_cats").siblings(".latent").length
  $(".show_cats").toggle() if n < 1

  n = $(".show_countries").siblings(".latent").length
  $(".show_countries").toggle() if n < 1

  n = $(".show_regions").siblings(".latent").length
  $(".show_regions").toggle() if n < 1

  n = $(".show_cities").siblings(".latent").length
  $(".show_cities").toggle() if n < 1
