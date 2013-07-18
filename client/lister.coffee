Meteor.subscribe 'lists'

Deps.autorun ->
  Meteor.subscribe 'currentList', Session.get('listId')
  
  Meteor.subscribe 'items', Session.get('listId'),
    onReady: ->
      Session.set('itemsReady', true)