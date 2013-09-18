Deps.autorun ->
  Meteor.subscribe 'lists', Session.get('username')
  Meteor.subscribe 'contributedLists', Session.get('username')
  Meteor.subscribe 'currentList', Session.get('listId')
  Meteor.subscribe 'items', Session.get('listId')

  color = '#'
  _(6).times -> color += (Math.floor(Math.random() * 7))
  Session.set('color', color)

  if Meteor.user() && Meteor.user().profile && Meteor.user().profile.color
    Session.set('color', Meteor.user().profile.color)
  else
