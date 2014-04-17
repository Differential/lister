Template.listsIndex.rendered = ->
  $('body').css('background-color', Session.get('color'))

Template.listsIndex.helpers
  username: ->
    Session.get('username')

  lists: ->
    if Session.get('username')
      List.where
        username: Session.get('username')
      ,
        sort:
          updatedAt: -1
    else
      List.where(userId: Meteor.userId())

  hasLists: ->
    if Session.get('username')
      List.count(username: Session.get('username')) > 0
    else
      List.count(userId: Meteor.userId()) > 0

  contributedLists: ->
    List.where
      contributed: true
      userId:
        $ne: Meteor.userId()
    ,
      sort:
        updatedAt: -1

  hasContributedToLists: ->
    List.count({ contributed: true, userId: { $ne: Meteor.userId() }}) > 0

  isUser: (un) ->
    Meteor.user() and Meteor.user().username is un
  
  hasFavorites: ->
    List.count({ favorited: Meteor.userId() }) > 0

  favorites: ->
    List.where({ favorited: Meteor.userId() })
      

Template.listsIndex.events
  'click .addList': ->
    Router.go('/lists/new')
