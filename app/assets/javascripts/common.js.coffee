$ = jQuery

$ ->
  $(".nav-tabs a:first").tab('show')

  $accompagne_dietary_other_field = $("#registration_accompagne_dietary_other")
  showNextif $accompagne_dietary_other_field.attr("checked") is "checked", $accompagne_dietary_other_field, $accompagne_dietary_other_field.parent().next()

  $accompagne_dietary_other_field.on "change", ->
    $accompagne_dietary_other_field = $(@)
    showNextif $accompagne_dietary_other_field.attr("checked") is "checked", $accompagne_dietary_other_field, $accompagne_dietary_other_field.parent().next()

  $dietary_other_field = $("#registration_dietary_other")
  showNextif $dietary_other_field.attr("checked") is "checked", $dietary_other_field, $dietary_other_field.parent().next()

  $dietary_other_field.on "change", ->
    $dietary_other_field = $(@)
    showNextif $dietary_other_field.attr("checked") is "checked", $dietary_other_field, $dietary_other_field.parent().next()

  $accompagne_radio = $("#registration_accompagne_yes")
  accompagne_radio_checked = $accompagne_radio.attr("checked") is "checked"
  showNextif accompagne_radio_checked, $accompagne_radio, $(".accompanying-fields")

  calculate_total_amount(check_if_accompanied())

  $("[name='registration[accompagne]']").change ->
    accompanied = if @value is "Yes" then true else false
    calculate_total_amount(accompanied)
    $next = $(".accompanying-fields")
    condition = @value is "Yes"
    showNextif condition, $(@), $next
    if @value is "No"
      $("#registration_accompagne_#{suffix}").val("") for suffix in ["title", "last_name", "first_name", "country", "other_what"]
      $("#registration_accompagne_#{suffix}").attr("checked", false) for suffix in ["vegetarian", "muslim", "kosher", "dietary_other"]

check_if_accompanied = ->
  $("#registration_accompagne_yes").attr("checked") is "checked"

calculate_total_amount = (accompanied=false,invited=false)->
  participant_amount = parseInt($("#registration_amount").val())
  accompanying_amount = if accompanied then parseInt($("#registration_accompanying_amount").val()) else 0
  total_amount = participant_amount + accompanying_amount
  formatted_total_amount = (total_amount / 100).toString() + " €"
  no_vat_total_amount = Math.round(total_amount / 100 / 1.196)
  $("#registration_amount").val(total_amount)
  $(".total-amount").html(formatted_total_amount)
  $(".total-amount-without-vat").html(no_vat_total_amount.toString() + " € + VAT 19.6%")

showNextif = (condition, element, next) ->
  if condition
    $(next).show()
    $(next).css("visibility", "visible")
  else
    $(next).hide()
    $(next).css("visibility", "hidden")
