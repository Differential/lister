class @Item extends Minimongoid
  @_collection: new Meteor.Collection 'items'

  @belongs_to: [
    {name: 'list'}
  ]

Item._collection.allow(
  insert: (userId, item) ->
    list = List.first(item.listId)

    userId && list && (list.userId == userId || list.open)

  update: (userId, item) ->
    true

  remove: (userId, item) ->
    true
)
