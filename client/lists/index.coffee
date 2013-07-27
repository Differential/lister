Template.listsIndex.helpers
  lists: ->
    Lists.find(userId: Meteor.userId())

Template.listsIndex.events
  'click .addList': ->
    Meteor.Router.to('/lists/new')
