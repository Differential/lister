Template.item.rendered = ->
  $('body').css('background-color', Session.get('color'))

Template.item.helpers
  ownItem: ->
    @.userId == Meteor.userId()

  'isOwner': ->
    @isOwner Meteor.user()

  'canVote': ->
    @canVote Meteor.user()

  'upvoteClass': ->
    if @hasUpvoted Meteor.user()
      return 'voted'

  'downvoteClass': ->
    if @hasDownvoted Meteor.user()
      return 'voted'

Template.item.events
  'click .delete': ->
    @destroy()

  'click .upvote': (event) ->
    event.preventDefault()
    Meteor.call('upvote', @id)

  'click .downvote': (event) ->
    event.preventDefault()
    Meteor.call('downvote', @id)
