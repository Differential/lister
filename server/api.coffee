Meteor.startup ->
  apiFilters =
    before:
      GET: (id, objs, token) ->
        user = Meteor.users.findOne({ 'profile.apiKey': token })

        # Fail this request if no user found
        if !token or !user
          return false

        # Filter objs by userId (no for loops in Coffee?)
        i = 0
        while i < objs.length
          objs[i] = null unless objs[i].userId is user._id
          i++

        return true

      POST: (obj, token) ->
        # Fail this request if no user found
        if !token or !Meteor.users.findOne({ 'profile.apiKey': token })
          return false
        return true

      PUT: (id, obj, token) ->
        user = Meteor.users.findOne({ 'profile.apiKey': token })

        # Fail this request if API key does not match
        if !token or user.profile.apiKey != token
          return false
        return true

      DELETE: (id, obj, token) ->
        user = Meteor.users.findOne({ 'profile.apiKey': token })

        # Fail this request if API key does not match
        if !token or user.profile.apiKey != token
          return false
        return true

  api = new CollectionAPI(
    apiPath: 'api/v1'
  )

  api.addCollection(Lists, 'lists', apiFilters)
  api.addCollection(Items, 'items', apiFilters)

  api.start()
