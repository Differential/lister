Meteor.publish 'lists', (username) ->
  Lists.find(username: username)

Meteor.publish 'contributedLists', (username) ->
  items = Items.find(
    {itemUsername: username}
  ).fetch()

  listIds = _.uniq(_.pluck(items, 'listId'))

  Lists.find(
    {_id: { $in: listIds }}
  )

 Meteor.publish 'currentList', (listId) ->
  Lists.find(_id: listId)

Meteor.publish 'items', (listId) ->
  Items.find(listId: listId)

Meteor.publish 'recentItems', (query) ->
  if query
    Items.find({$or: [
        {text: {$regex: query, $options: 'i'}},
        {listName: {$regex: query, $options: 'i'}}
      ]}, {limit: 10})
  else
    Items.find({}, {sort: {createdAt: -1}, limit: 10})
