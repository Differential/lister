Meteor.startup ->
  Meteor.methods
   updateApiKey: ->
     key = Random.hexString(32)
     Meteor.users.update(Meteor.userId(), {
       $set: { 'profile.apiKey': key }
     })
     key

   findListId: (username, slug) ->
     List.first(
       username: username
       slug: slug
     ).id

   upvote: (itemId) ->
     user = Meteor.user()

     if not user
       throw new Meteor.Error(401, "You need to login to upvote")

     item = Item.first(itemId)

     if not item
       throw new Meteor.Error(422, 'Item not found')

     item.upvote Meteor.user()

   downvote: (itemId) ->
     user = Meteor.user()

     if not user
       throw new Meteor.Error(401, "You need to login to upvote")

     item = Item.first(itemId)

     if not item
       throw new Meteor.Error(404, 'Item not found')

     list = List.first item.listId
     if not list.downvotable
       throw new Meteor.Error(403, 'List not downvotable')

     item.downvote Meteor.user()

    touchList: (listId, itemId) ->
      List.first(listId).touch Item.first(itemId)
