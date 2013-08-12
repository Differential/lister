@Items = new Meteor.Collection 'items'

Items.allow(
  insert: (userId, item) ->
    list = Lists.findOne(item.listId)

    userId && list && (list.userId == userId || list.open)

  update: (userId, item) ->
    true

  remove: (userId, item) ->
    true
)
