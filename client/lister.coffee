Meteor.subscribe 'lists'
Meteor.subscribe 'contributedLists'

Deps.autorun ->
  Meteor.subscribe 'currentList', Session.get('listId')

  Meteor.subscribe 'items', Session.get('listId'),
    onReady: ->
      Session.set('itemsReady', true)

  Meteor.subscribe 'recentItems', Session.get('query')

Meteor.startup ->
  if Meteor.user().profile && Meteor.user().profile.color
    color =  Meteor.user().profile.color
  else
    color = '#' + Math.floor(Math.random() * 6777215).toString(16)

  Session.set('color', color)
  $('body').css('background-color', color)
