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
      'listsIndex'
    else
      Session.set('username', null)
      'home'

  '/new': ->
    Session.set('username', Meteor.user().username)
    if Meteor.loggingIn()
      'loading'
    else if Meteor.user()
      'newList'
    else
      'home'

  '/:username/:slug': (username, slug) ->
    Session.set('username', username)
    Meteor.call 'findListId', username, slug, (err, listId) ->
      Session.set('listId', listId)
    'showList'

  '/api': ->
    Session.set('username', Meteor.user().username)
    if Meteor.loggingIn()
      'loading'
    else if Meteor.user()
      'api'
    else
      'home'

  '/:username': (username)->
    Session.set('username', username)
    'listsIndex'
