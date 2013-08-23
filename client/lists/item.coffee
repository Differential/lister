Template.listItem.rendered = ->
  $('body').css('background-color', Session.get('color'))

Template.listItem.helpers
  username: ->
    @username

  isOwner: ->
    Meteor.user() && (@.userId == Meteor.userId() || @.username == Meteor.user().username)

Template.listItem.events
  'click .delete': ->
    Lists.remove(@_id)
