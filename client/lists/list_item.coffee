Template.item.rendered = ->
  $('body').css('background-color', Session.get('color'))
  $('.score a').tooltip
    html: true

Template.item.helpers
  'ownItem': ->
    @userId == Meteor.userId()

  'isDownvotable': ->
    list = List.first @listId
    list.downvotable

  'isOwner': ->
    @isOwner Meteor.user()

  'canVote': ->
    @canVote Meteor.user()

  'onlyClass': ->
    list = List.first @listId
    if not list.downvotable
      return 'only'

  'upvoteClass': ->
    if @hasUpvoted Meteor.user()
      return 'voted'

  'downvoteClass': ->
    if @hasDownvoted Meteor.user()
      return 'voted'

  'voters': ->
    upvoterIds = _.compact @upvoters
    upvoters = Meteor.users.find({ _id: { $in: upvoterIds }}).fetch()
    ups = _.pluck(upvoters, 'username').join('<br>')

    downvoterIds = _.compact @downvoters
    downvoters = Meteor.users.find({ _id: { $in: downvoterIds }}).fetch()
    downs = _.pluck(downvoters, 'username').join('<br>')

    if ups.length and downs.length
      return "#{ups}<br>&#8961;<br>#{downs}"

    "#{ups}#{downs}"

Template.item.events
  'click .delete': ->
    @destroy()

  'click .upvote': (event) ->
    event.preventDefault()
    Meteor.call('upvote', @id)

  'click .downvote': (event) ->
    event.preventDefault()
    Meteor.call('downvote', @id)
