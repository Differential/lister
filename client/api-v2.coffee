Template.apiv2.rendered = ->
  $('body').css('background-color', Session.get('color'))

Template.apiv2.events
  'click [target=_blank]': (e) ->
    e.preventDefault()
    url = $(e.target).attr 'href'
    window.open url
