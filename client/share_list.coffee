Template.shareLists.helpers
  username: ->
    Session.get('username')

  list: ->
    Lists.findOne(Session.get('listId'))
