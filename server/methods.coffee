Meteor.startup ->
  Meteor.methods
   updateApiKey: ->
     key = Random.hexString(32)
     Meteor.users.update(Meteor.userId(), {
       $set: { 'profile.apiKey': key }
     })
     key

   findListId: (username, slug) ->
     Lists.findOne(
       username: username
       slug: slug
     )._id

   upvote: (itemId) ->
     user = Meteor.user()

     if (! user)
       throw new Meteor.Error(401, "You need to login to upvote")

     item = Items.findOne(itemId)

     if (! item)
       throw new Meteor.Error(422, 'Item not found')

     if (_.include(item.upvoters, user._id))
       Items.update(item._id, { $pull: {upvoters: user._id}, $inc: {score: -1}})
     else
       Items.update(item._id, { $addToSet: {upvoters: user._id}, $inc: {score: 1}})
