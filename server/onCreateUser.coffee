Accounts.onCreateUser (options, user) ->
  if user.services.facebook
    data = user.services.facebook
    user.username = user.services.facebook.name or user._id
  return user
