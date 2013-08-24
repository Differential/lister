Meteor.Router.add
  '/': ->
    Session.set('username', null)
    if Meteor.loggingIn()
      'loading'
    else
      Session.set('listId', null)
      Session.set('query', '')
      'home'

  '/lists': ->
    if Meteor.loggingIn()
      'loading'
    else if Meteor.user()
      Session.set('username', Meteor.user().username)
      Session.set('listId', null)
      'listsIndex'
    else
      Session.set('username', null)
      'home'

  '/new': ->
    if Meteor.loggingIn()
      'loading'
    else if Meteor.user()
      Session.set('username', Meteor.user().username)
      'newList'
    else
      'home'

  '/:username/:slug': (username, slug) ->
    Session.set('username', username)
    Meteor.call 'findListId', username, slug, (err, listId) ->
      Session.set('listId', listId)
    'showList'

  '/api': ->
    if Meteor.loggingIn()
      'loading'
    else if Meteor.user()
      Session.set('username', Meteor.user().username)
      'api'
    else
      'home'

  '/:username': (username)->
    Session.set('username', username)
    'listsIndex'
