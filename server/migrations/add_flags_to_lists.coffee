Meteor.startup ->
  Meteor.methods
    addFlagsToLists: ->
      List._collection.find().forEach (list) ->
        obj = {}
        obj.downvotable = true unless list.downvotable
        obj.hidden = false unless list.hidden
        obj.limit = false unless list.limit
        obj.maxvotes = '' unless list.maxvotes

        if _.size obj
          console.log ("Updated " + list._id)
          List._collection.update(
            {_id: list._id},
            { $set: obj }
          )
