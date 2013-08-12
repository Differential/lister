@Lists = new Meteor.Collection 'lists'

Lists.allow(
  insert: (userId, list) ->
    userId

  update: (userId, list) ->
    list.userId == userId

  remove: (userId, list) ->
    list.userId == userId
)
