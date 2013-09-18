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

     if (_.include(item.upvoters, user._id))
       item.pull(upvoters: user._id)
       item.update(score: item.score - 1)
     else
       item.push(upvoters: user._id)
       item.update(score: item.score + 1)
     if (_.include(item.downvoters, user._id))
       item.pull(downvoters: user._id)
       item.update(score: item.score + 1)

   downvote: (itemId) ->
     user = Meteor.user()

     if (! user)
       throw new Meteor.Error(401, "You need to login to upvote")

     item = Item.first(itemId)

     if (! item)
       throw new Meteor.Error(422, 'Item not found')

     if (_.include(item.downvoters, user._id))
       item.pull(downvoters: user._id)
       item.update(score: item.score + 1)
     else
       item.push(downvoters: user._id)
       item.update(score: item.score - 1)
     if (_.include(item.upvoters, user._id))
       item.pull({upvoters: user._id})
       item.update(score: item.score - 1)

    touchList: (listId, itemId) ->
        item = Item.first(itemId)
        List.first(listId).update
          updatedAt: new Date()
          'mostRecentItem.username': item.itemUsername
          'mostRecentItem.text': item.text
