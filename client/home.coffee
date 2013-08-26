Template.home.rendered = ->
  $('body').css('background-color', Session.get('color'))

Template.home.helpers
  items: ->
    Items.find({}, sort:{createdAt:-1})

  query: ->
    Session.get('query')

Template.home.events
  'keyup #query': (event) ->
    event.preventDefault()
    query = $(event.target).val()
    Session.set('query', query)
