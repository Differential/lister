Meteor.startup ->
  Meteor.methods
    fixItems: ->
      Items.find().forEach (item)->
        unless item.itemUsername
          console.log ("Updated " + item._id)
          user = Meteor.users.findOne(item.userId)
          Items.update(
            {_id: item._id},
            { $set:
              { itemUsername: user.username }
            }
          )
