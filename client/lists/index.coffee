Template.listsIndex.helpers
  lists: ->
    Lists.find()

Template.listsIndex.events
  'click .addList': ->
    Meteor.Router.to('/lists/new')
