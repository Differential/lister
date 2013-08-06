Meteor.subscribe 'lists'
Meteor.subscribe 'contributedLists'

Deps.autorun ->
  Meteor.subscribe 'currentList', Session.get('listId')

  Meteor.subscribe 'items', Session.get('listId'),
    onReady: ->
      Session.set('itemsReady', true)

  Meteor.subscribe 'recentItems'

Meteor.startup ->
  color = 'rgb(' + (Math.floor(Math.random() * 128)) + ',' + (Math.floor(Math.random() * 128)) + ',' + (Math.floor(Math.random() * 128)) + ')'
  $('body').css('background-color', color)
