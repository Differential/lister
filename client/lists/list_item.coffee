Template.item.rendered = ->
  $('body').css('background-color', Session.get('color'))

Template.item.helpers
  score: ->
    @upvoters.length if @upvoters.length > 0

  'isOwner': ->
    Meteor.user() && (@.userId == Meteor.userId() || @.username == Meteor.user().username)

  'canVote': ->
    Meteor.user() && @.userId != Meteor.userId()

  'voteClass': ->
    userId = Meteor.userId()

    if (userId && _.include(this.upvoters, userId))
      return 'upvoted'

Template.item.events
  'click .delete': ->
    Items.remove(@_id)

  'click .vote': ->
    event.preventDefault()
    Meteor.call('upvote', @._id)
