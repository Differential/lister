Template.listsIndex.rendered = ->
  $('body').css('background-color', Session.get('color'))
  document.title = Session.get('username') + "'s lists ~ lister.io"

Template.listsIndex.helpers
  username: ->
    Session.get('username')

  lists: ->
    if Session.get('username')
      List.where(username: Session.get('username'))
    else
      List.where(userId: Meteor.userId())

  hasLists: ->
    if Session.get('username')
      List.find(username: Session.get('username')).count() > 0
    else
      List.find(userId: Meteor.userId()).count() > 0

  contributedLists: ->
    List.where(userId: { $ne: Meteor.userId() })

  hasContributedToLists: ->
    List.find(userId: { $ne: Meteor.userId() }).count() > 0

Template.listsIndex.events
  'click .addList': ->
    Router.go('/lists/new')
