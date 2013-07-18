Meteor.publish 'lists', () ->
  Lists.find(userId: @userId)
  
 Meteor.publish 'currentList', (listId) ->
  Lists.find(_id: listId)
    
Meteor.publish 'items', (listId) ->
  Items.find(listId: listId)