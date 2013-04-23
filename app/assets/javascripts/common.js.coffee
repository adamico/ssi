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

  $("[name='registration[accompagne]']").change ->
    $next = $(".accompanying-fields")
    condition = @value is "Yes"
    showNextif condition, $(@), $next
    if @value is "No"
      $("#registration_accompagne_#{suffix}").val("") for suffix in ["title", "last_name", "first_name", "country", "other_what"]
      $("#registration_accompagne_#{suffix}").attr("checked", false) for suffix in ["vegetarian", "muslim", "kosher", "dietary_other"]

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
