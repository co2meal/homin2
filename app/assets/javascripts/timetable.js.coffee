# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.add_timeslice = (css, color, lid) ->
  $('.common-table-content').append("<div class=\"timeslice #{lid}\" style=\"background-color: #{color};#{css}\"></div>")

timeslices_from_time = (time) ->
  time.split(/\([^\)]*\)/).map((str)->str.trim()).filter((str)->str.length).map((str)-> [str[0],str.substr(1,str.length)])

window.css_from_timeslice = (timeslice) ->
  css = ""
  css += "left: "
  css += switch timeslice[0]
    when '월'
      "0%"
    when '화'
      "20%"
    when '수'
      "40%"
    when '목'
      "60%"
    when '금'
      "80%"
  css += ";"

  css += "width: 20%;"

  [top, bottom2] = if /^\d\d:\d\d~\d\d:\d\d$/.test(timeslice[1])
      timeslice[1].split('~').map (t)->
        q = t.split(':')
        (Number(q[0])-9)*100/9.0+q[1]*100/9.0/60
    else if /^[ABCDEF]$/.test(timeslice[1])
      [(timeslice[1].charCodeAt() - "A".charCodeAt()) * 100 / 6.0, (timeslice[1].charCodeAt() - "A".charCodeAt() + 1) * 100 / 6.0]
    else if /^[1234567890]+$/.test(timeslice[1])
      [(Number(timeslice[1])-1) * 100 / 9.0, Number(timeslice[1]) * 100 / 9.0]
    else
      console.error timeslice[1]
  bottom = 100 - bottom2

  css += "top: #{top}%; bottom: #{bottom}%;"

  css

$ ->
  $('.lecture input').change (e) ->
    $input = $(e.currentTarget)
    $lecture = $input.parent()
    $legendItemColor = $lecture.find('.legend-item-color')
    time = $lecture.data('time')
    lid = $lecture.data('lid')
    color = $lecture.data('color')

    if $input.is(":checked")
      $legendItemColor.css('visibility', 'visible')
      timeslices = timeslices_from_time(time)
      timeslices.forEach (timeslice) ->
        css = css_from_timeslice(timeslice)
        add_timeslice(css, color, lid)
    else
      $legendItemColor.css('visibility', 'hidden')
      $(".#{lid}").remove()