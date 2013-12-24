Deps.autorun ->
  color = ''
  _(4).times -> color += (15-Math.floor(Math.random() * 4)).toString(16)
  Session.set('color', "#cc#{color}")

  if Meteor.user() && Meteor.user().profile && Meteor.user().profile.color
    Session.set('color', Meteor.user().profile.color)

Template.header.events
  'keyup #query': (event) ->
    Session.get('query')
    event.preventDefault()
    query = $(event.target).val()
    Session.set('query', query)

Handlebars.registerHelper 'homeClass', () ->
    'home' if document.location.pathname == "/"

Handlebars.registerHelper 'isHome', () ->
    document.location.pathname == "/"
