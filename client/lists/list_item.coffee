Template.item.helpers
  'isListOwner': ->
    Meteor.user() && Meteor.user().username == Session.get('username')

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
