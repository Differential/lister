Router.map ->
  @route 'home',
    path: '/'
    waitOn: -> [
      Meteor.subscribe 'recentLists'
      Meteor.subscribe 'recentItems'
    ]
    before: ->
      if Meteor.loggingIn()
        @render 'loading'
        return @stop()

      Session.set('listId', null)
      Session.set('query', '')
      document.title = "lister ~ Easy public shareable lists"

  @route 'listsIndex',
    path: '/lists'
    waitOn: -> [
      Meteor.subscribe 'lists', Session.get('username')
      Meteor.subscribe 'contributedLists', Session.get('username')
    ]
    before: ->
      if Meteor.loggingIn()
        @render 'loading'
        return @stop()

      if !Meteor.user()
        Session.set('username', null)
        return @redirect('/')

      Session.set('username', Meteor.user().username)
      Session.set('listId', null)
      document.title = Session.get('username') + "'s lists ~ lister.io"

  @route 'newList',
    path: '/new',
    before: ->
      if Meteor.loggingIn()
        @render 'loading'
        return @stop()

      if !Meteor.user()
        Session.set('username', null)
        return @redirect('/')

      Session.set('username', Meteor.user().username)
      document.title = "Add list ~ lister.io"

  @route 'showList',
    path: '/:username/:slug',
    waitOn: -> [
      Meteor.subscribe 'currentList', Session.get('listId')
      Meteor.subscribe 'items', Session.get('listId')
      Meteor.subscribe 'voters', Session.get('listId')
    ]
    before: ->
      Session.set('username', @params.username)
      Meteor.call 'findListId', @params.username, @params.slug, (err, listId) ->
        Session.set('listId', listId)
    after: ->
      document.title = Session.get('name') + " ~ by " + Session.get('username') + " ~ lister.io"

  @route 'apiv1',
    path: '/api-v1',
    before: ->
      document.title = "API ~ lister.io"

  @route 'apiv2',
    path: '/api',
    before: ->
      document.title = "API ~ lister.io"

  @route 'listsIndex',
    path: '/:username',
    waitOn: -> [
      Meteor.subscribe 'lists', Session.get('username')
      Meteor.subscribe 'contributedLists', Session.get('username')
    ]
    before: ->
      Session.set('username', @params.username)
      document.title = Session.get('username') + "'s lists ~ lister.io"

Router.configure
  layout: 'lister'
  after: ->
    window._gaq.push ['_trackPageview']
