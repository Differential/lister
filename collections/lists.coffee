@Lists = new Meteor.Collection 'lists'

Lists.allow(
  insert: (userId, list) ->
    userId

  update: (userId, list) ->
    true

  remove: (userId, list) ->
    list.userId == userId
)
