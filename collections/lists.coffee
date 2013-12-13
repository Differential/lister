class @List extends Minimongoid
  @_collection: new Meteor.Collection 'lists'

  @has_many: [
    name: 'items'
    foreign_key: 'listId'
  ]

  @before_create: (attr) ->
    slug = (attr.name || '').replace(/\W+/g, '-').toLowerCase()

    if slug.substr(-1) is '-'
      slug = slug.substr(0, slug.length - 1)

    attr.slug = slug
    attr

  validate: ->
    if not @name
      @error 'name', "'name' is required"

    if @limit and not /\d+/.test(@maxvotes)
      @error 'maxvotes', "'maxvotes' must be numeric"

  isOwner: (user) ->
    if not user
      return false

    @userId is user._id or @username is user.userName

  canVote: (user) ->
    if not user
      return false

    if not @limit
      return true

    voters = []
    _.each @items(), (item) ->
      voters.push(item.upvoters, item.downvoters)
    voters = _.flatten voters

    numVotes = _.filter(voters, (voter) ->
      return voter is user._id
    ).length

    console.log numVotes
    numVotes < @maxvotes

  canAddItem: (user) ->
    if not user
      return false

    @userId is user._id or @open

  mostRecentItem: ->
    item = @items({sort: {createdAt: -1}})[0]

    if item
      return {
        username: item.itemUsername,
        text: item.text
      }

  touch: (item) ->
    @update
      updatedAt: new Date()

List._collection.allow(
  insert: (userId, list) ->
    userId

  update: (userId, list) ->
    list.userId == userId

  remove: (userId, list) ->
    list.userId == userId
)
