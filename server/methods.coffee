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

     if (! user)
       throw new Meteor.Error(401, "You need to login to upvote")

     item = Item.first(itemId)

     if (! item)
       throw new Meteor.Error(422, 'Item not found')

     item.upvote Meteor.user()

   downvote: (itemId) ->
     user = Meteor.user()

     if (! user)
       throw new Meteor.Error(401, "You need to login to upvote")

     item = Item.first(itemId)

     if (! item)
       throw new Meteor.Error(422, 'Item not found')

      item.downvote Meteor.user()

    touchList: (listId, itemId) ->
      List.first(listId).touch Item.first(itemId)
