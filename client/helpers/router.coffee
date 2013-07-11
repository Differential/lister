Meteor.Router.add
  '/': -> 'home'

  '/lists': -> 'listsIndex'
  '/new': -> 'newList'
  '/lists/:id': (id) ->
    Session.set('currentList', id)
    'showList'
