Template.showList.helpers
  list: ->
    Lists.findOne(Session.get('currentList'))
