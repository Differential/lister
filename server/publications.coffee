Meteor.publish 'lists', () ->
  Lists.find(userId: @userId)

 Meteor.publish 'currentList', (listId) ->
  Lists.find(_id: listId)

Meteor.publish 'items', (listId) ->
  Items.find(listId: listId)

Meteor.publish 'recentItems', () ->
  Items.find({}, {sort: {createdAt: -1}, limit: 10})
