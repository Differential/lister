Deps.autorun ->
  Meteor.subscribe 'lists', Session.get('username')
  Meteor.subscribe 'contributedLists', Session.get('username')
  Meteor.subscribe 'currentList', Session.get('listId')
  Meteor.subscribe 'items', Session.get('listId')

  color = ''
  _(4).times -> color += (15-Math.floor(Math.random() * 4)).toString(16)
  console.log color
  Session.set('color', "#cc#{color}")

  if Meteor.user() && Meteor.user().profile && Meteor.user().profile.color
    Session.set('color', Meteor.user().profile.color)
  else
