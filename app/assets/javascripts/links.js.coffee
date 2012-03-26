$ = jQuery
$ ->
  $(".link_category .title").bind 'click', ->
    $(this).next().toggle("fast")
