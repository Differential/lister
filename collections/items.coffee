@Items = new Meteor.Collection 'items'

Items.allow(
    insert: (userId, item) ->
        userId
        
    update: (userId, item) ->
        true
        
    remove: (userId, item) ->
        item.userId == userId
        )