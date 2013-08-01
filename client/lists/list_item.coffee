Template.item.helpers
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
