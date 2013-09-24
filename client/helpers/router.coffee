Router.map ->
  @route 'home',
    path: '/'
    waitOn: ->
      Meteor.subscribe 'recentLists', Session.get('query')
    before: ->
      if Meteor.loggingIn()
        @render 'loading'
        return @stop()

      Session.set('listId', null)
      Session.set('query', '')

  @route 'listsIndex',
    path: '/lists'
    before: ->
      if Meteor.loggingIn()
        @render 'loading'
        return @stop()

      if !Meteor.user()
        Session.set('username', null)
        return @redirect('/')

      Session.set('username', Meteor.user().username)
      Session.set('listId', null)

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

  @route 'showList',
    path: '/:username/:slug',
    before: ->
      Session.set('username', @params.username)
      Meteor.call 'findListId', @params.username, @params.slug, (err, listId) ->
        Session.set('listId', listId)

  @route 'api',
    path: '/api',
    before: ->
      if Meteor.loggingIn()
        @render 'loading'
        return @stop()

      if !Meteor.user()
        return @redirect('/')

      Session.set('username', Meteor.user().username)

  @route 'listsIndex',
    path: '/:username',
    before: ->
      Session.set('username', @params.username)

Router.configure
  after: ->
    window._gaq.push ['_trackPageview']
