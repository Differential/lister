Template.listsIndex.helpers
  lists: ->
    Lists.find(userId: Meteor.userId())

  contributedLists: ->
    Lists.find(userId: { $ne: Meteor.userId() })

Template.listsIndex.events
  'click .addList': ->
    Meteor.Router.to('/lists/new')
