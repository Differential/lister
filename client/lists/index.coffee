Template.listsIndex.helpers
  lists: ->
    Lists.find(userId: Meteor.userId())

  hasLists: ->
    Lists.find(userId: Meteor.userId()).count() > 0


  contributedLists: ->
    Lists.find(userId: { $ne: Meteor.userId() })

  hasContributedToLists: ->
    Lists.find(userId: { $ne: Meteor.userId() }).count() > 0

Template.listsIndex.events
  'click .addList': ->
    Meteor.Router.to('/lists/new')
