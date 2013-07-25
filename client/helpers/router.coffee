Meteor.Router.add
  '/': ->
    Session.set('listId', null)
    'home'

  '/lists': -> 'listsIndex'

  '/new': ->
     if Meteor.loggingIn()
       'loading'
     else if Meteor.user()
       'newList'
     else
       'home'

  '/:username/:slug': (username, slug) ->
    Session.set('username', username)
    Session.set('itemsReady', false)
    Meteor.call 'findListId', username, slug, (err, listId) ->
      Session.set('listId', listId)
      Session.set('itemsReady', true)
    'showList'
