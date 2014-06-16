# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $(".respuesta-content").keydown (e) ->
    form = undefined
    self = undefined
    pos = undefined
    self = this
    if e.keyCode is 13
      form = $(self).closest("form")
      $(form).submit()
    return
