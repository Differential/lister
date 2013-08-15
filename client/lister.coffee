Meteor.subscribe 'lists'
Meteor.subscribe 'contributedLists'

Deps.autorun ->
  Meteor.subscribe 'currentList', Session.get('listId')

  Meteor.subscribe 'items', Session.get('listId'),
    onReady: ->
      Session.set('itemsReady', true)

  Meteor.subscribe 'recentItems', Session.get('query')

Meteor.startup ->
  color = '#' + Math.floor(Math.random() * 16777215).toString(16)
  $('body').css('background-color', color)
