$ = jQuery

$ ->
  $(".nav-tabs a:first").tab('show')

  for field in ["arrival", "departure"]
    $field = $("#registration_#{field}")
    $field.mask("99/99/9999")
    pre_value = $field.attr("data-pre")
    $field.val(pre_value)

  make_invited($("#invited-speaker")) if $("#registration_payment").val() is "invited"

  $("#invited-speaker").on "click", (event) ->
    event.preventDefault()
    make_invited($(this))

make_invited = (element) ->
  $(element).hide()
  $("#payment-wrap").remove()
  invited = $('<input type="hidden" class="hidden" name="registration[payment]" id="registration_payment" />')
  invited.val("invited")
  $(invited).appendTo("form.registration")
