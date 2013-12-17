Deps.autorun ->
  color = ''
  _(4).times -> color += (15-Math.floor(Math.random() * 4)).toString(16)
  Session.set('color', "#cc#{color}")

  if Meteor.user() && Meteor.user().profile && Meteor.user().profile.color
    Session.set('color', Meteor.user().profile.color)
  else

Template.header.helpers
  homeClass: ->
    'home' if document.location.pathname == "/"

  isHome: ->
    document.location.pathname == "/"

Template.header.helpers
  query: ->
    Session.get('query')

Template.header.events
  'keyup #query': (event) ->
    Session.get('query')
    event.preventDefault()
    query = $(event.target).val()
    Session.set('query', query)

Template.nav.helpers
  homeClass: ->
    'home' if document.location.pathname == "/"