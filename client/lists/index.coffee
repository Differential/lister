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
      List.find(username: Session.get('username')).count() > 0
    else
      List.find(userId: Meteor.userId()).count() > 0

  contributedLists: ->
    List.where
      userId:
        $ne: Meteor.userId()
    ,
      sort:
        updatedAt: -1

  hasContributedToLists: ->
    List.find(userId: { $ne: Meteor.userId() }).count() > 0

  isUser: (un) ->
    Meteor.user().username == un
  
  hasFavorites: ->
    List.find({ favorited: Meteor.userId() }).count() > 0

  favorites: ->
    List.where({ favorited: Meteor.userId() })
      

Template.listsIndex.events
  'click .addList': ->
    Router.go('/lists/new')
