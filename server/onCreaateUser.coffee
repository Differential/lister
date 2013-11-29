Accounts.onCreateUser (options, user) ->
  HTTP.get "http://api.churnbee.com/v1/user/#{user._id}/?accessToken=EQOHfOwW_OmUEIbdjsXqEQzNexbDUO1c3TbF3ofzku0&plan=Free&custom[username]=#{user.username}"

  if user.services.facebook
    data = user.services.facebook
    user.username = data.username or user._id
  return user
