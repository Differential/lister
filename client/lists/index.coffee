Template.listsIndex.rendered = ->
  $('body').css('background-color', Session.get('color'))
  document.title = Session.get('username') + "'s lists ~ lister.io"

Template.listsIndex.helpers
  username: ->
    Session.get('username')

  lists: ->
    if Session.get('username')
      Lists.find(username: Session.get('username'))
    else
      Lists.find(userId: Meteor.userId())

  hasLists: ->
    if Session.get('username')
      Lists.find(username: Session.get('username')).count() > 0
    else
      Lists.find(userId: Meteor.userId()).count() > 0

  contributedLists: ->
    Lists.find(userId: { $ne: Meteor.userId() })

  hasContributedToLists: ->
    Lists.find(userId: { $ne: Meteor.userId() }).count() > 0

Template.listsIndex.events
  'click .addList': ->
    Meteor.Router.to('/lists/new')
