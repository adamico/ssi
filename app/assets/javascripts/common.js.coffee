$ = jQuery

$ ->
  $(".nav-tabs a:first").tab('show')

  #for field in ["arrival", "departure"]
    #$field = $("#registration_#{field}")
    #$field.mask("99/99/9999")
    #pre_value = $field.attr("data-pre")
    #$field.val(pre_value)

  make_invited($("#invited-speaker")) if $("#registration_payment").val() is "invited"

  $("#invited-speaker").on "click", (event) ->
    event.preventDefault()
    make_invited($(this))

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
  showNextif $accompagne_radio.attr("checked") is "checked", $accompagne_radio, $(".accompanying-fields")

  calculate_total_amount()

  $("[name='registration[accompagne]']").change ->
    addAccompanyingPrice = false
    addAccompanyingPrice = true if @value is "Yes"
    calculate_total_amount(addAccompanyingPrice)
    $next = $(".accompanying-fields")
    condition = @value is "Yes"
    showNextif condition, $(@), $next
    if @value is "No"
      $("#registration_accompagne_#{suffix}").val("") for suffix in ["title", "last_name", "first_name", "country", "other_what"]
      $("#registration_accompagne_#{suffix}").attr("checked", false) for suffix in ["vegetarian", "muslim", "kosher", "dietary_other"]

calculate_total_amount = (check=false)->
  participant_amount = parseInt $("#registration_amount").val()
  accompanying_amount = if check then parseInt($("#registration_accompanying_amount").val()) else 0
  total_amount = participant_amount + accompanying_amount
  formatted_total_amount = (total_amount / 100).toString() + " €"
  no_vat_total_amount = Math.round(total_amount / 100 / 1.196)
  $(".total-amount").html(formatted_total_amount)
  $(".total-amount-without-vat").html(no_vat_total_amount.toString() + " € + VAT 19.6%")

make_invited = (element) ->
  $(element).hide()
  $("#payment-wrap").remove()
  invited = $('<input type="hidden" class="hidden" name="registration[payment]" id="registration_payment" />')
  invited.val("invited")
  $(invited).appendTo("form.registration")

showNextif = (condition, element, next) ->
  if condition
    $(next).show()
    $(next).css("visibility", "visible")
  else
    $(next).hide()
    $(next).css("visibility", "hidden")
