class @List extends Minimongoid
  @_collection: new Meteor.Collection 'lists'

List._collection.allow(
  insert: (userId, list) ->
    userId

  update: (userId, list) ->
    list.userId == userId

  remove: (userId, list) ->
    list.userId == userId
)
