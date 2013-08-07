Template.home.helpers
  items: ->
    Items.find({}, sort:{createdAt:-1})

  query: ->
    Session.get('query')

Template.home.events
  'submit #searchItem': ->
    event.preventDefault()
    query = $(event.target).find('#searchItems').val()
    Session.set('query', query)
