Meteor.publish 'lists', (username) ->
  parms =
    username: username
    hidden: false

  if @userId
    loggedIn = Meteor.users.findOne(@userId).username
    if loggedIn is username
      delete parms.hidden

  List.find parms

Meteor.publish 'contributedLists', (username) ->
  items = Item.find({itemUsername: username}).fetch()

  listIds = _.uniq(_.pluck(items, 'listId'))

  parms =
    _id:
      $in: listIds
    hidden: false

  if @userId
    loggedIn = Meteor.users.findOne(@userId).username
    if loggedIn is username
      delete parms.hidden

  List.find parms

Meteor.publish 'currentList', (listId) ->
  List.find
    _id: listId

Meteor.publish 'items', (listId) ->
  Item.find
    listId: listId

LIMIT = 20

Meteor.publish 'recentLists', (query) ->
  if query
    Item.find({
      $or: [
        {text: {$regex: query, $options: 'i'}},
        {listName: {$regex: query, $options: 'i'}}
      ],
      hidden: false
    }, {
      sort: {createdAt: -1},
      limit: LIMIT
    })
  else
    List.find({hidden: false}, {sort: {updatedAt: -1}, limit: LIMIT})

Meteor.publish 'recentItems', () ->
  ids = _.pluck(List.where({}, {sort: {updatedAt: -1}, limit: LIMIT, fields: {id: 1}}), 'id')

  Item.find({listId: {$in: ids}})
