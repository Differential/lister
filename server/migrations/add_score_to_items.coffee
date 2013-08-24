Meteor.startup ->
  Meteor.methods
    addScoreToItems: ->
      Items.find().forEach (item)->
        unless item.score
          console.log ("Updated " + item._id)
          Items.update(
            {_id: item._id},
            { $set:
              { score: 0 }
            }
          )
