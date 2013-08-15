Accounts.onCreateUser (options, user) ->
  if user.services.facebook
    data = user.services.facebook
    user.username = data.username or user._id
    return user
