Template.home.rendered = ->
  $('body').css('background-color', Session.get('color'))

Template.home.helpers
  lists: ->
    List.find({}, sort:{updatedAt:-1})

  items: ->
    Item.find()

  query: ->
    Session.get('query')

Template.home.events
  'keyup #query': (event) ->
    event.preventDefault()
    query = $(event.target).val()
    Session.set('query', query)
