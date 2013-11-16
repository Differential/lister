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

  isOwner: (user) ->
    if not user
      return false

    @userId is user._id or @username is user.userName

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
