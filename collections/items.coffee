class @Item extends Minimongoid
  @_collection: new Meteor.Collection 'items'

  @belongs_to: [
    name: 'list'
  ]

  @before_create: (attr) ->
    if not attr.url.match(/^http/) and not attr.url.match(/^https/) and attr.url isnt ''
      attr.url = 'http://' + attr.url

    attr.upvoters = []
    attr.downvoters = []
    attr.score = 0
    attr.position = 0
    attr

  validate: ->
    if not @text or @text.length <= 2
      @error 'text', "'text' is required and should be descriptive"

  isOwner: (user) ->
    if not user
      return false

    @userId is user._id or @username is user.username

  canVote: (user) ->
    if not user
      return false

    @userId isnt user._id

  hasVoted: (user) ->
    @hasUpvoted(user) or @hasDownvoted(user)

  hasUpvoted: (user) ->
    if not user
      return false

    _.contains @upvoters, user._id

  hasDownvoted: (user) ->
    if not user
      return false

    _.contains @downvoters, user._id

  upvote: (user) ->
    if not user
      return false

    if _.contains @upvoters, user._id
      @pull upvoters: user._id
      @update score: @score - 1
    else
      @push upvoters: user._id
      @update score: @score + 1

    if _.contains @downvoters, user._id
      @pull downvoters: user._id
      @update score: @score + 1

  downvote: (user) ->
    if not user
      return false

    if _.contains @downvoters, user._id
      @pull downvoters: user._id
      @update score: @score + 1
    else
      @push downvoters: user._id
      @update score: @score - 1

    if _.contains @upvoters, user._id
      @pull upvoters: user._id
      @update score: @score - 1

Item._collection.allow(
  insert: (userId, item) ->
    list = List.first(item.listId)

    userId && list && (list.userId == userId || list.open)

  update: (userId, item) ->
    true

  remove: (userId, item) ->
    true
)
