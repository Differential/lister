RESTstop.configure(
  api_path: 'api/v2'
  use_auth: true
)

cutFields = (arr, fields) ->
  if not _.isArray(arr)
    arr = [arr]
  if not _.isArray(fields)
    fields = [fields]
  for key in fields
    for obj in arr
      delete obj[key]

popError = (errors) ->
  return _(errors[0]).values()[0]

################################################################################
# Lists
#

#
# GET
#

RESTstop.add 'lists', method: 'GET', () ->
  lists = List.all()
  cutFields lists, 'userId'
  [ lists ]

RESTstop.add 'users/:id/lists', method: 'GET', () ->
  user = Meteor.users.findOne @params.id
  if not user
    return 404

  lists = List.where userId: @params.id
  cutFields lists, 'userId'
  [ lists ]

RESTstop.add 'lists/:id', method: 'GET', () ->
  list = List.first @params.id

  if not list
    return 404

  cutFields list, 'userId'

  list.items = list.items()
  cutFields list.items, ['userId', 'upvoters', 'downvoters']

  list

#
# POST
#

RESTstop.add 'lists', { method: 'POST', require_login: true }, () ->

  list = List.create
    userId: @user._id
    username: @user.username
    name: @params.name
    open: !! @params.open
    createdAt: new Date()
    updatedAt: new Date()

  if list.errors
    return [400, popError list.errors]

  list

#
# DELETE
#

RESTstop.add 'lists/:id', { method: 'DELETE', require_login: true }, () ->
  list = List.first @params.id

  if not list
    return 404

  if not list.isOwner @user
    return 403

  list.destroy()

################################################################################
# Items
#

#
# POST
#

RESTstop.add 'lists/:id/items', { method: 'POST', require_login: true }, () ->
  list = List.first @params.id

  if not list
    return 404

  if not list.canAddItem @user
    return 403

  item = Item.create
    userId: @user._id
    itemUsername: @user.username
    listId: list.id
    text: @params.text
    url: @params.url
    createdAt: new Date()
    username: list.username
    listSlug: list.slug
    listName: list.name

  if item.errors
    return [400, popError item.errors]

  item

#
# PUT (only for upvotes/downvotes)
#

RESTstop.add 'items/:id', { method: 'PUT', require_login: true }, () ->
  item = Item.first @params.id

  if not item
    return 404

  if not @params.vote
    return [400, "'vote' is required"]

  if not item.canVote @user
    return 403

  if @params.vote == 'up'
    item.upvote @user
  else if @params.vote == 'down'
    item.downvote @user
  else
    [400, "'vote' must be either 'up' or 'down'"]

#
# DELETE
#

RESTstop.add 'items/:id', { method: 'DELETE', require_login: true }, () ->
  item = Item.first @params.id

  if not item
    return 404

  if not item.isOwner @user
    return 403

  item.destroy()
