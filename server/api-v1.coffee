authenticateToken = (token) ->
  user = Meteor.users.findOne({ 'profile.apiKey': token })

  # Fail this request if no user found
  if !token or !user
    return false
  user

authorized = (obj, token) ->
  if !(user = authenticateToken(token))
    return false

  if (obj and user._id isnt obj.userId)
    return false
  user

Meteor.startup ->
  listFilters =
    before:
      GET: (id, objs, token) ->
        if !(user = authenticateToken(token))
          return false

        true

      POST: (obj, token) ->
        if !authorized(obj, token)
          return false

        true

      PUT: (id, obj, newValues, token) ->
        if !authorized(obj, token)
          return false

        immutable = ['userId', 'username', 'createdAt']

        if _.intersection(_.keys(newValues), immutable).length
          return false

        true

      DELETE: (id, obj, token) ->
        if !authorized(obj, token)
          return false

        true

  itemFilters =
    before:
      GET: (id, objs, token) ->
        if !(user = authenticateToken(token))
          return false

        true

      POST: (obj, token) ->
        if !(user = authorized(obj, token))
          return false

        if !(list = List.first(obj.listId))
          return false

        if user._id isnt list.userId and !list.open
          return false

        true

      PUT: (id, obj, newValues, token) ->
        if !authorized(obj, token)
          return false

        immutable = ['userId', 'username', 'listId', 'listName', 'listSlug', 'createdAt']

        if _.intersection(_.keys(newValues), immutable).length
          return false

        true

      DELETE: (id, obj, token) ->
        if !authorized(obj, token)
          return false

        true

  api = new CollectionAPI(
    apiPath: 'api/v1'
  )

  api.addCollection(List, 'lists', listFilters)

  api.addCollection(Item, 'items', itemFilters)

  api.start()
