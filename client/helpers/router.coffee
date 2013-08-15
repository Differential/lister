Meteor.Router.add
  '/': ->
    Session.set('listId', null)
    Session.set('query', '')
    'home'

  '/lists': ->
     if Meteor.loggingIn()
       'loading'
     else if Meteor.user()
      'listsIndex'
     else
       'home'

  '/new': ->
     if Meteor.loggingIn()
       'loading'
     else if Meteor.user()
       'newList'
     else
       'home'

  '/:username/:slug': (username, slug) ->
    Session.set('itemsReady', false)
    Session.set('username', username)

    Meteor.call 'findListId', username, slug, (err, listId) ->
      Session.set('listId', listId)

    'showList'

  '/api': ->
     if Meteor.loggingIn()
       'loading'
     else if Meteor.user()
       'api'
     else
       'home'
