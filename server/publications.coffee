Meteor.publish 'lists', () ->
  Lists.find(userId: @userId)

Meteor.publish 'contributedLists', () ->
  items = Items.find(
    {userId: Meteor.userId()}
  ).fetch()

  listIds = _.uniq(_.pluck(items, 'listId'))

  Lists.find(
    {_id: { $in: listIds }},
    {userId: { $ne: Meteor.userId() }}
  )

 Meteor.publish 'currentList', (listId) ->
  Lists.find(_id: listId)

Meteor.publish 'items', (listId) ->
  Items.find(listId: listId)

Meteor.publish 'recentItems', () ->
  Items.find({}, {sort: {createdAt: -1}, limit: 10})
