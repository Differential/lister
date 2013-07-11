Template.showList.helpers
  list: ->
    Lists.findOne(Session.get('currentList'))

Template.showList.events
  'keypress input#newItem': (e) ->
    if e.which == 13
      text = e.target.value
      Lists.update(Session.get('currentList'), $push: {items: text})
      $(e.target).val('')
