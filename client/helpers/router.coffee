Meteor.Router.add
  '/': -> 'home'

  '/lists': -> 'listsIndex'

  '/lists/:id': (id) ->
    Session.set('currentList', id)
    'showList'
