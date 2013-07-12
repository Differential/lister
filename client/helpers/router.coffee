Meteor.Router.add
  '/': -> 'home'

  '/lists': -> 'listsIndex'

  '/new': ->
     if Meteor.loggingIn()
       'loading'
     else if Meteor.user()
       'newList'
     else
       'home'

  '/:username/:slug': (username, slug) ->
    Meteor.call 'findListId', username, slug, (err, res)->
      Session.set('listId', res)
    'showList'
