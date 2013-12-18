Template.item.rendered = ->
  $('body').css('background-color', Session.get('color'))
  $(this.find('.score a')).tooltip
    html: true
    container: 'body'
  img = $(this.find('.itemImg'))
  if img.length
    img.imageMaxSize({width: 200, height: 200}).data('size', 'small')

Template.item.helpers
  'isDownvotable': ->
    list = List.first @listId
    list.downvotable

  'isOwner': ->
    @isOwner Meteor.user()

  'ownerClass': ->
    if @isOwner Meteor.user()
      return 'isOwner'

  'canVote': ->
    list = List.first @listId
    user = Meteor.user()
    @canVote(user) and (list.canVote(user) or @hasVoted(user))

  'hideVote': ->
    list = List.first @listId
    user = Meteor.user()
    canVote = @canVote(user) and (list.canVote(user) or @hasVoted(user))
    if !canVote and user
      'hidden'

  'onlyClass': ->
    list = List.first @listId
    if not list.downvotable
      return 'only'

  'urlIsImage': (url) ->
    ext = url.substring(url.lastIndexOf('.'))
    ext in ['.png', '.jpg', '.gif']


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

  'click .imgHitArea': (event) ->
    event.preventDefault();
    targ = $(event.currentTarget)
    img = targ.find('.itemImg')
    icon = targ.find('.searchIcon')
    if img.data('size') is 'small'
      img
        .imageMaxSize( {height: Math.min($(window).height(), 800)} )
        .data('size', 'large')
      icon
        .removeClass('icon-search-plus')
        .addClass('icon-search-minus')
        .attr("title", "Shrink Image")
    else
      img
        .imageMaxSize( {width: 200, height: 200} )
        .data('size', 'small')
      icon
        .removeClass('icon-search-minus')
        .addClass('icon-search-plus')
        .attr("title", "Enlarge Image")

