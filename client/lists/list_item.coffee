Template.item.rendered = ->
  $('body').css('background-color', Session.get('color'))

Template.item.helpers
  'isOwner': ->
    Meteor.user() && (@.userId == Meteor.userId() || @.username == Meteor.user().username)

  'canVote': ->
    Meteor.user() && @.userId != Meteor.userId()

  'upvoteClass': ->
    userId = Meteor.userId()

    if (userId && _.include(this.upvoters, userId))
      return 'voted'

  'downvoteClass': ->
    userId = Meteor.userId()

    if (userId && _.include(this.downvoters, userId))
      return 'voted'

Template.item.events
  'click .delete': ->
    Items.remove(@_id)

  'click .upvote': (event) ->
    event.preventDefault()
    Meteor.call('upvote', @._id)

  'click .downvote': (event) ->
    event.preventDefault()
    Meteor.call('downvote', @._id)
