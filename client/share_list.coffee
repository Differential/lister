Template.shareLists.helpers
  username: ->
    Meteor.user().username
    
  list: ->
    Lists.findOne(Session.get('listId'))